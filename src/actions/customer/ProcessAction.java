package actions.customer;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.StringBufferInputStream;
import java.io.StringWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.sql.Blob;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.HttpVersion;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.params.BasicHttpParams;
import org.apache.http.params.HttpConnectionParams;
import org.apache.http.params.HttpParams;
import org.apache.http.params.HttpProtocolParamBean;
import org.apache.http.util.EntityUtils;
import org.apache.struts2.ServletActionContext;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.w3c.dom.Document;

import util.ProcessUtility;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

import dbBean.FunctionalReq;
import dbBean.Process;
import dbBean.Specification;
import dbDAO.FunctionalReqDAO;
import dbDAO.GeneralConfigurationDAO;
import dbDAO.ProcessDAO;
import dbDAO.SpecificationDAO;

public class ProcessAction extends ActionSupport implements ModelDriven<Process>{

	private Process process=new Process();
	private List<Process> processList=new ArrayList<Process>();
	private String idSpecification;
	private String idDomain;
	private FunctionalReqDAO functionalReqDAO=new FunctionalReqDAO();
	private SpecificationDAO specificationDAO=new  SpecificationDAO();
	private ProcessDAO processDAO=new ProcessDAO();
	private Integer processListSize;
	private File processFile;
	private String contentType;
    private String filename;
    private String idWorkflow;
  //  private InputStream inputStream;
    private InputStream existGoalsProcess;
	public String getContentType() {
		return contentType;
	}

	public void setContentType(String contentType) {
		this.contentType = contentType;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	@Override
	public Process getModel() {
		return process;
	}
	
	 public String listProcess(){
		 System.out.println("listProcess ID SPECIFICATION TO LIST-->"+idSpecification);
	     Specification specification=specificationDAO.getSpecificationById(Integer.parseInt((idSpecification)));
	     System.out.println("QUI");
	     
	     processList= processDAO.getAllProcessBySpecification(specification);
	     processListSize=processList.size();
//	     processList=functionalReqDAO.getAllProcessBySpecification(specification);
	     System.out.println("EXIST PROCESS ARE:"+processList.size());
	 return SUCCESS;
	 }
	 

	 
	 public String saveOrUpdateProcess() throws FileNotFoundException, IOException, ParseException{
		 System.out.println(" saveOrUpdateProcess-->"+idSpecification);
		 // è necessario genrare i goals associati. salvare nel db i corrispondenti fucntional requirements associandoli al processo e all'id della specifica
		System.out.println("FILE-->"+processFile);
		
		if(processFile!=null){
		System.out.println("FILE NAME-->"+processFile.getName());
		byte[] bFile = new byte[(int) processFile.length()];
		
		process.setFileWf(bFile);
	
		JSONParser parser=new JSONParser();
		Object obj = parser.parse(new FileReader(processFile.getAbsolutePath()));
		JSONObject jsonObject = (JSONObject) obj;

        String process_name = (String) jsonObject.get("process_name");
        try {
		         FileInputStream fileInputStream = new FileInputStream(processFile);
		         //convert file into array of bytes
		         fileInputStream.read(bFile);
		         fileInputStream.close();
		    } catch (Exception e) {
		         e.printStackTrace();
		    }
		 process.setName(process_name);
		}
		else
		{
			System.out.println(" process.getName()-->"+ process.getName());
			//creo un file vuoto di questo tipo {"cells":[],"items":[],"process_name":"test"}
			JSONObject jsonObject=new JSONObject();
			JSONArray cells = new JSONArray();
			JSONArray items = new JSONArray();
			
			jsonObject.put("cells", cells);
			jsonObject.put("items", items);
			jsonObject.put("process_name", process.getName());
			byte[] bFile = jsonObject.toString().getBytes();
			process.setFileWf(bFile);
		}
		
		Specification specification=specificationDAO.getSpecificationById(Integer.parseInt(idSpecification) );
		process.setSpecification(specification);

		 processDAO.saveOrUpdateProcess(process);
		 
		 
//		 try{
//		     FileOutputStream fos = new FileOutputStream("/Users/antonellacavaleri/Desktop/TESTPROCESS2.txt"); 
//		     fos.write(process.getFileWf());
//		     fos.close();
//		     
//		 }catch(Exception e){
//		     e.printStackTrace();
//		 }
		 
		 return SUCCESS;
	 }
	 
	 public String  verifyGoalsProcessExist(){
		 HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(ServletActionContext.HTTP_REQUEST);
	     
		 System.out.println("CALLverifyGoalsProcessExist--> "+request.getParameter("idWorkflow"));
		  Process processDB=processDAO.getProcessById(Integer.parseInt(request.getParameter("idWorkflow")));
		  List<FunctionalReq> functionalReqList=functionalReqDAO.getAllGeneratedFunctionalReqByProcess(processDB);
System.out.println("SIZE GOALS PROCESS-->"+functionalReqList.size());
		   if(functionalReqList.size()>0)
			   
			   existGoalsProcess = new StringBufferInputStream("true");   
			  
			   else
				   existGoalsProcess=new StringBufferInputStream("false");;
			   
				   
				   System.out.println("existGoalsProcess-->"+existGoalsProcess);
		 return SUCCESS;
			
				
			
	 }
	 public String generateGoals(){
		 
		 
		 
	        
			  HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(ServletActionContext.HTTP_REQUEST);
			     
				  Process processDB=processDAO.getProcessById(Integer.parseInt(request.getParameter("idWorkflow")));
				  
				  ProcessUtility processUtility=new ProcessUtility();
				  
				  List<FunctionalReq> functionalReqList=functionalReqDAO.getAllGeneratedFunctionalReqByProcess(processDB);
					for (int j = 0; j < functionalReqList.size(); j++) {
						 functionalReqDAO.deleteFunctionalReq(functionalReqList.get(j));
						
					}
				  JSONObject jsonObject;
				try {
					jsonObject = (JSONObject) new JSONParser().parse(new String(processDB.getFileWf()));
					System.out.println("jsonObject created->"+jsonObject);
					Document xmiBPMNDocument= processUtility.generateXMIFromJSON(jsonObject);
					DOMSource domSource = new DOMSource(xmiBPMNDocument);
					StringWriter writer = new StringWriter();
					StreamResult result = new StreamResult(writer);
					TransformerFactory tf = TransformerFactory.newInstance();
					Transformer transformer = tf.newTransformer();
					transformer.transform(domSource, result);
					System.out.println("XML IN String format is: \n" + writer.toString());
					GeneralConfigurationDAO configurationDAO=new GeneralConfigurationDAO();
					String ip= configurationDAO.getGeneralConfigurationByName("IP_BPMN2GOALSPEC_SERVICE").get(0).getValue();
					String port=configurationDAO.getGeneralConfigurationByName("PORT_BPMN2GOALSPEC_SERVICE").get(0).getValue();
//					 String url = "http://aose.pa.icar.cnr.it:8080/BPMN2REQWEB/GetGoalSpecFromBPMNServlet"; 
//					String servicePath=configurationDAO.getGeneralConfigurationByName("PATH_BPMN2GOALSPEC_SERVICE").get(0).getValue();
					 String url = "http://"+ip+":"+port+"/BPMN2REQWEB/GetGoalSpecFromBPMNServlet"; 
					 System.out.println("URL SERCIE GOALSPEC_->"+url);
					    HttpClient client = new DefaultHttpClient();
					    HttpPost post = new HttpPost(url);

					 
					    List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
					    urlParameters.add(new BasicNameValuePair("bpmnDiagramm", writer.toString()));

					    post.setEntity(new UrlEncodedFormEntity(urlParameters));

					    HttpResponse response = client.execute(post);
					    System.out.println("\nSending 'POST' request to URL : " + url);
					    System.out.println("Post parameters : " + post.getEntity());
					    System.out.println("Response Code : " + 
					                                response.getStatusLine().getStatusCode());

					    BufferedReader rd = new BufferedReader(
					                    new InputStreamReader(response.getEntity().getContent()));

					    StringBuffer resultCALL = new StringBuffer();
					    String line = "";
					    while ((line = rd.readLine()) != null) {
					    	resultCALL.append(line);
					    }

					    //leggo la string e creo un goals per ogni
					    jsonObject = (JSONObject) new JSONParser().parse(new String(processDB.getFileWf()));
						
					    JSONObject jsonGOALSOBJECT=(JSONObject) new JSONParser().parse(resultCALL.toString());
						String goalsString = jsonGOALSOBJECT.get("goals").toString();
					
						String goalsArray[] = goalsString.split("\n\n");
//						System.out.println("GOALS ARE:"+goalsArray.length);
						for (int i = 1; i < goalsArray.length; i++) {

							String goalsData[] = goalsArray[i].split("\n");
							
							
							String goalsName=goalsArray[i].substring(goalsArray[i].indexOf("GOAL")+5, goalsArray[i].indexOf(":")-1);
							System.out.println("goalsData[1]-->"+goalsData[1]);
							String body=goalsData[1].substring(goalsData[1].indexOf("WHEN")+5,goalsData[1].length());
//							String triggerCondition=goalsArray[i].substring(goalsArray[i].indexOf("WHEN")+5, goalsArray[i].lastIndexOf("THE")-1);
							System.out.println("body-->"+body);
							String actor=goalsData[2].substring(goalsData[2].indexOf("THE"), goalsData[2].indexOf("SHALL"));
							
							// elimino tutti i goal legati al processo che non hanno stato Manual
							
							FunctionalReq functionalReq=new FunctionalReq();
							functionalReq.setActors(actor);
							functionalReq.setCurrentState("waiting");
							functionalReq.setName(goalsName);
							functionalReq.setProcess(processDAO.getProcessById(processDB.getIdWorkflow()));
							functionalReq.setSpecification(specificationDAO.getSpecificationById(Integer.parseInt(idSpecification)));
							functionalReq.setBody(body);
							functionalReq.setType("generated");
							functionalReq.setDescription("Generated from "+processDB.getName());
							 functionalReqDAO.saveOrUpdateFunctionalReq(functionalReq);
							 
							 System.out.println("actor-->"+actor);
//							
//							System.out.println("goalsName-->"+goalsName);
//							System.out.println("triggerCondition-->"+triggerCondition);
//							System.out.println("finalState-->"+finalState);
						}
						//leggo la string e per
//						    System.out.println("GENERATED GOASL-->"+resultCALL.toString());


		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		catch (ParseException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (TransformerConfigurationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (TransformerException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 return SUCCESS;
		
	 }
	 public String getIdWorkflow() {
		return idWorkflow;
	}

	public void setIdWorkflow(String idWorkflow) {
		this.idWorkflow = idWorkflow;
	}

	public String deleteProcess()
	 {
		 System.out.println("CALL DELETE ACTION");
		 processDAO.deleteProcess(process);
			return SUCCESS;
	 }
	public Process getProcess() {
		return process;
	}
	public void setProcess(Process process) {
		this.process = process;
	}

	public List<Process> getProcessList() {
		return processList;
	}

	public void setProcessList(List<Process> processList) {
		this.processList = processList;
	}

	public String getIdSpecification() {
		return idSpecification;
	}

	public void setIdSpecification(String idSpecification) {
		this.idSpecification = idSpecification;
	}

	public String getIdDomain() {
		return idDomain;
	}

	public void setIdDomain(String idDomain) {
		this.idDomain = idDomain;
	}

	public Integer getProcessListSize() {
		return processListSize;
	}

	public void setProcessListSize(Integer processListSize) {
		this.processListSize = processListSize;
	}

	public File getProcessFile() {
		return processFile;
	}

	public void setProcessFile(File processFile) {
		this.processFile = processFile;
	}

	public InputStream getExistGoalsProcess() {
		return existGoalsProcess;
	}

	public void setExistGoalsProcess(InputStream existGoalsProcess) {
		this.existGoalsProcess = existGoalsProcess;
	}


	
	
}
