package com.freezma.ProfileModel;

import java.io.Serializable;

import javax.persistence.Embeddable;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotEmpty;


@Entity
@Embeddable
public class Profile implements Serializable
{
	private static final long serialVersionUID = 1L;

	
	@Id @GeneratedValue(strategy=GenerationType.SEQUENCE)
	private Long ID;
	
	private String Gender;
	
	private String Email;
	
	private String Username;
	
	private String Password;
	
	@Transient
	private String CPassword;
	
	private String Phone;
	
	private String Image;
	@Lob
	private String FriendList;
	@Lob
	private String RequestSent;
	
	public String getRequestSent() {
		return RequestSent;
	}

	public void setRequestSent(String requestSent) {
		RequestSent = requestSent;
	}


	@Lob
	private String PendingFriendList;
	@Lob
	private String Blogs;
	@Lob
	private String Forums;
	@Lob
	private String ChatHistory;
	@Lob
	private String Notifications;
	@Lob
	private String Gallery;
	
	private boolean LoginStatus;
	private String BasicInfo;

	
	
	public String getFriendList() {
		return FriendList;
	}

	public void setFriendList(String friendList) {
		FriendList = friendList;
	}

	public String getPendingFriendList() {
		return PendingFriendList;
	}

	public void setPendingFriendList(String pendingFriendList) {
		PendingFriendList = pendingFriendList;
	}

	public String getBlogs() {
		return Blogs;
	}

	public void setBlogs(String blogs) {
		Blogs = blogs;
	}

	public String getForums() {
		return Forums;
	}

	public void setForums(String forums) {
		Forums = forums;
	}

	public String getChatHistory() {
		return ChatHistory;
	}

	public void setChatHistory(String chatHistory) {
		ChatHistory = chatHistory;
	}

	public String getNotifications() {
		return Notifications;
	}

	public void setNotifications(String notifications) {
		Notifications = notifications;
	}

	public String getGallery() {
		return Gallery;
	}

	public void setGallery(String gallery) {
		Gallery = gallery;
	}

	public boolean isLoginStatus() {
		return LoginStatus;
	}

	public void setLoginStatus(boolean loginStatus) {
		LoginStatus = loginStatus;
	}

	public String getBasicInfo() {
		return BasicInfo;
	}

	public void setBasicInfo(String basicInfo) {
		BasicInfo = basicInfo;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}


	public String getImage() {
		return Image;
	}

	public void setImage(String image) {
		Image = image;
	}


	private String Address;
	private int Role = 1;
	private boolean Active = true;

	public int getRole() {
		return Role;
	}

	public void setRole(int role) {
		Role = role;
	}

	public boolean isActive() {
		return Active;
	}

	public void setActive(boolean active) {
		Active = active;
	}

	public Profile()
	{
		
	}

	public Long getID() {
		return ID;
	}


	public void setID(Long iD) {
		ID = iD;
	}


	@NotEmpty(message="Email field is mandatory.")
	public String getEmail() 
	{
		return Email;
	}
	
	public void setEmail(String email) {
		Email = email;
	}

	@NotEmpty(message="Username field is mandatory.")
	public String getUsername() 
	{
		return Username;
	}


	public void setUsername(String username) {
		Username = username;
	}

	@NotEmpty(message="Password field is mandatory.")
	@Size(min = 6, max = 15, message = "Your password must between 6 and 15 characters")
	public String getPassword() {
		return Password;
	}


	public void setPassword(String password) {
		Password = password;
	}

	@NotEmpty(message="Password field is mandatory.")
	@Size(min = 6, max = 15, message = "Your password must between 6 and 15 characters")
	public String getCPassword() 
	{
		return CPassword;
	}


	public void setCPassword(String cPassword) {
		CPassword = cPassword;
	}

	@Length(max=10,min=10,message="Phone number is not valid. Should be of length 10.")
    @NotEmpty(message="Phone field is mandatory.")
	public String getPhone() {
		return Phone;
	}
	
	
	public void setPhone(String phone) {
		Phone = phone;
	}

	public String getGender() {
		return Gender;
	}

	public void setGender(String gender) {
		Gender = gender;
	}

	@NotEmpty(message="Address field is mandatory.")
	public String getAddress() {
		return Address;
	}


	public void setAddress(String address) {
		Address = address;
	}

	@Override
	public String toString() {
		return "User [ID=" + ID + ", Email=" + Email + ", Username=" + Username + ", Password=" + Password
				+ ", CPassword=" + CPassword + ", Phone=" + Phone + "]";
	}

}
	
	
