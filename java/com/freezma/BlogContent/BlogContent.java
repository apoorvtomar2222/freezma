package com.freezma.BlogContent;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;


@Entity
public class BlogContent 
{	
	public BlogContent()
	{
		
	}
	@Id @GeneratedValue(strategy=GenerationType.AUTO)
	private long ContentID;
	private long BlogID;
	private long TimeStamp;
	
	public long getContentID() {
		return ContentID;
	}
	public void setContentID(long contentID) {
		ContentID = contentID;
	}
	public long getBlogID() {
		return BlogID;
	}
	public void setBlogID(long blogID) {
		BlogID = blogID;
	}
	public long getTimeStamp() {
		return TimeStamp;
	}
	public void setTimeStamp(long timeStamp) {
		TimeStamp = timeStamp;
	}
	public String getValue() {
		return Value;
	}
	public void setValue(String value) {
		Value = value;
	}
	public String getLikeList() {
		return LikeList;
	}
	public void setLikeList(String likeList) {
		LikeList = likeList;
	}
	@Lob
	private String Value;
	@Lob
	private String LikeList;
	
	
	
}