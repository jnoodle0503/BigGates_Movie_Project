package com.project.tfa;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LoginCheck {
	public static boolean pass(String id, String password) {
		String pass;
		
		Connection conn = DBUtil.getMySQLConnection();
		
		String sql = "select * from user where userId = ?";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			ResultSet rs = pstmt.executeQuery();
			
			Boolean isLogin = false;
			
			while(rs.next()) {
				pass = rs.getString("userPassword");
				if(pass.equals(password)) {
					isLogin = true;
				}
			}
			
			if(isLogin) {
				return true;
			}
			
			DBUtil.close(rs);
			DBUtil.close(pstmt);
			DBUtil.close(conn);
		} catch(SQLException e) {
			e.printStackTrace();
		}
		
		return false;
	}
}
