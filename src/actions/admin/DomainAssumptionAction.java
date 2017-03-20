package actions.admin;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

import dbBean.Domain;
import dbBean.DomainAssumption;
import dbBean.DomainConfiguration;
import dbDAO.DomainAssumptionDAO;
import dbDAO.DomainConfigurationDAO;
import dbDAO.DomainDAO;

public class DomainAssumptionAction extends ActionSupport implements ModelDriven<DomainAssumption>{

	private DomainAssumption domainAssumption=new DomainAssumption();
	private DomainDAO domainDAO=new DomainDAO();
	private List<DomainAssumption> domainAssumptionList=new ArrayList<DomainAssumption>();
	private DomainAssumptionDAO domainAssumptionDAO= new DomainAssumptionDAO();
	private String idDomain;
	@Override
	public DomainAssumption getModel() 
	{
		return domainAssumption;
	}
	
	public String listDomainAssumption()
	 {
		 Domain domain=new Domain();
		 domain = domainDAO.getDomainByID(Integer.parseInt(idDomain));
		 domainAssumptionList= domainAssumptionDAO.getAllAssumptionByDomain(domain);
		 return SUCCESS;
	 }
	
	public String saveOrUpdateDomainAssumption()
	{	
		Domain	 domain = domainDAO.getDomainByID(Integer.parseInt(idDomain));
		domainAssumption.setDomain(domain);
		domainAssumptionDAO.saveOrUpdateDomainAssumption(domainAssumption);
		domainAssumptionList=domainAssumptionDAO.getAllAssumptionByDomain(domain);
		
		return SUCCESS;
	 }
	
	 public String edit()
	 {
			 HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(ServletActionContext.HTTP_REQUEST);
			 domainAssumption = domainAssumptionDAO.getDomainAssumptionByID(Integer.parseInt(request.getParameter("id")));
			 Domain	 domain = domainDAO.getDomainByID(Integer.parseInt(idDomain));
			 domainAssumptionList=domainAssumptionDAO.getAllAssumptionByDomain(domain);
				
			 return SUCCESS;
	 }
		 
	 public String delete()
	 {
		 HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(ServletActionContext.HTTP_REQUEST);
		 domainAssumptionDAO.deleteDomainAssumption(Integer.parseInt(request.getParameter("id")));
				 Domain	 domain = domainDAO.getDomainByID(Integer.parseInt(request.getParameter("idDomain")));
				 domainAssumptionList=domainAssumptionDAO.getAllAssumptionByDomain(domain);
					
				return SUCCESS;
	 }

	public DomainAssumption getDomainAssumption() {
		return domainAssumption;
	}

	public void setDomainAssumption(DomainAssumption domainAssumption) {
		this.domainAssumption = domainAssumption;
	}

	public List<DomainAssumption> getDomainAssumptionList() {
		return domainAssumptionList;
	}

	public void setDomainAssumptionList(List<DomainAssumption> domainAssumptionList) {
		this.domainAssumptionList = domainAssumptionList;
	}

	public String getIdDomain() {
		return idDomain;
	}

	public void setIdDomain(String idDomain) {
		this.idDomain = idDomain;
	}

	
	
}
