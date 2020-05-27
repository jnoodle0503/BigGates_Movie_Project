<%@ page import="org.jsoup.Jsoup"%>
<%@ page import="org.jsoup.nodes.Document"%>
<%@ page import="org.jsoup.nodes.Element"%>
<%@ page import="org.jsoup.select.Elements"%>
<%@ page import="com.project.movieProject.JnoodleDBconn"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>

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
request.setCharacterEncoding("utf-8");

String[] movieCode = new String[10];
String[] posterSrc = new String[10];

PreparedStatement pstmt = null;
ResultSet rs = null;

Connection conn = JnoodleDBconn.getMySQLConnection();
String sql = "select * from boxOfficeList;";
pstmt = conn.prepareStatement(sql);
rs = pstmt.executeQuery();

int i = 0;

while(rs.next()) {
	posterSrc[i] = rs.getString("poster");
	i++;
}

for(int j = 0; j < posterSrc.length; j++) {
	String[] posterSrcSpl = posterSrc[j].split("[/]")[7].split("_");
	movieCode[j] = posterSrcSpl[0];
	System.out.println(movieCode[j]);
}

for(int m = 0; m < movieCode.length; m++) {
	Document trailerDoc = Jsoup.connect("https://movie.naver.com/movie/bi/mi/media.nhn?code=" + movieCode[m]).get();
	Elements trailer = trailerDoc.select(".ifr_trailer .ifr_area .video_thumb li");
	for(Element traLi: trailer) {
		String videoThumb = traLi.select("a img").attr("src");
		String videoLink = traLi.select("a").attr("href");
		String videoTitle = traLi.select(".tx_video a").text();
		String videoDate = traLi.select(".video_date").text();
		Document videoPlayerDoc = Jsoup.connect("https://movie.naver.com" + videoLink).get();
		Elements videoPlayer = videoPlayerDoc.select("._videoPlayer");
		String videoPlayerSrc = videoPlayer.attr("src");
		
%>
	<a href="https://movie.naver.com<%=videoLink %>">
		<img alt="" src="<%=videoThumb %>" width="164" height="114">
	</a>
	<p>
		<a href="https://movie.naver.com<%=videoLink %>"><%=videoTitle %></a>
	</p>
	<!-- 네이버 예고편 영상 부분
	<iframe class="_videoPlayer" src="https://movie.naver.com<예고편 링크 부분>" id="videoPlayer" name="videoPlayer" width="300px" height="480" frameborder="0" scrolling="no" allowfullscreen="“true”"></iframe>
	-->
<%
	}
}



JnoodleDBconn.close(conn);
%>
</body>
</html>