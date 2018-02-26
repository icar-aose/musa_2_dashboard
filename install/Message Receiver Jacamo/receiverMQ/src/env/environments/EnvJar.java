package environments;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.net.*;
import java.util.ArrayList;
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
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.apache.activemq.ActiveMQConnection;
import org.apache.activemq.ActiveMQConnectionFactory;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

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
private String msg,nomeClasse;
private String nomeMetodo="prova";
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
			//nomeClasse=msg.substring(msg.lastIndexOf("_")+1,msg.indexOf(".jar"));
 	       	//System.out.println(nomeClasse);
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
			    	 JarFile jarFile = new JarFile(file.getPath());
			    	 Enumeration<JarEntry> e = jarFile.entries();  
			    	 URLClassLoader cl = URLClassLoader.newInstance(urls);
			    	 @SuppressWarnings("rawtypes")
			    	 ArrayList<Class> ac=new ArrayList<Class>();
			    	 while (e.hasMoreElements()) {
			    	       JarEntry je = e.nextElement();			    	       
			    	       if(je.isDirectory() || !je.getName().endsWith(".class")){
			    	    	   if(!je.getName().equals("manifest.xml"))continue;
			    	    	   else {
			    	    		   try {InputStream in = cl.getResourceAsStream("/manifest.xml"); 
			    	    			DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
			    	    			DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
			    	    			Document doc = dBuilder.parse(in);
			    	    			NodeList nList = doc.getElementsByTagName("Concrete");
			    	    			Node nNode = nList.item(0);
			    	    			
			    	    			if (nNode.getNodeType() == Node.ELEMENT_NODE) {
			    	    				Element eElement = (Element) nNode;
			    	    				System.out.println("idConcrete : " + eElement.getElementsByTagName("idConcrete").item(0).getTextContent());
			    	    				System.out.println("idAbstract : " + eElement.getElementsByTagName("idAbstract").item(0).getTextContent());
			    	    				System.out.println("name : " + eElement.getElementsByTagName("name").item(0).getTextContent());
			    	    				System.out.println("classe : " + (nomeClasse= eElement.getElementsByTagName("classe").item(0).getTextContent()));
			    	    				System.out.println("ipworkspace : " + eElement.getElementsByTagName("ipworkspace").item(0).getTextContent());
			    	    				System.out.println("wpname : " + eElement.getElementsByTagName("wpname").item(0).getTextContent());
			    	    			}
			    	    			
									} 
			    	    		   catch (SAXException e1) {e1.printStackTrace();} 
			    	    		   catch (ParserConfigurationException e1) {e1.printStackTrace();}
			    	    		   continue;
			    	    	   }
			    	       }
			    	       
			    	       
			    	       String className = je.getName().substring(0,je.getName().length()-6);
			    	       className = className.replace('/', '.');
			    	       //System.out.println(className);
			    	       @SuppressWarnings("rawtypes")
			    	       Class c = cl.loadClass(className);
			    	       ac.add(c);
			    	  }
		    	  
		          for (Class classe : ac) { 
		        	  //System.out.println(classe.getName());
		    	       if(classe.getName().equals(nomeClasse)) {	
			    	       Object t = classe.newInstance();
		    	    	   @SuppressWarnings("unchecked")
		    	    	   Method m=classe.getMethod(nomeMetodo);
		    	    	   m.invoke(t);
		    	       }        
		    		  
		    	  }
		    	  jarFile.close();
		    	  cl.close();
		    	  }
		    	  catch (IllegalArgumentException e1) {e1.printStackTrace();}
		    	  catch (MalformedURLException e2){e2.printStackTrace();}
		    	  catch (InvocationTargetException e3) {e3.printStackTrace();}
		    	  catch (IOException e4){e4.printStackTrace();}
		    	  catch (ClassNotFoundException e5){e5.printStackTrace();}
		    	  catch (IllegalAccessException e6){e6.printStackTrace();}
		    	  catch (InstantiationException e7){e7.printStackTrace();}
		    	  catch (NoSuchMethodException e8) {e8.printStackTrace();}
		    	  catch (SecurityException e9) {e9.printStackTrace();}
		      }
			
	} catch (JMSException e) {e.printStackTrace();}

}

public String getMsg() {
	return msg;
}

}
}