package com.freezma.BlogContent;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import com.freezma.Blog.Blog;
import com.freezma.Blog.BlogDAO;

@Repository
@EnableTransactionManagement
public class BlogContentDAOImpl implements BlogContentDAO
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
		public void insert(BlogContent p) 
		{
			sessionFactory.getCurrentSession().save(p);
			
		}

		public void delete(int p) 
		{
			System.out.println("id to be deleted in dao impl  "+p);
			sessionFactory.getCurrentSession().createQuery("delete from Blog as p where p.BlogID = :BlogID").setInteger("BlogID", p).executeUpdate();	
		}

		public void update(BlogContent p) 
		{
			System.out.println("id to be updated in dao impl  "+p.getBlogID());
			sessionFactory.getCurrentSession().update(p);
		}

		public BlogContent get(String p) 
		{
			
			List l = this.getSessionFactory().getCurrentSession().createQuery("from Blog as p where p.BlogID = :BlogID").setString("BlogID", p).list();
			if (l.size()>0)
			{
				return (BlogContent)l.get(0);
			}
			else
			{
				return null;
			}

		}
		
		public List<BlogContent> getAllBlogs() 
		{
			List<BlogContent> list = (List<BlogContent>)sessionFactory.getCurrentSession().createQuery("from Blog").list();
			return list;
			
		}
		
		public BlogContent getBlogWithMaxId() 
		{
					//  select max(Blogid) from Blog
			List<BlogContent> l = sessionFactory.getCurrentSession().createQuery("from Blog as p where p.BlogID = ( select max(a.BlogID) from Blog as a ) ").list();

			if (l.size() > 0) 
			{
				return l.get(0);
			} 
			else 
			{
				return null;
			}
		}

		
	}

