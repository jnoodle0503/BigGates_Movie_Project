<%@page import="com.project.test.DBconn" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.ResultSet" %>
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
	request.setCharacterEncoding("UTF-8");

	Connection conn = DBconn.getMySQLConnection();
	
	String sql = "select * from recipeBook";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	
	ResultSet rs = pstmt.executeQuery();
	
	String reThumb = "";
	String reHref = "";
	String reTitle = "";
	
	while(rs.next()) {
		reThumb = rs.getString("recipeThumbLink");
		reTitle = rs.getString("recipeTitle");
		reHref = rs.getString("recipeLink");
%>

<p><a href="https://www.10000recipe.com<%=reHref %>"><%=reThumb %></a></p>
<p><%=reTitle %></p>
<p><%=reHref %></p>

<%
	}
%>
</body>
</html>