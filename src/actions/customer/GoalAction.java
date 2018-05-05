package actions.customer;

import java.io.UnsupportedEncodingException;
import java.sql.Blob;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

import dbBean.FunctionalReq;
import dbBean.GoalModel;
import dbBean.Specification;
import dbDAO.FunctionalReqDAO;
import dbDAO.GoalModelDAO;
import dbDAO.SpecificationDAO;



public class GoalAction extends ActionSupport implements ModelDriven<GoalModel> {

	private GoalModelDAO goalModelDAO = new GoalModelDAO();
	private SpecificationDAO specificationDAO = new SpecificationDAO();
	private FunctionalReqDAO functionalReqDAO = new FunctionalReqDAO();
	private String idSpecification;
	private String idDomain;
	private List<GoalModel> goalModelList = new ArrayList<GoalModel>();
	private List<FunctionalReq> functionalReqList = new ArrayList<FunctionalReq>();
	private GoalModel goalModel = new GoalModel();
	private Integer sizeGoalModel;
	private Blob fileJson=null;
	private String jsonContent,graphName;
	private String supportContent;
	private String goalName,goalBody;
	
	@Override
	public GoalModel getModel() {
		return goalModel;
	}


	public  GoalAction() {

	}
	
	public String saveOrUpdateGoalModel() {
		Specification specification = specificationDAO.getSpecificationById(Integer.parseInt(idSpecification));
		goalModelList = goalModelDAO.getAllGoalModelBySpecification(specification);
		goalModel=goalModelList.get(0);
		goalModel.setSpecification(specification);
		byte[] byteData;
		
		try {
			byteData = this.getSupportContent().getBytes("UTF-8");
			fileJson=new javax.sql.rowset.serial.SerialBlob(byteData);
		} catch (UnsupportedEncodingException|SQLException e1) {e1.printStackTrace();}
		
		goalModel.setName(this.getGraphName());		
		goalModel.setJson(fileJson);
		goalModelDAO.saveOrUpdateGoalModel(goalModel);
		return SUCCESS;
	}

	public String listGoalModel() {
	
		Specification specification = specificationDAO.getSpecificationById(Integer.parseInt((idSpecification)));
		goalModelList = goalModelDAO.getAllGoalModelBySpecification(specification);
		functionalReqList = functionalReqDAO.getAllFunctionalReqBySpecification(specification);
		sizeGoalModel = goalModelList.size();
		if(sizeGoalModel==0)
			this.setFileJson(null);
		else { 
			this.setFileJson(goalModelList.get(0).getJson());
			try {
				this.setJsonContent(new String(fileJson.getBytes(1l, (int) fileJson.length())));
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		this.setGraphName(goalModelList.get(0).getName());
		HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(ServletActionContext.HTTP_REQUEST);
		request.setAttribute("listaGoal",functionalReqList);
		this.setGoalName("");
		this.setGoalBody("");
		for(FunctionalReq f:functionalReqList) {
			this.setGoalName(this.getGoalName().concat(f.getName()).concat("~~"));
			this.setGoalBody(this.getGoalBody().concat(f.getBody()).concat("~~"));
		}
		System.out.println(goalName);
		System.out.println(goalBody);
		return SUCCESS;
	}
	
	public String getIdSpecification() {
		return idSpecification;
	}

	public void setIdSpecification(String idSpecification) {
		this.idSpecification = idSpecification;
	}
	
	public String getJsonContent() {
		return jsonContent;
	}

	public void setJsonContent(String jsonContent) {
		this.jsonContent = jsonContent;
	}	
	public String getGraphName() {
		return graphName;
	}

	public void setGraphName(String graphName) {
		this.graphName = graphName;
	}
	
	public String getIdDomain() {
		return idDomain;
	}

	public void setIdDomain(String idDomain) {
		this.idDomain = idDomain;
	}
	
	public Integer getSizeGoalModel() {
		return sizeGoalModel;
	}

	public void setSizeGoalModel(Integer sizeGoalModel) {
		this.sizeGoalModel = sizeGoalModel;
	}
	
	public List<GoalModel> getGoalModelList() {
		return goalModelList;
	}

	public void setGoalModelList(List<GoalModel> goalModelList) {
		this.goalModelList = goalModelList;
	}
	
	public Blob getFileJson() {
		return fileJson;
	}

	public void setFileJson(Blob fileJson) {

		this.fileJson = fileJson;
	}	
	
	public String getSupportContent() {
		return supportContent;
	}

	public void setSupportContent(String supportContent) {
		this.supportContent = supportContent;
	}
	
	public List<FunctionalReq> getFunctionalReqList() {
		return functionalReqList;
	}

	public void setFunctionalReqList(List<FunctionalReq> functionalReqList) {
		this.functionalReqList = functionalReqList;
	}
	
	public String getGoalName() {
		return goalName;
	}

	public void setGoalName(String goalName) {
		this.goalName = goalName;
	}
	public String getGoalBody() {
		return goalBody;
	}

	public void setGoalBody(String goalBody) {
		this.goalBody = goalBody;
	}
	
}
