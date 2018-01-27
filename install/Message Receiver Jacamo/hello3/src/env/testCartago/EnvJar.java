package testCartago;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.net.*;
import java.util.Enumeration;
import java.util.jar.JarEntry;
import java.util.jar.JarFile;

import javax.jms.BytesMessage;
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
public class EnvJar extends Artifact {
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
	subject = "JarFiles";
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
void receiveMsg(OpFeedbackParam<String> fileName) {
	await(cmd);
	fileName.set(cmd.getMsg());
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
private BytesMessage bMessage;
private File file;

private Message message;
public ReadCmd() {

}

public void exec() {

	try {
		
		message = consumer.receive();
		if((message instanceof BytesMessage)) {
			bMessage = (BytesMessage) message;
			msg=bMessage.getJMSType();
			byte[] bMsg = new byte[(int) bMessage.getBodyLength()];
			bMessage.readBytes(bMsg);
				try {
					file = new File("JarFiles/"+msg);
					FileOutputStream fos = new FileOutputStream(file);
					fos.write(bMsg);
					fos.flush();
					fos.close();
				} catch (IOException e) {e.printStackTrace();}
				
				//Comincia la sezione dedicata al Java Reflection
		    	  try {
		    		String pathJar=file.getAbsolutePath();
		    	  URL[] urls={new URL("jar:file:"+pathJar.replace("/","\\")+"!/")};
		    	  //System.out.println("File Path: "+pathJar);
		    	  //System.out.println("Url Jar: "+urls[0].toString());
		    	  
		    	  JarFile jarFile = new JarFile(file.getPath());
		    	  Enumeration<JarEntry> e = jarFile.entries();  
		    	  URLClassLoader cl = URLClassLoader.newInstance(urls);
		    	  
		    	  while (e.hasMoreElements()) {
		    	       JarEntry je = e.nextElement();
		    	       if(je.isDirectory() || !je.getName().endsWith(".class")){continue;}
		    	       String className = je.getName().substring(0,je.getName().length()-6);
		    	       className = className.replace('/', '.');
		    	       @SuppressWarnings("rawtypes")
					Class c = cl.loadClass(className);
		    	       Object t = c.newInstance();
		    	       @SuppressWarnings("unchecked")
		    	       Method m=c.getMethod("start");
		    	       m.invoke(t);
		    	  }
		    	  
		    	  jarFile.close();
		    	  }
		    	  catch (IllegalArgumentException e1) {e1.printStackTrace();}
		    	  catch (MalformedURLException e2){e2.printStackTrace();}
		    	  catch (InvocationTargetException e3) {e3.printStackTrace();}
		    	  catch (IOException e4){e4.printStackTrace();}
		    	  catch (ClassNotFoundException e5){e5.printStackTrace();}
		    	  catch (IllegalAccessException e6){e6.printStackTrace();}
		    	  catch (InstantiationException e7){e7.printStackTrace();}
		    	  catch (NoSuchMethodException e8) {System.out.println("Metodo Start() non trovato");}
		    	  catch (SecurityException e9) {e9.printStackTrace();}
		      }
			
		
			
	} catch (JMSException e) {e.printStackTrace();}

}

public String getMsg() {
	return msg;
}

}
}