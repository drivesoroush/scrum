package myjava;

import java.util.ArrayList;
import java.util.Date;

public class Group {
	private int id;
	private String name;
	private String Description;
	private Date date_created;
	ArrayList<User> users = null;
	
	public Group() {
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public String getName() {
		return name;
	}
	
	public void setId(int id) {
		this.id = id;
	}
	
	public int getId() {
		return id;
	}
	
	public void setDate_created(Date date_created) {
		this.date_created = date_created;
	}
	
	public Date getDate_created() {
		return date_created;
	}
	public void setDescription(String description) {
		Description = description;
	}
	
	public String getDescription() {
		return Description;
	}
	
	public void setUsers(ArrayList<User> users) {
		this.users = users;
	}
	
	public ArrayList<User> getUsers() {
		return users;
	}
	
	
}
