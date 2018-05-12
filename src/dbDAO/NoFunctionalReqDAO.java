package dbDAO;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import util.HibernateUtil;
import dbBean.FunctionalReq;
import dbBean.NonFunctionalReq;
import dbBean.Specification;

public class NoFunctionalReqDAO {

	public NonFunctionalReq getNonFunctionalReqById(Integer idNonFunctionalReq) {
		SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		Session session = sessionFactory.openSession();
		NonFunctionalReq nonFunctionalReq = (NonFunctionalReq) session.get(NonFunctionalReq.class, idNonFunctionalReq);

		sessionFactory.close();
		return nonFunctionalReq;

	}

	public List<NonFunctionalReq> getAllNonFunctionalReqBySpecification(Specification specification) {
		SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		Session session = sessionFactory.openSession();
		Query query = session.createQuery("from NonFunctionalReq where specification= :specification");
		query.setParameter("specification", specification);
		List<NonFunctionalReq> nonFunctionalReq = query.list();
		sessionFactory.close();
		return nonFunctionalReq;

	}
	
	public List<NonFunctionalReq> getAllManualNonFunctionalReqBySpecification(Specification specification) {
		SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		Session session = sessionFactory.openSession();
		Query query = session.createQuery("from NonFunctionalReq where specification= :specification and type='manual'");
		query.setParameter("specification", specification);
		List<NonFunctionalReq> nonFunctionalReq = query.list();
		sessionFactory.close();
		return nonFunctionalReq;

	}
	
	public List<NonFunctionalReq> getAllGeneratedNonFunctionalReqBySpecification(Specification specification) {
		SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		Session session = sessionFactory.openSession();
		Query query = session.createQuery("from NonFunctionalReq where specification= :specification and type='generated'");
		query.setParameter("specification", specification);
		List<NonFunctionalReq> nonFunctionalReq = query.list();
		sessionFactory.close();
		return nonFunctionalReq;
	}

	public void saveOrUpdateNonFunctionalReq(NonFunctionalReq nonFunctionalReq) {

		SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		Session session = sessionFactory.openSession();
		session.beginTransaction();
		session.saveOrUpdate(nonFunctionalReq);
		System.out.println("Inserted or Updated Successfully");
		session.getTransaction().commit();
		session.close();
		sessionFactory.close();

	}

	public void deleteNonFunctionalReq(NonFunctionalReq nonFunctionalReq) {
		SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		Session session = sessionFactory.openSession();
		session.beginTransaction();
		session.delete(nonFunctionalReq);
		System.out.println("Deleted NonFunctionalReq Successfully");
		session.getTransaction().commit();
		sessionFactory.close();

	}
	
	public void deleteNonFunctionalReqByList(List<NonFunctionalReq> nonFunctionalReq) {
		SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		Session session = sessionFactory.openSession();
		session.beginTransaction();
		for(NonFunctionalReq f:nonFunctionalReq) {
		session.delete(f);
		}
		System.out.println("Deleted NonFunctionalReq Successfully");
		session.getTransaction().commit();
		sessionFactory.close();

	}

}
