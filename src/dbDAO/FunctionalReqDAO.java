package dbDAO;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import util.HibernateUtil;
import dbBean.Domain;
import dbBean.FunctionalReq;
import dbBean.Process;
import dbBean.Specification;

public class FunctionalReqDAO {
	
	
	public FunctionalReq getFunctionalReqById(Integer idFunctionalReq){
		 SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		  Session session = sessionFactory.openSession();
		  session.beginTransaction();
		  FunctionalReq functionalReq = (FunctionalReq)session.get(FunctionalReq.class,idFunctionalReq);
			
		  session.getTransaction().commit();
		  
		  sessionFactory.close();
		  return functionalReq;
	
	 }

	 public List<FunctionalReq> getAllFunctionalReqBySpecification(Specification specification){
		 SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		  Session session = sessionFactory.openSession();
		  session.beginTransaction();
		  Query query = session.createQuery("from FunctionalReq where specification= :specification");
		  query.setParameter("specification", specification);
		  List<FunctionalReq> functionalReq = query.list();
		  session.getTransaction().commit();
		  sessionFactory.close();
		  return functionalReq;
	
	 }
	 
	 public List<FunctionalReq> getAllFunctionalReqByProcess(Process process){
		 SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		  Session session = sessionFactory.openSession();
		  session.beginTransaction();
		  Query query = session.createQuery("from FunctionalReq where process= :process");
		  query.setParameter("process", process);
		  List<FunctionalReq> functionalReq = query.list();
		  session.getTransaction().commit();
		  sessionFactory.close();
		  return functionalReq;
	
	 }
	 
	 public List<FunctionalReq> getAllGeneratedFunctionalReqByProcess(Process process){
		 SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		  Session session = sessionFactory.openSession();
		  session.beginTransaction();
		  Query query = session.createQuery("from FunctionalReq where process= :process and type='generated'");
		  query.setParameter("process", process);
		
		  List<FunctionalReq> functionalReq = query.list();
		  System.out.println("QUERY SIZE-->"+functionalReq.size());
		  System.out.println();
		  session.getTransaction().commit();
		  sessionFactory.close();
		  return functionalReq;
	
	 }


	 public List<Process> getAllProcessBySpecification(Specification specification){
		 SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		  Session session = sessionFactory.openSession();
		  session.beginTransaction();
		  System.out.println("specification DB-->"+specification.getIdSpecification());
		  Query query = session.createQuery("select fr.process from FunctionalReq fr where fr.specification= :specification");
		  query.setParameter("specification", specification);
		  List<Process> process = query.list();
		  session.getTransaction().commit();
		  sessionFactory.close();
		  return process;
	
	 }
	 
	 
	 
	 public  void saveOrUpdateFunctionalReq(FunctionalReq functionalReq)
		{
				
				SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
				Session session = sessionFactory.openSession();
				session.beginTransaction();
				session.saveOrUpdate(functionalReq);
				System.out.println("Inserted or Updated Successfully");
				session.getTransaction().commit();
				session.close();
				sessionFactory.close();
			
		}
	 
	 public void deleteFunctionalReq(FunctionalReq functionalReq ){
		 SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		  Session session = sessionFactory.openSession();
		  session.beginTransaction();
		   session.delete(functionalReq);
		  System.out.println("Deleted FunctionalReq Successfully");
		  session.getTransaction().commit();
		  sessionFactory.close();
		
	}

	 public void deleteFunctionalRequirementsByProcess(Process process ){
		 SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		  Session session = sessionFactory.openSession();
		  session.beginTransaction();
		  Query query = session.createQuery("delete FunctionalReq  where process= :process");
		  query.setParameter("process", process);
		  query.executeUpdate();
		  session.getTransaction().commit();
		  sessionFactory.close();
		  System.out.println("Deleted FunctionalReq by Process Successfully");
			
		  
	 }
}
