package actions.customer;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

import dbBean.CapabilityInstance;
import dbBean.CapabilityLog;
import dbBean.CaseExecution;
import dbBean.Specification;
import dbDAO.CapabilityInstanceDAO;
import dbDAO.CapabilityLogDAO;
import dbDAO.CasesDAO;

public class CapabilityInstanceAction extends ActionSupport implements ModelDriven<CapabilityInstance>{

	private CapabilityInstance capabilityInstance=new CapabilityInstance();
	private List<CapabilityInstance> capabilityInstanceList=new ArrayList<CapabilityInstance>();
	private List<CapabilityLog> capabilityLogList=new ArrayList<>();
	private CapabilityInstanceDAO capabilityInstanceDAO=new CapabilityInstanceDAO();
	private String idCaseExecution;
	private CasesDAO caseDAO=new CasesDAO();
	@Override
	public CapabilityInstance getModel() {
			return capabilityInstance;
	}
	
	
	 public String listCapabilityInstance(){
		 CaseExecution caseExecution= caseDAO.getCaseExecutionById(Integer.parseInt((idCaseExecution)));
		 capabilityInstanceList= capabilityInstanceDAO.getAllCapabilityInstanceByCases(caseExecution);
		 return SUCCESS;
	 }

	 public String  actionLogConcreteAbstractCapabilities(){
		 
		 CapabilityInstanceDAO capabilityInstanceDAO=new  CapabilityInstanceDAO();
		 HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(ServletActionContext.HTTP_REQUEST);
		 capabilityInstance=capabilityInstanceDAO.getCapabilityInstanceByID(Integer.parseInt(request.getParameter("idCapabilityInstance")));
		 System.out.println("CAP INSTANCE STATE-_>"+capabilityInstance.getState());
		 CapabilityLogDAO capabilityLogDAO=new CapabilityLogDAO();
		 capabilityLogList=capabilityLogDAO.getAllCapabilityLogByInstance(capabilityInstance);
		 System.out.println("capabilityLogList.size()-->"+capabilityLogList.size());
		 return SUCCESS;
	 }
	public CapabilityInstance getCapabilityInstance() {
		return capabilityInstance;
	}


	public void setCapabilityInstance(CapabilityInstance capabilityInstance) {
		this.capabilityInstance = capabilityInstance;
	}


	public List<CapabilityInstance> getCapabilityInstanceList() {
		return capabilityInstanceList;
	}


	public void setCapabilityInstanceList(
			List<CapabilityInstance> capabilityInstanceList) {
		this.capabilityInstanceList = capabilityInstanceList;
	}


	public String getIdCaseExecution() {
		return idCaseExecution;
	}


	public void setIdCaseExecution(String idCaseExecution) {
		this.idCaseExecution = idCaseExecution;
	}


	public List<CapabilityLog> getCapabilityLogList() {
		return capabilityLogList;
	}


	public void setCapabilityLogList(List<CapabilityLog> capabilityLogList) {
		this.capabilityLogList = capabilityLogList;
	}
	
	 

}
