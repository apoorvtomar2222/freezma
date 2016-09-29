package com.freezma.ProfileRole;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
@Service
public class ProfileRoleServiceImpl implements ProfileRoleService {

	@Autowired
	ProfileRoleDAO dao;
	@Transactional
	public void insertUserRole(ProfileRole p) {
		dao.insertUserRole(p);
	}
	@Transactional
	public void deleteUserRole(long p) {
		dao.deleteUserRole(p);
	}
	@Transactional
	public void updateUserRole(ProfileRole p) {
		dao.updateUserRole(p);
	}
	@Transactional
	public ProfileRole getUserRole(int p) {
		// TODO Auto-generated method stub
		return dao.getUserRole(p);
	}
	@Transactional
	public List<ProfileRole> getAllUsersRole() {
		// TODO Auto-generated method stub
		return dao.getAllUsersRole();
	}
	@Transactional
	public void generateUserRoles() {
		dao.generateUserRoles();
	}

}
