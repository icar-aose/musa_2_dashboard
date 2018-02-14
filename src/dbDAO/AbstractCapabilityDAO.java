package dbDAO;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import util.HibernateUtil;
import dbBean.AbstractCapability;
import dbBean.Domain;
import dbBean.DomainAssumption;

public class AbstractCapabilityDAO {
	
	public  List<AbstractCapability>  getAllAbstractCapabilityByDomain( Domain domain)
	{
		  SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		  Session session = sessionFactory.openSession();
		  session.beginTransaction();
		  Query query = session.createQuery("from AbstractCapability where domain= :domain");
		  query.setParameter("domain", domain);
		  List<AbstractCapability> abstractCapability = query.list();
		  session.getTransaction().commit();
		  sessionFactory.close();
	 
		  return abstractCapability;
	}
	
	public  List<AbstractCapability>  getAllAbstractCapability()
	{
		  SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		  Session session = sessionFactory.openSession();
		  session.beginTransaction();
		  Query query = session.createQuery("from AbstractCapability");
		  List<AbstractCapability> abstractCapability = query.list();
		  session.getTransaction().commit();
		  sessionFactory.close();
	 
		  return abstractCapability;
	}
	
	public  Integer saveOrUpdateAbstractCapability(AbstractCapability abstractCapability)
	{
			
			SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
			Session session = sessionFactory.openSession();
			session.beginTransaction();
			System.out.println("ID ABSTRACT CAP-->"+abstractCapability.getIdAbstratCapability());
			session.saveOrUpdate(abstractCapability);
			System.out.println("Inserted or Updated Successfully");
			session.getTransaction().commit();
			session.close();
			sessionFactory.close();
			return abstractCapability.getIdAbstratCapability();
		
	}
	
	public  AbstractCapability  getAbstractCapabilityByID(Integer idAbstractCapability)
	{
		  SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		  Session session = sessionFactory.openSession();
		  session.beginTransaction();
		  AbstractCapability abstractCapabilityDB = (AbstractCapability)session.get(AbstractCapability.class,idAbstractCapability);
		  session.getTransaction().commit();
		  sessionFactory.close();
		  return abstractCapabilityDB;
	}
	
	public void deleteAbstractCapability(int idAbstractCapability){
		 SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		  Session session = sessionFactory.openSession();
		  session.beginTransaction();
		  AbstractCapability abstractCapability = (AbstractCapability)session.load(AbstractCapability.class, idAbstractCapability);
		  System.out.println("DELETE FOR CAP :"+abstractCapability.getIdAbstratCapability());
		  session.delete(abstractCapability);
		  System.out.println("Deleted Successfully");
		  session.getTransaction().commit();
		  sessionFactory.close();
		
	}

	public void delete(AbstractCapability abstractCapability){
		 SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		  Session session = sessionFactory.openSession();
		  session.beginTransaction();
		  session.delete(abstractCapability);
		  System.out.println("Deleted Successfully");
		  session.getTransaction().commit();
		  sessionFactory.close();
		
	}
}
