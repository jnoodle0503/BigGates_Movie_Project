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
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String userId = request.getParameter("userId");
	String userPassword = request.getParameter("userPassword");
	
	String sql = "select * from recipeUser where userId = ?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, userId);
	
	
	
	rs = pstmt.executeQuery();
	
	Boolean isLogin = false;
	
	while(rs.next()) {
		if(rs.getString("userPassword").equals(userPassword)) {
			isLogin = true;
		}
	}
	
	if(isLogin) {
		session.setAttribute("sessionUserId", userId);
		session.setAttribute("sessionLogin", "yes");
%>
	<script>
		location.href = "userDetail.jsp";
	</script>
<%
	} else {
%>
	<script>
		alert("아이디 또는 비밀번호가 잘못되었습니다!!!");
		location.href = "main.jsp";
	</script>
<%
	}
%>
</body>
</html>