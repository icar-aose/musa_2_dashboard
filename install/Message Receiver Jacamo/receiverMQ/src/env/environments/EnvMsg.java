package environments;

import java.net.*;
import javax.jms.Connection;
import javax.jms.ConnectionFactory;
import javax.jms.Destination;
import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.MessageConsumer;
import javax.jms.Session;
import javax.jms.TextMessage;

import org.apache.activemq.ActiveMQConnection;
import org.apache.activemq.ActiveMQConnectionFactory;

import cartago.*;

@SuppressWarnings("unused")
public class EnvMsg extends Artifact {
ReadCmd cmd;
boolean receiving;

private static String url;
private static String subject;
private Session session;
private ConnectionFactory connectionFactory;
private Connection connection;
private Destination destination;
MessageConsumer consumer;

@OPERATION
void init() throws Exception {
	cmd = new ReadCmd();
	receiving = false;
	
	// URL of the JMS server
	url = ActiveMQConnection.DEFAULT_BROKER_URL;
	// Name of the queue we will receive messages from
	subject = "JCG_QUEUE";
	// Getting JMS connection from the server
	connectionFactory = new ActiveMQConnectionFactory(url);
	connection = connectionFactory.createConnection();
	connection.start();
	// Creating session for seding messages
	session = connection.createSession(false,Session.AUTO_ACKNOWLEDGE);
	// Getting the queue 'JCG_QUEUE'
	destination = session.createQueue(subject);
	// MessageConsumer is used for receiving (consuming) messages
	consumer = session.createConsumer(destination);
}

@OPERATION
void receiveMsg(OpFeedbackParam<String> msg) {
	await(cmd);
	msg.set(cmd.getMsg());
}

@OPERATION
void startReceiving() {
	receiving = true;
	execInternalOp("receiving");
}

@INTERNAL_OPERATION
void receiving() {
	while (true) {
		await(cmd);
		signal("new_msg", cmd.getMsg());
	}
}

@OPERATION
void stopReceiving() {
receiving = false;
}

class ReadCmd implements IBlockingCmd {
private String msg;
private TextMessage textMessage;
private Message message;
public ReadCmd() {

}

public void exec() {
	
	try {
			message = consumer.receive();
			if((message instanceof TextMessage)) {
				textMessage = (TextMessage) message;
				msg=textMessage.getText();
				//System.out.println("Received message '" + msg + "'");
			}
			
	} catch (JMSException e) {e.printStackTrace();}

}

public String getMsg() {
	return msg;
}

}
}