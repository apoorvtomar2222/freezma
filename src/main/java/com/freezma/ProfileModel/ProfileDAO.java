package com.freezma.ProfileModel;

import java.util.List;

import com.freezma.ProfileModel.Profile;

public interface ProfileDAO {
	

	public void insert(Profile p);
	public void delete(long p);
	public void update(Profile p);
	public Profile get(String p);

	    public List<Profile> getAllUsers();
	    
		
}


