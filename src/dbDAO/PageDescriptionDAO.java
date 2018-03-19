package dbDAO;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import util.HibernateUtil;
import dbBean.GoalRelationType;
import dbBean.PageDescription;
import dbBean.User;

public class PageDescriptionDAO {

	public  PageDescription  getUserByName(String name)
	{
		  SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		  Session session = sessionFactory.openSession();
		  session.beginTransaction();
		  PageDescription pageDB = (PageDescription)session.get(PageDescription.class,name);
		  session.getTransaction().commit();
		  sessionFactory.close();
		  return pageDB;
	}
	
	 public List<PageDescription> getAllPageDescription(){
		 SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		  Session session = sessionFactory.openSession();
		  session.beginTransaction();
		  Query query = session.createQuery("from PageDescription");
		  List<PageDescription> pageDB = query.list();
		  session.getTransaction().commit();
		  sessionFactory.close();
		  return pageDB;
	
	 }

}
