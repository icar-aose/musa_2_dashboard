package dbDAO;

import java.util.List;
import java.util.Set;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import util.HibernateUtil;

import dbBean.AbstractCapability;

import dbBean.ScenarioEvo;

public class ScenarioEvoDAO {
	
	
	public  void saveOrUpdateScenarioEvo(ScenarioEvo scenarioEvo)
	{
			
			SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
			Session session = sessionFactory.openSession();
			session.beginTransaction();
			session.saveOrUpdate(scenarioEvo);
			System.out.println("Inserted Successfully");
			session.getTransaction().commit();
			session.close();
			sessionFactory.close();
		
	}
	
	
	public  List<ScenarioEvo>  getAllScenarioEvoByAbstractCapability( AbstractCapability abstractCapability)
	{
		  SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		  Session session = sessionFactory.openSession();
		  session.beginTransaction();
		  Query query = session.createQuery("from ScenarioEvo where abstractCapability= :abstractCapability");
		  query.setParameter("abstractCapability", abstractCapability);
		  List<ScenarioEvo> scenarioEvo =  query.list();
		  session.getTransaction().commit();
		  sessionFactory.close();
	 
		  return scenarioEvo;
	}
	
	public void deleteScenarioEvo(int idScenarioEvo){
		 SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		  Session session = sessionFactory.openSession();
		  session.beginTransaction();
		  ScenarioEvo scenarioEvo = (ScenarioEvo)session.load(ScenarioEvo.class, idScenarioEvo);
		  session.delete(scenarioEvo);
		  System.out.println("Deleted Successfully");
		  session.getTransaction().commit();
		  sessionFactory.close();
		
	}
	
	public  ScenarioEvo  getScenarioEvoByID(Integer idScenarioEvo)
	{
		  SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		  Session session = sessionFactory.openSession();
		  session.beginTransaction();
		  ScenarioEvo scenarioEvoDB = (ScenarioEvo)session.get(ScenarioEvo.class,idScenarioEvo);
		  session.getTransaction().commit();
		  sessionFactory.close();
		  return scenarioEvoDB;
	}
	

}
