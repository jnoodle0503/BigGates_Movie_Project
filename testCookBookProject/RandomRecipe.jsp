<%@page import="com.project.test.RandomRecipe" %>
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
	String[] getRecipe = RandomRecipe.getRandomRecipe();
%>
<p>
	<a href="https://www.10000recipe.com<%=getRecipe[2] %>">
		<%=getRecipe[0] %>
	</a>
</p>
<p><%=getRecipe[1]%></p>
<p><%=getRecipe[2]%></p>
</body>
</html>