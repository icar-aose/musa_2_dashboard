package dbDAO;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import util.HibernateUtil;
import dbBean.CaseExecution;
import dbBean.FunctionalReq;
import dbBean.Specification;

public class CasesDAO {


	 public List<CaseExecution> getAllCasesBySpecification(Specification specification){
		 SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		  Session session = sessionFactory.openSession();
		  session.beginTransaction();
		  Query query = session.createQuery("from CaseExecution where specification= :specification");
		  query.setParameter("specification", specification);
		  List<CaseExecution> caseExecution = query.list();
		  session.getTransaction().commit();
		  sessionFactory.close();
		  return caseExecution;
	
	 }
	 
	 public CaseExecution getCaseExecutionById(Integer idCaseExecution){
		 SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		  Session session = sessionFactory.openSession();
		  session.beginTransaction();
		  CaseExecution caseExecutionDB = (CaseExecution)session.get(CaseExecution.class,idCaseExecution);
			
		  session.getTransaction().commit();
		  
		  sessionFactory.close();
		  return caseExecutionDB;
	
	 }
	
}
