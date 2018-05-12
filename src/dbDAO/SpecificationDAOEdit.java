package dbDAO;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import util.HibernateUtil;
import dbBean.Domain;
import dbBean.Specification;
import dbBean.User;

public class SpecificationDAOEdit {
	private SessionFactory sessionFactory;
	private Session session;
	
	public Specification getSpecificationById(Integer idSpecification,Session session) {
		Specification specificationDB = (Specification) session.get(Specification.class, idSpecification);

		return specificationDB;

	}

	public List<Specification> getAllSpecificationByDomain(Domain domain,Session session) {

		Query query = session.createQuery("from Specification where domain= :domain");
		query.setParameter("domain", domain);
		List<Specification> specifications = query.list();

		return specifications;

	}

	public List<Specification> getAllSpecificationByDomainAndUser(Domain domain, User user,Session session) {

		Query query = session.createQuery("from Specification where domain= :domain and user= :user");
		query.setParameter("domain", domain);
		query.setParameter("user", user);
		List<Specification> specifications = query.list();

		return specifications;

	}

	public void deleteSpecification(Specification specification,Session session) {

		session.delete(specification);
		System.out.println("Deleted specification Successfully");

	}

	public void saveOrUpdateSpecification(Specification specification,Session session) {


		session.saveOrUpdate(specification);
		System.out.println("Inserted or Updated Successfully");

	}

}
