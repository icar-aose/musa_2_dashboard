package org.msgagent;

import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLClassLoader;
import java.util.Enumeration;
import java.util.jar.JarEntry;
import java.util.jar.JarFile;

import javax.jms.BytesMessage;
import javax.jms.Connection;
import javax.jms.ConnectionFactory;
import javax.jms.Destination;
import javax.jms.JMSException;
import javax.jms.MessageProducer;
import javax.jms.Session;
import javax.jms.TextMessage;

import org.apache.activemq.ActiveMQConnectionFactory;

import dbDAO.GeneralConfigurationDAO;

public class SendMsg{
	private GeneralConfigurationDAO configurationDAO=new GeneralConfigurationDAO();
	private String ip= configurationDAO.getGeneralConfigurationByName("APACHEMQ_IP").get(0).getValue();
	private String port=configurationDAO.getGeneralConfigurationByName("APACHEMQ_PORT").get(0).getValue();
	private String url = "tcp://"+ip+":"+port;
	//URL of the JMS server. DEFAULT_BROKER_URL will just mean that JMS server is on localhost
	//private static String url = "failover://tcp://192.168.1.4:61616";
	//private static String url = ActiveMQConnection.DEFAULT_BROKER_URL;
	// default broker URL is : tcp://localhost:61616"
	private static String subject; // Queue Name.You can create any/many queue names as per your requirement
		
	public String sendMsg(Connection connection,String msg) {
		subject = "JCG_QUEUE";
		try {
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
			e.printStackTrace();
			return "ERRORE";
		}
		
		catch (NullPointerException npe) {
			// TODO Auto-generated catch block
			npe.printStackTrace();
		}
		return "INVIATO";
	}

	public String sendMsg(Connection connection,byte[] msg,String fileName) {
		subject = "JarFiles";
		try {
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
			e.printStackTrace();
			return "ERRORE";
		}
		catch (NullPointerException npe) {
			// TODO Auto-generated catch block
			npe.printStackTrace();
		}

		return "INVIATO";
	}

	public String checkJar(File fileToCreate) {
		
		try {
	        JarFile file = new JarFile(fileToCreate);
	        Enumeration<? extends JarEntry> e = file.entries();
	        while(e.hasMoreElements()) {
	            JarEntry entry = e.nextElement();
	        }
	        file.close();
	    } catch(Exception ex) {return "notvalid";}
		return "valid";
	}
	
	public String checkClass(File file,String cName) {
		try {
		String pathJar=file.getAbsolutePath();
		URL[] urls={new URL("jar:file:"+pathJar.replace("/","\\")+"!/")};
		JarFile jarFile = new JarFile(file.getPath());
		Enumeration<JarEntry> e = jarFile.entries();  
		URLClassLoader cl = URLClassLoader.newInstance(urls);
	  	  
		while (e.hasMoreElements()) {
  	       JarEntry je = e.nextElement();
  	       if(je.isDirectory() || !je.getName().endsWith(".class")){continue;}
  	       String className = je.getName().substring(0,je.getName().length()-6);
  	       className = className.replace('/', '.');
  	       if(!className.equals(cName)) {continue;}
  	       
  	       @SuppressWarnings("rawtypes")
  	       Class c = cl.loadClass(className);
  	       return "valid";
  	  	}
  	  
  	  jarFile.close();
  	  }
  	  catch (IllegalArgumentException e1) {return "notvalid";}
  	  catch (MalformedURLException e2){return "notvalid";}
  	  catch (IOException e4){return "notvalid";}
  	  catch (ClassNotFoundException e5){return "notvalid";}
  	  catch (SecurityException e9) {return "notvalid";}
	  return "notvalid";
}
	
	public Connection startConnection() {
		subject = "JCG_QUEUE";
		try {
			// Getting JMS connection from the server and starting it
			ConnectionFactory connectionFactory = new ActiveMQConnectionFactory(url);
			Connection connection = connectionFactory.createConnection();
			connection.start();
			return connection;
		} catch (JMSException e) {
			return null;	
		}
		
		catch (NullPointerException npe) {
			// TODO Auto-generated catch block
			return null;
		}
	}
	
	
	public String getUrl() {
		return url;
	}

	public void setHost(String url) {
		this.url = url;
	}
	

}