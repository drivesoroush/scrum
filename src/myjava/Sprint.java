package myjava;

import java.util.Date;

public class Sprint {
	private int id;
	private int is_current;
	private int is_done;
	private Date date_created;
	private Date date_started;
	private int started;
	private int row_num;
	private int project_id;
	
	public Sprint() {
	}
	
	
	public void setProject_id(int project_id) {
		this.project_id = project_id;
	}
	public int getProject_id() {
		return project_id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getId() {
		return id;
	}
	public void setIs_current(int is_current) {
		this.is_current = is_current;
	}
	public int getIs_current() {
		return is_current;
	}
	public void setIs_done(int is_done) {
		this.is_done = is_done;
	}
	public int getIs_done() {
		return is_done;
	}
	public void setDate_created(Date date_created) {
		this.date_created = date_created;
	}
	public Date getDate_created() {
		return date_created;
	}
	public void setDate_started(Date date_started) {
		this.date_started = date_started;
	}
	public Date getDate_started() {
		return date_started;
	}
	public void setStarted(int started) {
		this.started = started;
	}
	public int getStarted() {
		return started;
	}
	public void setRow_num(int row_num) {
		this.row_num = row_num;
	}
	public int getRow_num() {
		return row_num;
	}
}
