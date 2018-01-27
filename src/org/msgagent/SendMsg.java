package org.msgagent;

import javax.jms.BytesMessage;
import javax.jms.Connection;
import javax.jms.ConnectionFactory;
import javax.jms.Destination;
import javax.jms.JMSException;
import javax.jms.MessageProducer;
import javax.jms.Session;
import javax.jms.TextMessage;

//import org.apache.activemq.ActiveMQConnection;
import org.apache.activemq.ActiveMQConnectionFactory;

import dbDAO.GeneralConfigurationDAO;


public class SendMsg{
	private GeneralConfigurationDAO configurationDAO=new GeneralConfigurationDAO();
	private String ip= configurationDAO.getGeneralConfigurationByName("APACHEMQ_IP").get(0).getValue();
	private String port=configurationDAO.getGeneralConfigurationByName("APACHEMQ_PORT").get(0).getValue();
	private String url = "failover://tcp://"+ip+":"+port;
	//URL of the JMS server. DEFAULT_BROKER_URL will just mean that JMS server is on localhost
	//private static String url = "failover://tcp://192.168.1.4:61616";
	//private static String url = ActiveMQConnection.DEFAULT_BROKER_URL;
	// default broker URL is : tcp://localhost:61616"
	private static String subject; // Queue Name.You can create any/many queue names as per your requirement
		
	public String sendMsg(String msg) {
		subject = "JCG_QUEUE";
		try {
			System.out.println(msg);
			// Getting JMS connection from the server and starting it
			ConnectionFactory connectionFactory = new ActiveMQConnectionFactory(url);
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

	public String sendMsg(byte[] msg,String fileName) {
		subject = "JarFiles";
		try {
			System.out.println(msg);
			// Getting JMS connection from the server and starting it
			ConnectionFactory connectionFactory = new ActiveMQConnectionFactory(url);
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
			BytesMessage message = session.createBytesMessage();
			message.writeBytes(msg);
			message.setJMSType(fileName);
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

	public String getUrl() {
		return url;
	}

	public void setHost(String url) {
		this.url = url;
	}
	

}