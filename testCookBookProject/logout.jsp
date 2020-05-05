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
	String isLogin = (String)session.getAttribute("sessionLogin");
	String sessionUserId = (String)session.getAttribute("sessionUserId");
	
	if(isLogin == "yes" && sessionUserId != null) {
		session.removeAttribute("sessionLogin");
		session.removeAttribute("sessionUserId");
	 
%>
	<script>
		location.href = "main.jsp";
	</script>
<%
	} else {
%>
	<script>
		alert("잘못된 경로입니다!!!!");
		location.href = "main.jsp";
	</script>
<%
	}
%>
</body>
</html>