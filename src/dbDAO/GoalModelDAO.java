package dbDAO;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import util.HibernateUtil;
import dbBean.Specification;
import dbBean.GoalModel;

public class GoalModelDAO {

	public GoalModel getGoalModelById(Integer id,Session session) {
		GoalModel goalModel = (GoalModel) session.get(GoalModel.class,id);
		return goalModel;
	}

	public List<GoalModel> getAllGoalModelBySpecification(Specification specification,Session session) {

		Query query = session.createQuery("from GoalModel where specification= :specification");
		query.setParameter("specification", specification);
		List<GoalModel> goalModel = query.list();

		return goalModel;

	}

	public void saveOrUpdateGoalModel(GoalModel goalModel,Session session) {

		session.beginTransaction();
		session.saveOrUpdate(goalModel);
		System.out.println("Inserted or Updated Successfully");
		session.getTransaction().commit();

	}

	public void deleteGoalModel(GoalModel goalModel,Session session) {

		session.beginTransaction();
		session.delete(goalModel);
		System.out.println("Deleted goalModel Successfully");
		session.getTransaction().commit();

	}

}
