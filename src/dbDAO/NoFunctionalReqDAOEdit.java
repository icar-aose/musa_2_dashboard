package dbDAO;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import util.HibernateUtil;
import dbBean.FunctionalReq;
import dbBean.NonFunctionalReq;
import dbBean.Specification;

public class NoFunctionalReqDAOEdit {

	public NonFunctionalReq getNonFunctionalReqById(Integer idNonFunctionalReq,Session session ) {
		session.beginTransaction();

		NonFunctionalReq nonFunctionalReq = (NonFunctionalReq) session.get(NonFunctionalReq.class, idNonFunctionalReq);
		session.getTransaction().commit();

		return nonFunctionalReq;

	}

	public List<NonFunctionalReq> getAllNonFunctionalReqBySpecification(Specification specification,Session session ) {
		session.beginTransaction();

		Query query = session.createQuery("from NonFunctionalReq where specification= :specification");
		query.setParameter("specification", specification);
		List<NonFunctionalReq> nonFunctionalReq = query.list();
		session.getTransaction().commit();

		return nonFunctionalReq;

	}
	
	public List<NonFunctionalReq> getAllManualNonFunctionalReqBySpecification(Specification specification,Session session ) {
		session.beginTransaction();
		Query query = session.createQuery("from NonFunctionalReq where specification= :specification and type='manual'");
		query.setParameter("specification", specification);
		List<NonFunctionalReq> nonFunctionalReq = query.list();
		session.getTransaction().commit();

		return nonFunctionalReq;

	}
	
	public List<NonFunctionalReq> getAllGeneratedNonFunctionalReqBySpecification(Specification specification,Session session ) {
		session.beginTransaction();

		Query query = session.createQuery("from NonFunctionalReq where specification= :specification and type='generated'");
		query.setParameter("specification", specification);
		List<NonFunctionalReq> nonFunctionalReq = query.list();
		session.getTransaction().commit();

		return nonFunctionalReq;
	}

	public void saveOrUpdateNonFunctionalReq(NonFunctionalReq nonFunctionalReq,Session session ) {
		session.beginTransaction();
		session.saveOrUpdate(nonFunctionalReq);
		System.out.println("Inserted or Updated Successfully");
		session.getTransaction().commit();

	}

	public void deleteNonFunctionalReq(NonFunctionalReq nonFunctionalReq,Session session ) {
		session.beginTransaction();
		session.delete(nonFunctionalReq);
		System.out.println("Deleted NonFunctionalReq Successfully");
		session.getTransaction().commit();

	}
	
	public void deleteNonFunctionalReqByList(List<NonFunctionalReq> nonFunctionalReq,Session session ) {
		session.beginTransaction();
		for(NonFunctionalReq f:nonFunctionalReq) {
		session.delete(f);
		}
		System.out.println("Deleted NonFunctionalReq Successfully");
		session.getTransaction().commit();

	}

}
