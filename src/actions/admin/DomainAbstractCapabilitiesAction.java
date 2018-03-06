package actions.admin;

import java.io.InputStream;
import java.io.StringBufferInputStream;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

import dbBean.AbstractCapability;
import dbBean.AbstractCapabilityProposal;
import dbBean.Domain;
import dbDAO.AbstractCapabilityDAO;
import dbDAO.AbstractCapabilityProposalDAO;
import dbDAO.DomainDAO;

public class DomainAbstractCapabilitiesAction extends ActionSupport implements ModelDriven<AbstractCapability>{

	private AbstractCapability abstractCapability=new AbstractCapability();
	private AbstractCapabilityDAO abstractCapabilityDAO=new AbstractCapabilityDAO();
	private DomainDAO domainDAO=new DomainDAO();
	private List<AbstractCapability> abstractCapabilitiesList=new  ArrayList<AbstractCapability>();
	private String idDomain;
	private InputStream existProposalForAbstract;
	
	@Override
	public AbstractCapability getModel() {
		return abstractCapability;
	}

	
	public String listDomainAbstractCapabilities()
	 {
		 Domain domain=new Domain();
		 HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(ServletActionContext.HTTP_REQUEST);
		 System.out.println("ID DOMAIN-->"+request.getParameter("idDomain"));
			
		 	 domain = domainDAO.getDomainByID(Integer.parseInt(request.getParameter("idDomain")));
			
//		 domain = domainDAO.getDomainByID(Integer.parseInt(idDomain));
		 abstractCapabilitiesList= abstractCapabilityDAO.getAllAbstractCapabilityByDomain(domain);
		 return SUCCESS;
	 }
	
	public String saveOrUpdateDomainAbstractCapabilities()
	{	
		Domain	 domain = domainDAO.getDomainByID(Integer.parseInt(idDomain));
		abstractCapability.setDomain(domain);
		abstractCapabilityDAO.saveOrUpdateAbstractCapability(abstractCapability);
		abstractCapabilitiesList=abstractCapabilityDAO.getAllAbstractCapabilityByDomain(domain);
		
		return SUCCESS;
	 }
	 public String  newDomainAbstractCapabilities(){
		 abstractCapability = new AbstractCapability();
		 Domain	 domain = domainDAO.getDomainByID(Integer.parseInt(idDomain));
		 abstractCapabilitiesList=abstractCapabilityDAO.getAllAbstractCapabilityByDomain(domain);
	
		 return SUCCESS;
	 }
	 public String edit()
	 {
			 HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(ServletActionContext.HTTP_REQUEST);
			 System.out.println("ID FOR ABSTRAT TO EDITO-->"+request.getParameter("id"));
			 abstractCapability = abstractCapabilityDAO.getAbstractCapabilityByID(Integer.parseInt(request.getParameter("id")));
			 Domain	 domain = domainDAO.getDomainByID(Integer.parseInt(idDomain));
			 abstractCapabilitiesList=abstractCapabilityDAO.getAllAbstractCapabilityByDomain(domain);

			 return SUCCESS;
	 }
		 
	 public String delete()
	 {
		 HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(ServletActionContext.HTTP_REQUEST);
		 System.out.println("CALL DELETE FOR CAP:  "+request.getParameter("id"));
		 System.out.println("idDomain:"+request.getParameter("idDomain"));
		 abstractCapabilityDAO.deleteAbstractCapability(Integer.parseInt(request.getParameter("id")));
		 Domain	 domain = domainDAO.getDomainByID(Integer.parseInt(request.getParameter("idDomain")));
		 abstractCapabilitiesList=abstractCapabilityDAO.getAllAbstractCapabilityByDomain(domain);
		 System.out.println("ABSTRACT CAPABILITY ARE: "+abstractCapabilitiesList.size());
					return SUCCESS;
			
	 }
	 public String  verifyProposalExist(){
		 HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(ServletActionContext.HTTP_REQUEST);
	     
		  AbstractCapability abstractCapabilityDB= abstractCapabilityDAO.getAbstractCapabilityByID(Integer.parseInt(request.getParameter("idAbstratCapability")));
		  AbstractCapabilityProposalDAO abstractCapabilityProposalDAO=new AbstractCapabilityProposalDAO();
		  List<AbstractCapabilityProposal> abstractCapabilityProposals=abstractCapabilityProposalDAO.getProposalByAbstractCapability(abstractCapabilityDB);
		  System.out.println("SIZE PROPOSAL FOR ABSTRACT ->"+abstractCapabilityProposals.size());
		   if(abstractCapabilityProposals.size()>0)
			   
			   existProposalForAbstract = new StringBufferInputStream("true");   
			  
			   else
				   existProposalForAbstract=new StringBufferInputStream("false");;
			   
				   
		 System.out.println("existProposalForAbstract-->"+existProposalForAbstract);
		 return SUCCESS;
			
	 }
	 
	 public String  changeStateProposal(){
		 HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(ServletActionContext.HTTP_REQUEST);
	     
		  AbstractCapability abstractCapabilityDB= abstractCapabilityDAO.getAbstractCapabilityByID(Integer.parseInt(request.getParameter("idAbstratCapability")));
		  AbstractCapabilityProposalDAO abstractCapabilityProposalDAO=new AbstractCapabilityProposalDAO();
		  List<AbstractCapabilityProposal> abstractCapabilityProposals=abstractCapabilityProposalDAO.getProposalByAbstractCapability(abstractCapabilityDB);
		  for (int i = 0; i < abstractCapabilityProposals.size(); i++) {
			  
			  AbstractCapabilityProposal abstractCapabilityProposal=abstractCapabilityProposals.get(i);
			  abstractCapabilityProposal.setAbstractCapability(null);
			  abstractCapabilityProposal.setState("refused");
			  abstractCapabilityProposalDAO.saveOrUpdateAbstractCapability(abstractCapabilityProposal);
			
		}
		  return SUCCESS;
	 }
	 

		

	public AbstractCapability getAbstractCapability() {
		return abstractCapability;
	}


	public void setAbstractCapability(AbstractCapability abstractCapability) {
		this.abstractCapability = abstractCapability;
	}


	public List<AbstractCapability> getAbstractCapabilitiesList() {
		return abstractCapabilitiesList;
	}


	public void setAbstractCapabilitiesList(
			List<AbstractCapability> abstractCapabilitiesList) {
		this.abstractCapabilitiesList = abstractCapabilitiesList;
	}


	public String getIdDomain() {
		return idDomain;
	}


	public void setIdDomain(String idDomain) {
		this.idDomain = idDomain;
	}

	public InputStream getExistProposalForAbstract() {
		return existProposalForAbstract;
	}


	public void setExistProposalForAbstract(InputStream existProposalForAbstract) {
		this.existProposalForAbstract = existProposalForAbstract;
	}


	
	
	 
}
