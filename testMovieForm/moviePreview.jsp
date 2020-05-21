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

}

for(int m = 0; m < movieCode.length; m++) {
	Document doc = Jsoup.connect("https://movie.naver.com/movie/bi/mi/media.nhn?code=" + movieCode[m]).get();

%>

<%
}



JnoodleDBconn.close(conn);
%>
</body>
</html>