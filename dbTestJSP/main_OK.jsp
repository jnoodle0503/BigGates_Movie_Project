<%@page import="com.project.tfa.DBUtil" %>
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
	String id = (String)session.getAttribute("id");
	String name;
	
	Connection conn = DBUtil.getMySQLConnection();
	String sql = "select * from user where userId = ?";
	
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, id);
	ResultSet rs = pstmt.executeQuery();
	
	rs.next();
	name = rs.getString("userName");
	
	DBUtil.close(rs);
	DBUtil.close(pstmt);
	DBUtil.close(conn);
%>
<h1>안녕하세요! <%=name %>님!</h1><br/>
<table width = "300" border = "1">
	<tr><th colspan = "2">나의 정보</th></tr>
	<tr>
		<td align = "center">이름</td>
		<td align = "center"><%=name %></td>
	</tr>
	
</table>
<input type = "button" value = "로그아웃" id = "logout"/>
<script type="text/javascript" src = "formCheck.js"></script>
</body>
</html>