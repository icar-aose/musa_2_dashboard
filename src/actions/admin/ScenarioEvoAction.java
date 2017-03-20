package actions.admin;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

import dbBean.AbstractCapability;
import dbBean.Domain;
import dbBean.ScenarioEvo;
import dbDAO.AbstractCapabilityDAO;
import dbDAO.DomainDAO;
import dbDAO.ScenarioEvoDAO;

public class ScenarioEvoAction extends ActionSupport implements ModelDriven<ScenarioEvo>{

	private AbstractCapabilityDAO abstractCapabilityDAO=new AbstractCapabilityDAO();
	private ScenarioEvoDAO scenarioEvoDAO= new ScenarioEvoDAO();
	private ScenarioEvo scenarioEvo= new ScenarioEvo();
	private DomainDAO domainDAO=new DomainDAO();
	private List<AbstractCapability> abstractCapabilitiesList=new  ArrayList<AbstractCapability>();
	private Set<ScenarioEvo> scenarioEvos = new HashSet<ScenarioEvo>(0);
	private AbstractCapability abstractCapability;
	private String idAbstractCapability;
	private String idDomain;
	private String idEvo;
	@Override
	public ScenarioEvo getModel() {
		return scenarioEvo;
	}
		
	public String saveOrUpdateScenarioEvo()
	{	
		
		abstractCapability=abstractCapabilityDAO.getAbstractCapabilityByID(Integer.parseInt(idAbstractCapability));
		scenarioEvo.setAbstractCapability(abstractCapability);
		scenarioEvoDAO.saveOrUpdateScenarioEvo(scenarioEvo);
		Domain	 domain = domainDAO.getDomainByID(Integer.parseInt(idDomain));
		abstractCapabilitiesList=abstractCapabilityDAO.getAllAbstractCapabilityByDomain(domain);
		scenarioEvos= new HashSet<ScenarioEvo> ( scenarioEvoDAO.getAllScenarioEvoByAbstractCapability(abstractCapability));
		
		return SUCCESS;
	 }
	
	
	
	 public String edit()
	 {
		 System.out.println("CALL EDITO FOR EVO");
		 
			 HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(ServletActionContext.HTTP_REQUEST);
			 abstractCapability=abstractCapabilityDAO.getAbstractCapabilityByID(Integer.parseInt(idAbstractCapability));
			 scenarioEvo=scenarioEvoDAO.getScenarioEvoByID(Integer.parseInt(request.getParameter("idEvo")));
			 scenarioEvos= new HashSet<ScenarioEvo> ( scenarioEvoDAO.getAllScenarioEvoByAbstractCapability(abstractCapability));
			 Domain	 domain = domainDAO.getDomainByID(Integer.parseInt(idDomain));
			 abstractCapabilitiesList=abstractCapabilityDAO.getAllAbstractCapabilityByDomain(domain);
			 
			 
			 System.out.println("FIND CAP-->"+abstractCapability.getDescription());	
			 System.out.println("DOAMIN DESC-->"+domain.getDescription());
			 System.out.println("get idEvo"+request.getParameter("idEvo"));
			 System.out.println("ID ACAPABI-->"+request.getParameter("idAbstractCapability")); 
			 System.out.println("DESC EVO-->"+scenarioEvo.getDescription());
			 System.out.println("CAp fofr dome--"+abstractCapabilitiesList.size());
			 System.out.println("EVOS-->"+scenarioEvos.size());
			// scenarioEvos= new HashSet<ScenarioEvo> ( scenarioEvoDAO.getAllScenarioEvoByAbstractCapability(abstractCapability));
			 return SUCCESS;
			 
			 
			 
			 
		
			 
	 }
		 
	 public String delete()
	 {
		 HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(ServletActionContext.HTTP_REQUEST);
		 scenarioEvoDAO.deleteScenarioEvo(Integer.parseInt(request.getParameter("idEvo")));
		 System.out.println("ID DOM-->"+idDomain);
		 System.out.println("ID ABST:"+idAbstractCapability);
//		 abstractCapabilityDAO.deleteAbstractCapability(Integer.parseInt(request.getParameter("id")));
//		 Domain	 domain = domainDAO.getDomainByID(Integer.parseInt(request.getParameter("idDomain")));
//		 abstractCapabilitiesList=abstractCapabilityDAO.getAllAbstractCapabilityByDomain(domain);
					
				return SUCCESS;
	 }

	public ScenarioEvo getScenarioEvo() {
		return scenarioEvo;
	}
	public void setScenarioEvo(ScenarioEvo scenarioEvo) {
		this.scenarioEvo = scenarioEvo;
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


	public Set<ScenarioEvo> getScenarioEvos() {
		return scenarioEvos;
	}


	public void setScenarioEvos(Set<ScenarioEvo> scenarioEvos) {
		this.scenarioEvos = scenarioEvos;
	}

	public String getIdEvo() {
		return idEvo;
	}

	public void setIdEvo(String idEvo) {
		this.idEvo = idEvo;
	}


	
	
	
}
