package dbDAO;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import util.HibernateUtil;
import dbBean.FunctionalReqRelations;
import dbBean.GoalRelationType;

public class GoalRelTypeDAO {
	
	
	public GoalRelationType getGoalRelationTypeById(Integer idGrt){
		 SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		  Session session = sessionFactory.openSession();
		  session.beginTransaction();
		  GoalRelationType goalRelationType = (GoalRelationType)session.get(GoalRelationType.class,idGrt);
		  session.getTransaction().commit();
		  sessionFactory.close();
		  return goalRelationType;
	 }

	 public List<FunctionalReqRelations> getAllFunctionalReqRelByType(GoalRelationType type){
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
	 
	 public List<GoalRelationType> getAllGoalRelationType(){
		 SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		  Session session = sessionFactory.openSession();
		  session.beginTransaction();
		  Query query = session.createQuery("from GoalRelationType");
		  List<GoalRelationType> goalRelationType = query.list();
		  session.getTransaction().commit();
		  sessionFactory.close();
		  return goalRelationType;
	
	 }
	 
}
