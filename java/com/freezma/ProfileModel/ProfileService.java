package com.freezma.ProfileModel;

import java.util.List;

public interface ProfileService {
	
	public void insert(Profile p);
	public void delete(long p);
	public void update(Profile p);
	public Profile get(String p);

	    public List<Profile> getAllUsers();
	    
		

}
