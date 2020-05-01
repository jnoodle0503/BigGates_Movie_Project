package com.project.tfa;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DBUtil {
	public static Connection getMySQLConnection() {
		Connection conn = null;
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
			//String user = "root";
			//String password = "@wjddlstn8025";
			conn = DriverManager.getConnection(url, "root", "@wjddlstn8025");
			System.out.println("연결 성공");
		} catch(ClassNotFoundException e) {
			System.out.println("MySQL 드라이버가 없습니다.<br/>");
		} catch(SQLException e) {
			System.out.println("사용자 계정 또는 비밀번호가 일치하지 않습니다. <br/>");
		}
		return conn;
	}
	public static void close(Connection conn) {
		try {
			if(conn != null) {
				conn.close();
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	public static void close(Statement stmt) {
		try {
			if(stmt != null) {
				stmt.close();
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	public static void close(PreparedStatement pstmt) {
		try {
			if(pstmt != null) {
				pstmt.close();
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	public static void close(ResultSet rs) {
		try {
			if(rs != null) {
				rs.close();
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}
