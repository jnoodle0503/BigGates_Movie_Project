<%@page import="com.project.test.DBconn"%>
<%@page import="com.project.test.RandomRecipe"%>
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

<title>랜덤 레시피</title>
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
					<li><a><button onclick="location.href='userRecipeBook.jsp'" class="btn btn-link">등록된 레시피</button></a></li>
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
			} else {
			request.setCharacterEncoding("UTF-8");
			Connection conn = DBconn.getMySQLConnection();

			String userId = "";
			String recipeId = "";

			// recipe 쿼리 다루는 부분
			String getRecipe[] = RandomRecipe.getRandomRecipe();
			
			String reThumb = getRecipe[0];
			String reHref = getRecipe[2];
			String reTitle = getRecipe[1];
			
			PreparedStatement recipePstmt = null;
			ResultSet recipeRs = null;
			String recipeSql = "select * from recipeBook where recipeLink = ?";
			recipePstmt = conn.prepareStatement(recipeSql);
			recipePstmt.setString(1, getRecipe[2]);
			recipeRs = recipePstmt.executeQuery();

			while (recipeRs.next()) {
				recipeId = recipeRs.getString("recipeId");
			}

			// user 쿼리 다루는 부분
			PreparedStatement userPstmt = null;
			ResultSet userRs = null;
			String userSql = "select * from recipeUser where userId = ?";
			userPstmt = conn.prepareStatement(userSql);
			userPstmt.setString(1, sessionUserId);
			userRs = userPstmt.executeQuery();
			
			
			while (userRs.next()) {
				userId = userRs.getString("userId");
				String userName = userRs.getString("userName");
			
		%>
		<h1>
			안녕하세요, <%=userName%>님!
		</h1>
		<%
			}
		%>
		<br>
		<h2>오늘의 레시피는 뭘까요~?</h2>
		<h3>*사진을 클릭하셔서 자세한 레시피를 확인하세요!</h3>
		<table class="table table-condensed">
			<tr>
				<td>레시피 이미지</td>
				<td align="center">레시피 제목</td>
			</tr>
			<tr>
				<td>
					<a href="https://www.10000recipe.com<%=reHref%>">
						<img class="img-responsive img-rounded" src=<%=reThumb%>/>
					</a>
				</td>
				<td align="center"><%=reTitle%></td>
			</tr>
		</table>
		<%
			

		// RecipeAndUser 쿼리 다루는 부분
		PreparedStatement rauPstmt = null;
		ResultSet rauRs = null;
		String rauSql = "insert into RecipeAndUser(userId, recipeId) values(?, ?)";
		rauPstmt = conn.prepareStatement(rauSql);
		rauPstmt.setString(1, userId);
		rauPstmt.setString(2, recipeId);
		rauPstmt.executeUpdate();

		DBconn.close(recipePstmt);
		DBconn.close(userPstmt);
		DBconn.close(rauPstmt);
		DBconn.close(conn);
		}
		%>
		
	</div>
	<!-- 애니매이션 담당 JQUERY -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
</body>
</html>