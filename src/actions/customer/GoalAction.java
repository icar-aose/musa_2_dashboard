package actions.customer;

import java.io.UnsupportedEncodingException;
import java.sql.Blob;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

import dbBean.FunctionalReq;
import dbBean.FunctionalReqRelations;
import dbBean.GoalModel;
import dbBean.NonFunctionalReq;
import dbBean.Specification;
import dbDAO.FunctionalReqDAO;
import dbDAO.FunctionalReqRelationsDAO;
import dbDAO.GoalModelDAO;
import dbDAO.GoalRelTypeDAO;
import dbDAO.NoFunctionalReqDAO;
import dbDAO.SpecificationDAO;

public class GoalAction extends ActionSupport implements ModelDriven<GoalModel> {

	private GoalModelDAO goalModelDAO = new GoalModelDAO();
	private GoalRelTypeDAO goalRelTypeDAO = new GoalRelTypeDAO();	
	private SpecificationDAO specificationDAO = new SpecificationDAO();
	private FunctionalReqDAO functionalReqDAO = new FunctionalReqDAO();
	private FunctionalReqRelationsDAO functionalReqRelationsDAO = new FunctionalReqRelationsDAO();	
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
	private GoalAndQualityMapper gqMapper = new GoalAndQualityMapper();
	private Map<String,GoalAndQualityMapper> mappaID;
	
	@Override
	public GoalModel getModel() {
		return goalModel;
	}

	public GoalAction() {

	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String saveOrUpdateGoalModel() {
		Specification specification = specificationDAO.getSpecificationById(Integer.parseInt(idSpecification));
		
		// Parte dedicata al salvataggio dei singoli goal sul db, i goal sono prelevati
		// dal JSON che rappresenta il grafico
		if (flagSaveElements.equals("true")) {
			List<FunctionalReq> funcToDelete = functionalReqDAO.getAllGeneratedFunctionalReqBySpecification(specification);
			functionalReqDAO.deleteFunctionalReqByList(funcToDelete);
			
			
			List<NonFunctionalReq> nonFuncToDelete = nonFunctionalReqDAO.getAllGeneratedNonFunctionalReqBySpecification(specification);
			nonFunctionalReqDAO.deleteNonFunctionalReqByList(nonFuncToDelete);
			
			Gson gson = new Gson();
			String jsonString=supportContent;

			Map map = gson.fromJson(jsonString, Map.class);
			ArrayList<Map<String,String>> maps=(ArrayList) map.get("cells");
			System.out.println(maps.size());
			
			//Mappo goal e quality
			for(Map m:maps) {
				String type=java.util.Objects.toString(m.get("type")).trim();
				//Mapping Goal
					if(type.equals("erd.Goal")) {
						String name,body,description,priority,actors,goalID,rappidID;
						Map attrs = (Map) m.get("attrs");
						
						Map nameTxt=(Map) attrs.get("text");
						Map bodyTxt=(Map) attrs.get(".body");
						Map descriptionTxt=(Map) attrs.get(".description");
						Map priorityTxt=(Map) attrs.get(".priority");
						Map actorsTxt=(Map) attrs.get(".actors");
						Map goalIdtxt=(Map) attrs.get(".idDB");
						
						rappidID=java.util.Objects.toString(m.get("id"));
						name=java.util.Objects.toString(nameTxt.get("text"));
						body=java.util.Objects.toString(bodyTxt.get("text"));
						description=java.util.Objects.toString(descriptionTxt.get("text"));
						priority=java.util.Objects.toString(priorityTxt.get("text"));								
						actors=java.util.Objects.toString(actorsTxt.get("text"));
						
						if(goalIdtxt==null)goalID="";
						else
						goalID = java.util.Objects.toString(goalIdtxt.get("text"));
						
						FunctionalReq fr = new FunctionalReq();
						FunctionalReq frCheck = null;
						
						if(!(goalID).equals(""))
						frCheck=functionalReqDAO.getFunctionalReqById(Integer.parseInt(goalID));
						if(frCheck!=null)fr=frCheck;
						
						fr.setName(name);					fr.setBody(body);
						fr.setActors(actors);				fr.setSpecification(specification);
						fr.setCurrentState("activated");	fr.setPriority(priority);
						fr.setDescription(description);		fr.setType("generated");
						
						functionalReqDAO.saveOrUpdateFunctionalReq(fr);
						
						if(goalID.equals("")) {
							goalID=java.util.Objects.toString(fr.getIdFunctionalReq(),"");
							goalIdtxt.put("text",goalID);
						}
						
						gqMapper.setAll(goalID, type);
						mappaID.put(rappidID, gqMapper);
						
					}
					
					
					//Mapping Quality
					if(type.equals("basic.Quality")) {
						String name,body,description,qualityID,rappidID;
						Map attrs = (Map) m.get("attrs");
						
						Map nameTxt=(Map) attrs.get("text");
						Map bodyTxt=(Map) attrs.get(".body");
						Map descriptionTxt=(Map) attrs.get(".description");
						Map qualityIdtxt=(Map) attrs.get(".idDB");
						
						rappidID=java.util.Objects.toString(m.get("id"));
						name=java.util.Objects.toString(nameTxt.get("text"));
						body=java.util.Objects.toString(bodyTxt.get("text"));
						description=java.util.Objects.toString(descriptionTxt.get("text"));
						
						if(qualityIdtxt==null)qualityID="";
						else
						qualityID=java.util.Objects.toString(qualityIdtxt.get("text"));
						
						NonFunctionalReq nfr = new NonFunctionalReq();
						NonFunctionalReq nfrCheck = null;
						
						if(!(qualityID).equals(""))
						nfrCheck=nonFunctionalReqDAO.getNonFunctionalReqById(Integer.parseInt(qualityID));
						if(nfrCheck!=null)nfr=nfrCheck;
						
						nfr.setName(name);						
						nfr.setSpecification(specification);	
							
						nfr.setDescription(description);	
						nfr.setValue(body);
						nfr.setType("generated");
						nfr.setCurrentState("activated");
						
						nonFunctionalReqDAO.saveOrUpdateNonFunctionalReq(nfr);
						
						if(qualityID.equals("")) {
							qualityID=java.util.Objects.toString(nfr.getIdNonFunctionalReq(),"");
							qualityIdtxt.put("text",qualityID);
						}
						
						gqMapper.setAll(qualityID, type);
						mappaID.put(rappidID, gqMapper);

					}
			}
			
			supportContent=java.util.Objects.toString(gson.toJson(map));
			
			//Mappo i Link impact e conflict
			for(Map m:maps) {
				String type=java.util.Objects.toString(m.get("type")).trim();
				if(type.equals("app.Link")) {
					String source,target,relat,typeRelat;
					Map relattxt = (Map) m.get(".relat");
					if(relattxt!=null) {
						relat=java.util.Objects.toString(relattxt.get("text"));
						if(relat.equals("true")) {
							Map labels=((ArrayList<Map>) m.get("labels")).get(0);
							Map labelAttrs=(Map)labels.get("attrs");
							Map labelAttrsTxt=(Map)labelAttrs.get("text");
							Map targetId=(Map)m.get("target");
							Map sourceId=(Map)m.get("source");
							
							source=java.util.Objects.toString(sourceId.get("id"));
							target=java.util.Objects.toString(targetId.get("id"));
							typeRelat=java.util.Objects.toString(labelAttrsTxt.get("text"),"");
							
							if(!typeRelat.equals("")) {
							
								FunctionalReqRelations frr=new FunctionalReqRelations();
								
								gqMapper=mappaID.get(source);
								if(gqMapper.getObjectType()=="erd.Goal") 
									frr.setFunctionalReqByIdStart(functionalReqDAO.getFunctionalReqById(Integer.parseInt(gqMapper.getIdDB())));
								
								if(gqMapper.getObjectType()=="basic.Quality") 
									frr.setQualityReqByIdStart(nonFunctionalReqDAO.getNonFunctionalReqById(Integer.parseInt(gqMapper.getIdDB())));
									
								frr.setIdShowStart(Integer.parseInt(gqMapper.getIdDB()));
	
								gqMapper=mappaID.get(target);
								if(gqMapper.getObjectType()=="erd.Goal")
								frr.setFunctionalReqByIdEnd(functionalReqDAO.getFunctionalReqById(Integer.parseInt(gqMapper.getIdDB())));
								
								if(gqMapper.getObjectType()=="basic.Quality")
								frr.setQualityReqByIdEnd(nonFunctionalReqDAO.getNonFunctionalReqById(Integer.parseInt(gqMapper.getIdDB())));
								
								frr.setIdShowEnd(Integer.parseInt(gqMapper.getIdDB()));
	
								if(typeRelat=="IMPACT")
								frr.setType(goalRelTypeDAO.getGoalRelationTypeById(3));
	
								if(typeRelat=="CONFLICT")
								frr.setType(goalRelTypeDAO.getGoalRelationTypeById(4));
								
								functionalReqRelationsDAO.saveOrUpdateFunctionalReqRel(frr);
							
							}
							
						}
					}
				}
			}
			//Fine Mappatura link
			
			//Mappo le Relations AND e OR
			for(Map m:maps) {
				String type=java.util.Objects.toString(m.get("type")).trim();
				if(type.equals("erd.Relationship")) {
					Map attrs = (Map) m.get("attrs");
					Map attrstxt=(Map) attrs.get("text");
					String tipoRel=java.util.Objects.toString(attrstxt.get("text"));
					
					Map inLinks=(Map)attrs.get("inLinks");
					Map outLinks=(Map)attrs.get("outLinks");
					
					System.out.println("\nTipo: " +type+"\nRelazione: "+tipoRel);

					for(int i=0;i<inLinks.size();i++) {
						System.out.println(inLinks.get(java.util.Objects.toString(i)));
					}
					
					for(int i=0;i<outLinks.size();i++) {
						System.out.println(outLinks.get(java.util.Objects.toString(i)));
					}
				}
			}
			
			System.out.println(gson.toJson(map));

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