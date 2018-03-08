package actions.customer;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

import dbBean.FunctionalReq;
import dbBean.FunctionalReqRelations;
import dbBean.GoalRelationType;
import dbBean.Specification;
import dbDAO.FunctionalReqDAO;
import dbDAO.FunctionalReqRelationsDAO;
import dbDAO.GoalRelTypeDAO;
import dbDAO.SpecificationDAO;


public class FunctionalReqRelAction extends ActionSupport implements ModelDriven<FunctionalReqRelations>{
	
	private FunctionalReqRelations functionalReqRel=new FunctionalReqRelations();
	private GoalRelationType goalRelationType=new GoalRelationType();
	private List<FunctionalReqRelations> functionalReqRelList=new ArrayList<FunctionalReqRelations>();
	private List<FunctionalReq> functionalReqList=new ArrayList<FunctionalReq>(); 
	private List<GoalRelationType> goalRelationTypeList=new ArrayList<GoalRelationType>(); 
	private SpecificationDAO specificationDAO=new  SpecificationDAO();
	private FunctionalReqRelationsDAO functionalReqRelationsDAO=new FunctionalReqRelationsDAO();
	private FunctionalReqDAO functionalReqDAO=new FunctionalReqDAO();
	private GoalRelTypeDAO goalRelTypeDAO=new GoalRelTypeDAO();
	private String idSpecification,idfunctionalReqByIdStart,idfunctionalReqByIdEnd,idType;
	private String idDomain;
	@Override
	public FunctionalReqRelations getModel() {
		return functionalReqRel;
	}
	
	 public String listFunctionalReqRel(){
		 System.out.println("ID SPECIFICATION TO LIST-->"+idSpecification);
	     Specification specification=specificationDAO.getSpecificationById(Integer.parseInt((idSpecification)));
		 functionalReqRelList=functionalReqRelationsDAO.getAllFunctionalReqRelBySpecification(specification);
		 functionalReqList=functionalReqDAO.getAllFunctionalReqBySpecification(specification);
		 goalRelationTypeList=goalRelTypeDAO.getAllGoalRelationType();
	 return SUCCESS;
	 }
	

	public String saveOrUpdateFunctionalReqRel(){
		 
		 Specification specification=specificationDAO.getSpecificationById(Integer.parseInt(idSpecification));
		 FunctionalReq startRel=functionalReqDAO.getFunctionalReqById(Integer.parseInt(idfunctionalReqByIdStart));
		 FunctionalReq endRel=functionalReqDAO.getFunctionalReqById(Integer.parseInt(idfunctionalReqByIdEnd));
		 GoalRelationType goalRelationType=goalRelTypeDAO.getGoalRelationTypeById(Integer.parseInt(idType));
		 functionalReqRel.setType(goalRelationType);
		 functionalReqRel.setFunctionalReqByIdEnd(endRel);
		 functionalReqRel.setFunctionalReqByIdStart(startRel);
		 functionalReqRel.setSpecification(specification);
		 
		 //System.out.println(functionalReqRel.getName()+functionalReqRel.getFunctionalReqByIdStart().getName()+functionalReqRel.getFunctionalReqByIdEnd().getName()+functionalReqRel.getType());

		 functionalReqRelationsDAO.saveOrUpdateFunctionalReqRel(functionalReqRel);
		 return SUCCESS;
	 }
	 
	 public String deleteFunctionalReqRel()
	 {
	    HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(ServletActionContext.HTTP_REQUEST);
		if(request.getParameter("idFuncReqRel")!=null) {
	    functionalReqRel=functionalReqRelationsDAO.getFunctionalReqRelById(Integer.parseInt((request.getParameter("idFuncReqRel"))));
		functionalReqRelationsDAO.deleteFunctionalReqRel(functionalReqRel);}
		return SUCCESS;
	 }
	 
	 public String edit()
	 {
		      HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(ServletActionContext.HTTP_REQUEST);
		      System.out.println("ID FUNC REQ REL TO EDIT-->"+request.getParameter("idFuncReqRel"));
		      if(request.getParameter("idFuncReqRel")!=null) {
		    	  functionalReqRel=functionalReqRelationsDAO.getFunctionalReqRelById(Integer.parseInt((request.getParameter("idFuncReqRel"))));
		    	  this.setIdType(functionalReqRel.getType().getIdGrt().toString());
		    	  this.setIdfunctionalReqByIdEnd(functionalReqRel.getFunctionalReqByIdEnd().getIdFunctionalReq().toString());
		    	  this.setIdfunctionalReqByIdStart(functionalReqRel.getFunctionalReqByIdStart().getIdFunctionalReq().toString());		
		      }
		      
		     Specification specification=specificationDAO.getSpecificationById(Integer.parseInt((idSpecification)));
			 functionalReqRelList=functionalReqRelationsDAO.getAllFunctionalReqRelBySpecification(specification);
			 functionalReqList=functionalReqDAO.getAllFunctionalReqBySpecification(specification);
			 goalRelationTypeList=goalRelTypeDAO.getAllGoalRelationType();
			 	 
			 return SUCCESS;
	 }
	 
	 
	public FunctionalReqRelations getFunctionalReqRel() {
		return functionalReqRel;
	}
	public void setFunctionalReq(FunctionalReqRelations functionalReqRel) {
		this.functionalReqRel = functionalReqRel;
	}

	public String getIdSpecification() {
		return idSpecification;
	}

	public void setIdSpecification(String idSpecification) {
		this.idSpecification = idSpecification;
	}

	public String getIdfunctionalReqByIdStart() {
		return idfunctionalReqByIdStart;
	}

	public void setIdfunctionalReqByIdStart(String idfunctionalReqByIdStart) {
		this.idfunctionalReqByIdStart = idfunctionalReqByIdStart;
	}
	
	public String getIdfunctionalReqByIdEnd() {
		return idfunctionalReqByIdEnd;
	}

	public void setIdfunctionalReqByIdEnd(String idfunctionalReqByIdEnd) {
		this.idfunctionalReqByIdEnd = idfunctionalReqByIdEnd;
	}
	
	public List<FunctionalReqRelations> getFunctionalReqRelList() {
		return functionalReqRelList;
	}

	public void setFunctionalReqRelList(List<FunctionalReqRelations> functionalReqRelList) {
		this.functionalReqRelList = functionalReqRelList;
	}

	public List<GoalRelationType> getGoalRelationTypeList() {
		return goalRelationTypeList;
	}

	public void setGoalRelationTypeList(List<GoalRelationType> goalRelationTypeList) {
		this.goalRelationTypeList = goalRelationTypeList;
	}	
	
	public String getIdDomain() {
		return idDomain;
	}

	public void setIdDomain(String idDomain) {
		this.idDomain = idDomain;
	}
	
	public String getIdType() {
		return idType;
	}

	public void setIdType(String idType) {
		this.idType = idType;
	}

	public List<FunctionalReq> getFunctionalReqList() {
		return functionalReqList;
	}

	public void setFunctionalReqList(List<FunctionalReq> functionalReqList) {
		this.functionalReqList = functionalReqList;
	}
}
