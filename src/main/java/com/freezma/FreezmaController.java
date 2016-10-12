package com.freezma;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.codehaus.jackson.JsonFactory;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.freezma.ProfileModel.Profile;
import com.freezma.ProfileModel.ProfileService;
import com.freezma.ProfileRole.ProfileRole;
import com.freezma.ProfileRole.ProfileRoleService;

@Controller
public class FreezmaController {

	
@Autowired
ProfileService as;

@Autowired
ProfileRoleService urs;

@Autowired
JavaMailSender mail;

	@RequestMapping(value="/index")
	public String indx()
	{
		return "index";
	}
	
	@RequestMapping(value = "/viewprofile/{profileName}")
	public ModelAndView addproduct1(@PathVariable("profileName") String name) {
		ModelAndView mav = new ModelAndView("viewprofile");
		System.out.println(name);
		Profile p = as.get(name);
		
		System.out.println("profile"+p);
		JSONArray jarr = new JSONArray();
		JSONObject jobj = new JSONObject();
		if (p != null) 
		{
			jobj.put("ProfileName", p.getUsername());
			jobj.put("ProfileImage", p.getImage());
			jobj.put("ProfileEmail", p.getEmail());
			jobj.put("ProfileGender", p.getGender());
			jobj.put("ProfileAddress", p.getAddress());
			jobj.put("ProfilePhone", p.getPhone());
			jarr.add(jobj);
		}
		
		mav.addObject("mydata", jarr.toString());
		System.out.println("ARRAY"+jarr.toString());
		
		return mav;

	}
	@RequestMapping(value="/blog/{ProfileName}")
	public ModelAndView blog(@PathVariable("ProfileName") String username)
	{
		ModelAndView mav = new ModelAndView("blog");
		Profile p = as.get(username);
		System.out.println("user profile"+p);
		JSONObject json = new JSONObject();
		
		if (p.getBlogs()==null)
			{
				System.out.println("Test 1");
				mav.addObject("value","No blog");
			}
		else
			{

				System.out.println("Test 2");
				
				mav.addObject("value",p.getUsername());	
			}
		
		return mav;
	}
	

	
	
	
	@RequestMapping(value="/searchnewfreind")
	public String searchnewfreind()
	{
		return "searchnewfreind";
	}
	
	
	@RequestMapping("/profile")
	public ModelAndView prfl() 
	{

		String username = "";
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    if (auth != null && !auth.getName().equals("anonymousUser"))
	    {    
	    	username = auth.getName();
	    	
	    }
	    ModelAndView mav = new ModelAndView("profile");
		
/* 
		Profile p = as.get(username);
		
		System.out.println(p.getUsername());
		
		mav.addObject("dataValue",p );
		   mav.addObject("userName", p.getUsername());
*/
		
/*	JSONArray jarr = new JSONArray();
*/		
		JSONObject jobj = new JSONObject();
		List<Profile> list = as.getAllUsers();
		
		for (Profile p : list) {
			
			if( p.getUsername().equals(username) )
			{
				jobj.put("ProfileName", p.getUsername());
				jobj.put("ProfileImage", p.getImage());
				jobj.put("ProfileGender", p.getGender());
				jobj.put("ProfileAddress", p.getAddress());
				jobj.put("ProfilePhone", p.getPhone());
				
				
				
/*				jarr.add(jobj);
*/			}				
		}
		mav.addObject("data", jobj.toJSONString());

		return mav;

	}
	

	 @RequestMapping(value="/")
	public String home()
	{
		urs.generateUserRoles();
		return "index";
	}
		
	/* ADD NEW USER */


	@RequestMapping(value = "/signup")
	public ModelAndView sgnup() {
		ModelAndView mav = new ModelAndView("signup");
		mav.addObject("newuser", new Profile());

		return mav;
	}

	
	@RequestMapping(value = "/insertuser", method = RequestMethod.POST)
	public ModelAndView insertUser(@Valid @ModelAttribute("newuser") Profile p, BindingResult bind , HttpServletRequest req , HttpServletResponse resp) {

		ModelAndView mav = new ModelAndView("signup");

		
		System.out.println("In User Insert");

		if (bind.hasErrors()) 
		{
			mav.addObject("newuser", p);
		}
		else 
		{
			Profile validateuser = as.get(p.getUsername());
			
			if( validateuser == null )
			{
				if( p.getGender().equals("M") )
				{
					p.setImage("resources/images/male.jpg");
				}
				else
				{
					p.setImage("resources/images/female.jpg");
				}

			}

			if (p.getPassword().equals(p.getCPassword())) {
				List<Profile> list = as.getAllUsers();

				System.out.println(list);

				boolean usermatch = false;

				for (Profile u : list) 
				{
					if (u.getUsername().equals(p.getUsername())) 
					{
						usermatch = true;
						break;
					}
				}

				if (usermatch == false) 
				{
					as.insert(p);

					mav.addObject("newuser", new Profile());

					mav.addObject("success", "success");
				} 
				else 
				{
					mav.addObject("newuser", p);

					mav.addObject("useralreadyexists", "useralreadyexists");
				}
			} 
			else 
			{
				mav.addObject("newuser", p);

				mav.addObject("passwordmismatch", "passwordmismatch");
			}
		
		}
		
						
		String uemail = req.getParameter("Email");
		System.out.println( uemail );
		
		SimpleMailMessage email = new SimpleMailMessage();
		
		email.setTo(uemail);
		email.setSubject("Welcome to FREEZMA");
		email.setText(" Thanks for Connecting  \n  \n\n Regards, \n The Freeza Team");
		

		try
		{
			mail.send(email);
			
			System.out.println("Mail 1 Sent");
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	
			
		return mav;
	}

@RequestMapping(value = "/loginpage", method = RequestMethod.GET)
public ModelAndView login() 
{
	ModelAndView mav = new ModelAndView("login");
	return mav;
}

@RequestMapping(value = "/logout", method = RequestMethod.GET)
public String logoutPage(HttpServletRequest request, HttpServletResponse response) {
	Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	if (auth != null) {

		System.out.println("In LogOut");
		new SecurityContextLogoutHandler().logout(request, response, auth);

	}

	return "index";
}
}
