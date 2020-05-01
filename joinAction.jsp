<%@page import="com.project.test.DBconn" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.PreparedStatement" %>

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
	
	String userId = request.getParameter("userId");
	String userPassword = request.getParameter("userPassword");
	String userName = request.getParameter("userName");
	
	String sql = "insert into recipeUser values(?, ?, ?)";
	
	pstmt = conn.prepareStatement(sql);
	
	pstmt.setString(1, userId);
	pstmt.setString(2, userPassword);
	pstmt.setString(3, userName);
	pstmt.executeUpdate();
	
	DBconn.close(pstmt);
	DBconn.close(conn);
%>
<script>
	alert("회원가입에 성공하였습니다!\n이제 맛있는 레시피들을 만나보세요!");
	location.href = "main.jsp";
</script>
</body>
</html>