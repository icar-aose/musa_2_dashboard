package dbDAOEdit;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import util.HibernateUtil;
import dbBean.FunctionalReq;
import dbBean.Specification;
import dbBean.FunctionalReqRelations;
import dbBean.NonFunctionalReq;

public class FunctionalReqRelationsDAOEdit {

	public FunctionalReqRelations getFunctionalReqRelById(Integer idFunctionalReqRelations,Session session) {

		FunctionalReqRelations functionalReqRel = (FunctionalReqRelations) session.get(FunctionalReqRelations.class,
				idFunctionalReqRelations);
		

		return functionalReqRel;
	}

	public List<FunctionalReqRelations> getAllFunctionalReqRelBySpecification(Specification specification,Session session) {

		Query query = session.createQuery("from FunctionalReqRelations where specification= :specification");
		query.setParameter("specification", specification);
		List<FunctionalReqRelations> functionalReqRel = query.list();
		

		return functionalReqRel;

	}

	public List<FunctionalReqRelations> getAllFunctionalReqRelByStart(FunctionalReq start_rel,Session session) {

		Query query = session.createQuery("from FunctionalReqRelations where id_start= :start_rel");
		query.setParameter("start_rel", start_rel);
		List<FunctionalReqRelations> functionalReqRel = query.list();

		return functionalReqRel;
	}

	public List<FunctionalReqRelations> getAllFunctionalReqRelByEnd(FunctionalReq end_rel,Session session) {

		Query query = session.createQuery("from FunctionalReqRelations where id_end= :end_rel");
		query.setParameter("end_rel", end_rel);
		List<FunctionalReqRelations> functionalReqRel = query.list();
		

		return functionalReqRel;
	}

	public List<FunctionalReqRelations> getAllFunctionalReqRelByType(String type,Session session) {

		Query query = session.createQuery("from FunctionalReqRelations where type= :type");
		query.setParameter("type", type);
		List<FunctionalReqRelations> functionalReqRel = query.list();
		

		return functionalReqRel;
	}

	public void saveOrUpdateFunctionalReqRel(FunctionalReqRelations functionalReqRel,Session session) {

		session.beginTransaction();
		session.saveOrUpdate(functionalReqRel);
		System.out.println("Inserted or Updated Successfully");
		session.getTransaction().commit();
	}

	public void deleteFunctionalReqRel(FunctionalReqRelations functionalReqRel,Session session) {
		session.beginTransaction();
		session.delete(functionalReqRel);
		System.out.println("Deleted FunctionalReq Successfully");
		session.getTransaction().commit();

	}
	
	public void deleteByList(List<FunctionalReqRelations> functionalReqRel,Session session) {
		session.beginTransaction();
		for(FunctionalReqRelations f:functionalReqRel) {
		session.delete(f);
		}
		System.out.println("Deleted Relation Successfully");
		
		session.getTransaction().commit();

	}

	public List<FunctionalReqRelations> getAllGeneratedRelBySpecification(Specification specification,Session session ) {

		Query query = session.createQuery("from FunctionalReqRelations where specification= :specification and mangen='generated'");
		query.setParameter("specification", specification);
		List<FunctionalReqRelations> functionalReqRel = query.list();

		return functionalReqRel;
	}
}
