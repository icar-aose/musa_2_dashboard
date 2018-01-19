package dbDAO;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import util.HibernateUtil;
import dbBean.AbstractCapability;
import dbBean.Domain;
import dbBean.User;

public class UserDAO {
	public  List<User>  getAdminUser()
	{
		  SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		  Session session = sessionFactory.openSession();
		  session.beginTransaction();
		  Query query = session.createQuery("from User where role='admin'");
		  List<User> user = query.list();
		  session.getTransaction().commit();
		  sessionFactory.close();
	 
		  return user;
	}
	
	public  List<User>  getDevUser()
	{
		  SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		  Session session = sessionFactory.openSession();
		  session.beginTransaction();
		  Query query = session.createQuery("from User where role='dev'");
		  List<User> user = query.list();
		  session.getTransaction().commit();
		  sessionFactory.close();
	 
		  return user;
	}
	
	public  List<User>  getCustomerUser()
	{
		  SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		  Session session = sessionFactory.openSession();
		  session.beginTransaction();
		  Query query = session.createQuery("from User where role='customer'");
		  List<User> user = query.list();
		  session.getTransaction().commit();
		  sessionFactory.close();
	 
		  return user;
	}
	
	
	public  User  getUserByID(Integer idUser)
	{
		  SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		  Session session = sessionFactory.openSession();
		  session.beginTransaction();
		  User userDB = (User)session.get(User.class,idUser);
		  session.getTransaction().commit();
		  sessionFactory.close();
		  return userDB;
	}
	
	

}
