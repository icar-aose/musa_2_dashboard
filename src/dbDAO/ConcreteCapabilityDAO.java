package dbDAO;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import util.HibernateUtil;
import dbBean.AbstractCapability;
import dbBean.ConcreteCapability;
import dbBean.Domain;
import dbBean.User;

public class ConcreteCapabilityDAO {

	public List<ConcreteCapability> getAllConcreteCapabilityByAbstract(AbstractCapability abstractCapability) {
		SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		Session session = sessionFactory.openSession();
		Query query = session.createQuery("from ConcreteCapability where abstractCapability= :abstractCapability");
		query.setParameter("abstractCapability", abstractCapability);
		List<ConcreteCapability> concreteCapability = query.list();
		sessionFactory.close();

		return concreteCapability;
	}

	public List<ConcreteCapability> getAllConcreteCapabilityByAbstractUserDev(AbstractCapability abstractCapability,
			User user) {
		SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		Session session = sessionFactory.openSession();
		Query query = session
				.createQuery("from ConcreteCapability where abstractCapability= :abstractCapability and user= :user ");
		query.setParameter("abstractCapability", abstractCapability);
		query.setParameter("user", user);

		List<ConcreteCapability> concreteCapability = query.list();
		sessionFactory.close();

		return concreteCapability;
	}

	public List<ConcreteCapability> getAllConcreteCapabilityByDomain(Domain domain) {
		SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		Session session = sessionFactory.openSession();
		Query query = session.createQuery(
				"select cc from ConcreteCapability as cc ,AbstractCapability as ac  where cc.abstractCapability=ac.idAbstratCapability and ac.domain= :domain");
		query.setParameter("domain", domain);
		System.out.println("QUERY -->" + query.toString());
		List<ConcreteCapability> concreteCapability = query.list();
		sessionFactory.close();

		return concreteCapability;
	}

	public List<ConcreteCapability> getAllConcreteCapabilityByDomainUser(Domain domain, User user) {
		SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		Session session = sessionFactory.openSession();
		Query query = session.createQuery(
				"select cc from ConcreteCapability as cc ,AbstractCapability as ac  where cc.abstractCapability=ac.idAbstratCapability and ac.domain= :domain and cc.user= :user");
		query.setParameter("domain", domain);
		query.setParameter("user", user);
		System.out.println("QUERY -->" + query.toString());
		List<ConcreteCapability> concreteCapability = query.list();
		sessionFactory.close();

		return concreteCapability;
	}

	public Integer saveOrUpdateConcreteCapability(ConcreteCapability concreteCapability) {

		SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		Session session = sessionFactory.openSession();
		session.beginTransaction();
		session.saveOrUpdate(concreteCapability);
		System.out.println("Inserted or Updated Successfully");
		session.getTransaction().commit();
		session.close();
		sessionFactory.close();
		return concreteCapability.getIdConcreteCapability();

	}

	public ConcreteCapability getConcreteCapabilityByID(Integer idConcreteCapability) {
		SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		Session session = sessionFactory.openSession();
		session.beginTransaction();
		ConcreteCapability concreteCapabilityDB = (ConcreteCapability) session.get(ConcreteCapability.class,
				idConcreteCapability);
		session.getTransaction().commit();
		sessionFactory.close();
		return concreteCapabilityDB;
	}

	public void deleteConcreteCapability(int idConcreteCapability) {
		SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		Session session = sessionFactory.openSession();
		session.beginTransaction();
		ConcreteCapability concreteCapability = (ConcreteCapability) session.load(ConcreteCapability.class,
				idConcreteCapability);
		System.out.println("DELETE FOR CAP :" + concreteCapability.getIdConcreteCapability());
		session.delete(concreteCapability);
		System.out.println("Deleted Successfully");
		session.getTransaction().commit();
		sessionFactory.close();

	}
}
