package myjava;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;

public class ProductBacklogManager {
	public ProductBacklogManager() {
		String JDBC_DRIVER = "com.mysql.jdbc.Driver";
		try {
			Class.forName(JDBC_DRIVER);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	public ProductBacklog getProductBacklogById(int id,int project_id)
	{
		ProductBacklog productBacklog= new ProductBacklog();
		DB db = new DB();
		try {
			Connection conn = db.getConnection();
			Statement stmt = null;
			ResultSet rs = null;
			stmt = conn.createStatement();
			String sql = "select * from product_backlog where id = " + id + " and project_id = " + project_id;
			rs = stmt.executeQuery(sql);

			while (rs.next()) {
				productBacklog.setId(rs.getInt("id"));
				productBacklog.setName(rs.getString("name"));
				productBacklog.setDescription(rs.getString("description"));
				productBacklog.setDate_created(rs.getDate("date_created"));
				productBacklog.setIs_deleted(rs.getInt("is_deleted"));
				productBacklog.setIs_done(rs.getInt("is_done"));
				productBacklog.setIs_in_sprint(rs.getInt("is_in_sprint"));
				productBacklog.setIs_select_for_sprint(rs.getInt("is_select_for_sprint"));
				productBacklog.setPriority(rs.getString("priority"));
				productBacklog.setValue(rs.getInt("value"));
				productBacklog.setProject_id(rs.getInt("project_id"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} catch (Throwable e) {
			e.printStackTrace();
		}
		return productBacklog;
	}
	
	public ProductBacklog getProductBacklogById(int id)
	{
		ProductBacklog productBacklog= new ProductBacklog();
		DB db = new DB();
		try {
			Connection conn = db.getConnection();
			Statement stmt = null;
			ResultSet rs = null;
			stmt = conn.createStatement();
			String sql = "select * from product_backlog where id = " + id;
			rs = stmt.executeQuery(sql);

			while (rs.next()) {
				productBacklog.setId(rs.getInt("id"));
				productBacklog.setName(rs.getString("name"));
				productBacklog.setDescription(rs.getString("description"));
				productBacklog.setDate_created(rs.getDate("date_created"));
				productBacklog.setIs_deleted(rs.getInt("is_deleted"));
				productBacklog.setIs_done(rs.getInt("is_done"));
				productBacklog.setIs_in_sprint(rs.getInt("is_in_sprint"));
				productBacklog.setIs_select_for_sprint(rs.getInt("is_select_for_sprint"));
				productBacklog.setPriority(rs.getString("priority"));
				productBacklog.setValue(rs.getInt("value"));
				productBacklog.setProject_id(rs.getInt("project_id"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} catch (Throwable e) {
			e.printStackTrace();
		}
		return productBacklog;
	}
	
	public ArrayList<ProductBacklog> getAllProductBacklog(int project_id) {
		ArrayList<ProductBacklog> productBacklogs = new ArrayList<ProductBacklog>();
		DB db = new DB();
		try {
			Connection conn = db.getConnection();
			Statement stmt = null;
			ResultSet rs = null;
			stmt = conn.createStatement();
			String sql =
					" select * from product_backlog " +
					" where is_done = -1 and is_in_sprint = -1 and is_select_for_sprint = -1 " +
					" and is_deleted = -1 and project_id = " + project_id;
			rs = stmt.executeQuery(sql);

			while (rs.next()) {
				ProductBacklog productBacklog= new ProductBacklog();
				productBacklog.setId(rs.getInt("id"));
				productBacklog.setName(rs.getString("name"));
				productBacklog.setDescription(rs.getString("description"));
				productBacklog.setDate_created(rs.getDate("date_created"));
				productBacklog.setIs_deleted(rs.getInt("is_deleted"));
				productBacklog.setIs_done(rs.getInt("is_done"));
				productBacklog.setIs_in_sprint(rs.getInt("is_in_sprint"));
				productBacklog.setIs_select_for_sprint(rs.getInt("is_select_for_sprint"));
				productBacklog.setPriority(rs.getString("priority"));
				productBacklog.setValue(rs.getInt("value"));
				productBacklog.setProject_id(rs.getInt("project_id"));
				productBacklogs.add(productBacklog);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} catch (Throwable e) {
			e.printStackTrace();
		}
		return productBacklogs;
	}
	
	public ArrayList<ProductBacklog> getAllProductBacklogNotComplete(int project_id) {
		ArrayList<ProductBacklog> productBacklogs = new ArrayList<ProductBacklog>();
		DB db = new DB();
		try {
			Connection conn = db.getConnection();
			Statement stmt = null;
			ResultSet rs = null;
			stmt = conn.createStatement();
			String sql =
					" select * from product_backlog " +
					" where is_done = -1 and is_deleted = 1 and project_id = " + project_id;
			rs = stmt.executeQuery(sql);

			while (rs.next()) {
				ProductBacklog productBacklog= new ProductBacklog();
				productBacklog.setId(rs.getInt("id"));
				productBacklog.setName(rs.getString("name"));
				productBacklog.setDescription(rs.getString("description"));
				productBacklog.setDate_created(rs.getDate("date_created"));
				productBacklog.setIs_deleted(rs.getInt("is_deleted"));
				productBacklog.setIs_done(rs.getInt("is_done"));
				productBacklog.setIs_in_sprint(rs.getInt("is_in_sprint"));
				productBacklog.setIs_select_for_sprint(rs.getInt("is_select_for_sprint"));
				productBacklog.setPriority(rs.getString("priority"));
				productBacklog.setValue(rs.getInt("value"));
				productBacklog.setProject_id(rs.getInt("project_id"));
				productBacklogs.add(productBacklog);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} catch (Throwable e) {
			e.printStackTrace();
		}
		return productBacklogs;
	}

	
	public Chart getAllProductBacklogComplete(int project_id) {
		ArrayList<Date> dates = new ArrayList<Date>();
		ArrayList<Integer> values = new ArrayList<Integer>(); 
		Chart chart = new Chart();
		DB db = new DB();
		try {
			Connection conn = db.getConnection();
			Statement stmt = null;
			ResultSet rs = null;
			stmt = conn.createStatement();
			String sql =
					" select sum(value) as value,date_finished  from product_backlog " +
					" where is_done = 1 and project_id = " + project_id + 
					" group by date_finished order by date_finished asc ";
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				dates.add(rs.getDate("date_finished"));
				values.add(rs.getInt("value"));
			}
			chart.setDates(dates);
			chart.setValues(values);
		} catch (Exception e) {
			e.printStackTrace();
		} catch (Throwable e) {
			e.printStackTrace();
		}
		return chart;
	}
	
	public ArrayList<ProductBacklog> getAllProductBacklogInCurrentSprint(int project_id) {
		ArrayList<ProductBacklog> productBacklogs = new ArrayList<ProductBacklog>();
		DB db = new DB();
		try {
			Connection conn = db.getConnection();
			Statement stmt = null;
			ResultSet rs = null;
			stmt = conn.createStatement();
			String sql =
					" select * from product_backlog, sprint_product_backlog, sprint " +
					" where product_backlog.id = sprint_product_backlog.product_backlog_id and " +
					" sprint.id = sprint_product_backlog.sprint_id and sprint.is_current = 1 and " +
					" sprint.project_id = sprint_product_backlog.project_id and " +
					" sprint_product_backlog.project_id = product_backlog.project_id " +
					" and product_backlog.project_id = " + project_id;
			rs = stmt.executeQuery(sql);

			while (rs.next()) {
				ProductBacklog productBacklog= new ProductBacklog();
				productBacklog.setId(rs.getInt("id"));
				productBacklog.setName(rs.getString("name"));
				productBacklog.setDescription(rs.getString("description"));
				productBacklog.setDate_created(rs.getDate("date_created"));
				productBacklog.setIs_deleted(rs.getInt("is_deleted"));
				productBacklog.setIs_done(rs.getInt("is_done"));
				productBacklog.setIs_in_sprint(rs.getInt("is_in_sprint"));
				productBacklog.setIs_select_for_sprint(rs.getInt("is_select_for_sprint"));
				productBacklog.setPriority(rs.getString("priority"));
				productBacklog.setValue(rs.getInt("value"));
				productBacklog.setProject_id(rs.getInt("project_id"));
				productBacklog.setIs_all_task_done(true);
				productBacklogs.add(productBacklog);
			}
			for (int i = 0; i < productBacklogs.size(); i++) {
				sql = "select * from task where is_done = 0 and product_backlog_id = " + productBacklogs.get(i).getId();
				rs = stmt.executeQuery(sql);
				while (rs.next()) {
					productBacklogs.get(i).setIs_all_task_done(false);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} catch (Throwable e) {
			e.printStackTrace();
		}
		return productBacklogs;
	}
	
	public Sprint checkCurrentSprint(int project_id) throws SQLException {
		Sprint sprint = new Sprint();
	    java.sql.Date sqlDate = new java.sql.Date(new Date(System.currentTimeMillis()).getTime());
		boolean sprint_current_exist = false;
		DB db = new DB();
		Connection conn = null;
		try {
			conn = db.getConnection();
			Statement stmt = null;
			stmt = conn.createStatement();
			ResultSet rs = null;
			String sql = "select * from sprint where is_current = 1 and project_id = " + project_id;
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				sprint_current_exist = true;
			}
			
			if(!sprint_current_exist){
				sql = 
						" insert into sprint (id, is_current, is_done, date_created, date_started, started, project_id) " +
						" values (default, 1, 0, '" + sqlDate + "', '" + sqlDate + "', 0, " + project_id + ") ";
				stmt.executeUpdate(sql);
			}
			
			sql = "select * from sprint where is_current = 1 and project_id = " + project_id;
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				sprint.setId(rs.getInt("id"));
				sprint.setDate_created(rs.getDate("date_created"));
				sprint.setDate_started(rs.getDate("date_started"));
				sprint.setIs_current(rs.getInt("is_current"));
				sprint.setIs_done(rs.getInt("is_done"));
				sprint.setStarted(rs.getInt("started"));
				sprint.setProject_id(rs.getInt("project_id"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} catch (Throwable e) {
			e.printStackTrace();
		} finally {
			conn.close();
		}
		return sprint;
	}
	
	public ArrayList<Sprint> getAllSprint(int project_id) throws SQLException {
		ArrayList<Sprint> sprints = new ArrayList<Sprint>();
		
		DB db = new DB();
		Connection conn = null;
		try {
			conn = db.getConnection();
			Statement stmt = null;
			stmt = conn.createStatement();
			ResultSet rs = null;
			String sql = "select * from sprint where is_current = 0 and project_id = " + project_id;
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				Sprint sprint = new Sprint();
				sprint.setId(rs.getInt("id"));
				sprint.setDate_created(rs.getDate("date_created"));
				sprint.setDate_started(rs.getDate("date_started"));
				sprint.setIs_current(rs.getInt("is_current"));
				sprint.setIs_done(rs.getInt("is_done"));
				sprint.setStarted(rs.getInt("started"));
				sprint.setProject_id(rs.getInt("project_id"));
				sprints.add(sprint);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} catch (Throwable e) {
			e.printStackTrace();
		} finally {
			conn.close();
		}
		return sprints;
	}
	
	public boolean removeProductBacklog(int id, int project_id) throws SQLException {
		DB db = new DB();
		Connection conn = null;
		try {
			conn = db.getConnection();
			Statement stmt = null;
			stmt = conn.createStatement();
			
			String sql = "delete from product_backlog where id = " + id + " and project_id = " + project_id;
			stmt.executeUpdate(sql);
			
		} catch (Exception e) {
			e.printStackTrace();
		} catch (Throwable e) {
			e.printStackTrace();
		} finally {
			conn.close();
		}
		return true;
	}
	
	public boolean checkProductBcklogInCurrentSprint(int product_backlog_id) throws SQLException {
		DB db = new DB();
		Connection conn = null;
		try {
			conn = db.getConnection();
			Statement stmt = null;
			stmt = conn.createStatement();
			ResultSet rs = null;
			String sql =
					" select * from product_backlog, sprint where " +
					" (product_backlog.is_in_sprint = -1 or product_backlog.is_select_for_sprint = -1 " +
					" or (product_backlog.is_select_for_sprint = sprint.id and sprint.is_current = 1) ) " +
					" and product_backlog.id = " + product_backlog_id;
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				return true;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} catch (Throwable e) {
			e.printStackTrace();
		} finally {
			conn.close();
		}
		return false;
	}
	
	public void addProductBacklog(String name,String description,String priority,int value, int project_id) throws SQLException {
	    java.sql.Date sqlDate = new java.sql.Date(new Date(System.currentTimeMillis()).getTime());
		DB db = new DB();
		Connection conn = null;
		try {
			conn = db.getConnection();
			Statement stmt = null;
			stmt = conn.createStatement();
			String sql =
					" insert into product_backlog (id, name, description, date_created, value, priority, is_deleted, is_done, is_in_sprint, is_select_for_sprint, project_id) " +
					" values (default, '" + name + "', '" + description + "', '" + sqlDate + "', " + value + ", '" + priority + "', -1, -1, -1, -1, " + project_id + ") ";
			stmt.executeUpdate(sql);
		} catch (Exception e) {
			e.printStackTrace();
		} catch (Throwable e) {
			e.printStackTrace();
		} finally {
			conn.close();
		}
	}
	
	public void addProductBacklogToSprint(int product_backlog_id, int project_id) throws SQLException {
		int sprint_id = -1;
		DB db = new DB();
		Connection conn = null;
		try {
			conn = db.getConnection();
			Statement stmt = null;
			stmt = conn.createStatement();
			ResultSet rs = null;
			String sql = " select id from sprint where is_current = 1 and project_id = " + project_id;
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				sprint_id = rs.getInt("id");
			}
			
			sql =	" insert into sprint_product_backlog (id, sprint_id, product_backlog_id, project_id) " +
					" values (default, " + sprint_id + ", " + product_backlog_id + ", " + project_id + ") ";
			stmt.executeUpdate(sql);
			
			sql =	" update product_backlog set is_select_for_sprint = " + sprint_id + 
					" where id = " + product_backlog_id + " and project_id = " + project_id;
			stmt.executeUpdate(sql);
		} catch (Exception e) {
			e.printStackTrace();
		} catch (Throwable e) {
			e.printStackTrace();
		} finally {
			conn.close();
		}
	}
	
	public void removeProductBacklogFromSprint(int product_backlog_id, int project_id) throws SQLException
	{
		int sprint_id = -1;
		DB db = new DB();
		Connection conn = null;
		try {
			conn = db.getConnection();
			Statement stmt = null;
			stmt = conn.createStatement();
			ResultSet rs = null;
			String sql = "select id from sprint where is_current = 1 and project_id = " + project_id;
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				sprint_id =rs.getInt("id");
			}
			
			sql =	" delete from sprint_product_backlog " +
					" where sprint_id = " + sprint_id + 
					" and product_backlog_id = " + product_backlog_id + " and project_id = " + project_id;
			stmt.executeUpdate(sql);
			
			sql =	" update product_backlog set is_select_for_sprint = -1 " +
					" where id = " + product_backlog_id + " and project_id = " + project_id;
			stmt.executeUpdate(sql);
			
		} catch (Exception e) {
			e.printStackTrace();
		} catch (Throwable e) {
			e.printStackTrace();
		} finally {
			conn.close();
		}
	}
	
	public void startSprint(int project_id) throws SQLException
	{
	    java.sql.Date sqlDate = new java.sql.Date(new Date(System.currentTimeMillis()).getTime());
		int sprint_id = -1;
		DB db = new DB();
		Connection conn = null;
		try {
			conn = db.getConnection();
			Statement stmt = null;
			stmt = conn.createStatement();
			ResultSet rs = null;
			String sql =
					" select id from sprint " +
					" where is_current = 1 and project_id = " + project_id;
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				sprint_id =rs.getInt("id");
			}
			
			sql =	" update sprint set date_started = '" + sqlDate + "' " +
					" where id = " + sprint_id + " and project_id = " + project_id;
			stmt.executeUpdate(sql);
			
			sql = 	" update sprint set started=1 " +
					" where id = " + sprint_id + " and project_id = " + project_id;
			stmt.executeUpdate(sql);
			
			sql =	" update product_backlog set is_in_sprint = " + sprint_id + 
					" where is_select_for_sprint = " + sprint_id + " and project_id = " + project_id;
			stmt.executeUpdate(sql);
			
		} catch (Exception e) {
			e.printStackTrace();
		} catch (Throwable e) {
			e.printStackTrace();
		} finally {
			conn.close();
		}
	}
	
	public void finishSprint(int project_id) throws SQLException
	{
		int sprint_id = -1;
		DB db = new DB();
		Connection conn = null;
		try {
			conn = db.getConnection();
			Statement stmt = null;
			stmt = conn.createStatement();
			ResultSet rs = null;
			String sql = "select id from sprint where is_current=1 and project_id = " + project_id;
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				sprint_id =rs.getInt("id");
			}
			
			sql =	" update sprint set is_done = 1 " +
					" where id = " + sprint_id + " and project_id = " + project_id;
			stmt.executeUpdate(sql);
			
			sql =	" update sprint set is_current=0 " +
					" where id = " + sprint_id + " and project_id = " + project_id;
			stmt.executeUpdate(sql);
			
			sql =	" update product_backlog set is_deleted = 1 " +
					" where is_done = -1 and is_select_for_sprint = " + sprint_id + " and project_id = " + project_id;
			stmt.executeUpdate(sql);
			
		} catch (Exception e) {
			e.printStackTrace();
		} catch (Throwable e) {
			e.printStackTrace();
		} finally {
			conn.close();
		}
	}
	
	public ArrayList<ProductBacklog> getAllProductBacklogInSprint(int sprint_id,int project_id)
	{
		ArrayList<ProductBacklog> productBacklogs = new ArrayList<ProductBacklog>();
		DB db = new DB();
		try {
			Connection conn = db.getConnection();
			Statement stmt = null;
			ResultSet rs = null;
			stmt = conn.createStatement();
			String sql =
					" select * from product_backlog, sprint_product_backlog, sprint " +
					" where product_backlog.id = sprint_product_backlog.product_backlog_id and " +
					" sprint.id = sprint_product_backlog.sprint_id and sprint.id = " + sprint_id +" and " +
					" sprint.project_id=sprint_product_backlog.project_id and " +
					" sprint_product_backlog.project_id = product_backlog.project_id and " +
					" product_backlog.project_id = " + project_id;
			rs = stmt.executeQuery(sql);

			while (rs.next()) {
				ProductBacklog productBacklog= new ProductBacklog();
				productBacklog.setId(rs.getInt("id"));
				productBacklog.setName(rs.getString("name"));
				productBacklog.setDescription(rs.getString("description"));
				productBacklog.setDate_created(rs.getDate("date_created"));
				productBacklog.setIs_deleted(rs.getInt("is_deleted"));
				productBacklog.setIs_done(rs.getInt("is_done"));
				productBacklog.setIs_in_sprint(rs.getInt("is_in_sprint"));
				productBacklog.setIs_select_for_sprint(rs.getInt("is_select_for_sprint"));
				productBacklog.setPriority(rs.getString("priority"));
				productBacklog.setValue(rs.getInt("value"));
				productBacklog.setProject_id(rs.getInt("project_id"));
				productBacklogs.add(productBacklog);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} catch (Throwable e) {
			e.printStackTrace();
		}
		return productBacklogs;
	}
	
	public Sprint getSprintById(int id, int project_id) throws SQLException
	{
		Sprint sprint = new Sprint();
		DB db = new DB();
		Connection conn = null;
		try {
			conn = db.getConnection();
			Statement stmt = null;
			stmt = conn.createStatement();
			ResultSet rs = null;
			String sql = "select * from sprint where id = " + id + " and project_id  = " + project_id;
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				sprint.setId(rs.getInt("id"));
				sprint.setDate_created(rs.getDate("date_created"));
				sprint.setDate_started(rs.getDate("date_started"));
				sprint.setIs_current(rs.getInt("is_current"));
				sprint.setIs_done(rs.getInt("is_done"));
				sprint.setStarted(rs.getInt("started"));
				sprint.setProject_id(rs.getInt("project_id"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} catch (Throwable e) {
			e.printStackTrace();
		} finally {
			conn.close();
		}
		return sprint;
	}
	
	public void setDoneProductBacklog(int product_backlog_id) throws SQLException
	{
	    java.sql.Date sqlDate = new java.sql.Date(new Date(System.currentTimeMillis()).getTime());
		DB db = new DB();
		Connection conn = null;
		try {
			conn = db.getConnection();
			Statement stmt = null;
			stmt = conn.createStatement();
			String sql =
					" update product_backlog set is_done = 1, date_finished = '" + sqlDate + "' " +
					" where id = " + product_backlog_id;
			stmt.executeUpdate(sql);
			
		} catch (Exception e) {
			e.printStackTrace();
		} catch (Throwable e) {
			e.printStackTrace();
		} finally {
			conn.close();
		}
	}
}
