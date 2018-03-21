package actions.admin;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.Blob;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.jms.Connection;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.dispatcher.SessionMap;
import org.hibernate.Hibernate;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.msgagent.SendMsg;
import org.msgagent.WriteXMLFile;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

import dbBean.AbstractCapability;
import dbBean.CapabilityInstance;
import dbBean.CapabilityLog;
import dbBean.ConcreteCapability;
import dbBean.Domain;
import dbBean.User;
import dbDAO.AbstractCapabilityDAO;
import dbDAO.CapabilityInstanceDAO;
import dbDAO.CapabilityLogDAO;
import dbDAO.ConcreteCapabilityDAO;
import dbDAO.DomainDAO;
import dbDAO.UserDAO;
import util.HibernateUtil;

public class ConcreteCapabilityAction  extends ActionSupport implements ModelDriven<ConcreteCapability> {

	private SendMsg classeInvioMsg=new SendMsg();

	//private AbstractCapability abstractCapability=new AbstractCapability();
	private ConcreteCapability concreteCapability=new ConcreteCapability();
	private List<ConcreteCapability> concreteCapabilitiesList=new  ArrayList<ConcreteCapability>();
	private List<AbstractCapability> abstractCapabilitiesList=new  ArrayList<AbstractCapability>();
	private ConcreteCapabilityDAO concreteCapabilityDAO=new ConcreteCapabilityDAO();
	private AbstractCapabilityDAO abstractCapabilityDAO=new AbstractCapabilityDAO();
	private List<CapabilityLog> capabilityLogList=new ArrayList<>();
	private String idAbstractCapability;
	private String idDomain,msg="",textMsg="";
	private List<CapabilityInstance> capabilityInstanceList=new ArrayList<>();
	private String actionName;
	private Blob jarfile;
	private File UserJar;
	private DomainDAO domainDAO=new DomainDAO();
	private String pagina;
	@Override
	public ConcreteCapability getModel() {
		// TODO Auto-generated method stub
		return concreteCapability;
	}
	
	public ConcreteCapabilityAction(){
		HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(ServletActionContext.HTTP_REQUEST);
		SessionMap<String, Object> sessionMap=(SessionMap<String, Object>) ActionContext.getContext().getSession();
		String par=request.getParameter("idDomain");
		if(par!=null) {
		String dn = domainDAO.getDomainByID(Integer.parseInt(par)).getName();
		sessionMap.put("domainName", dn);}
		
		Cookie[] cok=request.getCookies();
		for(Cookie c:cok) {
			if(c.getName().equals("pagina")) {this.pagina=c.getValue();}
		}
	}
	
	public ConcreteCapability getConcreteCapability() {
		return concreteCapability;
	}
	public void setConcreteCapability(ConcreteCapability concreteCapability) {
		this.concreteCapability = concreteCapability;
	}
	
	
	 public String  newConcreteCapability(){
			switch(msg) {
			case "1": this.setTextMsg("Jar Non Valido"); break;
			case "2": this.setTextMsg("Classe non Valida"); break;
			default: this.setTextMsg("");
			}
			
		 HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(ServletActionContext.HTTP_REQUEST);
		 DomainDAO domainDAO=new DomainDAO();
		 Domain domain=domainDAO.getDomainByID(Integer.parseInt( request.getParameter("idDomain")));
		 this.abstractCapabilitiesList = abstractCapabilityDAO.getAllAbstractCapabilityByDomain(domain);
		 concreteCapability = new ConcreteCapability();
		 
		 return SUCCESS;
	 }
	public String listConcreteCapabilities()
	 {
		 AbstractCapability abstractCapability=abstractCapabilityDAO.getAbstractCapabilityByID(Integer.parseInt( idAbstractCapability));
		 concreteCapabilitiesList= concreteCapabilityDAO.getAllConcreteCapabilityByAbstract(abstractCapability);
		 return SUCCESS;
	 }
	public String edit(){
		switch(msg) {
		case "1": this.setTextMsg("Jar Non Valido"); break;
		case "2": this.setTextMsg("Classe non Valida"); break;
		default: this.setTextMsg("");
		}
		 HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(ServletActionContext.HTTP_REQUEST);
		 System.out.println("ID FOR CONCRETE TO EDIT-->"+request.getParameter("id"));
		 AbstractCapability abstractCapability=abstractCapabilityDAO.getAbstractCapabilityByID(Integer.parseInt(idAbstractCapability));
		 abstractCapabilitiesList.clear();
		 abstractCapabilitiesList.add(abstractCapability);
		 concreteCapability = concreteCapabilityDAO.getConcreteCapabilityByID(Integer.parseInt(request.getParameter("id")));
		 return SUCCESS;
	}
	
	public String delete(){
		 HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(ServletActionContext.HTTP_REQUEST);
		 System.out.println("ID FOR CONCRETE TO DELETE-->"+request.getParameter("id"));
		 concreteCapabilityDAO.deleteConcreteCapability(Integer.parseInt(request.getParameter("id")));
		 concreteCapability = concreteCapabilityDAO.getConcreteCapabilityByID(Integer.parseInt(request.getParameter("id")));
		 return SUCCESS;
	}	
	
	public String listConcreteCapabilitiesDev(){
		 
		 AbstractCapability abstractCapability=abstractCapabilityDAO.getAbstractCapabilityByID(Integer.parseInt( idAbstractCapability));
		 Map session = ActionContext.getContext().getSession();
		 UserDAO userDAO=new UserDAO();
		 User user=userDAO.getUserByID(Integer.parseInt(session.get("id").toString()));
		
		 concreteCapabilitiesList= concreteCapabilityDAO.getAllConcreteCapabilityByAbstractUserDev(abstractCapability,user);
		 return SUCCESS;
	}
	
	public String logConcreteAbstractCapabilities(){
		 CapabilityInstanceDAO capabilityInstanceDAO=new  CapabilityInstanceDAO();
		 HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(ServletActionContext.HTTP_REQUEST);
		 concreteCapability = concreteCapabilityDAO.getConcreteCapabilityByID(Integer.parseInt(request.getParameter("id")));
		 capabilityInstanceList= capabilityInstanceDAO.getAllCapabilityInstanceByConcreteCapability(concreteCapability);
		 return SUCCESS;
	}
	
	public String logAllConcreteAbstractCapabilities(){
		 CapabilityInstanceDAO capabilityInstanceDAO=new  CapabilityInstanceDAO();
		 HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(ServletActionContext.HTTP_REQUEST);
		 concreteCapability = concreteCapabilityDAO.getConcreteCapabilityByID(Integer.parseInt(request.getParameter("id")));
		 CapabilityLogDAO capabilityLogDAO=new CapabilityLogDAO();
		 capabilityLogList= capabilityLogDAO.getAllCapabilityLogByCapability(concreteCapability);
		 return SUCCESS;
	}
	
	public String changeStateConcreteCapability(){
		Connection connection=classeInvioMsg.startConnection();
		if(connection==null) {return("erroreMQ");}
		
		HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(ServletActionContext.HTTP_REQUEST);
		concreteCapability = concreteCapabilityDAO.getConcreteCapabilityByID(Integer.parseInt(request.getParameter("id")));
	
		if(concreteCapability.getState().equals("active"))
			concreteCapability.setState("unactive");
		else
			concreteCapability.setState("active");
			
		String res=classeInvioMsg.sendMsg(connection,"CONCRETE CAPABILITY: "+concreteCapability.getName()+" STATE: "+concreteCapability.getState());
		if(!res.equals("INVIATO")) {return("erroreMQ");}	
		
		concreteCapabilityDAO.saveOrUpdateConcreteCapability(concreteCapability);	
		return SUCCESS;
	}
	
	public String changeDeployConcreteCapability() throws SQLException{
		Connection connection=classeInvioMsg.startConnection();
		if(connection==null) {return("erroreMQ");}
		
		HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(ServletActionContext.HTTP_REQUEST);
		concreteCapability = concreteCapabilityDAO.getConcreteCapabilityByID(Integer.parseInt(request.getParameter("id")));
		String statedeploy=concreteCapability.getDeploystate();
		
		if(statedeploy.equals("deployed"))
		{
			concreteCapability.setState("unactive");
			concreteCapability.setDeploystate("undeployed");
			System.out.println(concreteCapability.getDeploystate());
			String res=classeInvioMsg.sendMsg(connection,"CONCRETE CAPABILITY: "+concreteCapability.getName()+" DEPLOY STATE: "+concreteCapability.getDeploystate());
		    if(!res.equals("INVIATO")) {return("erroreMQ");}
		}
		else
		{
		Blob blob=concreteCapability.getJarfile();
	    byte[] bMsg = blob.getBytes(1, (int) blob.length());
	    String nomefile=concreteCapability.getIdConcreteCapability().toString()+concreteCapability.getName()+".jar";
	    
	    String res=classeInvioMsg.sendMsg(connection,bMsg,nomefile);
	    if(!res.equals("INVIATO")) {return("erroreMQ");}
 
		concreteCapability.setDeploystate("deployed");
		concreteCapability.setState("active");		
		}
		concreteCapabilityDAO.saveOrUpdateConcreteCapability(concreteCapability);

		return SUCCESS;
	}	
	
	
	public String listConcreteCapabilitiesByDomain(){
		DomainDAO domainDAO=new DomainDAO();
		HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(ServletActionContext.HTTP_REQUEST);
		Domain domain=domainDAO.getDomainByID(Integer.parseInt( request.getParameter("idDomain")));
		Map session = ActionContext.getContext().getSession();
		UserDAO userDAO=new UserDAO();
		User user=userDAO.getUserByID(Integer.parseInt(session.get("id").toString()));
		
		 concreteCapabilitiesList= concreteCapabilityDAO.getAllConcreteCapabilityByDomainUser(domain,user);
		 return SUCCESS;
	 }
	
	
	public String saveOrUpdateConcreteAbstractCapabilities() throws IOException{
		actionName = ServletActionContext.getRequest().getHeader("Referer");
		actionName = actionName.substring(actionName.lastIndexOf('/') + 1);
		Integer lastind=actionName.indexOf("&msg");
		actionName = actionName.substring(0,(lastind > -1) ? lastind : actionName.length());
		
		//System.out.println(actionName);
		AbstractCapability abstractCapability=abstractCapabilityDAO.getAbstractCapabilityByID(Integer.parseInt(idAbstractCapability));
		String checkJar=classeInvioMsg.checkJar(UserJar);
		if(checkJar.equals("notvalid")) {this.setMsg("1");return "input";}
		
		System.out.println(Paths.get(UserJar.getAbsolutePath()).getParent());
		String filePath = ServletActionContext.getServletContext().getRealPath("/")+"uploadedJars";
		File fileToCreate = new File(filePath, UserJar.getName()+".jar");
		
		try {
			FileUtils.copyFile(this.UserJar, fileToCreate);
		} catch (IOException e1) {e1.printStackTrace();}
		
		String checkClass=classeInvioMsg.checkClass(UserJar, concreteCapability.getClassname());
		if(checkClass.equals("notvalid")) {this.setMsg("2");return "input";}
		
		Map session2 = ActionContext.getContext().getSession();
		UserDAO userDAO=new UserDAO();
		User user=userDAO.getUserByID(Integer.parseInt(session2.get("id").toString()));
		concreteCapability.setUser(user);
	    concreteCapability.setAbstractCapability(abstractCapability);
		
		concreteCapabilityDAO.saveOrUpdateConcreteCapability(concreteCapability);
	    
		 WriteXMLFile xmlwriter=new WriteXMLFile();
		 File xmlfile=xmlwriter.CreateXML(fileToCreate,filePath,concreteCapability);
		
		 SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
			Session session = sessionFactory.openSession();
			session.beginTransaction();
			FileInputStream inputStream = new FileInputStream(fileToCreate);
			this.jarfile = Hibernate.getLobCreator(session).createBlob(inputStream, fileToCreate.length());
			sessionFactory.close();
			
		concreteCapability.setJarfile(jarfile);
		concreteCapabilityDAO.saveOrUpdateConcreteCapability(concreteCapability);

		return SUCCESS;
	}
	
	public List<ConcreteCapability> getConcreteCapabilitiesList() {
		return concreteCapabilitiesList;
	}
	public void setConcreteCapabilitiesList(
			List<ConcreteCapability> concreteCapabilitiesList) {
		this.concreteCapabilitiesList = concreteCapabilitiesList;
	}
		
	public void setAbstractCapabilitiesList(
			List<AbstractCapability> abstractCapabilitiesList) {
		this.abstractCapabilitiesList = abstractCapabilityDAO.getAllAbstractCapability();
	}
	
	public List<AbstractCapability> getAbstractCapabilitiesList() {
		return abstractCapabilitiesList;
	}
	
	public String getIdAbstractCapability() {
		return idAbstractCapability;
	}
	public void setIdAbstractCapability(String idAbstractCapability) {
		this.idAbstractCapability = idAbstractCapability;
	}
	public String getIdDomain() {
		return idDomain;
	}
	public void setIdDomain(String idDomain) {
		this.idDomain = idDomain;
	}
	public List<CapabilityInstance> getCapabilityInstanceList() {
		return capabilityInstanceList;
	}
	public void setCapabilityInstanceList(
			List<CapabilityInstance> capabilityInstanceList) {
		this.capabilityInstanceList = capabilityInstanceList;
	}
	public List<CapabilityLog> getCapabilityLogList() {
		return capabilityLogList;
	}
	public void setCapabilityLogList(List<CapabilityLog> capabilityLogList) {
		this.capabilityLogList = capabilityLogList;
	}

	public File getUserJar() {
		return UserJar;
	}

	public void setUserJar(File UserJar) {
		this.UserJar = UserJar;
	}
	
	public String getActionName() {
		return actionName;
	}

	public void setActionName(String actionName) {
		this.actionName = actionName;
	}
	
    public Blob getJarfile() {
        return jarfile;
    }
 
    public void setJarfile(Blob jarfile){

        this.jarfile = jarfile;
    }
 
	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}
	
		public String getTextMsg() {
		return textMsg;
	}

	public void setTextMsg(String textMsg) {
		this.textMsg = textMsg;

	}
	
	public String getPagina() {
		return pagina;
	}

	public void setPagina(String pagina) {
		this.pagina = pagina;
	}	
}

