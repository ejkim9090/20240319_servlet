package kh.mclass.jdbc;

import java.io.FileReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Properties;


public class JdbcTemplate {
	private JdbcTemplate() {}

	public static Connection getConnection() {
		Connection conn = null;
		Properties prop = new Properties();
		try {
			String currentPath = JdbcTemplate.class.getResource("").getPath();
			System.out.println(currentPath);
			prop.load(new FileReader(currentPath+"driver.properties"));
			Class.forName(prop.getProperty("jdbc.driver"));
			conn = DriverManager.getConnection(prop.getProperty("jdbc.url")
												, prop.getProperty("jdbc.username")
												, prop.getProperty("jdbc.password"));
			System.out.println((conn!=null)?"연결성공":"연결실패");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return  conn;
	}
	public static void close(Connection conn) {
		try {
			if(conn != null) conn.close();
		}catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	public static void close(Statement stmt) {
		try {
			if(stmt != null) stmt.close();
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	public static void close(ResultSet rs) {
		try {
			if(rs != null) rs.close();
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	// TODO commit/rollback/setAutoCommit
}
