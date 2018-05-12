package dbDAOEdit;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import util.HibernateUtil;
import dbBean.FunctionalReqRelations;
import dbBean.GoalRelationType;

public class GoalRelTypeDAOEdit {

	public GoalRelationType getGoalRelationTypeById(Integer idGrt,Session session) {

		GoalRelationType goalRelationType = (GoalRelationType) session.get(GoalRelationType.class, idGrt);

		return goalRelationType;
	}

	public List<FunctionalReqRelations> getAllFunctionalReqRelByType(GoalRelationType type,Session session) {

		Query query = session.createQuery("from FunctionalReqRelations where type= :type");
		query.setParameter("type", type);
		List<FunctionalReqRelations> functionalReqRel = query.list();

		return functionalReqRel;
	}

	public List<GoalRelationType> getAllGoalRelationType(Session session) {

		Query query = session.createQuery("from GoalRelationType");
		List<GoalRelationType> goalRelationType = query.list();

		return goalRelationType;

	}

}
