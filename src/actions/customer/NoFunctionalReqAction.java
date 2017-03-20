package actions.customer;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

import dbBean.FunctionalReq;
import dbBean.NonFunctionalReq;
import dbBean.Specification;
import dbDAO.FunctionalReqDAO;
import dbDAO.NoFunctionalReqDAO;
import dbDAO.SpecificationDAO;

public class NoFunctionalReqAction extends ActionSupport implements ModelDriven<NonFunctionalReq>{

	private NonFunctionalReq nonFunctionalReq=new NonFunctionalReq();
	private List<NonFunctionalReq> nonFunctionalReqList=new ArrayList<NonFunctionalReq>(); 
	private SpecificationDAO specificationDAO=new  SpecificationDAO();
	private NoFunctionalReqDAO  nonFunctionalReqDAO=new NoFunctionalReqDAO();
	private String idSpecification;
	private String idDomain;

	
	
	 public String listNoFunctionalReq(){
		 System.out.println("ID SPECIFICATION TO LIST-->"+idSpecification);
	     Specification specification=specificationDAO.getSpecificationById(Integer.parseInt((idSpecification)));
	     nonFunctionalReqList=nonFunctionalReqDAO.getAllNonFunctionalReqBySpecification(specification);
	 return SUCCESS;
	 }
	 
	 
	 public String saveOrUpdateNoFunctionalReq(){
		 
		 Specification specification=specificationDAO.getSpecificationById(Integer.parseInt(idSpecification));
		 System.out.println("SAVE OR UPDATE-->"+ nonFunctionalReq.getCurrentState());
		 if(nonFunctionalReq.getIdNonFunctionalReq()==null)
			 nonFunctionalReq.setCurrentState("waiting");
		 nonFunctionalReq.setSpecification(specification);
		 nonFunctionalReqDAO.saveOrUpdateNonFunctionalReq(nonFunctionalReq);
		 return SUCCESS;
	 }
	 
	 public String deleteNoFunctionalReq(){
			System.out.println("specificatio ID-->"+nonFunctionalReq.getIdNonFunctionalReq());
			nonFunctionalReqDAO.deleteNonFunctionalReq(nonFunctionalReq);
			return SUCCESS;
		}
	 
	 public String edit()
		{
		      HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(ServletActionContext.HTTP_REQUEST);
		      System.out.println("ID FUNC REQ TO EDIT-->"+request.getParameter("idFunctionalReq"));
		      nonFunctionalReq=nonFunctionalReqDAO.getNonFunctionalReqById(Integer.parseInt((request.getParameter("idNonFunctionalReq"))));
		      System.out.println("EDIT STATE-->"+ nonFunctionalReq.getCurrentState());
		  	
		     Specification specification=specificationDAO.getSpecificationById(Integer.parseInt((idSpecification)));
		     nonFunctionalReqList=nonFunctionalReqDAO.getAllNonFunctionalReqBySpecification(specification);
			 return SUCCESS;
		}
	 
	 public String changeStateNoFunctionalReq(){
		  HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(ServletActionContext.HTTP_REQUEST);
	      System.out.println("ID FUNC REQ TO EDIT-->"+request.getParameter("idFunctionalReq"));
	      nonFunctionalReq=nonFunctionalReqDAO.getNonFunctionalReqById(Integer.parseInt((request.getParameter("idFunctionalReq"))));
			
			 if(nonFunctionalReq.getCurrentState().equals("active"))
				 nonFunctionalReq.setCurrentState("deactivate");
		 else
			 nonFunctionalReq.setCurrentState("active");
			 nonFunctionalReqDAO.saveOrUpdateNonFunctionalReq(nonFunctionalReq);
			 System.out.println("NEW STATE-->"+nonFunctionalReq.getCurrentState());
		 return SUCCESS;
	 }
	 
	public List<NonFunctionalReq> getNonFunctionalReqList() {
		return nonFunctionalReqList;
	}
	public void setNonFunctionalReqList(List<NonFunctionalReq> nonFunctionalReqList) {
		this.nonFunctionalReqList = nonFunctionalReqList;
	}
	public String getIdSpecification() {
		return idSpecification;
	}
	public void setIdSpecification(String idSpecification) {
		this.idSpecification = idSpecification;
	}
	
	@Override
	public NonFunctionalReq getModel() {
		return nonFunctionalReq;
	}
	public NonFunctionalReq getNonFunctionalReq() {
		return nonFunctionalReq;
	}
	public void setNonFunctionalReq(NonFunctionalReq nonFunctionalReq) {
		this.nonFunctionalReq = nonFunctionalReq;
	}


	public String getIdDomain() {
		return idDomain;
	}


	public void setIdDomain(String idDomain) {
		this.idDomain = idDomain;
	}

	

}
