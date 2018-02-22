package org.login;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.Enumeration;
import java.util.jar.JarEntry;
import java.util.jar.JarFile;

import javax.jms.Connection;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.io.FileUtils;
import org.apache.struts2.interceptor.ServletRequestAware;
import com.opensymphony.xwork2.ActionSupport;
import org.msgagent.SendMsg;

@SuppressWarnings("serial")
public class FileUploadAction extends ActionSupport implements ServletRequestAware {
	private File UserJar;
	private String msg;
	private String fileName;
	private SendMsg objSendFile;
	
	private HttpServletRequest servletRequest;

	public String execute() {
		try {
			 
			String filePath = servletRequest.getSession().getServletContext().getRealPath("/")+"uploadedJars";
			//System.out.println("Server path:" + filePath);
			//System.out.println("Nome File:" + fileName);
			File fileToCreate = new File(filePath, fileName);
			FileUtils.copyFile(this.UserJar, fileToCreate);

			//Verifica file Jar
			 try {
			        JarFile file = new JarFile(fileToCreate);
			        Enumeration<? extends JarEntry> e = file.entries();
			        while(e.hasMoreElements()) {
			            JarEntry entry = e.nextElement();
			            //System.out.println(entry.getName());
			        }
			        file.close();
			    } catch(Exception ex) {;
			        this.setMsg("File Jar non valido");
			        return INPUT;
			    }
			//Trasformazione file in byte array
			ByteArrayOutputStream bos = new ByteArrayOutputStream();
			try {
			  byte[] yourBytes = Files.readAllBytes(fileToCreate.toPath());
			  objSendFile=new SendMsg();
			  Connection connection=objSendFile.startConnection();
			  if(connection.equals(null)) {return("erroreMQ");}
			  if(!connection.equals(null)) {
				  this.setMsg("Impossibile connettersi ad ActiveMQ");
				   Files.deleteIfExists(UserJar.toPath());
				   Files.deleteIfExists(fileToCreate.toPath());
				  return INPUT;
			  }
			  String res=objSendFile.sendMsg(connection,yourBytes,fileName);

			  
			} finally {
			  try {
			    bos.close();
			    Files.deleteIfExists(UserJar.toPath());
			    Files.deleteIfExists(fileToCreate.toPath());
			  } catch (IOException ex) {}
			}
		      
		} catch (Exception e) {
			e.printStackTrace();
			addActionError(e.getMessage());
			this.setMsg("Errore nel caricamento del file");
			return INPUT;
		}
		this.setMsg("File Inviato Correttamente");

		return SUCCESS;
	}

	public File getUserJar() {
		return UserJar;
	}

	public void setUserJar(File UserJar) {
		this.UserJar = UserJar;
	}

	@Override
	public void setServletRequest(HttpServletRequest servletRequest) {
		this.servletRequest = servletRequest;
	}
	
	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}
	
	public String getUserJarFileName() {
		return fileName;
	}

	public void setUserJarFileName(String fileName) {
		this.fileName = fileName;
	}
}