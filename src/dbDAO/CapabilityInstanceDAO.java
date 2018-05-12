package dbDAO;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import util.HibernateUtil;
import dbBean.CapabilityInstance;
import dbBean.CaseExecution;
import dbBean.ConcreteCapability;

public class CapabilityInstanceDAO {

	public List<CapabilityInstance> getAllCapabilityInstanceByCases(CaseExecution caseExecution) {
		SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		Session session = sessionFactory.openSession();
		Query query = session.createQuery("from CapabilityInstance where caseExecution= :caseExecution");
		query.setParameter("caseExecution", caseExecution);
		List<CapabilityInstance> capabilityInstance = query.list();
		sessionFactory.close();
		return capabilityInstance;

	}

	public List<CapabilityInstance> getAllCapabilityInstanceByConcreteCapability(
			ConcreteCapability concreteCapability) {
		SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		Session session = sessionFactory.openSession();
		Query query = session.createQuery("from CapabilityInstance where concreteCapability= :concreteCapability");
		query.setParameter("concreteCapability", concreteCapability);
		List<CapabilityInstance> capabilityInstance = query.list();
		sessionFactory.close();
		return capabilityInstance;

	}

	public CapabilityInstance getCapabilityInstanceByID(Integer idCapabilityInstance) {
		SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		Session session = sessionFactory.openSession();
		CapabilityInstance capabilityInstanceDB = (CapabilityInstance) session.get(CapabilityInstance.class,
				idCapabilityInstance);
		sessionFactory.close();
		return capabilityInstanceDB;
	}

}
