package actions.admin;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import jdk.nashorn.internal.runtime.RewriteException;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.dispatcher.SessionMap;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

import dbBean.AbstractCapability;
import dbBean.AbstractCapabilityProposal;
import dbBean.Domain;
import dbBean.User;
import dbDAO.AbstractCapabilityDAO;
import dbDAO.AbstractCapabilityProposalDAO;
import dbDAO.DomainDAO;
import dbDAO.UserDAO;

public class AbstractCapabilityProposalAction extends ActionSupport implements ModelDriven<AbstractCapabilityProposal>{
	private AbstractCapabilityProposal abstractCapabilityProposal=new AbstractCapabilityProposal();
	private String idDomain;
	private DomainDAO domainDAO=new DomainDAO();
	private AbstractCapabilityDAO abstractCapabilityDAO= new AbstractCapabilityDAO();
	private List<AbstractCapabilityProposal> abstractCapabilityProposalsList=new ArrayList<AbstractCapabilityProposal>();
	private AbstractCapabilityProposalDAO abstractCapabilityProposalDAO=new AbstractCapabilityProposalDAO();
	private String state;
	private String motivation;
	@Override
	public AbstractCapabilityProposal getModel() {
		return abstractCapabilityProposal;
	}
	
	public AbstractCapabilityProposalAction(){
		HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(ServletActionContext.HTTP_REQUEST);
		SessionMap<String, Object> sessionMap=(SessionMap<String, Object>) ActionContext.getContext().getSession();
		String par=request.getParameter("idDomain");
		if(par!=null) {
		String dn = domainDAO.getDomainByID(Integer.parseInt(par)).getName();
		sessionMap.put("domainName", dn);}
	}
	
	public String loadAbstractCapabilityProposal()
	 {  HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(ServletActionContext.HTTP_REQUEST);
		System.out.println("CALL loadAbstractCapabilityProposal for-->"+request.getParameter("id"));
		abstractCapabilityProposal= abstractCapabilityProposalDAO.getAbstractCapabilityProposalByID(Integer.parseInt(request.getParameter("id")));
		Domain dom=domainDAO.getDomainByID(Integer.parseInt(request.getParameter("idDomain")));
		abstractCapabilityProposalsList=abstractCapabilityProposalDAO.getAllAbstractCapabilityProposalByDomain(dom);
		return SUCCESS;
		
	 }
	
	public String deleteAbstractCapabilityProposal(){
		 HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(ServletActionContext.HTTP_REQUEST);
		 System.out.println("CALL DELETE FOR CAP:  "+request.getParameter("id"));
		 System.out.println("idDomain:"+request.getParameter("idDomain"));
		 abstractCapabilityProposalDAO.deleteAbstractCapabilityProposal(Integer.parseInt(request.getParameter("id")));
		 return SUCCESS;
	
	}
	public String listAbstractCapabilityProposal()
	 {
		System.out.println("CHIAMATA");
		 Domain domain=new Domain();
		 System.out.println("CALL LIST ABSTRACT CAPABILITI"+idDomain);
		 domain = domainDAO.getDomainByID(Integer.parseInt(idDomain));
		 abstractCapabilityProposalsList= abstractCapabilityProposalDAO.getAllAbstractCapabilityProposalByDomain(domain);
		 System.out.println("SIZE PROPOSAL:"+abstractCapabilityProposalsList.size());
		 return SUCCESS;
	 }

	
	public String saveOrUpdateDomainAbstractCapabilityProposal()
	{	
		 HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(ServletActionContext.HTTP_REQUEST);
		 System.out.println("STATE-->"+state);
		 abstractCapabilityProposal= abstractCapabilityProposalDAO.getAbstractCapabilityProposalByID(Integer.parseInt(request.getParameter("id")));
		 abstractCapabilityProposal.setState(request.getParameter("state"));
		 AbstractCapability newAbstractCapability;
		if(request.getParameter("state").equals("refused")){
			// se lo stato è rifiutato allora se è valorizzato il campo idAbstract lo imposto a null 
			//e rimuovo la corrispondente abstract capability
			 abstractCapabilityProposal.setMotivation(request.getParameter("motivation"));
			 newAbstractCapability=abstractCapabilityProposal.getAbstractCapability();
			 System.out.println("STATO RIFIUTATO LA PROPOSTA HA CAP-->"+newAbstractCapability.getIdAbstratCapability());
			 
			 abstractCapabilityProposal.setAbstractCapability(null);
			 abstractCapabilityProposalDAO.saveOrUpdateAbstractCapability(abstractCapabilityProposal);
				
			 System.out.println("HAS CAP-->"+abstractCapabilityProposal.getAbstractCapability());
			 if(newAbstractCapability!=null){
				 System.out.println("ESISTE LA CAP la proposta è rifiutata quindi la emimino");
				 abstractCapabilityDAO.delete(newAbstractCapability);
			 }
		}else{
			//se lo stato è approvato allora creo una nuova Abstract capability e la salvo nel database e inserisco il suo indice come riferiemtno per la proposal 
			
			if(abstractCapabilityProposal.getAbstractCapability()==null){
				System.out.println("LA PROPOSATA NON HA CAP ASSOCIATE NE CREO UNA");
			newAbstractCapability=new AbstractCapability();
			newAbstractCapability.setDescription(abstractCapabilityProposal.getDescription());
			newAbstractCapability.setDomain(abstractCapabilityProposal.getDomain());
			newAbstractCapability.setName(abstractCapabilityProposal.getName());
			newAbstractCapability.setBody(abstractCapabilityProposal.getBody());
			Integer idAbstractCap=abstractCapabilityDAO.saveOrUpdateAbstractCapability(newAbstractCapability);
			abstractCapabilityProposal.setAbstractCapability(newAbstractCapability);
			}
		  	abstractCapabilityProposal.setMotivation("");
		  	abstractCapabilityProposalDAO.saveOrUpdateAbstractCapability(abstractCapabilityProposal);
			
		}
		 System.out.println("MOTIVATION-->"+motivation);
		 System.out.println("MOTIVATION req-->"+ request.getParameter("motivation"));
		// abstractCapabilityProposalDAO.saveOrUpdateAbstractCapability(abstractCapabilityProposal);
			
//		abstractCapability.setDomain(domain);
//		abstractCapabilityDAO.saveOrUpdateAbstractCapability(abstractCapability);
//		abstractCapabilitiesList=abstractCapabilityDAO.getAllAbstractCapabilityByDomain(domain);
//		
		return SUCCESS;
	 }
	
	
	 public String  newAbstractCapabilitiesProposal(){
		 abstractCapabilityProposal = new AbstractCapabilityProposal();
		
		 return SUCCESS;
	 }
	public String saveOrUpdateAbstractCapabilitiesProposal(){

		Domain	 domain = domainDAO.getDomainByID(Integer.parseInt(idDomain));
		System.out.println("CALL UPDATE FOR PROPOSAL-->"+abstractCapabilityProposal.getIdProposal());
		System.out.println("SET NAME FOR PROPOSAL-->"+abstractCapabilityProposal.getName());
		
		abstractCapabilityProposal.setDomain(domain);
		 abstractCapabilityProposal.setAbstractCapability(null);
		 Map session = ActionContext.getContext().getSession();
		 UserDAO userDAO=new UserDAO();
		 User user=userDAO.getUserByID(Integer.parseInt(session.get("id").toString()));
		 abstractCapabilityProposal.setUser(user);
		 abstractCapabilityProposal.setState("waiting");
		abstractCapabilityProposalDAO.saveOrUpdateAbstractCapability(abstractCapabilityProposal);
			
		return SUCCESS;
	}
	
	public AbstractCapabilityProposal getAbstractCapabilityProposal() {
		return abstractCapabilityProposal;
	}

	public void setAbstractCapabilityProposal(
			AbstractCapabilityProposal abstractCapabilityProposal) {
		this.abstractCapabilityProposal = abstractCapabilityProposal;
	}

	public String getIdDomain() {
		return idDomain;
	}

	public void setIdDomain(String idDomain) {
		this.idDomain = idDomain;
	}

	public List<AbstractCapabilityProposal> getAbstractCapabilityProposalsList() {
		return abstractCapabilityProposalsList;
	}

	public void setAbstractCapabilityProposalsList(
			List<AbstractCapabilityProposal> abstractCapabilityProposalsList) {
		this.abstractCapabilityProposalsList = abstractCapabilityProposalsList;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getMotivation() {
		return motivation;
	}

	public void setMotivation(String motivation) {
		this.motivation = motivation;
	}

	
	
	

}
