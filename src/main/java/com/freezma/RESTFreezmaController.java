package com.freezma;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.math.Fraction;
import org.apache.http.protocol.HTTP;
import org.codehaus.jackson.JsonParser;
import org.hibernate.validator.constraints.Length;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Jsr250MethodSecurityMetadataSource;
import org.springframework.security.authentication.ProviderManager;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.util.UriComponentsBuilder;

import com.freezma.BlogComment.BlogComment;
import com.freezma.BlogComment.BlogCommentService;
import com.freezma.BlogContent.BlogContent;
import com.freezma.BlogContent.BlogContentService;
import com.freezma.Forum.Forum;
import com.freezma.Forum.ForumService;
import com.freezma.ProfileModel.Profile;
import com.freezma.ProfileModel.ProfileService;

import javassist.compiler.ast.Variable;

@CrossOrigin(origins = "http://localhost:9000", maxAge = 3600)
@RestController
public class RESTFreezmaController {

	@Autowired
	ForumService fs;
	@Autowired
	ProfileService ps;

	@Autowired
	ServletContext context;

	@Autowired
	BlogContentService bcs;
	
	@Autowired
	BlogCommentService bcms;
	
	@CrossOrigin
	@RequestMapping(value="/getforumDetail/{x.ForumID}", method=RequestMethod.POST)
	public ResponseEntity<String> getforumdetails(@PathVariable("ForumID") String id, HttpServletRequest req , HttpServletResponse rep , UriComponentsBuilder ucBuilder)
	{
		System.out.println(id);
		JSONObject jobj = new JSONObject();
		
		String user = "";
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		
		if(authentication!=null && !authentication.getName().equals("annonymusUser"))
		{
			user= authentication.getName();
		}
		System.out.println(user);

		Profile pu = ps.get(user);
	
		List<Forum> list = fs.getAllForums();
		
		if(user!=null)
		{
		for(Forum f:list)
		{
			System.out.println("f.getowner id   "+ f.getOwnerID());
			
			System.out.println("user id"+ pu.getID().toString());
			if(f.getOwnerID().equals(pu.getID().toString()))
			{
				
				jobj.put("ForumWriter", pu.getUsername());
				jobj.put("TopicName", f.getTopicname());
				jobj.put("TopicDescription", f.getDescription());
				
			}
			
		}
		}
		
		System.out.println(jobj);
		
	return new ResponseEntity<String>(jobj.toJSONString(),HttpStatus.CREATED);
	}
	
	
	
	@CrossOrigin
	@RequestMapping(value = "/getUserDetails/", method = RequestMethod.POST)
	public ResponseEntity<String> getUserDetails(HttpServletRequest request, HttpServletResponse response,
			UriComponentsBuilder ucBuilder) {

		String user = null;

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth != null && !auth.getName().equals("anonymousUser")) {
			System.out.println(auth.getName());
			user = auth.getName();
		}

		JSONObject json = new JSONObject();

		if (user != null) {
			Profile p = ps.get(user);

			json.put("ProfileName", p.getUsername());
			json.put("ProfileImage", p.getImage());
			json.put("ProfileGender", p.getGender());
			json.put("ProfileAddress", p.getAddress());
			json.put("ProfilePhone", p.getPhone());
			json.put("ProfileEmail", p.getEmail());
			json.put("ProfileID", p.getID());
	
		}

		System.out.println(json.toString());

		return new ResponseEntity<String>(json.toString(), HttpStatus.CREATED);
	}

	@CrossOrigin
	@RequestMapping(value = "/updateUserDetails/", method = RequestMethod.POST)

	public ResponseEntity<String> updateUserDetails(HttpServletResponse response, @RequestBody String data,
			UriComponentsBuilder ucBuilder) {

		System.out.println(data);

		JSONObject jobjin = new JSONObject();

		JSONParser jpar = new JSONParser();

		try {
			jobjin = (JSONObject) jpar.parse(data);
		} catch (Exception e) {
			e.printStackTrace();
		}

		String user = null;

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth != null && !auth.getName().equals("anonymousUser")) {
			System.out.println(auth.getName());
			user = auth.getName();
		}
		if (user != null) 
		{
			Profile p = ps.get(user);

			p.setUsername(jobjin.get("ProfileName").toString());
			p.setGender(jobjin.get("ProfileGender").toString());
			p.setPhone(jobjin.get("ProfilePhone").toString());
			p.setAddress(jobjin.get("ProfileAddress").toString());
			p.setEmail(jobjin.get("ProfileEmail").toString());
			p.setCPassword(p.getPassword());

			ps.update(p);

		}

		JSONObject json = new JSONObject();

		json.put("status", "Updated");

		System.out.println(json.toString());

		return new ResponseEntity<String>(json.toString(), HttpStatus.CREATED);
	}

	@CrossOrigin
	@RequestMapping(value = "/updatePassword/", method = RequestMethod.POST)

	public ResponseEntity<String> updatePassword(HttpServletResponse response, @RequestBody String data,
			UriComponentsBuilder ucBuilder) {

		System.out.println(data);

		JSONObject json = new JSONObject();

		JSONParser jpar = new JSONParser();

		try {
			json = (JSONObject) jpar.parse(data);
		} catch (Exception e) {
			e.printStackTrace();
		}

		String user = null;

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth != null && !auth.getName().equals("anonymousUser")) {
			System.out.println(auth.getName());
			user = auth.getName();
		}

		if (user != null)

		{
			Profile p = ps.get(user);

			String pass = json.get("OldPassword").toString();

			if (p.getPassword().equals(pass)) {
				String npass = json.get("NewPassword").toString();
				p.setPassword(npass);
				p.setUsername(p.getUsername());
				p.setGender(p.getGender());
				p.setPhone(p.getPhone());
				p.setAddress(p.getAddress());
				p.setCPassword(p.getPassword());

				ps.update(p);

				json.put("status", "Updated");
			} else {
				json.put("status", "Password Incorrect");
			}

		} else {
			json.put("status", "Password Incorrect");
		}

		System.out.println(json.toString());

		return new ResponseEntity<String>(json.toString(), HttpStatus.CREATED);
	}

	@CrossOrigin
	@RequestMapping(value = "/updateProfilePicture/", method = RequestMethod.POST)
	public ResponseEntity<String> updateProfilePicture(MultipartHttpServletRequest request,
			HttpServletResponse response, UriComponentsBuilder ucBuilder) {
		System.out.println(request.getHeader("user"));

		System.out.println(request.getFile("file").getName());
		System.out.println(request.getFile("file").getSize());
		System.out.println(request.getFile("file").getContentType());
		System.out.println(request.getFile("file").getOriginalFilename());

		String hashname[] = request.getFile("file").getOriginalFilename().split(",");

		JSONObject json = new JSONObject();
		BufferedOutputStream stream = null;

		try {
			String path = context.getRealPath("/");

			System.out.println(path);

			File directory = null;

			System.out.println(request.getFile("file"));

			if (request.getFile("file").getContentType().contains("image")) {
				directory = new File(path + "\\resources\\images");

				System.out.println(directory);

				byte[] bytes = null;
				File file = null;
				bytes = request.getFile("file").getBytes();

				if (!directory.exists())
					directory.mkdirs();
				{
					file = new File(directory.getAbsolutePath() + System.getProperty("file.separator") + hashname[0]);

					System.out.println(file.getAbsolutePath());

					stream = new BufferedOutputStream(new FileOutputStream(file));
					stream.write(bytes);
					stream.close();

					Profile p = ps.get(request.getHeader("user"));

					if (p != null) {
						p.setImage("resources/images/" + hashname[0]);
						System.out.println(p.getPassword());
						p.setPassword(p.getPassword());

						p.setCPassword(p.getPassword());
						ps.update(p);

						json.put("status", "Uploaded");

						json.put("imagesrc", "resources/images/" + hashname[0]);

					}
				}

			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		System.out.println(json.toString());

		return new ResponseEntity<String>(json.toString(), HttpStatus.CREATED);
	}

	/*
	 * @CrossOrigin
	 * 
	 * @RequestMapping(value = "/fetchAllItems/", method = RequestMethod.POST)
	 * public ResponseEntity<String> fetchAllItems(HttpServletRequest request,
	 * HttpServletResponse response, UriComponentsBuilder ucBuilder) {
	 * 
	 * String user = null;
	 * 
	 * Authentication auth =
	 * SecurityContextHolder.getContext().getAuthentication(); if (auth != null
	 * && !auth.getName().equals("anonymousUser")) {
	 * System.out.println(auth.getName()); user = auth.getName();
	 * 
	 * } JSONArray jarr1 = new JSONArray(); JSONParser jpartemp = new
	 * JSONParser();
	 * 
	 * Profile P1 = ps.get(user);
	 * 
	 * 
	 * 
	 * try { jarr1 = (JSONArray)jpartemp.parse(P1.getPendingFriendList());
	 * 
	 * for( Object e : jarr1 ) if(e.equals(p.getID().toString()))
	 * 
	 * { System.out.println("Pending List ID  " + e);
	 * 
	 * 
	 * }
	 * 
	 * } catch(Exception e) { e.printStackTrace(); }
	 * 
	 * 
	 * JSONArray jarr = new JSONArray();
	 * 
	 * 
	 * List<Profile> list = ps.getAllUsers();
	 * 
	 * 
	 * 
	 * for (Profile p : list)
	 * 
	 * 
	 * 
	 * // if(e.equals(p.getID().toString()))
	 * 
	 * 
	 * 
	 * if(!p.getUsername().equals(user)) { JSONObject jobj = new JSONObject();
	 * System.out.println(p.getUsername()); jobj.put("ProfileID", p.getID());
	 * jobj.put("ProfileName", p.getUsername()); jobj.put("ProfileEmail",
	 * p.getEmail()); jobj.put("ProfileImage", p.getImage());
	 * 
	 * jarr.add(jobj); } else { System.out.println("match");
	 * 
	 * }
	 * 
	 * 
	 * return new ResponseEntity<String>(jarr.toString(), HttpStatus.CREATED); }
	 */

	@CrossOrigin
	@RequestMapping(value = "/fetchAllItems/", method = RequestMethod.POST)
	public ResponseEntity<String> fetchAllItems(HttpServletRequest request, HttpServletResponse response,
			UriComponentsBuilder ucBuilder) {

		String user = null;

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth != null && !auth.getName().equals("anonymousUser")) {
			// System.out.println(auth.getName());
			user = auth.getName();
		}

		Profile P1 = ps.get(user);
		JSONArray jarr = new JSONArray();
		JSONParser jpartemp = new JSONParser();

		try {

			// System.out.println("Displaying List: "+
			// P1.getPendingFriendList());
			// System.out.println("Pending List ID"+ e);
			List<Profile> list = ps.getAllUsers();
			for (Profile p : list) {
				// System.out.println("Verifying" );
				if (!p.getUsername().equals(user)) {
					JSONObject jobj = new JSONObject();
					jobj.put("ProfileID", p.getID());
					jobj.put("ProfileName", p.getUsername());
					jobj.put("ProfileEmail", p.getEmail());
					jobj.put("ProfileImage", p.getImage());

					boolean check = true;
					JSONArray jarr1;
					jarr1 = new JSONArray();
					if (check) //Test 1
					{
					if(P1.getPendingFriendList() != null)	
						{
						System.out.println("Test 1");	
						jarr1 = (JSONArray) jpartemp.parse(P1.getPendingFriendList());// login
																						// user
																						// array
						for (Object e : jarr1) {
							if (e.equals(p.getID().toString())) {
								jobj.put("ProfileAssociation", "pendingrequest");
								check = false;
								break;
							}
						}
					
						}}
					/*System.out.println(p.getID());
					System.out.println(check);*/
					if (check) 
					{
						if(P1.getRequestSent()!= null)//Test 2
							{
								System.out.println("Test 2");
								jarr1 = new JSONArray();
								jarr1 = (JSONArray) jpartemp.parse(P1.getRequestSent());// login// user// request// sent
								System.out.println(jarr1);
								for (Object e : jarr1) 
									{
										System.out.println(e);
										System.out.println(p.getID());
											if (e.equals(p.getID().toString())) 
												{
													System.out.println("request sent");
													jobj.put("ProfileAssociation", "Sent");
													check = false;
													break;
												}
									}
							}
					}
					
					if (check) //Test 3
					{
						if(P1.getFriendList()!= null)
							{
								System.out.println("Test 3");
								jarr1 = new JSONArray();
								jarr1 = (JSONArray) jpartemp.parse(P1.getFriendList());// login// user// request// sent
								System.out.println(jarr1);
								for (Object e : jarr1) 
									{
										System.out.println(e);
										System.out.println(p.getID());
											if (e.equals(p.getID().toString())) 
												{
													System.out.println("Friends");
													jobj.put("ProfileAssociation", "Friend");
													check = false;
													break;
												}
									}
							}
					}

					if (check) {

						jobj.put("ProfileAssociation", "notfriend");
						check = false;

					}

		
		
					jarr.add(jobj);
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		/*finally
		{
			List<Profile> list1 = ps.getAllUsers();
			
			for (Profile p1 : list1) {
				
			JSONObject jobj = new JSONObject();
			jobj.put("ProfileID", p1.getID());
			jobj.put("ProfileName", p1.getUsername());
			jobj.put("ProfileEmail", p1.getEmail());
			jobj.put("ProfileImage", p1.getImage());
			jobj.put("Profileassociation","Empty");
			jarr.add(jobj);
		}
	}
*/		System.out.println("this is from fetchcommment rest controller "+jarr);

		return new ResponseEntity<String>(jarr.toString(), HttpStatus.CREATED);
	}

@CrossOrigin
@RequestMapping(value = "/AddFriend/", method = RequestMethod.POST)
public ResponseEntity<String> AddFriend(HttpServletRequest request, HttpServletResponse response,@RequestBody String data, UriComponentsBuilder ucBuilder) 
{
		System.out.println(data);
		String user = null;
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth != null && !auth.getName().equals("anonymousUser")) 
			{
				// System.out.println(auth.getName());
				user = auth.getName();
			}
		JSONObject json = new JSONObject();
		JSONParser jpar = new JSONParser();
		try 
			{
				json = (JSONObject) jpar.parse(data);
			} 
		catch (Exception e) 
			{
				e.printStackTrace();
			}
		String pass = json.get("FriendID").toString();
		String IDfriend = json.get("ProfileID").toString();
		System.out.println(pass);
		System.out.println(IDfriend);
		// List <Profile> list = ps.getAllUsers();
		JSONObject rjson = new JSONObject();
		if (user != null) 
			{
				Profile p = ps.get(pass);
				Profile myp = ps.get(user);
					if (p.getPendingFriendList() == null && myp.getRequestSent() == null) 
						{
							System.out.println("1");
							JSONArray jarr = new JSONArray();
							JSONArray jarr1 = new JSONArray();
							jarr.add(myp.getID().toString());
							jarr1.add(IDfriend.toString());
							p.setPendingFriendList(jarr.toJSONString());
							myp.setRequestSent(jarr1.toJSONString());
							rjson.put("ProfileAssociation","Sent");
							rjson.put("ProfileID", p.getID());
							p.setCPassword(p.getPassword());
							myp.setCPassword(myp.getPassword());
							ps.update(p);
							ps.update(myp);
							
						} 
		else
			{
				System.out.println("3");
				JSONArray jarr = new JSONArray();
				JSONParser jpartemp = new JSONParser();
				JSONArray jarr1 = new JSONArray();
				JSONParser jpartemp1 = new JSONParser();

				try 
					{
						jarr = (JSONArray) jpartemp.parse(p.getPendingFriendList());// friend
						jarr1 = (JSONArray) jpartemp1.parse(myp.getRequestSent());// user
						System.out.println("array 1" + jarr);
						System.out.println("array2" + jarr1);
					}
				catch(Exception e)
					{
						e.printStackTrace();
					}
				
				if (!jarr.contains(myp.getID().toString())) 
					{
					if (!jarr1.contains(p.getID().toString()))
				
						{		
							System.out.println("last loop");
							jarr.add(myp.getID().toString());
							jarr1.add(p.getID().toString());
							p.setPendingFriendList(jarr.toString());
							myp.setRequestSent(jarr1.toString());
							rjson.put("ProfileAssociation","Sent");
							rjson.put("ProfileID", p.getID());
				
						
						}
					
					}
				try 
				{
						p.setCPassword(p.getPassword());
					myp.setCPassword(myp.getPassword());
					ps.update(p);
					ps.update(myp);
				}
				catch(Exception e)
				{
					e.printStackTrace();
				}
			}
		}
				
			rjson.put("status", "Updated");
			System.out.println(rjson);
			return new ResponseEntity<String>(rjson.toString(), HttpStatus.CREATED);
	}
	
	
@CrossOrigin
@RequestMapping(value="/AcceptRequest/",method=RequestMethod.POST)
public ResponseEntity<String> AcceptRequest(HttpServletRequest req, HttpServletResponse res, @RequestBody String data , UriComponentsBuilder uri)
{
		System.out.println(data);
		String user=null;
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if(authentication != null && !authentication.getName().equals("anonymouseUser"))
		{
			user = authentication.getName();
			System.out.println("login User "+user);
		}
		JSONObject json = new JSONObject();
		JSONParser jpar = new JSONParser();
		try
		{	
			json =  (JSONObject)jpar.parse(data);
		}
		catch(Exception e)
		{
		e.printStackTrace();	
		}
		System.out.println(json);
		String usertoadd = json.get("FriendName").toString();
		String idtoadd =json.get("ProfileID").toString();
		System.out.println("USERNAME TO ACCEPT REQUEST"+ usertoadd);
		System.out.println("USERID TO ACCEPT REQUEST"+ idtoadd);
		
		Profile p1 = ps.get(usertoadd);//profiletoadd
		Profile p2 = ps.get(user);//userprofile
		
		System.out.println("Profile of Friend "+ p1);
		System.out.println("User PRofile of login user"+ p2);
		System.out.println(p2.getFriendList());
		System.out.println(p1.getFriendList());
		JSONArray jarr3 = new JSONArray();
		JSONArray jarr4 = new JSONArray();
		JSONParser jpar3 = new JSONParser();
		JSONParser jpar4 = new JSONParser();

		
		if(user != null)
		{
			if(p2.getFriendList()==null && p1.getFriendList()==null)
			{
				System.out.println("If friend list is empty");
				JSONArray jarr = new JSONArray();
				JSONArray jarr2 = new JSONArray();
				
				try
				{
				jarr.add(p2.getID().toString());
				jarr2.add(p1.getID().toString());
				
				jarr3 = (JSONArray)jpar.parse(p2.getPendingFriendList().toString());///////////////// USer	
				jarr4 = (JSONArray)jpar.parse(p1.getRequestSent().toString());	/////////////////////not USer
				
				jarr3.remove(p1.getID().toString());
				jarr4.remove(p2.getID().toString());
			
				
				p1.setFriendList(jarr.toString());
				p1.setCPassword(p1.getPassword());
				p1.setRequestSent(jarr4.toString());
				
				
				p2.setPendingFriendList(jarr3.toString());
				p2.setFriendList(jarr2.toString());
				p2.setCPassword(p2.getPassword());
				ps.update(p1);
				ps.update(p2);

				}
				catch(Exception e)
				{
					e.printStackTrace();
				}
			}
		else
		{
			System.out.println("else part");
			JSONArray jarr = new JSONArray();
			JSONArray jarr1 = new JSONArray();
			JSONParser jpar0 = new JSONParser();
			JSONParser jpar1 = new JSONParser();
		try
			{
				jarr= (JSONArray)jpar0.parse(p1.getFriendList());
				jarr1=(JSONArray)jpar1.parse(p2.getFriendList());
				jarr3 = (JSONArray)jpar.parse(p2.getPendingFriendList().toString());	
				jarr4 = (JSONArray)jpar.parse(p1.getRequestSent().toString());	
				
			
				System.out.println(jarr);
				System.out.println(jarr1);
			}
		catch(Exception e)
		{
			e.printStackTrace();
		}
			if(!jarr.contains(p2.getID()))
						{
						if(!jarr1.contains(p1.getID()))
							{
							try
							{
							
								jarr.add(p2.getID());
								jarr1.add(p1.getID());
								jarr3.remove(p1.getID().toString());
								jarr4.remove(p2.getID().toString());
								p1.setFriendList(jarr.toString());
								p1.setCPassword(p1.getPassword());
								p1.setRequestSent(jarr4.toString());
								
								
								p2.setPendingFriendList(jarr3.toString());
								p2.setFriendList(jarr1.toString());
								p2.setCPassword(p2.getPassword());
								
								System.out.println("qqq "+p1.getFriendList());
								System.out.println("dfdsfsd "+p2.getFriendList());
						
									ps.update(p1);
								ps.update(p2);
								}

							catch(Exception e)
								{
									e.printStackTrace();
								}
							
							}
						
						}

								
						}
				
					
				}
			
				
		
		JSONObject json1 = new JSONObject();
		json1.put("status","Updated");
		json1.put("ProfileAssociation","Friend");
		json1.put("ProfileID", p1.getID());

		System.out.println(json1.toString());
		
		return  new ResponseEntity<String>(json1.toString() , HttpStatus.CREATED);
	
}
	
	@CrossOrigin
	@RequestMapping(value = "/Delete/", method = RequestMethod.POST)
	public ResponseEntity<String> DeleteFriend(HttpServletRequest req, HttpServletResponse res,@RequestBody String data, UriComponentsBuilder uri) {
		System.out.println(data);
		String user = "null";
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if (authentication != null && !authentication.getName().equals("anonymousUser")) 
			{
				System.out.println(authentication.getName());
				user = authentication.getName();
			}

		JSONObject json = new JSONObject();
		JSONParser jpar = new JSONParser();
		try {
				json = (JSONObject) jpar.parse(data);
			} 
		catch (Exception e) 	
			{
				e.printStackTrace();
			}
		System.out.println(json);
		String pass = json.get("ProfileID").toString();
		String name = json.get("FriendID").toString();
		

		System.out.println(name);
		System.out.println(pass);
		Profile P1 = ps.get(user);
		Profile P2 = ps.get(name);
		// System.out.println(P1.getPendingFriendList().toString());

		if (user != null) 
			{
				System.out.println("test 1 passed");
				JSONArray jarr = new JSONArray();
				JSONArray jarr1 = new JSONArray();
				JSONParser jpartemp = new JSONParser();
				JSONParser jpartemp1 = new JSONParser();
			try 
				{
					System.out.println("test 2 passed");
					jarr = (JSONArray) jpartemp.parse(P1.getRequestSent());
					jarr1 = (JSONArray) jpartemp1.parse(P2.getPendingFriendList());
					
					System.out.println("before test 3"+jarr.toJSONString());
					if (jarr.contains(pass)) 
						{
							System.out.println("test 3 passed");
							System.out.println(jarr.toJSONString());
							System.out.println(jarr1.toJSONString());
							jarr.remove(pass);
							jarr1.remove(P1.getID().toString());
							System.out.println(jarr.toJSONString());
							System.out.println(jarr1.toJSONString());
							
							P1.setRequestSent(jarr.toString());
							P1.setCPassword(P1.getPassword());
							
							P2.setPendingFriendList(jarr1.toJSONString());
							P2.setCPassword(P2.getPassword());
							
							ps.update(P1);
							ps.update(P2);
						}
				}

			catch (Exception e) 
				{
					e.printStackTrace();
				}

			
			json.put("status", "Deleted");
			json.put("ProfileAssociation","notfriend");
			json.put("ProfileID", P2.getID());
				
		}

		return new ResponseEntity<String>(json.toString(), HttpStatus.CREATED);
	}

	@CrossOrigin
	@RequestMapping(value = "/IgnoreFriend/", method = RequestMethod.POST)
	public ResponseEntity<String> IgnoreFriend(HttpServletRequest req, HttpServletResponse res,@RequestBody String data, UriComponentsBuilder uri) {
		System.out.println(data);
		String user = "null";
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if (authentication != null && !authentication.getName().equals("anonymousUser")) 
			{
				System.out.println(authentication.getName());
				user = authentication.getName();
			}

		JSONObject json = new JSONObject();
		JSONParser jpar = new JSONParser();
		try {
				json = (JSONObject) jpar.parse(data);
			} 
		catch (Exception e) 	
			{
				e.printStackTrace();
			}
		System.out.println(json);
		String pass = json.get("ProfileID").toString();
		String name = json.get("FriendID").toString();
		

		System.out.println(name);
		System.out.println(pass);
		Profile P1 = ps.get(user);
		Profile P2 = ps.get(name);
		// System.out.println(P1.getPendingFriendList().toString());

		if (user != null) 
			{
				System.out.println("test 1 passed");
				JSONArray jarr = new JSONArray();
				JSONArray jarr1 = new JSONArray();
				JSONParser jpartemp = new JSONParser();
				JSONParser jpartemp1 = new JSONParser();
			try 
				{
					System.out.println("test 2 passed");
					jarr = (JSONArray) jpartemp.parse(P2.getRequestSent());
					jarr1 = (JSONArray) jpartemp1.parse(P1.getPendingFriendList());
					
					System.out.println("before test 3"+jarr.toJSONString());
					if (jarr1.contains(pass)) 
						{
							System.out.println("test 3 passed");
							System.out.println(jarr.toJSONString());
							System.out.println(jarr1.toJSONString());
							jarr1.remove(pass);
							jarr.remove(P1.getID());
							System.out.println(jarr.toJSONString());
							System.out.println(jarr1.toJSONString());
							
							P2.setRequestSent(jarr.toString());
							P2.setCPassword(P2.getPassword());
							
							P1.setPendingFriendList(jarr1.toJSONString());
							P1.setCPassword(P2.getPassword());
							
							ps.update(P1);
							ps.update(P2);
						}
				}

			catch (Exception e) 
				{
					e.printStackTrace();
				}

			
			json.put("status", "Deleted");
			json.put("ProfileAssociation","notfriend");
			json.put("ProfileID", P2.getID());

		}

		return new ResponseEntity<String>(json.toString(), HttpStatus.CREATED);
	}

	@CrossOrigin
	@RequestMapping(value = "/RemoveFriend/", method = RequestMethod.POST)
	public ResponseEntity<String> RemoveFriend(HttpServletRequest req, HttpServletResponse res,@RequestBody String data, UriComponentsBuilder uri) {
		System.out.println(data);
		String user = "null";
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if (authentication != null && !authentication.getName().equals("anonymousUser")) 
			{
				System.out.println(authentication.getName());
				user = authentication.getName();
			}

		JSONObject json = new JSONObject();
		JSONParser jpar = new JSONParser();
		try {
				json = (JSONObject) jpar.parse(data);
			} 
		catch (Exception e) 	
			{
				e.printStackTrace();
			}
		System.out.println(json);

		String pass = json.get("ProfileID").toString();
		String name = json.get("FriendName").toString();
		

		System.out.println(name);
		System.out.println(pass);
		Profile P1 = ps.get(user);//User Profile
		Profile P2 = ps.get(name);//Friend's Profile
		// System.out.println(P1.getPendingFriendList().toString());

		if (user != null) 
			{
				System.out.println("test 1 passed");
				JSONArray jarr = new JSONArray();
				JSONArray jarr1 = new JSONArray();
				JSONParser jpartemp = new JSONParser();
				JSONParser jpartemp1 = new JSONParser();
			try 
				{
					System.out.println("test 2 passed");
					jarr = (JSONArray) jpartemp.parse(P1.getFriendList());//login user list
					jarr1= (JSONArray) jpartemp.parse(P2.getFriendList());//frnd to be deleted
					
					System.out.println("before test 3"+jarr.toJSONString());
					if (jarr.contains(pass)) 
						{
							System.out.println("test 3 passed");
							System.out.println(jarr.toJSONString());
							System.out.println(jarr1.toJSONString());
							jarr.remove(pass.toString());
							jarr1.remove(P1.getID().toString());
							System.out.println(jarr.toJSONString());
							System.out.println(jarr1.toJSONString());
							
							P1.setFriendList(jarr.toString());
							P1.setCPassword(P1.getPassword());
							
							P2.setFriendList(jarr1.toJSONString());
							P2.setCPassword(P2.getPassword());
							
							ps.update(P1);
							ps.update(P2);
						}
				}

			catch (Exception e) 
				{
					e.printStackTrace();
				}

			
			json.put("status", "Deleted");
			json.put("ProfileAssociation","notfriend");
			json.put("ProfileID", P2.getID());
			
		}

		return new ResponseEntity<String>(json.toString(), HttpStatus.CREATED);
	}


	@CrossOrigin
	@RequestMapping(value = "/updateLike/", method = RequestMethod.POST)
	public ResponseEntity<String> updateLikes(HttpServletRequest request, HttpServletResponse response,@RequestBody String data, UriComponentsBuilder ucBuilder) 
	{
			System.out.println(data);
			JSONObject rjson = new JSONObject();
			JSONArray jarr = new JSONArray();
			String user = null;
			
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			if (auth != null && !auth.getName().equals("anonymousUser")) 
				{
					// System.out.println(auth.getName());
					user = auth.getName();
				}
			Profile p = ps.get(user);
			JSONObject jobj = new JSONObject();
			JSONParser jpar = new JSONParser();
			try
			{
				jobj = (JSONObject)jpar.parse(data);
			}
		catch(Exception e)
			{
			e.printStackTrace();
			}
			
			String blogid = jobj.get("BlogID").toString();//Content ID of blogcontent table
			System.out.println("content id"+blogid);
			
			
			BlogContent bc = bcs.get(blogid);
			System.out.println("bc.getContentID() is  "+bc.getContentID());
			
	if(bc.getLikeList()==null)
	{
			if(blogid.equals(String.valueOf(bc.getContentID()) ))
			{	
				System.out.println("Entered the if ");
				jarr.add(p.getID().toString());
				bc.setLikeList(jarr.toString());
				System.out.println(jarr.toString());
				
				bcs.update (bc);
			}
	
	}
	else 
	{
		
		JSONParser jpar1 = new JSONParser();
		try
		{
			jarr=(JSONArray)jpar.parse(bc.getLikeList());
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		if(!jarr.contains(p.getID().toString()))
		{
		System.out.println("Entered the else 's if ");
		jarr.add(p.getID().toString());
		bc.setLikeList(jarr.toString());
		System.out.println(jarr.toString());
		bcs.update (bc);
	
	  
		}
		 
	}
	

		int length = jarr.size();
		System.out.println("String array length is: " + length);
		rjson.put("status", "Updated");
		rjson.put("length", length);
		rjson.put("id", bc.getContentID());
		rjson.put("check1", "true");
		
		System.out.println("id"+bc.getContentID());
		
		System.out.println(rjson);
				

	
	return new ResponseEntity<String>(rjson.toString(), HttpStatus.CREATED);
	
	
	
	}
	
	

	@CrossOrigin
    @RequestMapping(value = "/submitComment/", method = RequestMethod.POST)
    public ResponseEntity<String> submitComment(@ModelAttribute BlogComment p,HttpServletRequest request, HttpServletResponse response, @RequestBody String data12, UriComponentsBuilder ucBuilder) 
	{
		System.out.println(data12);
		
		JSONParser jpar = new JSONParser();
        
        JSONObject jobj = new JSONObject();
        
        
        try
        {
        	jobj = (JSONObject)jpar.parse(data12);
        }
		catch(Exception e)
        {
			System.out.println("ERROR READING ADDRESSES");
        }
        String CommentContent = jobj.get("CommentValue").toString();
        String ContentID = jobj.get("CommentID").toString();
        System.out.println(CommentContent);
        System.out.println(ContentID);
        String user = "";
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    	if (auth != null && !auth.getName().equals("anonymousUser"))
	    	{    
	    		user = auth.getName();
	    	}
	    	
	    	DateFormat df = new SimpleDateFormat("dd/MM/yy HH:mm:ss");
			Date dateobj = new Date();
		
		Profile pu = ps.get(user);
		if(user!=null)
		{

			p.setContentID(ContentID);
			p.setCommentValue(CommentContent);
			p.setTimeStamp(df.format(dateobj));
			p.setOwnerID(pu.getID().toString());
			bcms.insert(p);
		}
		JSONObject res = new JSONObject();
		
		
	    	res.put("Comment", p.getCommentValue());
	    	res.put("CommentUserName",user);
	    	res.put("status", "updated");
	    	res.put("Contentid", p.getContentID());
	    	System.out.println(res.toJSONString());
	    
	    	
        return new ResponseEntity<String>(res.toJSONString(), HttpStatus.CREATED);
    }
	

	@CrossOrigin
    @RequestMapping(value = "/submitBlog/", method = RequestMethod.POST)
    public ResponseEntity<String> submitBlog(@ModelAttribute BlogContent p,HttpServletRequest request, HttpServletResponse response, @RequestBody String data12, UriComponentsBuilder ucBuilder) 
	{
		System.out.println(data12);
		
		JSONParser jpar = new JSONParser();
        
        JSONObject jobj = new JSONObject();
        
        
        try
        {
        	jobj = (JSONObject)jpar.parse(data12);
        }
		catch(Exception e)
        {
			System.out.println("ERROR READING ADDRESSES");
        }
        String user = "";
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    	if (auth != null && !auth.getName().equals("anonymousUser"))
	    	{    
	    		user = auth.getName();
	    	}
	    	
	    	DateFormat df = new SimpleDateFormat("dd/MM/yy HH:mm:ss");
			Date dateobj = new Date();
		
		Profile pu = ps.get(user);
/*		if(user!=null)
		{

			p.setContentID(ContentID);
			p.setCommentValue(CommentContent);
			p.setTimeStamp(df.format(dateobj));
			p.setOwnerID(pu.getID().toString());
			bcms.insert(p);
		}
*/		JSONObject res = new JSONObject();
		
		
	    	res.put("CommentUserName",user);
	    	res.put("status", "updated");
	    	res.put("Contentid", p.getContentID());
	    	System.out.println(res.toJSONString());

	    	return new ResponseEntity<String>(res.toJSONString(), HttpStatus.CREATED);
    }

	
	
	
	@CrossOrigin
	@RequestMapping(value = "/fetchcomment/", method = RequestMethod.POST)
	public ResponseEntity<String> fetchcomment(HttpServletRequest request, HttpServletResponse response,UriComponentsBuilder ucBuilder) {

		String user = null;
	
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth != null && !auth.getName().equals("anonymousUser")) 
		{
			user = auth.getName();
		}
		Profile pu = ps.get(user);
		List<Profile> list1 = ps.getAllUsers();
		List<BlogComment> list = bcms.getAllBlogs();
		JSONArray jarr = new JSONArray();
		for(BlogComment b:list )
		{
			JSONObject jobj = new JSONObject();
			for(Profile pk:list1)
			{
				if(pk.getID().toString().equals(b.getOwnerID()) )
				{
					jobj.put("OwnerName",pk.getUsername());
					
				}
			}
		
		jobj.put("CommentValue",b.getCommentValue());
		jobj.put("CommentTimeStamp",b.getTimeStamp());
		jobj.put("Contentid",b.getContentID());
		
		
		
		jarr.add(jobj);
		}
		System.out.println("this is fetch comment "+jarr);
		return new ResponseEntity<String>(jarr.toString(), HttpStatus.CREATED);
	}
	
	
/*
	@CrossOrigin
	@RequestMapping(value = "/addForum/", method = RequestMethod.POST)
	public ResponseEntity<String> addForum(@ModelAttribute Forum f ,HttpServletRequest request, HttpServletResponse response,@RequestBody String data,UriComponentsBuilder ucBuilder)
	{
		System.out.println("data in addForum "+ data);
		
		JSONParser jpar = new JSONParser();
		JSONObject jobj = new JSONObject();

		try
		{
			jobj = (JSONObject)jpar.parse(data);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	
		DateFormat df = new SimpleDateFormat("dd/MM/yy HH:mm:ss");
		Date dateobj = new Date();
		
		String user="";
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth != null && !auth.getName().equals("anonymousUser")) 
		{
			user = auth.getName();
		}
		Profile pu = ps.get(user);
		
		   
		String topicname = jobj.get("Topicname").toString();
		String topicdescription = jobj.get("Description").toString();
		
		System.out.println("data in topicname "+ topicname);
		System.out.println("data in topicdescription "+ topicdescription);
		if(user!=null)
		{
			f.setStatus("Pending");
			f.setDescription(topicdescription);
			f.setTopicname(topicname);
			f.setTimestamp(df.format(dateobj));
			
			fs.insert(f);
		}
	JSONObject jobj1 = new JSONObject();
	jobj1.put("status", "updated");
		
		
		
		return new ResponseEntity<String>(jobj1.toString(), HttpStatus.CREATED);
		
}	
	
	
	
	
*/		

////////////////////////////////////////////For friend List

/*
@CrossOrigin
@RequestMapping(value = "/fetchAllfriends/", method = RequestMethod.POST)
public ResponseEntity<String> fetchAllfriends(HttpServletRequest request, HttpServletResponse response, UriComponentsBuilder ucBuilder) {
	JSONArray jarr = new JSONArray();
	
	String user = null;

	Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	if (auth != null && !auth.getName().equals("anonymousUser")) 
	{
		// System.out.println(auth.getName());
		user = auth.getName();
	}

	Profile P1 = ps.get(user);
	List<Profile> list = ps.getAllUsers();
		for (Profile p : list) 
		{
		
	if (user!=null) 
			{
				JSONObject jobj = new JSONObject();
				jobj.put("ProfileImage", P1.getImage());
				
				jarr.add(jobj);
			}
	System.out.println("this is the friend rest controller araay   "+jarr);
	
		
return new ResponseEntity<String>(jarr.toString(), HttpStatus.CREATED);

	
}*/















@CrossOrigin
@RequestMapping(value = "/GetAllFriends/", method = RequestMethod.POST)
public ResponseEntity<String> GetAllFriends(HttpServletResponse response,@RequestBody String data, UriComponentsBuilder ucBuilder) {
    
	System.out.println("getAllFriends data "+ data);
		
	JSONArray jarr = new JSONArray();
	JSONParser jpar = new JSONParser();	
	JSONObject jobj = new JSONObject();
	try
	{
		jobj =(JSONObject)jpar.parse(data);
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
	
	String user = jobj.get("currentUser").toString();
	
	Profile  p1 = ps.get(user);
	
	if( p1 != null && p1.getFriendList() != null )
	{
		String friends[] = p1.getFriendList().split(",");
		List<Profile> list = ps.getAllUsers();
		for( String friend: friends )
		{
			for(Profile b:list)
			{
		/*	if(friend!=null && b!=null)
			{
			
					
			
		*/		System.out.println("friend"+friend.toString());
				System.out.println("id" + b.getID() );
		   if(friend.toString().contains(b.getID().toString()))
				{
					System.out.println(friend);
					
					JSONObject jobj1 = new JSONObject();
					
					jobj1.put("Name", b.getUsername());
					jobj1.put("Image", b.getImage().replaceAll("\\\\", ""));
					
					jarr.add(jobj1);
					
				}
		   else{
			   System.out.println("sorry no match");
			   
		   }
				
				
		/*	}
		*/	}
			
			
			/*Profile pe = ps.get(friend);
			
			if( pe != null )
			{
				JSONObject jobj1 = new JSONObject();
				
				jobj.put("Name", pe.getUsername());
				jobj.put("Image", pe.getImage().replaceAll("\\\\", ""));
				
				jarr.add(jobj);
			}*/
			
			
			
		}
		
	}
	
	JSONObject json = new JSONObject();
	
	json.put("AllMyFriends", jarr);
    System.out.println(json.toString());
	
    return new ResponseEntity<String>(json.toString(), HttpStatus.CREATED);
}


}	
	

