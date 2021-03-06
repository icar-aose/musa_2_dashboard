package actions.admin;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

import dbBean.Domain;
import dbBean.DomainConfiguration;
import dbBean.GeneralConfiguration;
import dbDAO.DomainConfigurationDAO;
import dbDAO.DomainDAO;

public class DomainManagementAction extends ActionSupport implements ModelDriven<Domain> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Domain domain=new Domain();
	private String idDomain;
	private List<Domain> domainList=new ArrayList<Domain>();
	private DomainDAO domainDAO=new DomainDAO();
	
	

	@Override
	public Domain getModel() {
		
		return domain;
	}

	public String listDomains()
	{
		System.out.println("CALL LIST DOMAINS");
		domainList = domainDAO.getAllDomain();
		System.out.println("DOMAINS ARE:"+domainList.size());
	    return SUCCESS;
	}
	
	public String saveOrUpdate()
	{	
		domainDAO.saveOrUpdateDomain(domain);
		domainList = domainDAO.getAllDomain();
		
		return SUCCESS;
	}

	public String delete()
	{
		HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(ServletActionContext.HTTP_REQUEST);
		domainDAO.deleteDomain(Integer.parseInt(request.getParameter("id")));
		
		return SUCCESS;
	}
	
	
	public String edit()
	{
		HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(ServletActionContext.HTTP_REQUEST);
		domain = domainDAO.getDomainByID(Integer.parseInt(request.getParameter("id")));
		domainList = domainDAO.getAllDomain();
		
		return SUCCESS;
	}
	
	public Domain getDomain() {
		return domain;
	}

	public void setDomain(Domain domain) {
		this.domain = domain;
	}

	public List<Domain> getDomainList() {
		return domainList;
	}

	public void setDomainList(List<Domain> domainList) {
		this.domainList = domainList;
	}

	public DomainDAO getDomainDAO() {
		return domainDAO;
	}

	public void setDomainDAO(DomainDAO domainDAO) {
		this.domainDAO = domainDAO;
	}


	public String getIdDomain() {
		return idDomain;
	}


	public void setIdDomain(String idDomain) {
		this.idDomain = idDomain;
	}

	

}
