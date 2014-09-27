package myjava;

import java.util.Date;

public class ProductBacklog {
	private String name;
	private int id;
	private int value;
	private String priority;
	private String description;
	private int is_deleted;
	private int is_done;
	private int is_in_sprint;
	private int is_select_for_sprint;
	private Date date_created;
	private int project_id;
	private boolean is_all_task_done = false;
	private Date date_finished;
	
	
	public void setDate_finished(Date date_finished) {
		this.date_finished = date_finished;
	}
	public Date getDate_finished() {
		return date_finished;
	}
	public void setIs_all_task_done(boolean is_all_task_done) {
		this.is_all_task_done = is_all_task_done;
	}
	public boolean getIs_all_task_done() {
		return this.is_all_task_done;
	}
	public void setProject_id(int project_id) {
		this.project_id = project_id;
	}
	public int getProject_id() {
		return project_id;
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
	public void setValue(int value) {
		this.value = value;
	}
	public int getValue() {
		return value;
	}
	public void setPriority(String priority) {
		this.priority = priority;
	}
	public String getPriority() {
		return priority;
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
	public int getIs_deleted() {
		return is_deleted;
	}
	public void setIs_deleted(int is_deleted) {
		this.is_deleted = is_deleted;
	}
	public void setIs_done(int is_done) {
		this.is_done = is_done;
	}
	public int getIs_done() {
		return is_done;
	}
	public void setIs_in_sprint(int is_in_sprint) {
		this.is_in_sprint = is_in_sprint;
	}
	public int getIs_in_sprint() {
		return is_in_sprint;
	}
	public void setIs_select_for_sprint(int is_select_for_sprint) {
		this.is_select_for_sprint = is_select_for_sprint;
	}
	public int getIs_select_for_sprint() {
		return is_select_for_sprint;
	}
}
