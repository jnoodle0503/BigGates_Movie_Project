<%@ page import="com.project.movieProject.DBconn"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	request.setCharacterEncoding("utf-8");

	String recoMovie[] = request.getParameterValues("checkbox");
	String recoMovieList[] = new String[40];

	Connection conn = DBconn.getMySQLConnection();
	String sql = "insert into intermovietable values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	PreparedStatement pstmt = null;

	String movieUserId = "test";
	String thumbImgSrc = "";
	String movieAge = "";
	String movieDetailHref = "";
	String movieTitle = "";
	String movieScore = "";
	String movieScoreNum1 = "";
	String movieScoreNum2 = "";
	String movieRating = "";
	String movieOutline = "";
	String movieDirector = "";
	String movieActor = "";
	if (request.getParameterValues("checkbox") != null) {
		for (int i = 0; i < recoMovie.length; i++) {
			pstmt = conn.prepareStatement(sql);

			recoMovieList = recoMovie[i].split("\\^");
			thumbImgSrc = recoMovieList[0];
			movieAge = recoMovieList[1];
			movieDetailHref = recoMovieList[2];
			movieTitle = recoMovieList[3];
			movieScore = recoMovieList[4];
			movieScoreNum1 = recoMovieList[5];
			movieScoreNum2 = recoMovieList[6];
			movieRating = recoMovieList[7];
			movieOutline = recoMovieList[8];
			movieDirector = recoMovieList[9];
			movieActor = recoMovieList[10];

			pstmt.setString(1, movieUserId + i);
			pstmt.setString(2, thumbImgSrc);
			pstmt.setString(3, movieAge);
			pstmt.setString(4, movieDetailHref);
			pstmt.setString(5, movieTitle);
			pstmt.setString(6, movieScore);
			pstmt.setString(7, movieScoreNum1);
			pstmt.setString(8, movieScoreNum2);
			pstmt.setString(9, movieRating);
			pstmt.setString(10, movieOutline);
			pstmt.setString(11, movieDirector);
			pstmt.setString(12, movieActor);
			pstmt.executeUpdate();

			System.out.println(movieUserId);
			System.out.println(thumbImgSrc);
			System.out.println(movieAge);
			System.out.println(movieDetailHref);
			System.out.println(movieTitle);
			System.out.println(movieScore);
			System.out.println(movieScoreNum1);
			System.out.println(movieScoreNum2);
			System.out.println(movieRating);
			System.out.println(movieOutline);
			System.out.println(movieDirector);
			System.out.println(movieActor);

			System.out.println("============================================================");

		}

		DBconn.close(pstmt);
		DBconn.close(conn);
	%>
	<script>
		alert("나의 관심영화 목록을 확인하세요!");
		location.href = "./movieTestIndex1.html";
	</script>
	<%
		} 
	%>
<script>
	alert("관심가는 영화를 선택해주세요");
	window.history.back();
</script>
</body>
</html>