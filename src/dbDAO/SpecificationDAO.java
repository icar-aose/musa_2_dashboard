package dbDAO;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import util.HibernateUtil;
import dbBean.Domain;
import dbBean.Specification;
import dbBean.User;

public class SpecificationDAO {

	public Specification getSpecificationById(Integer idSpecification) {
		SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		Session session = sessionFactory.openSession();
		Specification specificationDB = (Specification) session.get(Specification.class, idSpecification);

		sessionFactory.close();
		return specificationDB;

	}

	public List<Specification> getAllSpecificationByDomain(Domain domain) {
		SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		Session session = sessionFactory.openSession();
		Query query = session.createQuery("from Specification where domain= :domain");
		query.setParameter("domain", domain);
		List<Specification> specifications = query.list();
		sessionFactory.close();
		return specifications;

	}

	public List<Specification> getAllSpecificationByDomainAndUser(Domain domain, User user) {
		SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		Session session = sessionFactory.openSession();
		Query query = session.createQuery("from Specification where domain= :domain and user= :user");
		query.setParameter("domain", domain);
		query.setParameter("user", user);
		List<Specification> specifications = query.list();
		sessionFactory.close();
		return specifications;

	}

	public void deleteSpecification(Specification specification) {
		SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		Session session = sessionFactory.openSession();
		session.beginTransaction();
		session.delete(specification);
		System.out.println("Deleted specification Successfully");
		session.getTransaction().commit();
		sessionFactory.close();

	}

	public void saveOrUpdateSpecification(Specification specification) {

		SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		Session session = sessionFactory.openSession();
		session.beginTransaction();
		session.saveOrUpdate(specification);
		System.out.println("Inserted or Updated Successfully");
		session.getTransaction().commit();
		session.close();
		sessionFactory.close();

	}

}
