package it.project.bean;

import java.util.Date;

public class GameBean 
{
	
	private String name;
	private String description;
	private double price;
	private Date releaseDate;
	private int minAge;
	private String preview;
	private int admin_key;
	
	public void setAdminKey(int key)
	{
		this.admin_key = key;
	}
	
	public void setReleaseDate(Date date)
	{
		this.releaseDate = date;
	}
	
	public void setDescription(String description)
	{
		this.description = description;
	}
	
	public void setMinAge(int age)
	{
		this.minAge = age;
	}
	
	public void setName(String name)
	{
		this.name = name;
	}
	
	public void setPreview(String url)
	{
		this.preview = url;
	}
	
	public void setPrice(double price)
	{
		this.price = price;
	}
	
	public int getAdminKey()
	{
		return admin_key;
	}
	
	public Date getReleaseDate()
	{
		return releaseDate;
	}
	
	public String getDescription()
	{
		return this.description;
	}
	
	public int getMinAge()
	{
		return minAge;
	}
	
	public String getName()
	{
		return name;
	}
	
	public String getPreview()
	{
		return preview;
	}
	
	public double getPrice()
	{
		return price;
	}

}
