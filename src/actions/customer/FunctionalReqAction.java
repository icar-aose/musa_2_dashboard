package actions.customer;

import org.msgagent.SendMsg;
import java.util.ArrayList;
import java.util.List;

import javax.jms.Connection;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

import dbBean.Domain;
import dbBean.FunctionalReq;
import dbBean.Specification;
import dbDAO.FunctionalReqDAO;
import dbDAO.SpecificationDAO;


public class FunctionalReqAction extends ActionSupport implements ModelDriven<FunctionalReq>{
	private SendMsg classeInvioMsg=new SendMsg();

	private FunctionalReq functionalReq=new FunctionalReq();
	private List<FunctionalReq> functionalReqList=new ArrayList<FunctionalReq>(); 
	private SpecificationDAO specificationDAO=new  SpecificationDAO();
	private FunctionalReqDAO functionalReqDAO=new FunctionalReqDAO();
	private String idSpecification;
	private String idDomain;
	private Integer sizeFunctionalReq;
	@Override
	public FunctionalReq getModel() {
		return functionalReq;
	}
	
	 public String listFunctionalReq(){
		 System.out.println("ID SPECIFICATION TO LIST-->"+idSpecification);
	     Specification specification=specificationDAO.getSpecificationById(Integer.parseInt((idSpecification)));
		 functionalReqList=functionalReqDAO.getAllFunctionalReqBySpecification(specification);
		 sizeFunctionalReq=functionalReqList.size();
	 return SUCCESS;
	 }
	

	public String saveOrUpdateFunctionalReq(){
		 
		 Specification specification=specificationDAO.getSpecificationById(Integer.parseInt(idSpecification));
		 System.out.println("FUNCTIONAL REQ CURRENT STATE-->"+functionalReq.getCurrentState());
		 if(functionalReq.getIdFunctionalReq()==null){
			 functionalReq.setCurrentState("waiting");		
		 }
		 functionalReq.setType("manual");
		 functionalReq.setSpecification(specification);
		 functionalReqDAO.saveOrUpdateFunctionalReq(functionalReq);
		 return SUCCESS;
	 }
	 
	 public String deleteFunctionalReq()
	 {
		 HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(ServletActionContext.HTTP_REQUEST);
	      System.out.println("ID FUNC REQ TO delete-->"+request.getParameter("idFunctionalReq"));
	      if(request.getParameter("idFunctionalReq")!=null) {
	      functionalReq=functionalReqDAO.getFunctionalReqById(Integer.parseInt((request.getParameter("idFunctionalReq"))));
		functionalReqDAO.deleteFunctionalReq(functionalReq);
	     Specification specification=specificationDAO.getSpecificationById(Integer.parseInt((idSpecification)));
		 functionalReqList=functionalReqDAO.getAllFunctionalReqBySpecification(specification);
		 sizeFunctionalReq=functionalReqList.size();	      
	      }
			return SUCCESS;
	 }
	 
	 public String edit()
	 {
		      HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(ServletActionContext.HTTP_REQUEST);
		      System.out.println("ID FUNC REQ TO EDIT-->"+request.getParameter("idFunctionalReq"));
		      if(request.getParameter("idFunctionalReq")!=null)
		      functionalReq=functionalReqDAO.getFunctionalReqById(Integer.parseInt((request.getParameter("idFunctionalReq"))));
		      
		    	  
		     Specification specification=specificationDAO.getSpecificationById(Integer.parseInt((idSpecification)));
			 functionalReqList=functionalReqDAO.getAllFunctionalReqBySpecification(specification);
			 return SUCCESS;
	 }
	 
	 
	 public String changeStateFunctionalReq(){
		 
		 HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(ServletActionContext.HTTP_REQUEST);
	     System.out.println("ID FUNC REQ TO EDIT-->"+request.getParameter("idFunctionalReq"));
	     functionalReq=functionalReqDAO.getFunctionalReqById(Integer.parseInt((request.getParameter("idFunctionalReq"))));
	     Connection connection=classeInvioMsg.startConnection();
	     if(connection==null) {return("erroreMQ");}
			
	     if(functionalReq.getCurrentState().equals("activated"))
			 functionalReq.setCurrentState("deactivated");
		 else
			 functionalReq.setCurrentState("activated");
	     
		 String res=classeInvioMsg.sendMsg(connection,"FUNCTIONAL REQ: "+functionalReq.getName()+" STATE: "+functionalReq.getCurrentState());
		 if(!res.equals("INVIATO")) {return("erroreMQ");}
		 
			 System.out.println(" STATE-->"+functionalReq.getCurrentState());
			 functionalReqDAO.saveOrUpdateFunctionalReq(functionalReq);
			 System.out.println("NEW STATE-->"+functionalReq.getCurrentState());
			 this.listFunctionalReq();
		 return SUCCESS;
	 }
	 
	public FunctionalReq getFunctionalReq() {
		return functionalReq;
	}
	public void setFunctionalReq(FunctionalReq functionalReq) {
		this.functionalReq = functionalReq;
	}

	public String getIdSpecification() {
		return idSpecification;
	}

	public void setIdSpecification(String idSpecification) {
		this.idSpecification = idSpecification;
	}

	public List<FunctionalReq> getFunctionalReqList() {
		return functionalReqList;
	}

	public void setFunctionalReqList(List<FunctionalReq> functionalReqList) {
		this.functionalReqList = functionalReqList;
	}

	public String getIdDomain() {
		return idDomain;
	}

	public void setIdDomain(String idDomain) {
		this.idDomain = idDomain;
	}
	 public Integer getSizeFunctionalReq() {
		return sizeFunctionalReq;
	}

	public void setSizeFunctionalReq(Integer sizeFunctionalReq) {
		this.sizeFunctionalReq = sizeFunctionalReq;
	}
	
	
}
