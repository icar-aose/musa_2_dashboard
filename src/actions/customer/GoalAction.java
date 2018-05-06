package actions.customer;

import java.io.UnsupportedEncodingException;
import java.sql.Blob;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

import dbBean.FunctionalReq;
import dbBean.GoalModel;
import dbBean.NonFunctionalReq;
import dbBean.Specification;
import dbDAO.FunctionalReqDAO;
import dbDAO.GoalModelDAO;
import dbDAO.NoFunctionalReqDAO;
import dbDAO.SpecificationDAO;



public class GoalAction extends ActionSupport implements ModelDriven<GoalModel> {

	private GoalModelDAO goalModelDAO = new GoalModelDAO();
	private SpecificationDAO specificationDAO = new SpecificationDAO();
	private FunctionalReqDAO functionalReqDAO = new FunctionalReqDAO();
	private NoFunctionalReqDAO nonFunctionalReqDAO = new NoFunctionalReqDAO();
	private String idSpecification,idDomain;
	private List<GoalModel> goalModelList = new ArrayList<GoalModel>();
	private List<FunctionalReq> functionalReqList = new ArrayList<FunctionalReq>();
	private List<NonFunctionalReq> nonFunctionalReqList = new ArrayList<NonFunctionalReq>();
	private GoalModel goalModel = new GoalModel();
	private Integer sizeGoalModel;
	private Blob fileJson=null;
	private String jsonContent,graphName,supportContent;
	private String jsonNameList,jsonBodyList,jsonPriorityList,jsonActorsList,jsonDescriptionList;
	private String jsonQualityNameList,jsonQualityBodyList,jsonQualityDescriptionList;	
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
		nonFunctionalReqList = nonFunctionalReqDAO.getAllNonFunctionalReqBySpecification(specification);
		sizeGoalModel = goalModelList.size();
		if(sizeGoalModel==0)
			this.setJsonContent("");
		else { 
			try {
				this.setFileJson(goalModelList.get(0).getJson());
				this.setJsonContent(new String(fileJson.getBytes(1l, (int) fileJson.length())));
				this.setGraphName(goalModelList.get(0).getName());
			} catch (SQLException e) {e.printStackTrace();}
		}
		
		int goalSize=functionalReqList.size();
		if(goalSize>0) {
			String[] goalName=new String[goalSize];
			String[] goalBody=new String[goalSize];
			String[] goalPriority=new String[goalSize];
			String[] goalActors=new String[goalSize];
			String[] goalDescription=new String[goalSize];		
			int i=0;
			for(FunctionalReq f:functionalReqList) {
				goalName[i]=java.util.Objects.toString(f.getName());
				goalBody[i]=java.util.Objects.toString(f.getBody());
				goalPriority[i]=java.util.Objects.toString(f.getPriority());
				goalActors[i]=java.util.Objects.toString(f.getActors());
				goalDescription[i]=java.util.Objects.toString(f.getDescription());
				i+=1;
			}
			jsonNameList = new Gson().toJson(goalName);
			jsonBodyList = new Gson().toJson(goalBody);
			jsonPriorityList = new Gson().toJson(goalPriority);
			jsonActorsList = new Gson().toJson(goalActors);
			jsonDescriptionList = new Gson().toJson(goalDescription);
		}else{
			jsonNameList = jsonBodyList=jsonPriorityList=jsonActorsList=jsonDescriptionList=new Gson().toJson(null);
		}
		
		int qualitySize=nonFunctionalReqList.size();
		
		if(qualitySize>0) {
			String[] qualityName=new String[qualitySize];
			String[] qualityBody=new String[qualitySize];
			String[] qualityDescription=new String[qualitySize];		
			int j=0;
			for(NonFunctionalReq g:nonFunctionalReqList) {
				qualityName[j]=java.util.Objects.toString(g.getName());
				qualityBody[j]=java.util.Objects.toString(g.getValue());
				qualityDescription[j]=java.util.Objects.toString(g.getDescription());
				j+=1;
			}
			jsonQualityNameList = new Gson().toJson(qualityName);
			jsonQualityBodyList = new Gson().toJson(qualityBody);
			jsonQualityDescriptionList = new Gson().toJson(qualityDescription);
		}else
		{
			jsonQualityNameList = jsonQualityBodyList=jsonQualityDescriptionList=new Gson().toJson(null);

		}
		System.out.println(jsonQualityNameList);
		System.out.println(jsonQualityBodyList);
		System.out.println(jsonQualityDescriptionList);

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

	public List<NonFunctionalReq> getNonFunctionalReqList() {
		return nonFunctionalReqList;
	}

	public void setNonFunctionalReqList(List<NonFunctionalReq> nonFunctionalReqList) {
		this.nonFunctionalReqList = nonFunctionalReqList;
	}	
	
	public String getJsonNameList() {
		return jsonNameList;
	}

	public void setJsonNameList(String jsonNameList) {
		this.jsonNameList = jsonNameList;
	}
	public String getJsonBodyList() {
		return jsonBodyList;
	}

	public void setJsonBodyList(String jsonBodyList) {
		this.jsonBodyList = jsonBodyList;
	}
	public String getJsonPriorityList() {
		return jsonPriorityList;
	}

	public void setJsonPriorityList(String jsonPriorityList) {
		this.jsonPriorityList = jsonPriorityList;
	}
	public String getJsonActorsList() {
		return jsonActorsList;
	}

	public void setJsonDescriptionList(String jsonDescriptionList) {
		this.jsonDescriptionList = jsonDescriptionList;
	}
	public String getJsonDescriptionList() {
		return jsonDescriptionList;
	}

	public void setJsonActorsList(String jsonActorsList) {
		this.jsonActorsList = jsonActorsList;
	}	
	
	
	public void setJsonQualityDescriptionList(String jsonQualityDescriptionList) {
		this.jsonQualityDescriptionList = jsonDescriptionList;
	}
	public String getJsonQualityDescriptionList() {
		return jsonQualityDescriptionList;
	}
	
	public void setJsonQualityNameList(String jsonQualityNameList) {
		this.jsonQualityNameList = jsonQualityNameList;
	}
	
	public String getJsonQualityNameList() {
		return jsonQualityNameList;
	}
	
	public String getJsonQualityBodyList() {
		return jsonQualityBodyList;
	}

	public void setJsonQualityBodyList(String jsonQualityBodyList) {
		this.jsonQualityBodyList = jsonQualityBodyList;
	}
}
