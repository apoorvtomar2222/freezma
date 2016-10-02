package com.freezma;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.JsonParser;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.util.UriComponentsBuilder;

import com.freezma.ProfileModel.Profile;
import com.freezma.ProfileModel.ProfileService;


@CrossOrigin(origins = "http://localhost:9001", maxAge = 3600)
@RestController
public class RESTFreezmaController 
{

	@Autowired
	ProfileService ps;
	
	@Autowired
    ServletContext context;	
	
	@CrossOrigin
    @RequestMapping(value = "/getUserDetails/", method = RequestMethod.POST )
    public ResponseEntity<String> getUserDetails(HttpServletRequest request , HttpServletResponse response , UriComponentsBuilder ucBuilder) {
        
		String user = null;
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    if (auth != null && !auth.getName().equals("anonymousUser"))
	    {   
	    	System.out.println(auth.getName());
	    	user = auth.getName();
	    }
	    
	    JSONObject json = new JSONObject();
	    
	    System.out.println(user);
	    
	    if( user != null )
	    {
	    	Profile p = ps.get(user);
	    	
	    	json.put("ProfileName", p.getUsername());
			json.put("ProfileImage", p.getImage());
			json.put("ProfileGender", p.getGender());
			json.put("ProfileAddress", p.getAddress());
			json.put("ProfilePhone", p.getPhone());
			json.put("ProfileEmail", p.getEmail());
	    	
	    }
		
		System.out.println(json.toString());
        
        return new ResponseEntity<String>(json.toString(), HttpStatus.CREATED);
    }
		
	
	@CrossOrigin
    @RequestMapping(value = "/updateUserDetails/", method = RequestMethod.POST)
	
    public ResponseEntity<String> updateUserDetails(HttpServletResponse response,@RequestBody String data, UriComponentsBuilder ucBuilder) {
        
		System.out.println(data);
		
		JSONObject jobjin = new JSONObject();
		
		JSONParser jpar = new JSONParser();
		
		try
		{
			jobjin = (JSONObject)jpar.parse(data);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		String user = null;
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    if (auth != null && !auth.getName().equals("anonymousUser"))
	    {   
	    	System.out.println(auth.getName());
	    	user = auth.getName();
	    }
	    
	    System.out.println(user);
	    
	    if( user != null )
	    {
	    	Profile p = ps.get(user);
	    	
	    	p.setUsername( jobjin.get("ProfileName").toString() );
	    	p.setGender( jobjin.get("ProfileGender").toString() );
	    	p.setPhone( jobjin.get("ProfilePhone").toString() );
	    	p.setAddress( jobjin.get("ProfileAddress").toString() );
	    	p.setCPassword(p.getPassword());
	    	
	    	ps.update(p);
	    	
	    }
		
		JSONObject json = new JSONObject();
        	        
        json.put("status", "Updated");
        
        System.out.println(json.toString());
        
        return new ResponseEntity<String>(json.toString(), HttpStatus.CREATED);
    }
	
	/*

	@CrossOrigin
    @RequestMapping(value = "/updatePassword/", method = RequestMethod.POST)
	public ResponseEntity<String> updateUserPassword(HttpServletResponse response,@RequestBody JSONObject data, UriComponentsBuilder ucBuilder) {
	    
		{
			System.out.println(data);
			JSONObject json = new JSONObject();
		
		return new ResponseEntity<String>(json.toString(), HttpStatus.CREATED);
	
		}
		}*/

}