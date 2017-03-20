package dbDAO;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import util.HibernateUtil;
import dbBean.CapabilityInstance;
import dbBean.CapabilityLog;
import dbBean.ConcreteCapability;

public class CapabilityLogDAO {

	
	 public List<CapabilityLog> getAllCapabilityLogByInstance(CapabilityInstance capabilityInstance){
		 SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		  Session session = sessionFactory.openSession();
		  session.beginTransaction();
		  Query query = session.createQuery("from CapabilityLog where capabilityInstance= :capabilityInstance");
		  query.setParameter("capabilityInstance", capabilityInstance);
		  List<CapabilityLog> capabilityLog = query.list();
		  session.getTransaction().commit();
		  sessionFactory.close();
		  return capabilityLog;
	
	 }
	 
	 public List<CapabilityLog> getAllCapabilityLogByCapability(ConcreteCapability concreteCapability){
		 SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		  Session session = sessionFactory.openSession();
		  session.beginTransaction();
		  Query query = session.createQuery("select cl from CapabilityInstance as ci, CapabilityLog as  cl where ci.concreteCapability= :concreteCapability and ci.idCapabilityInstance=cl.capabilityInstance");
		  query.setParameter("concreteCapability", concreteCapability);
		  List<CapabilityLog> capabilityLog = query.list();
		  session.getTransaction().commit();
		  sessionFactory.close();
		  return capabilityLog;
	
	 }
}
