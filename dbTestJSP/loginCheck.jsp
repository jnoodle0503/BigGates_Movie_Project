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
	request.setCharacterEncoding("UTF-8");
	
	String id = request.getParameter("id");
	String pass = request.getParameter("password");
	
	Connection conn = DBUtil.getMySQLConnection();
	
	String sql = "select * from user where userId = ?";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	
	pstmt.setString(1, id);
	ResultSet rs = pstmt.executeQuery();
	
	String passChk;
	
	Boolean isLogin = false;
	
	while(rs.next()) {
		passChk = rs.getString("userPassword");
		if(passChk.equals(pass)) {
			isLogin = true;
		}
	}
	
	if(isLogin) {
		out.println("<script>");
		out.println("alert('로그인 되었습니다. 환영합니다. :)')");
		out.println("location.href='main.jsp'");
		out.println("</script>");
	} else {
		out.println("<script>");
		out.println("alert('로그인 실패!')");
		out.println("location.href='main.jsp'");
		out.println("</script>");
	}
	DBUtil.close(rs);
	DBUtil.close(pstmt);
	DBUtil.close(conn);
%>
</body>
</html>