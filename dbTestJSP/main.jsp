<%@page import="com.project.tfa.LoginCheck" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	
	if(LoginCheck.pass(id, password)) {
		session.setAttribute("id", id);
		session.setAttribute("login", "yes");
	}
	
	String logout = request.getParameter("logout");
	
	if(logout != null && logout.equals("yes")) {
		session.removeAttribute("id");
		session.removeAttribute("login");
	}
	
	String login = (String)session.getAttribute("login");
	if(login != null && login.equals("yes")) {
		out.println("<script>");
		out.println("alert('로그인 되었습니다. 환영합니다. :)')");
		out.println("location.href='main_OK.jsp'");
		out.println("</script>");
	}
	else {
%>
<h1>환영합니다 :) </h1>
<form action = "?" method = "post" onsubmit="return loginCheck(this)">
<table>
	<tr><th colspan = "2">로그인</th></tr>
	<tr>
		<td>아이디</td>
		<td><input type = "text" name = "id"></td>
	</tr>
	<tr>
		<td>비밀번호</td>
		<td><input type = "password" name = "password"></td>
	</tr>
	<tr>
		<td colspan = "2" align = "center"><input type = "submit" value = "로그인하기"/></td>
		<td align = "center"><input type = "button" value = "회원가입" onclick = "location.href='joinPage.jsp'"/></td>
	</tr>
</table>
</form>
<%
	}
%>
<script type="text/javascript" src = "formCheck.js"></script>
</body>
</html>