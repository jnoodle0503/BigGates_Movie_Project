<%@page import="testPkg.JavaTest"%>

<%@page import="java.sql.Connection" %>
<%@page import="java.sql.Statement" %>
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
		Connection conn = JavaTest.getDBConnection();
	
		Statement st = null;
		ResultSet rs = null;

		// 쿼리 수행을 위한 Statement 객체 생성
		st = conn.createStatement();
		
		// 쿼리 수행
		// 레코드들은 ResultSet 객체에 추가된다
		rs = st.executeQuery("SHOW DATABASES");

		while(rs.next()) {
			// 레코드의 칼럼은 배열과 달리 0부터 시작하지 않고 1부터 시작한다
			// 데이터베이스에서 가져오는 데이터의 타입에 맞게 getString 또는 getInt 등을 호출한다
			
			String str = rs.getNString(1);
	%>
	
	<h1><%= str %></h1>
	
	<%
		}
	%>
	
</body>
</html>