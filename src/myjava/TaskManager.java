package myjava;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;

public class TaskManager {
	public TaskManager() {
		String JDBC_DRIVER = "com.mysql.jdbc.Driver";
		try {
			Class.forName(JDBC_DRIVER);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<Task> getTasksOfProductBacklog(int product_backlog_id)
	{
		ArrayList<Task> tasks = new ArrayList<Task>();
		UserManager userManager = new UserManager();
		ProductBacklogManager productBacklogManager = new ProductBacklogManager();
		DB db = new DB();
		try {
			Connection conn = db.getConnection();
			Statement stmt = null;
			ResultSet rs = null;
			stmt = conn.createStatement();
			String sql = "SELECT * FROM task where product_backlog_id="+product_backlog_id;
			rs = stmt.executeQuery(sql);

			while (rs.next()) {
				Task task = new Task();
				task.setDate_created(rs.getDate("date_created"));
				task.setDescription(rs.getString("description"));
				task.setId(rs.getInt("id"));
				task.setIs_done(rs.getInt("is_done"));
				task.setName(rs.getString("name"));
				task.setProduct_backlog_id(productBacklogManager.getProductBacklogById(rs.getInt("product_backlog_id")));
				task.setUser(userManager.getUserById(rs.getInt("user_id")));
				tasks.add(task);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} catch (Throwable e) {
			e.printStackTrace();
		}
		return tasks;
	}
	
	public void addTask(String name,String description,int user_id, int product_backlog_id) throws SQLException
	{
	    java.sql.Date sqlDate = new java.sql.Date(new Date(System.currentTimeMillis()).getTime());
		DB db = new DB();
		Connection conn = null;
		try {
			conn = db.getConnection();
			Statement stmt = null;
			stmt = conn.createStatement();
			
			String sql = "insert into task (id,name,description,date_created,user_id,product_backlog_id,is_done) "
					+ "values(Default,'"+name+"','"+description+"','"+sqlDate+"',"+user_id+","+product_backlog_id+",0)";
			stmt.executeUpdate(sql);
			
		} catch (Exception e) {
			e.printStackTrace();
		} catch (Throwable e) {
			e.printStackTrace();
		}finally{
			conn.close();
		}
	}
	
	public void setTaskDone(int task_id) throws SQLException
	{
		DB db = new DB();
		Connection conn = null;
		try {
			conn = db.getConnection();
			Statement stmt = null;
			stmt = conn.createStatement();
			
			String sql = "update task set is_done=1 where id="+task_id;
			stmt.executeUpdate(sql);
			
		} catch (Exception e) {
			e.printStackTrace();
		} catch (Throwable e) {
			e.printStackTrace();
		}finally{
			conn.close();
		}
	}
	
	public void removeTask(int task_id) throws SQLException
	{
		DB db = new DB();
		Connection conn = null;
		try {
			conn = db.getConnection();
			Statement stmt = null;
			stmt = conn.createStatement();
			
			String sql = "delete from task where id="+task_id;
			stmt.executeUpdate(sql);
			
		} catch (Exception e) {
			e.printStackTrace();
		} catch (Throwable e) {
			e.printStackTrace();
		}finally{
			conn.close();
		}
	}
}
