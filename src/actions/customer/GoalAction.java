package actions.customer;

import java.io.UnsupportedEncodingException;
import java.sql.Blob;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
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
	private String idSpecification, idDomain;
	private List<GoalModel> goalModelList = new ArrayList<GoalModel>();
	private List<FunctionalReq> functionalReqList = new ArrayList<FunctionalReq>();
	private List<NonFunctionalReq> nonFunctionalReqList = new ArrayList<NonFunctionalReq>();
	private GoalModel goalModel = new GoalModel();
	private Integer sizeGoalModel;
	private Blob fileJson = null;
	private String jsonContent, graphName, supportContent;
	private String jsonGoalList,jsonQualityList;
	private String flagSaveElements;
	private Map<String, String[]> map = new HashMap<String, String[]>();
	private String[] valueHash=new String[2];
	@Override
	public GoalModel getModel() {
		return goalModel;
	}

	public GoalAction() {

	}

	public String saveOrUpdateGoalModel() {
		Specification specification = specificationDAO.getSpecificationById(Integer.parseInt(idSpecification));
		
		// Parte dedicata al salvataggio dei singoli goal sul db, i goal sono prelevati
		// dal JSON che rappresenta il grafico
		if (flagSaveElements.equals("true")) {
			List<FunctionalReq> funcToDelete = functionalReqDAO.getAllGeneratedFunctionalReqBySpecification(specification);
			functionalReqDAO.deleteFunctionalReqByList(funcToDelete);
			
			
			List<NonFunctionalReq> nonFuncToDelete = nonFunctionalReqDAO.getAllGeneratedNonFunctionalReqBySpecification(specification);
			nonFunctionalReqDAO.deleteNonFunctionalReqByList(nonFuncToDelete);
			
			
			String goalName, goalBody, goalDescr, goalActors, goalPriority,goalId;
			String qualityName, qualityBody, qualityDescr,qualityId;
			String linkSource, linkTarget, linkLabel;
			JsonParser parser = new JsonParser();
			JsonElement jsonTree = parser.parse(supportContent);

			if (jsonTree.isJsonObject()) {
				JsonObject treeObject = jsonTree.getAsJsonObject();
				JsonElement cells = treeObject.get("cells");

				if (cells.isJsonArray()) {
					JsonArray cellsArray = cells.getAsJsonArray();
					//System.out.println("numero di elementi " + cellsArray.size());
										
					for (JsonElement cell : cellsArray) {
						if (cell.isJsonObject()) {
							JsonObject cellObject = cell.getAsJsonObject();
							JsonElement tipo = cellObject.get("type");
							JsonElement attrs = cellObject.get("attrs");
							String rappidId = cellObject.get("id").getAsString();							
							if (attrs.isJsonObject()) {
								JsonObject attrsObject = attrs.getAsJsonObject();
								if (tipo.getAsString().equals("erd.Goal")) {
									JsonElement elemName = attrsObject.get("text");
									JsonElement elemBody = attrsObject.get(".body");
									JsonElement elemActors = attrsObject.get(".actors");
									JsonElement elemPriority = attrsObject.get(".priority");
									JsonElement elemDescription = attrsObject.get(".description");
									JsonElement elemId = attrsObject.get(".idDB");
									
									if(elemId==null)goalId="";
										else
									goalId = elemId.getAsJsonObject().get("text").getAsString();
									
									goalName = elemName.getAsJsonObject().get("text").getAsString();
									goalBody = elemBody.getAsJsonObject().get("text").getAsString();
									goalDescr = elemDescription.getAsJsonObject().get("text").getAsString();
									goalActors = elemActors.getAsJsonObject().get("text").getAsString();
									goalPriority = elemPriority.getAsJsonObject().get("text").getAsString();

									
									FunctionalReq fr = new FunctionalReq();
									FunctionalReq frCheck = null;
									
									if(!(goalId).equals(""))
									frCheck=functionalReqDAO.getFunctionalReqById(Integer.parseInt(goalId));
									if(frCheck!=null)fr=frCheck;
									
									fr.setName(goalName);
									fr.setBody(goalBody);
									fr.setActors(goalActors);
									fr.setSpecification(specification);
									fr.setCurrentState("activated");
									fr.setPriority(goalPriority);
									fr.setDescription(goalDescr);
									fr.setType("generated");
									functionalReqDAO.saveOrUpdateFunctionalReq(fr);
									
									if((goalId).equals("")) {
										JsonObject nuovoID=new JsonObject();										
										nuovoID.addProperty("text", java.util.Objects.toString(fr.getIdFunctionalReq(),""));
										attrsObject.add(".idDB",nuovoID);
									}
									valueHash[0]=java.util.Objects.toString(fr.getIdFunctionalReq(),"");
									valueHash[1]="goal";
									map.put(rappidId,valueHash);									
								}
								if (tipo.getAsString().equals("basic.Quality")) {

									JsonElement elemQualityName = attrsObject.get("text");
									JsonElement elemQualityBody = attrsObject.get(".body");
									JsonElement elemQualityDescription = attrsObject.get(".description");
									JsonElement elemQualityId = attrsObject.get(".idDB");
									
									if(elemQualityId==null)qualityId="";
										else
									qualityId = elemQualityId.getAsJsonObject().get("text").getAsString();
									qualityName = elemQualityName.getAsJsonObject().get("text").getAsString();
									qualityBody = elemQualityBody.getAsJsonObject().get("text").getAsString();
									qualityDescr = elemQualityDescription.getAsJsonObject().get("text").getAsString();
									
									NonFunctionalReq nfr = new NonFunctionalReq();
									NonFunctionalReq nfrCheck = null;
									
									if(!(qualityId).equals(""))
									nfrCheck=nonFunctionalReqDAO.getNonFunctionalReqById(Integer.parseInt(qualityId));
									if(nfrCheck!=null)nfr=nfrCheck;
									
									nfr.setName(qualityName);
									nfr.setValue(qualityBody);
									nfr.setSpecification(specification);
									nfr.setDescription(qualityDescr);
									nfr.setType("generated");
									nfr.setCurrentState("waiting");
									nonFunctionalReqDAO.saveOrUpdateNonFunctionalReq(nfr);
									
									if((qualityId).equals("")) {
										JsonObject nuovoID=new JsonObject();										
										nuovoID.addProperty("text", java.util.Objects.toString(nfr.getIdNonFunctionalReq(),""));
										attrsObject.add(".idDB",nuovoID);
									}
									valueHash[0]=java.util.Objects.toString(nfr.getIdNonFunctionalReq(),"");
									valueHash[1]="quality";
									map.put(rappidId,valueHash);
								}

							}
						}

					}
/*					
					for (JsonElement cell : cellsArray) {
						if (cell.isJsonObject()) {
							JsonObject cellObject = cell.getAsJsonObject();
							JsonElement tipo = cellObject.get("type");
							JsonElement source = cellObject.get("source");
							JsonElement target = cellObject.get("target");							
							JsonElement attrs = cellObject.get("attrs");
							if (attrs.isJsonObject()) {
								JsonObject attrsObject = attrs.getAsJsonObject();
								
								if (tipo.getAsString().equals("app.Link")) {
									JsonElement source = cellObject.get("source");
									JsonElement target = cellObject.get("target");		
									JsonElement labels = cellObject.get("labels");	
									linkSource = source.getAsJsonObject().get("id").getAsString();
									linkTarget = target.getAsJsonObject().get("id").getAsString();
									linkLabel = labels.getAsJsonObject().get("text").getAsString();
									
								}	
							
							}
						}
					}
*/
				}		
				supportContent=java.util.Objects.toString(treeObject);
			}

		}
		
		// Parte dedicata al salvataggio del Grafico come JSON su DB
		
		goalModelList = goalModelDAO.getAllGoalModelBySpecification(specification);
		if (goalModelList.size() > 0)
			goalModel = goalModelList.get(0);
		goalModel.setSpecification(specification);
		byte[] byteData;

		try {
			byteData = this.getSupportContent().getBytes("UTF-8");
			fileJson = new javax.sql.rowset.serial.SerialBlob(byteData);
		} catch (UnsupportedEncodingException | SQLException e1) {
			e1.printStackTrace();
		}

		goalModel.setName(this.getGraphName());
		goalModel.setJson(fileJson);
		goalModelDAO.saveOrUpdateGoalModel(goalModel);
		
		return SUCCESS;
	}

	public String listGoalModel() {
		Gson gson= new GsonBuilder().excludeFieldsWithoutExposeAnnotation().create();
		Specification specification = specificationDAO.getSpecificationById(Integer.parseInt((idSpecification)));
		goalModelList = goalModelDAO.getAllGoalModelBySpecification(specification);
		functionalReqList = functionalReqDAO.getAllManualFunctionalReqBySpecification(specification);
		nonFunctionalReqList = nonFunctionalReqDAO.getAllManualNonFunctionalReqBySpecification(specification);
		sizeGoalModel = goalModelList.size();
		if (sizeGoalModel == 0)
			this.setJsonContent("");
		else {
			try {
				this.setFileJson(goalModelList.get(0).getJson());
				this.setJsonContent(new String(fileJson.getBytes(1l, (int) fileJson.length())));
				this.setGraphName(goalModelList.get(0).getName());
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		int goalSize = functionalReqList.size();
		if (goalSize > 0) {
			jsonGoalList =gson.toJson(functionalReqList);
		} else {
			jsonGoalList =gson.toJson(null);
		}

		int qualitySize = nonFunctionalReqList.size();

		if (qualitySize > 0) {
			jsonQualityList= gson.toJson(nonFunctionalReqList);
		} else {
			jsonQualityList= gson.toJson(null);

		}

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

	public String getJsonGoalList() {
		return jsonGoalList;
	}

	public void setJsonGoalList(String jsonGoalList) {
		this.jsonGoalList = jsonGoalList;
	}

	public String getJsonQualityList() {
		return jsonQualityList;
	}

	public void setJsonQualityList(String jsonQualityList) {
		this.jsonQualityList = jsonQualityList;
	}

	public String getFlagSaveElements() {
		return flagSaveElements;
	}

	public void setFlagSaveElements(String flagSaveElements) {
		this.flagSaveElements = flagSaveElements;
	}
}