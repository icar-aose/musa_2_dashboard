package dbDAO;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import util.HibernateUtil;
import dbBean.AbstractCapability;
import dbBean.AbstractCapabilityProposal;
import dbBean.Domain;

public class AbstractCapabilityProposalDAO {

	public List<AbstractCapabilityProposal> getAllAbstractCapabilityProposalByDomain(Domain domain) {
		SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		Session session = sessionFactory.openSession();
		session.beginTransaction();
		Query query = session.createQuery("from AbstractCapabilityProposal where domain= :domain");
		query.setParameter("domain", domain);
		List<AbstractCapabilityProposal> abstractCapability = query.list();
		session.getTransaction().commit();
		sessionFactory.close();

		return abstractCapability;
	}

	public void saveOrUpdateAbstractCapability(AbstractCapabilityProposal abstractCapabilityProposal) {

		SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		Session session = sessionFactory.openSession();
		session.beginTransaction();
		session.saveOrUpdate(abstractCapabilityProposal);
		System.out.println("Inserted or Updated Successfully");
		session.getTransaction().commit();
		session.close();
		sessionFactory.close();

	}

	public AbstractCapabilityProposal getAbstractCapabilityProposalByID(Integer idAbstractCapabilityProposal) {
		SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		Session session = sessionFactory.openSession();
		session.beginTransaction();
		AbstractCapabilityProposal abstractCapabilityProposalDB = (AbstractCapabilityProposal) session
				.get(AbstractCapabilityProposal.class, idAbstractCapabilityProposal);
		session.getTransaction().commit();
		sessionFactory.close();
		return abstractCapabilityProposalDB;
	}

	public List<AbstractCapabilityProposal> getProposalByAbstractCapability(AbstractCapability abstractCapability) {
		SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		Session session = sessionFactory.openSession();
		session.beginTransaction();
		Query query = session
				.createQuery("from AbstractCapabilityProposal where abstractCapability= :abstractCapability");
		query.setParameter("abstractCapability", abstractCapability);
		List<AbstractCapabilityProposal> abstractCapabilityProposal = query.list();
		session.getTransaction().commit();
		sessionFactory.close();
		return abstractCapabilityProposal;
	}

	public void deleteAbstractCapabilityProposal(int idAbstractCapabilityProposal) {
		SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		Session session = sessionFactory.openSession();
		session.beginTransaction();
		AbstractCapabilityProposal abstractCapabilityProposal = (AbstractCapabilityProposal) session
				.load(AbstractCapabilityProposal.class, idAbstractCapabilityProposal);
		session.delete(abstractCapabilityProposal);
		System.out.println("Deleted Successfully");
		session.getTransaction().commit();
		sessionFactory.close();

	}

}
