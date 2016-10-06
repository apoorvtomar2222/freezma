package com.freezma.ProfileModel;

import java.util.List;

import com.freezma.ProfileModel.Profile;

import java.util.List;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.method.P;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.EnableTransactionManagement;

	@Repository
	@EnableTransactionManagement
	public class ProfileDAOImpl implements ProfileDAO
	{
		@Autowired
		private SessionFactory sessionFactory;
	 
		public SessionFactory getSessionFactory() 
		{
			return sessionFactory;
		}

		public void setSessionFactory(SessionFactory sessionFactory) {
			this.sessionFactory = sessionFactory;
		}
		
		
		public void insert(Profile p) {
			//Session session = getSessionFactory().getCurrentSession();
			sessionFactory.getCurrentSession().save(p);
			
			System.out.println("User Inserted");
		}

		public void delete(long p) {
			sessionFactory.getCurrentSession().createQuery("delete from Profile as p where p.ID = :id").setLong("id", p).executeUpdate();
			System.out.println("User Deleted");
		}

		public void update(Profile p) {
			System.out.println("Profile Update. PID: " + p.getID());
			
			sessionFactory.getCurrentSession().saveOrUpdate(p);
			sessionFactory.getCurrentSession().flush();
			System.out.println("User updated");
		}

		public List<Profile> getAllUsers() {

			List<Profile> list = (List<Profile>)sessionFactory.getCurrentSession().createQuery("from Profile").list();
			
			return list;
			
		}

		public Profile get(String p) {
			List l = this.getSessionFactory().getCurrentSession().createQuery("from Profile as p where p.Username = :username").setString("username", p).list();
			if (l.size()>0)
			{
				return (Profile)l.get(0);
			}
			else
			{
				return null;
			}

		}

		}

