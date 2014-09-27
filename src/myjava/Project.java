package myjava;

import java.sql.Date;

public class Project {
	private String name;
	private int creator_id;
	private String vision;
	private String description;
	private Date date_created;
	private int id;
	private int time;
	Group group;
	
	public void setName(String name) {
		this.name = name;
	}
	
	public String getName() {
		return name;
	}
	
	public void setGroup(Group group) {
		this.group = group;
	}
	
	public Group getGroup() {
		return group;
	}
	
	public void setCreatorId(int creator_id) {
		this.creator_id = creator_id;
	}
	
	public int getCreatorId() {
		return creator_id;
	}
	
	public void setVision(String vision) {
		this.vision = vision;
	}
	
	public String getVision() {
		return vision;
	}
	
	public void setDate_created(Date date_created) {
		this.date_created = date_created;
	}
	
	public Date getDate_created() {
		return date_created;
	}
	
	public void setDescription(String description) {
		this.description = description;
	}
	
	public String getDescription() {
		return description;
	}
	
	public void setId(int id) {
		this.id = id;
	}
	
	public int getId() {
		return id;
	}
	
	public void setTime(int time) {
		this.time = time;
	}
	
	public int getTime() {
		return time;
	}
}
