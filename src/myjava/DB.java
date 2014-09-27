package myjava;

import java.sql.*;

public class DB {

	public DB() {
	}

	public Connection getConnection() throws Throwable {
		/**
		 * 8889 is mysql port
		 * check mysql port with this query
		 * show global variables like 'port';
		 */
		String DB_URL = "jdbc:mysql://localhost:8889/scrum";
		String USER = "root";
		String PASS = "root";
		return DriverManager.getConnection(DB_URL, USER, PASS);
	}
}
