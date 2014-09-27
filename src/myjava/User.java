package myjava;

import java.util.ArrayList;
import java.util.Date;

public class User {
	String name;
	String fname;
	int id;
	Date date_created;
	String Email;
	ArrayList<String> roles;
	
	public User() {
	}
	
	public void setRoles(ArrayList<String> roles) {
		this.roles = roles;
	}
	
	public ArrayList<String> getRoles() {
		return roles;
	}
	
	public void setEmail(String email) {
		Email = email;
	}
	
	public String getEmail() {
		return Email;
	}
	
	public void setDate_created(Date date_created) {
		this.date_created = date_created;
	}
	
	public Date getDate_created() {
		return date_created;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public String getName() {
		return name;
	}
	
	public void setFname(String fname) {
		this.fname = fname;
	}
	
	public String getFname() {
		return fname;
	}
	
	public void setId(int id) {
		this.id = id;
	}
	
	public int getId() {
		return id;
	}
}
