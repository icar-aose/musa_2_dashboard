package actions.customer;

import java.util.ArrayList;
import java.util.List;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

import dbBean.CaseExecution;
import dbBean.Process;
import dbBean.Specification;
import dbDAO.CasesDAO;
import dbDAO.SpecificationDAO;

public class CasesAction extends ActionSupport implements ModelDriven<CaseExecution>{

	private CaseExecution caseExecution =new CaseExecution();
	private List<CaseExecution> casesExecutionList=new ArrayList<CaseExecution>();
	private CasesDAO casesDAO=new CasesDAO();
	private String idSpecification;
	private SpecificationDAO specificationDAO=new  SpecificationDAO();

	
	 public String listCases(){
		 Specification specification=specificationDAO.getSpecificationById(Integer.parseInt((idSpecification)));
		 casesExecutionList= casesDAO.getAllCasesBySpecification(specification);
		 return SUCCESS;
	 }
	
	 public String detailsCase(){
		 
		 return SUCCESS;
	 }
	 
	@Override
	public CaseExecution getModel() {
		return caseExecution;
	}

	public CaseExecution getCaseExecution() {
		return caseExecution;
	}

	public void setCaseExecution(CaseExecution caseExecution) {
		this.caseExecution = caseExecution;
	}


	public String getIdSpecification() {
		return idSpecification;
	}

	public void setIdSpecification(String idSpecification) {
		this.idSpecification = idSpecification;
	}

	public List<CaseExecution> getCasesExecutionList() {
		return casesExecutionList;
	}

	public void setCasesExecutionList(List<CaseExecution> casesExecutionList) {
		this.casesExecutionList = casesExecutionList;
	}

	

}
