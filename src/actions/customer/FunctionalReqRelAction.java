package actions.customer;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

import dbBean.FunctionalReqRelations;
import dbBean.Specification;
import dbDAO.FunctionalReqRelationsDAO;
import dbDAO.SpecificationDAO;


public class FunctionalReqRelAction extends ActionSupport implements ModelDriven<FunctionalReqRelations>{
	
	private FunctionalReqRelations functionalReqRel=new FunctionalReqRelations();
	private List<FunctionalReqRelations> functionalReqRelList=new ArrayList<FunctionalReqRelations>(); 
	private SpecificationDAO specificationDAO=new  SpecificationDAO();
	private FunctionalReqRelationsDAO functionalReqRelationsDAO=new FunctionalReqRelationsDAO();
	private String idSpecification;
	private String idDomain;
	@Override
	public FunctionalReqRelations getModel() {
		return functionalReqRel;
	}
	
	 public String listFunctionalReqRel(){
		 System.out.println("ID SPECIFICATION TO LIST-->"+idSpecification);
	     Specification specification=specificationDAO.getSpecificationById(Integer.parseInt((idSpecification)));
		 functionalReqRelList=functionalReqRelationsDAO.getAllFunctionalReqRelBySpecification(specification);

	 return SUCCESS;
	 }
	

	public String saveOrUpdateFunctionalReqRel(){
		 
		 Specification specification=specificationDAO.getSpecificationById(Integer.parseInt(idSpecification));

		 functionalReqRelationsDAO.saveOrUpdateFunctionalReqRel(functionalReqRel);
		 return SUCCESS;
	 }
	 
	 public String deleteFunctionalReq()
	 {
			functionalReqRelationsDAO.deleteFunctionalReqRel(functionalReqRel);
			return SUCCESS;
	 }
	 
	 public String edit()
	 {
		      HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(ServletActionContext.HTTP_REQUEST);
		      System.out.println("ID FUNC REQ TO EDIT-->"+request.getParameter("idFunctionalReq"));
		      if(request.getParameter("idFunctionalReq")!=null)
		      functionalReqRel=functionalReqRelationsDAO.getFunctionalReqRelById(Integer.parseInt((request.getParameter("idFunctionalReqRel"))));
		      
		     Specification specification=specificationDAO.getSpecificationById(Integer.parseInt((idSpecification)));
			 functionalReqRelList=functionalReqRelationsDAO.getAllFunctionalReqRelBySpecification(specification);
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

	public List<FunctionalReqRelations> getFunctionalReqRelList() {
		return functionalReqRelList;
	}

	public void setFunctionalReqRelList(List<FunctionalReqRelations> functionalReqRelList) {
		this.functionalReqRelList = functionalReqRelList;
	}

	public String getIdDomain() {
		return idDomain;
	}

	public void setIdDomain(String idDomain) {
		this.idDomain = idDomain;
	}

	
}
