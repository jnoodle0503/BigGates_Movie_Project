package com.project.movieProject;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class JnoodleDBconn {
	public static Connection getMySQLConnection() {
		Connection conn = null;

		try {
			Class.forName("com.mysql.jdbc.Driver");
			String addUrl = "?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
			String url = "jdbc:mysql://jnoodle4560.cafe24.com:3306/jnoodle4560" + addUrl;

			String user = "jnoodle4560";
			String password = "jsp_i_team00";
			conn = DriverManager.getConnection(url, user, password);
			System.out.println("DB connected");
		} catch (ClassNotFoundException e) {
			System.out.println("MySQL 드라이버가 없습니다.");
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("사용자 계정 또는 비밀번호가 일치하지 않습니다.");
		}
		return conn;
	}

	public static void close(Connection conn) {
		try {
			if (conn != null) {
				conn.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static void close(Statement stmt) {
		try {
			if (stmt != null) {
				stmt.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static void close(PreparedStatement pstmt) {
		try {
			if (pstmt != null) {
				pstmt.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static void close(ResultSet rs) {
		try {
			if (rs != null) {
				rs.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
