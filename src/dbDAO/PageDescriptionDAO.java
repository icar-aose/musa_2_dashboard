package dbDAO;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import util.HibernateUtil;
import dbBean.PageDescription;

public class PageDescriptionDAO {

	public PageDescription getUserByName(String name) {
		SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		Session session = sessionFactory.openSession();
		PageDescription pageDB = (PageDescription) session.get(PageDescription.class, name);
		sessionFactory.close();
		return pageDB;
	}

	public List<PageDescription> getAllPageDescription() {
		SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
		Session session = sessionFactory.openSession();
		Query query = session.createQuery("from PageDescription");
		List<PageDescription> pageDB = query.list();
		sessionFactory.close();
		return pageDB;

	}

}
