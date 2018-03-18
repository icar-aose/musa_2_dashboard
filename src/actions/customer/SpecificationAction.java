package actions.customer;

import org.msgagent.SendMsg;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.jms.Connection;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.dispatcher.SessionMap;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

import dbBean.Domain;
import dbBean.DomainConfiguration;
import dbBean.Specification;
import dbBean.User;
import dbDAO.DomainConfigurationDAO;
import dbDAO.DomainDAO;
import dbDAO.SpecificationDAO;
import dbDAO.UserDAO;

public class SpecificationAction  extends ActionSupport implements ModelDriven<Specification>{
	private SendMsg classeInvioMsg=new SendMsg();
	private Specification specification=new Specification();
	private DomainDAO domainDAO=new DomainDAO();
	private List<Specification> domainSpecificationList=new ArrayList<Specification>();
	private SpecificationDAO specificationDAO= new SpecificationDAO();
	private String idDomain;
	private String idSpecification;
	private String pagina;
	@Override
	public Specification getModel() {
		// TODO Auto-generated method stub
		return specification;
	}
	
	public SpecificationAction(){
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
	
	 public String listDomainSpecification()
	 {	
		 
		Domain domain=new Domain();
		domain = domainDAO.getDomainByID(Integer.parseInt(idDomain));
		Map session = ActionContext.getContext().getSession();
		UserDAO userDAO=new UserDAO();
		User user=userDAO.getUserByID(Integer.parseInt(session.get("id").toString()));
		
		 domainSpecificationList= specificationDAO.getAllSpecificationByDomainAndUser(domain,user);
//		 domainSpecificationList= specificationDAO.getAllSpecificationByDomain(domain);
		 return SUCCESS;
	 }
	 
	public String deleteSpecification(){
		System.out.println("specificatio ID-->"+specification.getIdSpecification());
		specificationDAO.deleteSpecification(specification);
		Domain domain=new Domain();
		domain = domainDAO.getDomainByID(Integer.parseInt(idDomain));
		Map session = ActionContext.getContext().getSession();
		UserDAO userDAO=new UserDAO();
		User user=userDAO.getUserByID(Integer.parseInt(session.get("id").toString()));
		domainSpecificationList= specificationDAO.getAllSpecificationByDomainAndUser(domain,user);
		return SUCCESS;
	}
	
	public String saveOrUpdateSpecification(){
		 Domain domain=new Domain();
		 domain = domainDAO.getDomainByID(Integer.parseInt(idDomain));
		 specification.setDomain(domain);
		 if(specification.getIdSpecification()==null)
			 specification.setState("waiting");
		Map session = ActionContext.getContext().getSession();
		UserDAO userDAO=new UserDAO();
		User userCustomer=userDAO.getUserByID(Integer.parseInt(session.get("id").toString()));
		specification.setUser(userCustomer); 
		 specificationDAO.saveOrUpdateSpecification(specification);
		 return SUCCESS;
	}
	
	
	 public String edit()
		{
		     System.out.println("specification ID-->"+specification.getIdSpecification());
		     specification=specificationDAO.getSpecificationById(specification.getIdSpecification());
		     Domain domain=new Domain();
			 domain = domainDAO.getDomainByID(Integer.parseInt(idDomain));
			 domainSpecificationList= specificationDAO.getAllSpecificationByDomain(domain);
			 return SUCCESS;
		}
	 
	 
	 public String changeStateSpecification(){
	 
		  HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(ServletActionContext.HTTP_REQUEST);
	      specification=specificationDAO.getSpecificationById(Integer.parseInt((request.getParameter("idSpecification"))));
	      
	      Connection connection=classeInvioMsg.startConnection();
	      if(connection==null) {return("erroreMQ");}
	      
	      if(specification.getState().equals("activate"))
	    	  specification.setState("deactivate");
	      else
	    	  specification.setState("activate");

	      String res=classeInvioMsg.sendMsg(connection,"SPECIFICATION: "+specification.getName()+" STATE: "+specification.getState());
	      if(!res.equals("INVIATO")) {return("erroreMQ");}	
	      
	      specificationDAO.saveOrUpdateSpecification(specification);
	      return SUCCESS;
	 }
	 
	public Specification getSpecification() {
		return specification;
	}
	public void setSpecification(Specification specification) {
		this.specification = specification;
	}

	public List<Specification> getDomainSpecificationList() {
		return domainSpecificationList;
	}

	public void setDomainSpecificationList(
			List<Specification> domainSpecificationList) {
		this.domainSpecificationList = domainSpecificationList;
	}

	public String getIdDomain() {
		return idDomain;
	}

	public void setIdDomain(String idDomain) {
		this.idDomain = idDomain;
	}
	
	public String getPagina() {
		return pagina;
	}

	public void setPagina(String pagina) {
		this.pagina = pagina;
	}	
	
}
