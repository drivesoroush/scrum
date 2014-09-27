package myjava;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;

public class GroupManager {
	public GroupManager () {
		String JDBC_DRIVER = "com.mysql.jdbc.Driver";
		try {
			Class.forName(JDBC_DRIVER);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	
	public Group getGroupById (int id) {
		Group group= new Group();
		DB db = new DB();
		try {
			Connection conn = db.getConnection();
			Statement stmt = null;
			ResultSet rs = null;
			stmt = conn.createStatement();
			String sql = "select * from `group` where id = " + id;
			rs = stmt.executeQuery(sql);

			while (rs.next()) {
				group.setId(rs.getInt("id"));
				group.setName(rs.getString("name"));
				group.setDescription(rs.getString("description"));
				group.setDate_created(rs.getDate("date_created"));
			}
			
			sql = "select * from user_group,user where user.id = user_group.user_id and group_id = " + id;
			rs = stmt.executeQuery(sql);

			ArrayList<User> user_in_group = new ArrayList<User>();
			while (rs.next()) {
				User user= new User();
				user.setId(rs.getInt("user.id"));
				user.setName(rs.getString("user.name"));
				user.setFname(rs.getString("user.fname"));
				user.setEmail(rs.getString("user.email"));
				user.setDate_created(rs.getDate("user.date_created"));
				user_in_group.add(user);
			}
			group.setUsers(user_in_group);
			
		} catch (Exception e) {
			e.printStackTrace();
		} catch (Throwable e) {
			e.printStackTrace();
		}
		return group;
	}
	
	public boolean removeGroup (int id) throws SQLException {
		DB db = new DB();
		Connection conn = null;
		try {
			conn = db.getConnection();
			Statement stmt = null;
			stmt = conn.createStatement();
			
			ResultSet rs = null;
			String sql = "select * from project where group_id = " + id;
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				return false;
			}
			
			sql = "delete from `group` where id = " + id;
			stmt.executeUpdate(sql);
			
			sql = "delete from user_group where group_id = " + id;
			stmt.executeUpdate(sql);
			
		} catch (Exception e) {
			e.printStackTrace();
		} catch (Throwable e) {
			e.printStackTrace();
		}finally{
			conn.close();
		}
		return true;
	}
	
	public boolean removeUserFromGroup (int user_id, int group_id) throws SQLException {
		DB db = new DB();
		Connection conn = null;
		try {
			conn = db.getConnection();
			Statement stmt = null;
			stmt = conn.createStatement();
			String sql = "delete from user_group where user_id = " + user_id + " and group_id = " + group_id;
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
	
	public ArrayList<Group> getAllGroup () {
		ArrayList<Group> groups = new ArrayList<Group>();
		DB db = new DB();
		try {
			Connection conn = db.getConnection();
			Statement stmt = null;
			ResultSet rs = null;
			stmt = conn.createStatement();
			String sql = "select * from `group`";
			rs = stmt.executeQuery(sql);

			while (rs.next()) {
				Group group= new Group();
				group.setId(rs.getInt("id"));
				group.setName(rs.getString("name"));
				group.setDescription(rs.getString("description"));
				group.setDate_created(rs.getDate("date_created"));
				groups.add(group);
			}
			
			for (int i = 0; i < groups.size(); i++) {
				sql = "select * from user_group,user where user.id = user_group.user_id and group_id = " + groups.get(i).getId();
				rs = stmt.executeQuery(sql);

				ArrayList<User> user_in_group = new ArrayList<User>();
				while (rs.next()) {
					User user= new User();
					user.setId(rs.getInt("user.id"));
					user.setName(rs.getString("user.name"));
					user.setFname(rs.getString("user.fname"));
					user.setEmail(rs.getString("user.email"));
					user.setDate_created(rs.getDate("user.date_created"));
					user_in_group.add(user);
				}
				groups.get(i).setUsers(user_in_group);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} catch (Throwable e) {
			e.printStackTrace();
		}
		return groups;
	}
	
	public boolean addGroup (String name, String description) throws SQLException {
	    java.sql.Date sqlDate = new java.sql.Date(new Date(System.currentTimeMillis()).getTime());
		DB db = new DB();
		Connection conn = null;
		String query = "";
		try {
			conn = db.getConnection();
			Statement stmt = conn.createStatement();
			
			query = " select id from `group` where name = '" + name + "' ";
			ResultSet result = stmt.executeQuery(query);
			
			int count = 0;
			while (result.next()) {
				count++;
			}
			
			if (count == 0) {
				query =
						" insert into `group` ( id, name, description, date_created ) " +
						" values ( default, '" + name + "', '" + description + "', '" + sqlDate + "' ) ";
				stmt.executeUpdate(query);
			} else {
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} catch (Throwable e) {
			e.printStackTrace();
		} finally {
			conn.close();
		}
		return true;
	}
	
}
