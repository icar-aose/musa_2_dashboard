package actions.admin;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.msgagent.SendMsg;

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

public class ConcreteCapabilityAction  extends ActionSupport implements ModelDriven<ConcreteCapability>{

	private SendMsg classeInvioMsg=new SendMsg();

	//private AbstractCapability abstractCapability=new AbstractCapability();
	private ConcreteCapability concreteCapability=new ConcreteCapability();
	private List<ConcreteCapability> concreteCapabilitiesList=new  ArrayList<ConcreteCapability>();
	private List<AbstractCapability> abstractCapabilitiesList=new  ArrayList<AbstractCapability>();
	private ConcreteCapabilityDAO concreteCapabilityDAO=new ConcreteCapabilityDAO();
	private AbstractCapabilityDAO abstractCapabilityDAO=new AbstractCapabilityDAO();
	private List<CapabilityLog> capabilityLogList=new ArrayList<>();
	private String idAbstractCapability;
	private String idDomain;
	private List<CapabilityInstance> capabilityInstanceList=new ArrayList<>();
	@Override
	public ConcreteCapability getModel() {
		// TODO Auto-generated method stub
		return concreteCapability;
	}
	public ConcreteCapability getConcreteCapability() {
		return concreteCapability;
	}
	public void setConcreteCapability(ConcreteCapability concreteCapability) {
		this.concreteCapability = concreteCapability;
	}
	
	
	 public String  newConcreteCapability(){
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
		 HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(ServletActionContext.HTTP_REQUEST);
		 System.out.println("ID FOR CONCRETE TO EDIT-->"+request.getParameter("id"));
		 AbstractCapability abstractCapability=abstractCapabilityDAO.getAbstractCapabilityByID(Integer.parseInt(idAbstractCapability));
		 abstractCapabilitiesList.clear();
		 abstractCapabilitiesList.add(abstractCapability);
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
		String res=classeInvioMsg.sendMsg("Concrete Capability "+concreteCapability.getName()+" "+concreteCapability.getState());
		if(!res.equals("INVIATO")) {return("erroreMQ");}
		
		HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(ServletActionContext.HTTP_REQUEST);
		  concreteCapability = concreteCapabilityDAO.getConcreteCapabilityByID(Integer.parseInt(request.getParameter("id")));
				
			 if(concreteCapability.getState().equals("active"))
				 concreteCapability.setState("unactive");
			 else
			 concreteCapability.setState("active");
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
	
	
	public String saveOrUpdateConcreteAbstractCapabilities(){
		AbstractCapability abstractCapability=abstractCapabilityDAO.getAbstractCapabilityByID(Integer.parseInt(idAbstractCapability));
		concreteCapability.setAbstractCapability(abstractCapability);
		Map session = ActionContext.getContext().getSession();
		UserDAO userDAO=new UserDAO();
		User user=userDAO.getUserByID(Integer.parseInt(session.get("id").toString()));
		concreteCapability.setUser(user);
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

	
}
