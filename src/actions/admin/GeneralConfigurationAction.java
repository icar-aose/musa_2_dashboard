package actions.admin;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import dbBean.GeneralConfiguration;
import dbDAO.GeneralConfigurationDAO;

public class GeneralConfigurationAction extends ActionSupport implements ModelDriven<GeneralConfiguration>{

	
	private static final long serialVersionUID = 1L;
	private GeneralConfiguration generalConfiguration=new GeneralConfiguration();
	private List<GeneralConfiguration> generalConfigurationList=new ArrayList<GeneralConfiguration>();
	private GeneralConfigurationDAO generalConfigurationDAO=new GeneralConfigurationDAO();

	@Override
	public GeneralConfiguration getModel() {
		// TODO Auto-generated method stub
		return generalConfiguration;
	}
	
	

	public String listGeneralConfiguration()
	{
		
		System.out.println("Call listGeneralConfiguration");
		generalConfigurationList = generalConfigurationDAO.getAllGeneralConfiguration();
		
		
	    return SUCCESS;
	}
	
	public String saveOrUpdate()
	{	
		generalConfigurationDAO.saveOrUpdateGeneralConfiguration(generalConfiguration);
		generalConfigurationList = generalConfigurationDAO.getAllGeneralConfiguration();
		
		return SUCCESS;
	}
	
	public String save()
	{	
		generalConfigurationDAO.saveGeneralConfiguration(generalConfiguration);
		generalConfigurationList = generalConfigurationDAO.getAllGeneralConfiguration();
		
		return SUCCESS;
	}
	public String update()
	{	
		generalConfigurationDAO.updateGeneralConfiguration(generalConfiguration);
		generalConfigurationList = generalConfigurationDAO.getAllGeneralConfiguration();
		
		return SUCCESS;
	}
	
	public String delete()
	{
		HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(ServletActionContext.HTTP_REQUEST);
		generalConfigurationDAO.deleteGeneralConfiguration(Integer.parseInt(request.getParameter("id")));
		
		return SUCCESS;
	}
	
	
	public String edit()
	{
		HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(ServletActionContext.HTTP_REQUEST);
		generalConfiguration = generalConfigurationDAO.getGeneralConfigurationByID(Integer.parseInt(request.getParameter("id")));
		generalConfigurationList = generalConfigurationDAO.getAllGeneralConfiguration();
		
		return SUCCESS;
	}
	
	public GeneralConfiguration getGeneralConfiguration() {
		return generalConfiguration;
	}
	public void setGeneralConfiguration(GeneralConfiguration generalConfiguration) {
		this.generalConfiguration = generalConfiguration;
	}
	public List<GeneralConfiguration> getGeneralConfigurationList() {
		return generalConfigurationList;
	}
	public void setGeneralConfigurationList(
			List<GeneralConfiguration> generalConfigurationList) {
		this.generalConfigurationList = generalConfigurationList;
	}
	public GeneralConfigurationDAO getGeneralConfigurationDAO() {
		return generalConfigurationDAO;
	}
	public void setGeneralConfigurationDAO(
			GeneralConfigurationDAO generalConfigurationDAO) {
		this.generalConfigurationDAO = generalConfigurationDAO;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	
}
