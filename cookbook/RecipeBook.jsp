<%@ page import="org.jsoup.Jsoup" %>
<%@ page import="org.jsoup.nodes.Document" %>
<%@ page import="org.jsoup.nodes.Element" %>
<%@ page import="org.jsoup.select.Elements" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	try {
		String thumbnails[][][] = new String[6][40][40];
		String reHref[][][] = new String[6][40][40];
		String reTitle[][][] = new String[6][40][40];
		
		int cnt = 0;
		int cnt2 = 0;
		int cnt3 = 0;
		int k = 0;
		
		for(int i = 0; i < 100; i++) {
			Document doc = Jsoup.connect("https://www.10000recipe.com/recipe/list.html?order=reco&page=" + (i + 1)).get();
			
			Elements reContents = doc.select(".thumbnail");
			Elements reThumbnails = reContents.select("img[src*=cache]");
			
			String href = "";
			
			for(Element e: reContents) {
				k++;
				href = e.attr("href");
				if(cnt != 40) {
					thumbnails[cnt3][cnt2][cnt] = e.select("img[src*=cache]").toString();
					reHref[cnt3][cnt2][cnt] = href;
					reTitle[cnt3][cnt2][cnt] = e.select(".ellipsis_title2").toString();
					cnt++;
				} if(cnt == 40){
					cnt = 0;
					cnt2++;
					
				} if(cnt2 == 40) {
					cnt = 0;
					cnt2 = 0;
					cnt3++;
				}
			}
		}
		
		System.out.println(k);
	
%>
<%
	int n = 0;
	for(int i = 0; i <= cnt3; i++) {
		for(int j = 0; j < 40; j++) {
			for(int x = 0; x < 40; x++) {
				n++;
%>
			<p><a href="https://www.10000recipe.com<%=reHref[i][j][x] %>"><%=thumbnails[i][j][x] %></a></p>
			<p><%=reTitle[i][j][x]%></p>
			<p><%=reHref[i][j][x]%></p>
<%
			}
		}
	}
%>

<%
	} catch(Exception e) {
		e.printStackTrace();
	}
%>
</body>
</html>