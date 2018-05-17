package actions.customer;

import java.io.UnsupportedEncodingException;
import java.sql.Blob;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.Session;
import org.hibernate.SessionFactory;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

import dbBean.FunctionalReq;
import dbBean.FunctionalReqRelations;
import dbBean.GoalModel;
import dbBean.GoalRelationType;
import dbBean.NonFunctionalReq;
import dbBean.Specification;
import dbDAO.FunctionalReqDAO;
import dbDAO.FunctionalReqRelationsDAO;
import dbDAO.GoalModelDAO;
import dbDAO.GoalRelTypeDAO;
import dbDAO.NoFunctionalReqDAO;
import dbDAO.SpecificationDAO;
import dbDAOEdit.FunctionalReqDAOEdit;
import dbDAOEdit.FunctionalReqRelationsDAOEdit;
import dbDAOEdit.GoalRelTypeDAOEdit;
import dbDAOEdit.NoFunctionalReqDAOEdit;
import dbDAOEdit.SpecificationDAOEdit;
import util.HibernateUtil;

public class GoalAction extends ActionSupport implements ModelDriven<GoalModel> {

	private GoalModelDAO goalModelDAO = new GoalModelDAO();
	private GoalRelTypeDAOEdit goalRelTypeDAO = new GoalRelTypeDAOEdit();	
	private SpecificationDAOEdit specificationDAO = new SpecificationDAOEdit();
	private FunctionalReqDAOEdit functionalReqDAO = new FunctionalReqDAOEdit();
	private FunctionalReqRelationsDAOEdit functionalReqRelationsDAO = new FunctionalReqRelationsDAOEdit();	
	private NoFunctionalReqDAOEdit nonFunctionalReqDAO = new NoFunctionalReqDAOEdit();
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
	private Map<String,GoalAndQualityMapper> mappaID=new HashMap<String,GoalAndQualityMapper>();
	
	@Override
	public GoalModel getModel() {
		return goalModel;
	}

	public GoalAction() {

	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String saveOrUpdateGoalModel() {
		SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		Session session = sessionFactory.openSession();
		
		Specification specification = specificationDAO.getSpecificationById(Integer.parseInt(idSpecification),session);
		
		// Parte dedicata al salvataggio dei singoli goal sul db, i goal sono prelevati
		// dal JSON che rappresenta il grafico
		if (flagSaveElements.equals("true")) {
			
			List<FunctionalReq> funcToDelete = functionalReqDAO.getAllGeneratedFunctionalReqBySpecification(specification,session);
			ArrayList<FunctionalReq> funcInGraph = new ArrayList<FunctionalReq>();
			List<NonFunctionalReq> qualityToDelete = nonFunctionalReqDAO.getAllGeneratedNonFunctionalReqBySpecification(specification,session);
			ArrayList<NonFunctionalReq> qualityInGraph = new ArrayList<NonFunctionalReq>();
			
			//nonFunctionalReqDAO.deleteNonFunctionalReqByList(nonFuncToDelete,session);
			//functionalReqDAO.deleteFunctionalReqByList(funcToDelete,session);

			List<FunctionalReqRelations> relationsToDelete = functionalReqRelationsDAO.getAllGeneratedRelBySpecification(specification,session);
			functionalReqRelationsDAO.deleteByList(relationsToDelete,session);			
			
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
						
						rappidID=java.util.Objects.toString(m.get("id"),"").trim();
						name=java.util.Objects.toString(nameTxt.get("text"),"").trim();
						body=java.util.Objects.toString(bodyTxt.get("text"),"").trim();
						description=java.util.Objects.toString(descriptionTxt.get("text"),"").trim();
						priority=java.util.Objects.toString(priorityTxt.get("text"),"").trim();								
						actors=java.util.Objects.toString(actorsTxt.get("text"),"").trim();
						
						if(goalIdtxt!=null)
							goalID = java.util.Objects.toString(goalIdtxt.get("text"),"");
						else
							goalID="";
						
						FunctionalReq fr = new FunctionalReq();
						FunctionalReq frCheck = null;
						
						if(!(goalID).equals(""))
						frCheck=functionalReqDAO.getFunctionalReqById(Integer.parseInt(goalID),session);
						
						if(frCheck!=null)fr=frCheck;
						
						fr.setName(name);					fr.setBody(body);
						fr.setActors(actors);				fr.setSpecification(specification);
						fr.setCurrentState("activated");	fr.setPriority(java.util.Objects.toString(Math.round(Float.parseFloat(priority))));
						fr.setDescription(description);		fr.setType("generated");
						
						functionalReqDAO.saveOrUpdateFunctionalReq(fr,session);
						
						goalID=java.util.Objects.toString(fr.getIdFunctionalReq(),"");

						if(goalIdtxt==null) {
							Map<String,String> newGoalID=new HashMap<String,String>();
							newGoalID.put("text", goalID);
							attrs.put(".idDB",newGoalID);
						}
						else {
							goalIdtxt.put("text",goalID);
						}
						
						funcInGraph.add(fr);
						
						GoalAndQualityMapper gqMapper = new GoalAndQualityMapper();
						gqMapper.setAll(goalID, type);
						mappaID.put(rappidID, gqMapper);
						System.out.println("Rappid: "+rappidID+"\nidDB: "+goalID+"\nTipo: "+type);

						
					}
					
					
					//Mapping Quality
					if(type.equals("basic.Quality")) {
						String name,body,description,qualityID,rappidID;
						Map attrs = (Map) m.get("attrs");
						
						Map nameTxt=(Map) attrs.get("text");
						Map bodyTxt=(Map) attrs.get(".body");
						Map descriptionTxt=(Map) attrs.get(".description");
						Map qualityIdtxt=(Map) attrs.get(".idDB");
						
						rappidID=java.util.Objects.toString(m.get("id"),"").trim();
						name=java.util.Objects.toString(nameTxt.get("text"),"").trim();
						body=java.util.Objects.toString(bodyTxt.get("text"),"").trim();
						description=java.util.Objects.toString(descriptionTxt.get("text"),"").trim();
						
						if(qualityIdtxt==null)
							qualityID="";
						else
							qualityID=java.util.Objects.toString(qualityIdtxt.get("text"),"");
						
						NonFunctionalReq nfr = new NonFunctionalReq();
						NonFunctionalReq nfrCheck = null;
						
						if(!(qualityID).equals(""))
						nfrCheck=nonFunctionalReqDAO.getNonFunctionalReqById(Integer.parseInt(qualityID),session);
						if(nfrCheck!=null)nfr=nfrCheck;
						
						nfr.setName(name);						
						nfr.setSpecification(specification);	
							
						nfr.setDescription(description);	
						nfr.setValue(body);
						nfr.setType("generated");
						nfr.setCurrentState("active");
						
						nonFunctionalReqDAO.saveOrUpdateNonFunctionalReq(nfr,session);
						
						qualityID=java.util.Objects.toString(nfr.getIdNonFunctionalReq(),"");

						if(qualityIdtxt==null) {
							Map<String,String> newQualityID=new HashMap<String,String>();
							newQualityID.put("text", qualityID);
							attrs.put(".idDB",newQualityID);
						}
						else {
							qualityIdtxt.put("text",qualityID);
						}
						
						qualityInGraph.add(nfr);
						GoalAndQualityMapper gqMapper = new GoalAndQualityMapper();
						gqMapper.setAll(qualityID, type);
						mappaID.put(rappidID, gqMapper);
						System.out.println("Rappid: "+rappidID+"\nidDB: "+qualityID+"\nTipo: "+type);

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
							
							source=java.util.Objects.toString(sourceId.get("id")).trim();
							target=java.util.Objects.toString(targetId.get("id")).trim();
							typeRelat=java.util.Objects.toString(labelAttrsTxt.get("text"),"").trim();
							if(!typeRelat.equals("")) {
							
								FunctionalReqRelations frr=new FunctionalReqRelations();
								GoalAndQualityMapper gqMapper = new GoalAndQualityMapper();
								gqMapper=mappaID.get(source);
								if(gqMapper.getObjectType().equals("erd.Goal")) {
									frr.setFunctionalReqByIdStart(
											functionalReqDAO.getFunctionalReqById(Integer.parseInt(gqMapper.getIdDB()),session));
									frr.setIdShowStart(frr.getFunctionalReqByIdStart().getName());
								}
									
								if(gqMapper.getObjectType().equals("basic.Quality")) {
									frr.setQualityReqByIdStart(
											nonFunctionalReqDAO.getNonFunctionalReqById(Integer.parseInt(gqMapper.getIdDB()),session));
									
									frr.setIdShowStart(frr.getQualityReqByIdStart().getName());
								}
								
								gqMapper=mappaID.get(target);
								if(gqMapper.getObjectType().equals("erd.Goal")) {
									frr.setFunctionalReqByIdEnd(
											functionalReqDAO.getFunctionalReqById(Integer.parseInt(gqMapper.getIdDB()),session)
									);
									frr.setIdShowEnd(frr.getFunctionalReqByIdEnd().getName());
								}
								
								if(gqMapper.getObjectType().equals("basic.Quality")) {
								frr.setQualityReqByIdEnd(
										nonFunctionalReqDAO.getNonFunctionalReqById(Integer.parseInt(gqMapper.getIdDB()),session)
								);
								frr.setIdShowEnd(frr.getQualityReqByIdEnd().getName());
								}
								
								GoalRelationType grt=new GoalRelationType();
								
								if(typeRelat.equals("IMPACT")) {
									grt=goalRelTypeDAO.getGoalRelationTypeById(3,session);
								}
								
								if(typeRelat.equals("CONFLICT")) {
									grt=goalRelTypeDAO.getGoalRelationTypeById(4,session);
								}
								
								frr.setType(grt);
								frr.setSpecification(specification);
								frr.setMangen("generated");
																
								functionalReqRelationsDAO.saveOrUpdateFunctionalReqRel(frr,session);

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
					String tipoRel=java.util.Objects.toString(attrstxt.get("text")).trim();
					
					Map inLinks=(Map)attrs.get("inLinks");
					Map outLinks=(Map)attrs.get("outLinks");
					
					String inLinksFirst=java.util.Objects.toString(inLinks.get("0")).trim();
					GoalAndQualityMapper gqMapper = new GoalAndQualityMapper();
					gqMapper=mappaID.get(inLinksFirst);

					Integer idInLinksFirst=Integer.parseInt(gqMapper.getIdDB().trim());
					System.out.println("ORIGINE: "+idInLinksFirst);

					String objType=gqMapper.getObjectType().trim();
					
					GoalRelationType grt=new GoalRelationType();
												
					if(tipoRel.equals("AND"))
						grt=goalRelTypeDAO.getGoalRelationTypeById(1,session);

					if(tipoRel.equals("OR"))
						grt=goalRelTypeDAO.getGoalRelationTypeById(2,session);
					
					

					for(int i=0;i<outLinks.size();i++) {
						System.out.println("Size OUTLINKS: "+outLinks.size());
						FunctionalReqRelations frr=new FunctionalReqRelations();
						
						if(objType.equals("erd.Goal")) {
							frr.setFunctionalReqByIdStart(
									functionalReqDAO.getFunctionalReqById(idInLinksFirst,session)
							);
							frr.setIdShowStart(frr.getFunctionalReqByIdStart().getName());							
						}
						
						if(objType.equals("basic.Quality")) {
							frr.setQualityReqByIdStart(nonFunctionalReqDAO.getNonFunctionalReqById(idInLinksFirst,session));
							frr.setIdShowStart(frr.getQualityReqByIdStart().getName());						
						}

						gqMapper=mappaID.get(outLinks.get(java.util.Objects.toString(i)));
						if(gqMapper.getObjectType().equals("erd.Goal")) {
							frr.setFunctionalReqByIdEnd(
									functionalReqDAO.getFunctionalReqById(Integer.parseInt(gqMapper.getIdDB()),session)
							);
							frr.setIdShowEnd(frr.getFunctionalReqByIdEnd().getName());
						}
						
						if(gqMapper.getObjectType().equals("basic.Quality")) {
							frr.setQualityReqByIdEnd(
									nonFunctionalReqDAO.getNonFunctionalReqById(Integer.parseInt(gqMapper.getIdDB()),session)
							);
							frr.setIdShowEnd(frr.getQualityReqByIdEnd().getName());	
						}
						
						frr.setType(grt);
						frr.setSpecification(specification);
						frr.setMangen("generated");
						
						functionalReqRelationsDAO.saveOrUpdateFunctionalReqRel(frr,session);
					}
				}
			}
			
			
		for(FunctionalReq f:funcToDelete) {
			if (!funcInGraph.contains(f)){
				functionalReqDAO.deleteFunctionalReq(f, session);
			}
		}
		
		for(NonFunctionalReq nf:qualityToDelete) {
			if (!qualityInGraph.contains(nf)){
				nonFunctionalReqDAO.deleteNonFunctionalReq(nf, session);
			}
		}
		
		}
		
		
		
		// Parte dedicata al salvataggio del Grafico come JSON su DB
		
		goalModelList = goalModelDAO.getAllGoalModelBySpecification(specification,session);
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
		goalModelDAO.saveOrUpdateGoalModel(goalModel,session);
		
		sessionFactory.close();
		return SUCCESS;
	}

	public String listGoalModel() {
		SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		Session session = sessionFactory.openSession();
		
		Gson gson= new GsonBuilder().excludeFieldsWithoutExposeAnnotation().create();
		Specification specification = specificationDAO.getSpecificationById(Integer.parseInt((idSpecification)),session);
		goalModelList = goalModelDAO.getAllGoalModelBySpecification(specification,session);
		functionalReqList = functionalReqDAO.getAllManualFunctionalReqBySpecification(specification,session);
		nonFunctionalReqList = nonFunctionalReqDAO.getAllManualNonFunctionalReqBySpecification(specification,session);
		sizeGoalModel = goalModelList.size();
		if (sizeGoalModel.equals(0))
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
		
		sessionFactory.close();
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