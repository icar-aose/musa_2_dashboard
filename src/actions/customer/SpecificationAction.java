package actions.customer;

import org.msgagent.SendMsg;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

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

	@Override
	public Specification getModel() {
		// TODO Auto-generated method stub
		return specification;
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
			
			 if(specification.getState().equals("activate"))
				 specification.setState("deactivate");
		 else
			 specification.setState("activate");
			 specificationDAO.saveOrUpdateSpecification(specification);
		

			 classeInvioMsg.sendMsg("Specification "+specification.getName()+" "+specification.getState());
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
	
	
	
}
