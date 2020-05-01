<%@page import="com.project.test.DBconn"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 뷰포트 -->
<meta name="viewport" content="width=device-width" initial-scale="1">
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<title>등록된 레시피</title>
</head>
<body>
<div class="container">
	<nav class="navbar navbar-default">
		<div class="navbar-header">

			<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="#">오늘 뭐 먹지?</a>
		</div>
		<div class="collapse navbar-collapse" id="navbar" aria-expanded="true">
			<ul class="nav navbar-nav">
				<li><a><button onclick="location.href='logout.jsp'" class="btn btn-link">로그아웃</button></a></li>
			</ul>

		</div>
	</nav>
	<%
		String sessionUserId = (String) session.getAttribute("sessionUserId");
	if (sessionUserId == null) {
	%>
	<script>
		alert("잘못된 경로입니다!!!!");
		location.href = "main.jsp";
	</script>
	<%
		}
	request.setCharacterEncoding("UTF-8");
	Connection conn = DBconn.getMySQLConnection();

	PreparedStatement userPstmt = null;
	ResultSet userRs = null;
	String userSql = "select recipeId from RecipeAndUser where userId = ?";

	userPstmt = conn.prepareStatement(userSql);
	userPstmt.setString(1, sessionUserId);
	userRs = userPstmt.executeQuery();

	String recipeId = "";

	PreparedStatement recipePstmt = null;
	ResultSet recipeRs = null;
	String recipeSql = "select * from recipeBook where recipeId = ?";
	recipePstmt = conn.prepareStatement(recipeSql);
	String reThumb = "";
	String reHref = "";
	String reTitle = "";
	%>
	<h1>등록된 레시피</h1>
	<table class="table table-condensed">
		<tr>
			<td>레시피 이미지</td>
			<td align="center">레시피 제목</td>
		</tr>
		<%
			while (userRs.next()) {
			recipeId = userRs.getString("recipeId");
			recipePstmt.setString(1, recipeId);
			recipeRs = recipePstmt.executeQuery();
			while (recipeRs.next()) {
				reThumb = recipeRs.getString("recipeThumbLink");
				reTitle = recipeRs.getString("recipeTitle");
				reHref = recipeRs.getString("recipeLink");
		%>


		<tr>
			<td>
				<a href="https://www.10000recipe.com<%=reHref%>">
					<img class="img-responsive img-rounded" src=<%=reThumb%>/>
				</a>
			</td>
			<td align="center"><%=reTitle%></td>
		</tr>
		<%
			}

		}
		%>
	</table>
</div>
	<!-- 애니매이션 담당 JQUERY -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
</body>
</html>