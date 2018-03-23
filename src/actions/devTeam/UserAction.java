package actions.devTeam;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

import dbBean.User;
import dbDAO.UserDAO;

public class UserAction extends ActionSupport implements ModelDriven<User> {
	private UserDAO userDAO = new UserDAO();
	private List<User> userDevList = new ArrayList<User>();
	private List<User> userCustomerList = new ArrayList<User>();
	private String user;
	private String userCustomer;

	@Override
	public User getModel() {
		// TODO Auto-generated method stub
		return null;
	}

	public String listDevUser() {
		userDevList = userDAO.getDevUser();
		return SUCCESS;
	}

	public String listCustomerUser() {
		userCustomerList = userDAO.getCustomerUser();
		return SUCCESS;
	}

	public String saveDevUser() {
		System.out.println("user-->" + user);
		if (!"none".equals(user)) {
			Map session = ActionContext.getContext().getSession();
			session.put("id", user);
			return SUCCESS;

		}
		return ERROR;

	}

	public String saveCustomerUser() {

		System.out.println("user-->" + userCustomer);
		if (!"none".equals(userCustomer)) {
			Map session = ActionContext.getContext().getSession();
			session.put("id", userCustomer);
			return SUCCESS;

		}
		return ERROR;

	}

	public String getUserCustomer() {
		return userCustomer;
	}

	public void setUserCustomer(String userCustomer) {
		this.userCustomer = userCustomer;
	}

	public List<User> getUserDevList() {
		return userDevList;
	}

	public void setUserDevList(List<User> userDevList) {
		this.userDevList = userDevList;
	}

	public String getUser() {
		return user;
	}

	public void setUser(String user) {
		this.user = user;
	}

	public List<User> getUserCustomerList() {
		return userCustomerList;
	}

	public void setUserCustomerList(List<User> userCustomerList) {
		this.userCustomerList = userCustomerList;
	}

}
