package dbDAOEdit;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import util.HibernateUtil;
import dbBean.FunctionalReq;
import dbBean.Specification;
public class FunctionalReqDAOEdit {

	public FunctionalReq getFunctionalReqById(Integer idFunctionalReq,Session session) {
		FunctionalReq functionalReq = (FunctionalReq) session.get(FunctionalReq.class, idFunctionalReq);
		return functionalReq;

	}

	public List<FunctionalReq> getAllFunctionalReqBySpecification(Specification specification,Session session) {

		Query query = session.createQuery("from FunctionalReq where specification= :specification");
		query.setParameter("specification", specification);
		List<FunctionalReq> functionalReq = query.list();

		return functionalReq;

	}
	
	public List<FunctionalReq> getAllManualFunctionalReqBySpecification(Specification specification,Session session) {

		Query query = session.createQuery("from FunctionalReq where specification= :specification and type='manual'");
		query.setParameter("specification", specification);
		List<FunctionalReq> functionalReq = query.list();

		return functionalReq;

	}

	public List<FunctionalReq> getAllGeneratedFunctionalReqBySpecification(Specification specification,Session session) {

		Query query = session.createQuery("from FunctionalReq where specification= :specification and type='generated'");
		query.setParameter("specification", specification);
		List<FunctionalReq> functionalReq = query.list();

		return functionalReq;
	}


	public void saveOrUpdateFunctionalReq(FunctionalReq functionalReq,Session session) {
		session.beginTransaction();
		session.saveOrUpdate(functionalReq);
		System.out.println("Inserted or Updated Successfully");		
		session.getTransaction().commit();

	}

	public void deleteFunctionalReq(FunctionalReq functionalReq,Session session) {
		session.beginTransaction();
		session.delete(functionalReq);
		System.out.println("Deleted FunctionalReq Successfully");
		session.getTransaction().commit();
		
	}
	
	public void deleteFunctionalReqByList(List<FunctionalReq> functionalReq,Session session) {
		session.beginTransaction();
		for(FunctionalReq f:functionalReq) {
		session.delete(f);
		}
		System.out.println("Deleted FunctionalReq Successfully");
		session.getTransaction().commit();

	}

}
