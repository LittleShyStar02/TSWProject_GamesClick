package it.project.bean;

import java.util.Date;

public class UserBean 
{
	
	private String name;
	private String surname;
	private String email;
	private String password;
	private Date borndate;
	private String address;
	private boolean admin;
	
	public String getAddress()
	{
		return address;
	}
	
	public Date getBornDate()
	{
		return borndate;
	}
	
	public String getEmail()
	{
		return email;
	}
	
	public String getName()
	{
		return name;
	}
	
	public String getPassword()
	{
		return password;
	}
	
	public String getSurname()
	{
		return surname;
	}
	
	public boolean isAdmin()
	{
		return admin;
	}
	
	public void setAdmin(boolean admin)
	{
		this.admin = admin;
	}
	
	public void setAddress(String address)
	{
		this.address = address;
	}
	
	public void setBornDate(Date date)
	{
		this.borndate = date;
	}
	
	public void setEmail(String email)
	{
		this.email = email;
	}
	
	public void setName(String name)
	{
		this.name = name;
	}
	
	public void setPassword(String password)
	{
		this.password = password;
	}
	
	public void setSurname(String surname)
	{
		this.surname = surname;
	}

}
