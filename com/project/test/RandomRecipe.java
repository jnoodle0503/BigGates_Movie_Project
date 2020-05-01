package com.project.test;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class RandomRecipe {
	public static String[] getRandomRecipe() {
		String randomRecipe[] = new String[4];
		try {
			Connection conn = DBconn.getMySQLConnection();
			
			int random = (int)(Math.random() * 100000) + 1;

			String sql = "Select * from recipeBook where recipeId = ?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, Integer.toString(random));
			
			ResultSet rs = pstmt.executeQuery();
			
			String reThumb = "";
			String reHref = "";
			String reTitle = "";
			String recipeId = "";
			
			while(rs.next()) {
				recipeId = rs.getString("recipeId");
				reThumb = rs.getString("recipeThumbLink");
				reTitle = rs.getString("recipeTitle");
				reHref = rs.getString("recipeLink");
			}
			
			randomRecipe[0] = reThumb;
			randomRecipe[1] = reTitle;
			randomRecipe[2] = reHref;
			randomRecipe[3] = recipeId;
			
		} catch(SQLException e) {
			e.printStackTrace();
		}
		return randomRecipe;
	}
}
