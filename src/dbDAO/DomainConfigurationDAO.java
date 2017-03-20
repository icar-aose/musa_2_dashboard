package dbDAO;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import util.HibernateUtil;
import dbBean.Domain;
import dbBean.DomainConfiguration;
import dbBean.GeneralConfiguration;

public class DomainConfigurationDAO {

	
	public  List<DomainConfiguration>  getAllConfigurationByDomain( Domain domain)
	{
		  SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		  Session session = sessionFactory.openSession();
		  session.beginTransaction();
		  Query query = session.createQuery("from DomainConfiguration where domain= :domain");
		  query.setParameter("domain", domain);
		  List<DomainConfiguration> domainsConfiguration = query.list();
		  session.getTransaction().commit();
		  sessionFactory.close();
	 
		  return domainsConfiguration;
	}
	
	
	public  void saveOrUpdateDomainConfiguration(DomainConfiguration domainConfiguration)
	{
			
			SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
			Session session = sessionFactory.openSession();
			session.beginTransaction();
			session.saveOrUpdate(domainConfiguration);
			System.out.println("Inserted or Updated Successfully");
			session.getTransaction().commit();
			session.close();
			sessionFactory.close();
		
	}
	
	public  DomainConfiguration  getDomainConfigurationByID(Integer idDomainConfiguration)
	{
		  SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		  Session session = sessionFactory.openSession();
		  session.beginTransaction();
		  DomainConfiguration domainConfigurationDB = (DomainConfiguration)session.get(DomainConfiguration.class,idDomainConfiguration);
		  session.getTransaction().commit();
		  sessionFactory.close();
		  return domainConfigurationDB;
	}
	
	public void deleteDomainConfiguration(int idDomainConfiguration){
		 SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		  Session session = sessionFactory.openSession();
		  session.beginTransaction();
		  DomainConfiguration domainConfiguration = (DomainConfiguration)session.load(DomainConfiguration.class, idDomainConfiguration);
		  session.delete(domainConfiguration);
		  System.out.println("Deleted DomainConfiguration Successfully");
		  session.getTransaction().commit();
		  sessionFactory.close();
		
	}

}
