<%@ page import="org.jsoup.Jsoup"%>
<%@ page import="org.jsoup.nodes.Document"%>
<%@ page import="org.jsoup.nodes.Element"%>
<%@ page import="org.jsoup.select.Elements"%>
<%@ page import="com.project.movieProject.JnoodleDBconn"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");

	String[] movieName = new String[10];

	PreparedStatement pstmt = null;
	ResultSet rs = null;

	Connection conn = JnoodleDBconn.getMySQLConnection();
	String sql = "select * from boxOfficeList;";
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();

	int i = 0;

	while (rs.next()) {
		movieName[i] = rs.getString("movieNm");
		System.out.println(movieName[i]);
		i++;
	}

	String[] youtubeSrc = new String[10]; // youtube 주소
	String[] youtubeTitle = new String[10]; // youtube 제목

	for (int j = 0; j < movieName.length; j++) {
		Document doc1 = Jsoup.connect("https://www.google.com/search?q=youtube: " + movieName[j] + " 영화 리뷰&source=lnms&tbm=vid").get();
		Elements vidItems1 = doc1.select(".rc .rGhul");
		String[] vidCode1 = vidItems1.get(0).attr("href").split("=");
		
		String vid1 = "https://www.youtube.com/embed/" + vidCode1[1] + "?autoplay=1";
		Elements vidTitleEl1 = doc1.select(".rc .r .LC20lb");
		String vidTitle1 = vidTitleEl1.get(0).text();
		
		/*
		Document doc2 = Jsoup.connect("https://www.google.com/search?q=" + movieName[j] + " 리뷰&source=lnms&tbm=vid").get();
		Elements vidItems2 = doc2.select(".rc .rGhul");
		String[] vidCode2 = vidItems2.get(0).attr("href").split("=");
		String vid2 = "https://www.youtube.com/embed/" + vidCode2[1];
		Elements vidTitleEl2 = doc2.select(".rc .r .LC20lb");
		String vidTitle2 = vidTitleEl2.get(0).text();
		*/
		
		if(vidTitle1.contains(movieName[j])) {
			youtubeSrc[j] = vid1;
			youtubeTitle[j] = vidTitle1;
			System.out.println(youtubeSrc[j]);
			System.out.println(youtubeTitle[j]);
			System.out.println();
			%>
			<iframe width="500" height="300" src="<%=vid1 %>"></iframe>
			<%
		} else {
			System.out.println("영화 리뷰 없음");
			System.out.println();
		}
	}
	
	/*
	for(int m = 0; m < youtubeSrc.length; m++) {
		if(youtubeSrc[m] != null) {
		System.out.println(youtubeSrc[m]);
		System.out.println(youtubeTitle[m]);
		System.out.println();
		}
	}
	*/
	

	JnoodleDBconn.close(conn);
	%>
</body>
</html>