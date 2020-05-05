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
	if(id != null) {
		out.println("<script>");
		out.println("alert('잘못된 경로입니다!!!!!')");
		out.println("location.href='main.jsp'");
		out.println("</script>");
	}
%>
<form action="joinOK.jsp" method="post">
<table width = "400" align = "center" border="1">
	<tr><th colspan="2">회원가입</th></tr>
	<tr>
		<td width = "200" align = "center">아이디</td>
		<td width = "200" align = "center"><input type = "text" name = "id"/></td>
	</tr>
	<tr>
		<td width = "200" align = "center">비밀번호</td>
		<td width = "200" align = "center"><input type = "password" name = "password"/></td>
	</tr>
	<tr>
		<td width = "200" align = "center">이름</td>
		<td width = "200" align = "center"><input type = "text" name = "name"/></td>
	</tr>
	<tr>
		<td colspan = "2" align = "center"><input type = "submit" value = "회원가입 하기"></td>
	</tr>
</table>
</form>
</body>
</html>