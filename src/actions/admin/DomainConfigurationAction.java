package actions.admin;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.dispatcher.SessionMap;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

import dbBean.Domain;
import dbBean.DomainConfiguration;
import dbDAO.DomainConfigurationDAO;
import dbDAO.DomainDAO;

public class DomainConfigurationAction extends ActionSupport implements ModelDriven<DomainConfiguration>{
	private DomainConfiguration domainConfiguration=new DomainConfiguration();
	private DomainDAO domainDAO=new DomainDAO();
	private List<DomainConfiguration> domainConfigurationList=new ArrayList<DomainConfiguration>();
	private DomainConfigurationDAO domainConfigurationDAO= new DomainConfigurationDAO();
	private String idDomain;

	
	@Override
	public DomainConfiguration getModel() {
		
		return domainConfiguration;
	}

	public DomainConfigurationAction(){
		HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(ServletActionContext.HTTP_REQUEST);
		SessionMap<String, Object> sessionMap=(SessionMap<String, Object>) ActionContext.getContext().getSession();
		String par=request.getParameter("idDomain");
		if(par!=null) {
		String dn = domainDAO.getDomainByID(Integer.parseInt(par)).getName();
		sessionMap.put("domainName", dn);}
	}
	
	 public String saveOrUpdateDomainConf()
	 {	
		 System.out.println("CALL saveOrUpdateDomainConf");
		HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(ServletActionContext.HTTP_REQUEST);
		Domain	 domain = domainDAO.getDomainByID(Integer.parseInt(idDomain));
		domainConfiguration.setDomain(domain);
		domainConfigurationDAO.saveOrUpdateDomainConfiguration(domainConfiguration);
		 System.out.println(" domainConfiguration"+domainConfiguration.getName());
		domainConfigurationList=domainConfigurationDAO.getAllConfigurationByDomain(domain);
		
		return SUCCESS;
	 }
	 public String listDomainConfiguration()
	 {
		 Domain domain=new Domain();
		 domain = domainDAO.getDomainByID(Integer.parseInt(idDomain));
		 domainConfigurationList= domainConfigurationDAO.getAllConfigurationByDomain(domain);
		 return SUCCESS;
	 }

	 public String edit()
	{
		 HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(ServletActionContext.HTTP_REQUEST);
		 domainConfiguration = domainConfigurationDAO.getDomainConfigurationByID(Integer.parseInt(request.getParameter("id")));
		 Domain	 domain = domainDAO.getDomainByID(Integer.parseInt(idDomain));
		 domainConfigurationList = domainConfigurationDAO.getAllConfigurationByDomain(domain);
		
		 return SUCCESS;
	}
	 
	 public String delete()
		{
			HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(ServletActionContext.HTTP_REQUEST);
			domainConfigurationDAO.deleteDomainConfiguration(Integer.parseInt(request.getParameter("id")));
			 Domain	 domain = domainDAO.getDomainByID(Integer.parseInt(request.getParameter("idDomain")));
			 domainConfigurationList = domainConfigurationDAO.getAllConfigurationByDomain(domain);
			
			return SUCCESS;
		}
	public DomainConfiguration getDomainConfiguration() {
		return domainConfiguration;
	}

	public void setDomainConfiguration(DomainConfiguration domainConfiguration) {
		this.domainConfiguration = domainConfiguration;
	}

	public List<DomainConfiguration> getDomainConfigurationList() {
		return domainConfigurationList;
	}

	public void setDomainConfigurationList(
			List<DomainConfiguration> domainConfigurationList) {
		this.domainConfigurationList = domainConfigurationList;
	}

	public String getIdDomain() {
		return idDomain;
	}

	public void setIdDomain(String idDomain) {
		this.idDomain = idDomain;
	}
	
	 
	 
}
