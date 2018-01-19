package org.msgagent;

import javax.jms.Connection;
import javax.jms.ConnectionFactory;
import javax.jms.Destination;
import javax.jms.JMSException;
import javax.jms.MessageProducer;
import javax.jms.Session;
import javax.jms.TextMessage;

import org.apache.activemq.ActiveMQConnection;
import org.apache.activemq.ActiveMQConnectionFactory;


public class SendMsg{
	private String host;
	//URL of the JMS server. DEFAULT_BROKER_URL will just mean that JMS server is on localhost
	//private static String url = "failover://tcp://192.168.1.4:61616";
	//private static String url = ActiveMQConnection.DEFAULT_BROKER_URL;
	// default broker URL is : tcp://localhost:61616"
	private static String subject = "JCG_QUEUE"; // Queue Name.You can create any/many queue names as per your requirement
		
	public String sendMsg(String msg) {
		
		try {
			System.out.println(msg);
			// Getting JMS connection from the server and starting it
			ConnectionFactory connectionFactory = new ActiveMQConnectionFactory(ActiveMQConnection.DEFAULT_BROKER_URL);
			Connection connection = connectionFactory.createConnection();
			connection.start();
			//Creating a non transactional session to send/receive JMS message.
			Session session = connection.createSession(false,Session.AUTO_ACKNOWLEDGE);	
			
			//Destination represents here our queue 'JCG_QUEUE' on the JMS server. 
			//The queue will be created automatically on the server.
			Destination destination = session.createQueue(subject);	
			
			// MessageProducer is used for sending messages to the queue.
			MessageProducer producer = session.createProducer(destination);
			
			// We will send a small text message 
			TextMessage message = session.createTextMessage(msg);
			
			// Here we are sending our message!
			producer.send(message);
			
			connection.close();
		} catch (JMSException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		catch (NullPointerException npe) {
			// TODO Auto-generated catch block
			npe.printStackTrace();
		}

		return "INVIATO";
	}


	public String getHost() {
		return host;
	}

	public void setHost(String host) {
		this.host = host;
	}
	

}