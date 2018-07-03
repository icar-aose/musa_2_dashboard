package org.login;

import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.persistence.NoResultException;
import javax.persistence.TypedQuery;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.dispatcher.SessionMap;
import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

import dbBean.PageDescription;
import dbBean.User;
import dbDAO.PageDescriptionDAO;
import util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

public class LoginAction extends ActionSupport implements SessionAware {

	private static final long serialVersionUID = -143141172172157L;

	// Generate getters and setters....
	private String userId, userPass, msg;
	private SessionMap<String, Object> sessionMap;
	private User userP;
	private PageDescriptionDAO pagedescriptiondao = new PageDescriptionDAO();
	private List<PageDescription> pagedescriptionlist = new ArrayList<PageDescription>();

	@Override
	public void setSession(Map<String, Object> map) {
		sessionMap = (SessionMap<String, Object>) map;
	}

	@SuppressWarnings({ "unchecked" })
	public String login() {
		try {
			
			SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
			if(sessionFactory==null) {this.msg = "No network connection";}
			else {
			Session session2 = sessionFactory.openSession();
			TypedQuery<User> query = session2.createQuery("from User where name= :userId AND password= :userPass");
			query.setParameter("userId", userId);
			query.setParameter("userPass", userPass);
			userP = (User) query.getSingleResult();
			sessionFactory.close();
			}
		} catch (NoResultException nre) {this.msg = "Credenziali non Valide";}

		if (userP != null) {
			// add the attribute in session
			//this.logout();
			HttpServletRequest request = (HttpServletRequest) ActionContext.getContext()
					.get(ServletActionContext.HTTP_REQUEST);
			HttpSession session = request.getSession();
			session.setMaxInactiveInterval(-1);
			sessionMap.put("userId", userP.getName());
			sessionMap.put("id", userP.getIdUser());
			sessionMap.put("role", userP.getRole());
			sessionMap.put("root", "off");

			pagedescriptionlist = pagedescriptiondao.getAllPageDescription();
			for (PageDescription descr : pagedescriptionlist) {
				sessionMap.put(descr.getName(), descr.getDescription());
				sessionMap.put("link_" + descr.getName(), descr.getLink());
			}

			switch (userP.getRole()) {
			case "customer":
				return "login_customer";
			case "admin":
				return "login_admin";
			case "dev":
				return "login_dev";
			case "super": {
				sessionMap.put("root", "on");
				return "login_super";
			}

			}
		}
		System.out.println("Errore sessione inesistente");

		return "LOGIN";
	}
	public String loginGuest() {
		sessionMap.put("userId", "guest");
		sessionMap.put("role", "guest");
		sessionMap.put("root", "on");
		pagedescriptionlist = pagedescriptiondao.getAllPageDescription();
		for (PageDescription descr : pagedescriptionlist) {
			sessionMap.put(descr.getName(), descr.getDescription());
			sessionMap.put("link_" + descr.getName(), descr.getLink());
		}
		
		return "loginGuest";
	}
	
	public String logout() {

		sessionMap.clear();
		sessionMap.invalidate();

		return "LOGOUT";
	}
	public String redirect() {
		return "loginMUSA";
	}
	public SessionMap<String, Object> getSessionMap() {
		return sessionMap;
	}

	public void setSessionMap(SessionMap<String, Object> sessionMap) {
		this.sessionMap = sessionMap;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserPass() {
		return userPass;
	}

	public void setUserPass(String userPass) {
		this.userPass = userPass;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

}