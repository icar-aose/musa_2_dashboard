package dbDAO;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import util.HibernateUtil;
import dbBean.CaseExecution;
import dbBean.Specification;

public class CasesDAO {

	public List<CaseExecution> getAllCasesBySpecification(Specification specification) {
		SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		Session session = sessionFactory.openSession();
		Query query = session.createQuery("from CaseExecution where specification= :specification");
		query.setParameter("specification", specification);
		List<CaseExecution> caseExecution = query.list();
		sessionFactory.close();
		return caseExecution;

	}

	public CaseExecution getCaseExecutionById(Integer idCaseExecution) {
		SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		Session session = sessionFactory.openSession();
		CaseExecution caseExecutionDB = (CaseExecution) session.get(CaseExecution.class, idCaseExecution);

		sessionFactory.close();
		return caseExecutionDB;

	}

}
