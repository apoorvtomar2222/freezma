package com.freezma.ProfileModel;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@Service
public class ProfileServiceImpl implements ProfileService {
	
	@Autowired
	ProfileDAO dao;
	@Transactional
	public void insert(Profile p) {
	dao.insert(p);
		
	}
	@Transactional
	public void delete(long p) {
		dao.delete(p);
	}
	@Transactional
	public void update(Profile p) {
		dao.update(p);
	}
	@Transactional
	public Profile get(String p) {
		return dao.get(p);
	}
	@Transactional
	public List<Profile> getAllUsers() {
		return dao.getAllUsers();
	}

}
