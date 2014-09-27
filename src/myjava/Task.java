package myjava;

import java.util.Date;

public class Task {
	private int id;
	private User user;
	private ProductBacklog product_backlog;
	private int is_done;
	private Date date_created;
	private String description;
	private String name;
	
	public Task() {
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getId() {
		return id;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public User getUser() {
		return user;
	}
	public void setProduct_backlog_id(ProductBacklog product_backlog) {
		this.product_backlog = product_backlog;
	}
	public ProductBacklog getProduct_backlog() {
		return product_backlog;
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
	public void setDescription(String description) {
		this.description = description;
	}
	public String getDescription() {
		return description;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getName() {
		return name;
	}
}
