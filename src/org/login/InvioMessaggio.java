package org.login;
import java.io.IOException;
import java.net.*;

import com.opensymphony.xwork2.ActionSupport;


@SuppressWarnings("serial")
public class InvioMessaggio extends ActionSupport{
	private String msg;
	private String host;
	private int port;
	private DatagramSocket socket;
		
	public String sendMsg() {

		System.out.println("Il messaggio è: "+msg);
		System.out.println("L'indirizzo è: "+host);
		System.out.println("La porta è: "+port);
		
		try {
			/*int index = fullAddress.indexOf(':');
			InetAddress address = InetAddress.getByName(fullAddress.substring(0, index));
			int port = Integer.parseInt(fullAddress.substring(index + 1));*/
			InetAddress address=InetAddress.getByName(host);
			
			if(socket==null) {socket = new DatagramSocket();
			System.out.println("Creazione nuova socket");
			}
			
			socket.send(new DatagramPacket(msg.getBytes(),msg.getBytes().length, address, port));
			return "INVIATO";
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		catch (NullPointerException npe) {
			// TODO Auto-generated catch block
			npe.printStackTrace();
		}
		socket.close();
		return "INVIATO";
	}


	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}
	
	public String getHost() {
		return host;
	}

	public void setHost(String host) {
		this.host = host;
	}
	
	public int getPort() {
		return port;
	}

	public void setPort(int port) {
		this.port = port;
	}
}