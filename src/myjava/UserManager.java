package myjava;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;

public class UserManager {
	public UserManager () {
		String JDBC_DRIVER = "com.mysql.jdbc.Driver";
		try {
			Class.forName(JDBC_DRIVER);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	
	public void removeuser (int id) throws SQLException {
		DB db = new DB();
		Connection conn = null;
		try {
			conn = db.getConnection();
			Statement stmt = null;
			stmt = conn.createStatement();
			String sql = "delete from user where id = " + id;
			stmt.executeUpdate(sql);
		} catch (Exception e) {
			e.printStackTrace();
		} catch (Throwable e) {
			e.printStackTrace();
		} finally {
			conn.close();
		}
	}
	
	public User getUserById (int user_id) {
		User user= new User();
		DB db = new DB();
		try {
			Connection conn = db.getConnection();
			Statement stmt = null;
			ResultSet rs = null;
			stmt = conn.createStatement();
			String sql = "select * from user where id = " + user_id;
			rs = stmt.executeQuery(sql);

			while (rs.next()) {
				user.setId(rs.getInt("id"));
				user.setName(rs.getString("name"));
				user.setFname(rs.getString("fname"));
				user.setEmail(rs.getString("email"));
				user.setDate_created(rs.getDate("date_created"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} catch (Throwable e) {
			e.printStackTrace();
		}
		return user;

	}
	
	public User getUserByEmail (String email) {
		User user= new User();
		DB db = new DB();
		try {
			Connection conn = db.getConnection();
			Statement stmt = null;
			ResultSet rs = null;
			stmt = conn.createStatement();
			String sql = "select * from user where email='"+email+"'";
			rs = stmt.executeQuery(sql);

			while (rs.next()) {
				user.setId(rs.getInt("id"));
				user.setName(rs.getString("name"));
				user.setFname(rs.getString("fname"));
				user.setEmail(rs.getString("email"));
				user.setDate_created(rs.getDate("date_created"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} catch (Throwable e) {
			e.printStackTrace();
		}
		return user;

	}
	
	
	public ArrayList<User> getAllUsers () {
		ArrayList<User> users = new ArrayList<User>();
		DB db = new DB();
		try {
			Connection conn = db.getConnection();
			Statement stmt = null;
			ResultSet rs = null;
			stmt = conn.createStatement();
			String sql = "select * from user";
			rs = stmt.executeQuery(sql);

			while (rs.next()) {
				User user= new User();
				user.setId(rs.getInt("id"));
				user.setName(rs.getString("name"));
				user.setFname(rs.getString("fname"));
				user.setEmail(rs.getString("email"));
				user.setDate_created(rs.getDate("date_created"));
				users.add(user);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} catch (Throwable e) {
			e.printStackTrace();
		}
		return users;
	}
	
	public boolean addUserToGroup(int user_id,int group_id) throws SQLException {
		DB db = new DB();
		Connection conn = null;
		try {
			conn = db.getConnection();
			Statement stmt = null;
			stmt = conn.createStatement();
			ResultSet rs = null;
			String sql = "select * from user_group where user_id = " + user_id+" and group_id = " + group_id;
			rs = stmt.executeQuery(sql);
			
			while (rs.next()) {
				return false;
			}
			
			sql = "insert into user_group (id,user_id,group_id) "
					+ "values(default,"+user_id + ", " + group_id + ")";
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
	
	public boolean addUser (String name,String fname,String email) throws SQLException {
	    java.sql.Date sqlDate = new java.sql.Date(new Date(System.currentTimeMillis()).getTime());
		DB db = new DB();
		Connection conn = null;
		try {
			conn = db.getConnection();
			Statement stmt = null;
			stmt = conn.createStatement();
			
			ResultSet rs = null;
			String sql = "select * from user where email='"+email+"'";
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				return false;
			}
			
			sql =
					" insert into user (id, name, fname, date_created, email, password, type) " +
					" values (default, '" + name + "', '" + fname + "', '" + sqlDate + "', '" + email+"', '1', '') ";
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
	
	public boolean chechUserLogin (String email,String password) throws SQLException {
		DB db = new DB();
		Connection conn = null;
		try {
			conn = db.getConnection();
			Statement stmt = null;
			stmt = conn.createStatement();
			
			ResultSet rs = null;
			String sql =
					" select * from user " +
					" where email = '" + email + "' and password = '" + password + "'";
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
	
	public boolean isAdminUserByEmail (String email) throws SQLException {
		DB db = new DB();
		Connection conn = null;
		String type = "";
		try {
			conn = db.getConnection();
			Statement stmt = null;
			stmt = conn.createStatement();
			
			ResultSet rs = null;
			String sql = "select type from user where email = '" + email + "'";
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				type = rs.getString("type");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} catch (Throwable e) {
			e.printStackTrace();
		} finally {
			conn.close();
		}
		
		if (type.equals("admin")) {
			return true;
		}
		return false;
	}

}
