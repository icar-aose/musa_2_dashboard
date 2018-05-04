package dbDAO;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import util.HibernateUtil;
import dbBean.Specification;
import dbBean.GoalModel;

public class GoalModelDAO {

	public GoalModel getGoalModelById(Integer id) {
		SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		Session session = sessionFactory.openSession();
		session.beginTransaction();
		GoalModel goalModel = (GoalModel) session.get(GoalModel.class,id);
		session.getTransaction().commit();
		sessionFactory.close();
		return goalModel;
	}

	public List<GoalModel> getAllGoalModelBySpecification(Specification specification) {
		SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		Session session = sessionFactory.openSession();
		session.beginTransaction();
		Query query = session.createQuery("from GoalModel where specification= :specification");
		query.setParameter("specification", specification);
		List<GoalModel> goalModel = query.list();
		session.getTransaction().commit();
		sessionFactory.close();
		return goalModel;

	}

	public void saveOrUpdateGoalModel(GoalModel goalModel) {
		SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		Session session = sessionFactory.openSession();
		session.beginTransaction();
		session.saveOrUpdate(goalModel);
		System.out.println("Inserted or Updated Successfully");
		session.getTransaction().commit();
		session.close();
		sessionFactory.close();
	}

	public void deleteGoalModel(GoalModel goalModel) {
		SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		Session session = sessionFactory.openSession();
		session.beginTransaction();
		session.delete(goalModel);
		System.out.println("Deleted goalModel Successfully");
		session.getTransaction().commit();
		sessionFactory.close();
	}

}
