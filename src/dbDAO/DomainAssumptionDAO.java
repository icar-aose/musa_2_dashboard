package dbDAO;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import util.HibernateUtil;
import dbBean.Domain;
import dbBean.DomainAssumption;
import dbBean.DomainConfiguration;

public class DomainAssumptionDAO {
	

	public  List<DomainAssumption>  getAllAssumptionByDomain( Domain domain)
	{
		  SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		  Session session = sessionFactory.openSession();
		  session.beginTransaction();
		  Query query = session.createQuery("from DomainAssumption where domain= :domain");
		  query.setParameter("domain", domain);
		  List<DomainAssumption> domainsAssumption = query.list();
		  session.getTransaction().commit();
		  sessionFactory.close();
	 
		  return domainsAssumption;
	}
	
	public  void saveOrUpdateDomainAssumption(DomainAssumption domainAssumption)
	{
			
			SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
			Session session = sessionFactory.openSession();
			session.beginTransaction();
			session.saveOrUpdate(domainAssumption);
			System.out.println("Inserted or Updated Successfully");
			session.getTransaction().commit();
			session.close();
			sessionFactory.close();
		
	}
	
	public  DomainAssumption  getDomainAssumptionByID(Integer idDomainAssumption)
	{
		  SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		  Session session = sessionFactory.openSession();
		  session.beginTransaction();
		  DomainAssumption domainAssumptionDB = (DomainAssumption)session.get(DomainAssumption.class,idDomainAssumption);
		  session.getTransaction().commit();
		  sessionFactory.close();
		  return domainAssumptionDB;
	}
	
	public void deleteDomainAssumption(int idDomainAssumption){
		 SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		  Session session = sessionFactory.openSession();
		  session.beginTransaction();
		  DomainAssumption domainAssumption = (DomainAssumption)session.load(DomainAssumption.class, idDomainAssumption);
		  session.delete(domainAssumption);
		  System.out.println("Deleted Successfully");
		  session.getTransaction().commit();
		  sessionFactory.close();
		
	}

}
