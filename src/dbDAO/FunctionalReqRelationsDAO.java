package dbDAO;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import util.HibernateUtil;
import dbBean.FunctionalReq;
import dbBean.Specification;
import dbBean.FunctionalReqRelations;

public class FunctionalReqRelationsDAO {
	
	
	public FunctionalReqRelations getFunctionalReqRelById(Integer idFunctionalReqRelations){
		 SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		  Session session = sessionFactory.openSession();
		  session.beginTransaction();
		  FunctionalReqRelations functionalReqRel = (FunctionalReqRelations)session.get(FunctionalReqRelations.class,idFunctionalReqRelations);
		  session.getTransaction().commit();
		  sessionFactory.close();
		  return functionalReqRel;
	 }

	 public List<FunctionalReqRelations> getAllFunctionalReqRelBySpecification(Specification specification){
		 SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		  Session session = sessionFactory.openSession();
		  session.beginTransaction();
		  Query query = session.createQuery("from FunctionalReqRelations where specification= :specification");
		  query.setParameter("specification", specification);
		  List<FunctionalReqRelations> functionalReqRel = query.list();
		  session.getTransaction().commit();
		  sessionFactory.close();
		  return functionalReqRel;
	
	 }
	
	 public List<FunctionalReqRelations> getAllFunctionalReqRelByStart(FunctionalReq start_rel){
		 SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		  Session session = sessionFactory.openSession();
		  session.beginTransaction();
		  Query query = session.createQuery("from FunctionalReqRelations where id_start= :start_rel");
		  query.setParameter("start_rel", start_rel);
		  List<FunctionalReqRelations> functionalReqRel = query.list();
		  session.getTransaction().commit();
		  sessionFactory.close();
		  return functionalReqRel;
	 }
	 
	 public List<FunctionalReqRelations> getAllFunctionalReqRelByEnd(FunctionalReq end_rel){
		 SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		  Session session = sessionFactory.openSession();
		  session.beginTransaction();
		  Query query = session.createQuery("from FunctionalReqRelations where id_end= :end_rel");
		  query.setParameter("end_rel", end_rel);
		  List<FunctionalReqRelations> functionalReqRel = query.list();
		  session.getTransaction().commit();
		  sessionFactory.close();
		  return functionalReqRel;
	 }
	 
	 public List<FunctionalReqRelations> getAllFunctionalReqRelByType(String type){
		 SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		  Session session = sessionFactory.openSession();
		  session.beginTransaction();
		  Query query = session.createQuery("from FunctionalReqRelations where type= :type");
		  query.setParameter("type", type);
		  List<FunctionalReqRelations> functionalReqRel = query.list();
		  session.getTransaction().commit();
		  sessionFactory.close();
		  return functionalReqRel;
	 }
	 
	 public  void saveOrUpdateFunctionalReqRel(FunctionalReqRelations functionalReqRel)
		{
				
				SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
				Session session = sessionFactory.openSession();
				session.beginTransaction();
				session.saveOrUpdate(functionalReqRel);
				System.out.println("Inserted or Updated Successfully");
				session.getTransaction().commit();
				session.close();
				sessionFactory.close();
			
		}
	 
	 public void deleteFunctionalReqRel(FunctionalReqRelations functionalReqRel ){
		 SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		  Session session = sessionFactory.openSession();
		  session.beginTransaction();
		   session.delete(functionalReqRel);
		  System.out.println("Deleted FunctionalReq Successfully");
		  session.getTransaction().commit();
		  sessionFactory.close();
		
	}


}
