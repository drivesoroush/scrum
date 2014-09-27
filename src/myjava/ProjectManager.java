package myjava;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;

public class ProjectManager {
	
	public ProjectManager() {
		String JDBC_DRIVER = "com.mysql.jdbc.Driver";
		try {
			Class.forName(JDBC_DRIVER);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	public void removeProject(int id) throws SQLException
	{
		DB db = new DB();
		Connection conn = null;
		try {
			conn = db.getConnection();
			Statement stmt = null;
			stmt = conn.createStatement();
			String sql = "delete from project where id="+id;
			stmt.executeUpdate(sql);
			
		} catch (Exception e) {
			e.printStackTrace();
		} catch (Throwable e) {
			e.printStackTrace();
		}finally{
			conn.close();
		}
	}
	
	
	public Project getProjectById(int id)
	{
		Project project = new Project();
		DB db = new DB();
		try {
			Connection conn = db.getConnection();
			Statement stmt = null;
			ResultSet rs = null;
			stmt = conn.createStatement();
			String sql = "select * from project where id="+id;
			rs = stmt.executeQuery(sql);

			while (rs.next()) {
				project.setId(rs.getInt("id"));
				project.setName(rs.getString("name"));
				project.setTime(rs.getInt("time"));
				project.setCreatorId(rs.getInt("creator_id"));
				project.setVision(rs.getString("vision"));
				project.setDescription(rs.getString("description"));
				project.setDate_created(rs.getDate("date_created"));
				GroupManager groupManager = new GroupManager();
				project.setGroup(groupManager.getGroupById(rs.getInt("group_id")));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} catch (Throwable e) {
			e.printStackTrace();
		}
		return project;
	}
	
	public int getSumValueProjectById(int id)
	{
		DB db = new DB();
		try {
			Connection conn = db.getConnection();
			Statement stmt = null;
			ResultSet rs = null;
			stmt = conn.createStatement();
			String sql =
					" select sum(pb.value) as sum from project p, product_backlog pb " +
					" where p.id = pb.project_id and p.id = " + id;
			rs = stmt.executeQuery(sql);

			while (rs.next()) {
				return rs.getInt("sum");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} catch (Throwable e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	public ArrayList<String> getRolesOfUser(int project_id,int user_id)
	{
		ArrayList<String> roles = new ArrayList<String>();
		DB db = new DB();
		try {
			Connection conn = db.getConnection();
			Statement stmt = null;
			ResultSet rs = null;
			stmt = conn.createStatement();
			String sql = "select * from role_user where user_id = " + user_id + " and project_id = " + project_id;
			rs = stmt.executeQuery(sql);

			while (rs.next()) {
				roles.add(rs.getString("type"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} catch (Throwable e) {
			e.printStackTrace();
		}
		return roles;
	}
	
	public ArrayList<Project> getAllProject() {
		ArrayList<Project> projects = new ArrayList<Project>();
		DB db = new DB();
		try {
			Connection conn = db.getConnection();
			Statement stmt = null;
			ResultSet rs = null;
			stmt = conn.createStatement();
			String sql = "select * from project";
			rs = stmt.executeQuery(sql);

			while (rs.next()) {
				Project project = new Project();
				project.setId(rs.getInt("id"));
				project.setName(rs.getString("name"));
				project.setTime(rs.getInt("time"));
				project.setCreatorId(rs.getInt("creator_id"));
				project.setVision(rs.getString("vision"));
				project.setDescription(rs.getString("description"));
				project.setDate_created(rs.getDate("date_created"));
				GroupManager groupManager = new GroupManager();
				project.setGroup(groupManager.getGroupById(rs.getInt("group_id")));
				projects.add(project);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} catch (Throwable e) {
			e.printStackTrace();
		}
		return projects;
	}
	
	public void addProject(String name,String vision,String Description, int time, int group_id) throws SQLException
	{
	    java.sql.Date sqlDate = new java.sql.Date(new Date(System.currentTimeMillis()).getTime());
		DB db = new DB();
		Connection conn = null;
		try {
			conn = db.getConnection();
			Statement stmt = null;
			stmt = conn.createStatement();
			String sql =
					" insert into project (id, name, vision, time, date_created, creator_id, description, group_id) " +
					" values (default,'"+name+"','"+vision+"',"+time+",'"+sqlDate+"',1,'"+Description+"',"+group_id+")";
			stmt.executeUpdate(sql);
			
		} catch (Exception e) {
			e.printStackTrace();
		} catch (Throwable e) {
			e.printStackTrace();
		}finally{
			conn.close();
		}
	}
	
	public boolean checkUserIn(int user_id, int project_id)
	{
		DB db = new DB();
		try {
			Connection conn = db.getConnection();
			Statement stmt = null;
			ResultSet rs = null;
			stmt = conn.createStatement();
			String sql = "select * from role_user where user_id = " + user_id + " and project_id = " + project_id;
			rs = stmt.executeQuery(sql);

			while (rs.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} catch (Throwable e) {
			e.printStackTrace();
		}
		return false;
	}
}
