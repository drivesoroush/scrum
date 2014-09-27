package myjava;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class RoleManager {
	public RoleManager() {
		String JDBC_DRIVER = "com.mysql.jdbc.Driver";
		try {
			Class.forName(JDBC_DRIVER);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 
	 * @return	0 all ok
	 * 			1 user is already scrum master, can't be product owner
	 * 			2 user is already product owner, can't be scrum master
	 * 			3 user already has this role in project
	 */
	public int assignUserToRoleInProject (int user_id, int project_id, String type) throws SQLException {
		DB db = new DB();
		Connection conn = null;
		String query = "";
		try {
			conn = db.getConnection();
			Statement stmt = null;
			stmt = conn.createStatement();
			
			if (RoleType.PRODUCT_OWNER.equals(type)) {
				query =
						" select id from role_user " +
						" where user_id = " + user_id + " and project_id = " + project_id +
						" and (type = '" + RoleType.SCRUM_MASTER + "')";
				ResultSet rs = stmt.executeQuery(query);
				while (rs.next()) {
					return 1;
				}
			} else if (RoleType.SCRUM_MASTER.equals(type)) {
				query =
						" select id from role_user " +
						" where user_id = " + user_id + " and project_id = " + project_id +
						" and (type = '" + RoleType.PRODUCT_OWNER + "')";
				ResultSet rs = stmt.executeQuery(query);
				while (rs.next()) {
					return 2;
				}
			}
			query =
					" select id from role_user " +
					" where user_id = " + user_id + " and project_id = " + project_id + " and type = '" + type + "'";
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				return 3;
			}
			
			query =
					" insert into role_user (id, user_id, project_id, type) " +
					" values (default, " + user_id + ", " + project_id + ", '" + type + "')";
			stmt.executeUpdate(query);
			
		} catch (Exception e) {
			e.printStackTrace();
		} catch (Throwable e) {
			e.printStackTrace();
		} finally {
			conn.close();
		}
		return 0;
	}
	
	public boolean unassignUserToRoleInProject(int user_id,int project_id,String type) throws SQLException {
		DB db = new DB();
		Connection conn = null;
		try {
			conn = db.getConnection();
			Statement stmt = null;
			stmt = conn.createStatement();
			String sql =
					" delete from role_user " +
					" where user_id = " + user_id + " and project_id = " + project_id + " and type= '" + type + "'";
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
	
	public ArrayList<String> getRolesByUserId(int user_id, int project_id) throws SQLException {
		ArrayList<String> roles = new ArrayList<String>();
		DB db = new DB();
		Connection conn = null;
		try {
			conn = db.getConnection();
			Statement stmt = null;
			stmt = conn.createStatement();
			ResultSet rs = null;
			String sql =
					" select * from role_user " +
					" where user_id = " + user_id + " and project_id = " + project_id;
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				roles.add(rs.getString("type"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} catch (Throwable e) {
			e.printStackTrace();
		} finally {
			conn.close();
		}
		return roles;
	}
}
