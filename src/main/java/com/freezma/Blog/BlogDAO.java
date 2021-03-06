package com.freezma.Blog;

import java.util.List;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.EnableTransactionManagement;

public interface BlogDAO 
{
	public void insert(Blog p);
	public void delete(int p);
	public void update(Blog p);
	public Blog get(String p);
	public List<Blog> getAllBlogs();
	public Blog getBlogWithMaxId();
	}
