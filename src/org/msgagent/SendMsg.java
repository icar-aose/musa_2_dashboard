package org.msgagent;

import org.icar.musa.core.runtime_entity.ConcreteCapabilityInterface;
import java.io.File;
import java.io.IOException;
import java.lang.reflect.Method;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLClassLoader;
import java.util.Enumeration;
import java.util.HashSet;
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

public class SendMsg {
	private GeneralConfigurationDAO configurationDAO = new GeneralConfigurationDAO();
	private String ip;
	private String port;
	private String url;
	private String subject;

	public String sendMsg(Connection connection, String msg) {
		subject = "JCG_QUEUE";
		try {
			// Creating a non transactional session to send/receive JMS message.
			Session session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);

			// Destination represents here our queue 'JCG_QUEUE' on the JMS server.
			// The queue will be created automatically on the server.
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

	public String sendMsg(Connection connection, byte[] msg, String fileName) {
		subject = "JarFiles";
		try {
			// Creating a non transactional session to send/receive JMS message.
			Session session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);

			// Destination represents here our queue 'JCG_QUEUE' on the JMS server.
			// The queue will be created automatically on the server.
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
		} catch (NullPointerException npe) {
			// TODO Auto-generated catch block
			npe.printStackTrace();
		}

		return "INVIATO";
	}

	public String checkJar(File fileToCreate) {

		try {
			JarFile file = new JarFile(fileToCreate);
			Enumeration<? extends JarEntry> e = file.entries();
			while (e.hasMoreElements()) {
				JarEntry entry = e.nextElement();
			}
			file.close();
		} catch (Exception ex) {
			return "notvalid";
		}
		return "valid";
	}

	public String checkClass(File file, String cName) {
		try {
			String pathJar = file.getAbsolutePath();
			URL[] urls = { new URL("jar:file:" + pathJar.replace("/", "\\") + "!/") };
			JarFile jarFile = new JarFile(file.getPath());
			Enumeration<JarEntry> e = jarFile.entries();
			URLClassLoader cl = URLClassLoader.newInstance(urls);

			while (e.hasMoreElements()) {
				JarEntry je = e.nextElement();
				if (je.isDirectory() || !je.getName().endsWith(".class")) {
					continue;
				}
				String className = je.getName().substring(0, je.getName().length() - 6);
				className = className.replace('/', '.');
				if (className.equals(cName)) {
					@SuppressWarnings("rawtypes")
					Class c = cl.loadClass(className);
					if (ConcreteCapabilityInterface.class.getName().equals(c.getInterfaces()[0].getName())) {
						HashSet<String> set1 = new HashSet<String>();
						HashSet<String> set2 = new HashSet<String>();
						Method[] metodiInterfaccia = ConcreteCapabilityInterface.class.getDeclaredMethods();
						for (Method m : metodiInterfaccia) {
							set1.add(m.getName());
						}
						Method[] metodi = c.getDeclaredMethods();
						for (Method m : metodi) {
							set2.add(m.getName());
						}
						if (set2.containsAll(set1)) {
							System.out.println("Interfacce uguali");
							jarFile.close();
							return "valid";
						}
					}
				} else {
					continue;
				}
			}
			jarFile.close();
		} catch (IllegalArgumentException e1) {
			return "notvalid";
		} catch (MalformedURLException e2) {
			return "notvalid";
		} catch (IOException e4) {
			return "notvalid";
		} catch (ClassNotFoundException e5) {
			return "notvalid";
		} catch (SecurityException e9) {
			return "notvalid";
		}

		return "notvalid";
	}

	public Connection startConnection() {
		ip = configurationDAO.getGeneralConfigurationByID(23).getValue();
		port = configurationDAO.getGeneralConfigurationByID(24).getValue();
		if (ip == null || port == null) {
			return null;
		}
		url = "tcp://" + ip + ":" + port;
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