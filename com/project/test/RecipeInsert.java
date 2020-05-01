package com.project.test;

import java.sql.Connection;
import java.sql.PreparedStatement;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import com.project.test.DBconn;

public class RecipeInsert {
	public static void main(String[] args) {
		Connection conn = DBconn.getMySQLConnection();
		PreparedStatement pstmt = null;
		
		String sql = "";
		
		
		try {
			String thumbnails[][][][] = new String[3][40][40][40];
			String reHref[][][][] = new String[3][40][40][40];
			String reTitle[][][][] = new String[3][40][40][40];
			
			int cnt = 0;
			int cnt2 = 0;
			int cnt3 = 0;
			int cnt4 = 0;
			int k = 0;
			
			for(int i = 0; i < 2500; i++) {
				Document doc = Jsoup.connect("https://www.10000recipe.com/recipe/list.html?order=reco&page=" + (i + 1)).get();
				
				Elements reContents = doc.select(".thumbnail");
				
				String href = "";
				
				for(Element e: reContents) {
					k++;
					href = e.attr("href");
					if(cnt != 40) {
						thumbnails[cnt4][cnt3][cnt2][cnt] = e.select("img[src*=cache]").attr("src");
						reHref[cnt4][cnt3][cnt2][cnt] = href;
						reTitle[cnt4][cnt3][cnt2][cnt] = e.select(".ellipsis_title2").toString();
						cnt++;
					} if(cnt == 40){
						cnt = 0;
						cnt2++;
						
					} if(cnt2 == 40) {
						cnt = 0;
						cnt2 = 0;
						cnt3++;
					} if(cnt3 == 40) {
						cnt = 0;
						cnt2 = 0;
						cnt3 = 0;
						cnt4++;
					}
				}
			}
			
			
			for(int n = 0; n < 3; n++) {
				for(int i = 0; i < 40; i++) {
					for(int j = 0; j < 40; j++) {
						for(int x = 0; x < 40; x++) {
							sql = "insert into recipeBook(recipeTitle, recipeLink, recipeThumbLink) values(?, ?, ?)";
							pstmt = conn.prepareStatement(sql);
							
							if(thumbnails[n][i][j][x] != null && reTitle[n][i][j][x] != null && reHref[n][i][j][x] != null) {
								System.out.println(thumbnails[n][i][j][x]);
								pstmt.setString(1, reTitle[n][i][j][x]);
								pstmt.setString(2, reHref[n][i][j][x]);
								pstmt.setString(3, thumbnails[n][i][j][x]);
								pstmt.executeUpdate();
							}
						}
					}
				}
			}
			System.out.println(k);
			DBconn.close(pstmt);
			DBconn.close(conn);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}

