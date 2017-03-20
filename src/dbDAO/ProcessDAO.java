package dbDAO;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import dbBean.FunctionalReq;
import dbBean.Process;
import dbBean.Specification;

import util.HibernateUtil;

public class ProcessDAO {
	
	 public  void saveOrUpdateProcess(Process process)
		{
				
				SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
				Session session = sessionFactory.openSession();
				session.beginTransaction();
				session.saveOrUpdate(process);
				System.out.println("Inserted or Updated Successfully");
				session.getTransaction().commit();
				session.close();
				sessionFactory.close();
			
		}
	 public void deleteProcess(Process process ){
		 System.out.println("PROCESS ID TO DELETE-_>"+process.getIdWorkflow());
		 System.out.println("PROCESS NAME_>"+process.getName());
		 FunctionalReqDAO functionalReqDAO=new FunctionalReqDAO();
		 // è necessario eliminare tutti i goals ad esso associati (functioanl requierement)
		 functionalReqDAO.deleteFunctionalRequirementsByProcess(process);
		 SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		  Session session = sessionFactory.openSession();
		  session.beginTransaction();
		   session.delete(process);
		  System.out.println("Deleted Process Successfully");
		  session.getTransaction().commit();
		  sessionFactory.close();
		
	}

	 
	 public List<Process> getAllProcessBySpecification(Specification specification){
		 SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		  Session session = sessionFactory.openSession();
		  session.beginTransaction();
		  Query query = session.createQuery("from Process where specification= :specification");
		  query.setParameter("specification", specification);
		  List<Process> process = query.list();
		  session.getTransaction().commit();
		  sessionFactory.close();
		  return process;
	
	 }
	 public Process getProcessById(Integer idWorkflow){
		 SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		  Session session = sessionFactory.openSession();
		  session.beginTransaction();
		  Process process = (Process)session.get(Process.class,idWorkflow);
			
		  session.getTransaction().commit();
		  
		  sessionFactory.close();
		  return process;
	
	 }

}
