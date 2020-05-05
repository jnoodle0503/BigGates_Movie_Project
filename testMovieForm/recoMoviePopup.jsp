<%@ page import="org.jsoup.Jsoup"%>
<%@ page import="org.jsoup.nodes.Document"%>
<%@ page import="org.jsoup.nodes.Element"%>
<%@ page import="org.jsoup.select.Elements"%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="./styles/recoMovieStyle.css">
<style>
/* The Modal (background) */
.modal {
	display: none; /* Hidden by default */
	position: fixed; /* Stay in place */
	z-index: 1; /* Sit on top */
	left: 0;
	top: 0;
	width: 100%; /* Full width */
	height: 100%; /* Full height */
	overflow: auto; /* Enable scroll if needed */
	background-color: rgb(0, 0, 0); /* Fallback color */
	background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
}

/* Modal Content/Box */
.modal-content {
	background-color: #fefefe;
	margin: 15% auto; /* 15% from the top and centered */
	padding: 20px;
	border: 1px solid #888;
	width: 30%; /* Could be more or less, depending on screen size */
}
</style>
</head>

<%
	/*
영화포스터, 제목, 평점, 예매율, 상영시간, 관람연령, 개봉날짜, 감독, 개요, 예매(링크)
*/

Document doc = Jsoup.connect("https://movie.naver.com/movie/running/current.nhn").get();

Elements currMovieContents = doc.select(".lst_detail_t1");
Elements currMovieThumb = currMovieContents.select(".thumb");
Elements currMovieDsc = currMovieContents.select(".lst_dsc");

// 영화 개요의 정보들
String dscDate[][] = new String[40][40]; // 영화 개봉날짜 
String dscTime[][] = new String[40][40]; // 영화 상영시간 
String dscGenre[][] = new String[40][40]; // 영화 장르

String thumbHref[][] = new String[40][40]; // 썸네일(링크) -> 상세페이지 이
String thumbImgSrc[][] = new String[40][40]; // 썸네일 이미지(링크)
String dscTitle[][] = new String[40][40]; // 영화 제목 
String dscScore[][] = new String[40][40]; // 영화 평점
String dscScoreHref[][] = new String[40][40]; // 영화 평점(링크)
String dscScoreNum[][] = new String[40][40]; // 영화 평점값(실수형식)
String dscScoreNum2[][] = new String[40][40]; // 영화 평점 참여자수 
String dscRate[][] = new String[40][40]; // 영화 예매율 
String dscAge[][] = new String[40][40]; // 영화 연령제한 
String dscDirector[][] = new String[40][40]; // 영화 감독 
String dscOutline[][] = new String[40][40]; // 영화 개요
String dscActor[][] = new String[40][40]; // 영화 배우 

int x = 0, y = 0; // 배열 인덱스

for (Element th : currMovieThumb) {
	if (x != 40) {
		thumbHref[x][y] = th.select("a").attr("href");
		thumbImgSrc[x][y] = th.select("a img").attr("src");
		x++;
	}
	if (x == 40) {
		x = 0;
		y++;
	}

}

x = 0;
y = 0;

for (Element ds : currMovieDsc) {
	if (x != 40) {

		dscAge[x][y] = ds.select(".tit span").attr("class");
		dscTitle[x][y] = ds.select(".tit a").text();
		dscScore[x][y] = ds.select(".star .info_star .star_t1 .st_off").toString();
		dscScoreHref[x][y] = ds.select(".star .info_star .star_t1 a").attr("href");
		dscScoreNum[x][y] = ds.select(".star .info_star .star_t1 a .num").text();
		dscScoreNum2[x][y] = ds.select(".star .info_star .star_t1 a .num2").toString();
		dscRate[x][y] = ds.select(".star .info_exp .b_star").toString();

		Elements infoTxt = ds.select("dd .info_txt1 dd");

		dscOutline[x][y] = infoTxt.get(0).text();

		String outlineArr[] = dscOutline[x][y].split("\\|");

		// 나중에 정렬할 때 쓸 수도 있음(날짜정렬)
		dscDate[x][y] = outlineArr[2].substring(0, outlineArr[2].indexOf("개봉"));

		dscGenre[x][y] = outlineArr[0];

		dscDirector[x][y] = infoTxt.get(1).text();
		dscActor[x][y] = infoTxt.get(infoTxt.size() - 1).text();

		x++;
	}
	if (x == 40) {
		x = 0;
		y++;
	}
}
%>
<!-- The Modal -->
<div id="myModal" class="modal">

	<!-- Modal content -->
	<div class="modal-content">
		<p style="text-align: center;">
			<span style="font-size: 14pt;"><b><span style="font-size: 24pt;">공지</span></b></span>
		</p>
		<p style="text-align: center; line-height: 1.5;">
			<%
				String recoMovie[] = new String[5];
			String splitStr = "^";
			for (int s = 0; s < 5; s++) {
				int i = (int) (Math.random() * 39) + 1;
				int j = (int) (Math.random() * 39) + 1;

				if (thumbHref[i][j] != null) {
					recoMovie[s] = thumbImgSrc[i][j] + splitStr + dscAge[i][j] + splitStr + thumbHref[i][j] + splitStr
					+ dscTitle[i][j] + splitStr + dscScore[i][j] + splitStr + dscScoreNum[i][j] + splitStr
					+ dscScoreNum2[i][j] + splitStr + dscRate[i][j] + splitStr + dscOutline[i][j] + splitStr
					+ dscDirector[i][j] + splitStr + dscActor[i][j];
			%>
		
		<div id="container">
			<form action="recoMovieAction.jsp" method="post">
				<div class="lst_wrap">
					<ul class="lst_detail_t1">
						<li>

							<div class="thumb">

								<input type="checkbox" id="thumbCheckbox<%=s%>" name="checkbox" value='<%=recoMovie[s]%>' style="opacity: 0; position: absolute; left: 9999px;" /> <label for="thumbCheckbox<%=s%>"> <img src="<%=thumbImgSrc[i][j]%>" />
								</label>


							</div>
							<dl class="lst_dsc">
								<dt class="tit">
									<span class="<%=dscAge[i][j]%>"></span> <a href="https://movie.naver.com<%=thumbHref[i][j]%>"> <font size="2"><%=dscTitle[i][j]%></font>
									</a>
								</dt>

								<dd class="star">
									<dl class="info_star">
										<dd>
											<div class="star_t1">
												<span> <%=dscScore[i][j]%> <span class="num"><%=dscScoreNum[i][j]%></span>

												</span>
											</div>
										</dd>
									</dl>

								</dd>

							</dl>
						</li>
					</ul>

				</div>


				<%
					thumbHref[i][j] = null;
				} else {
					s--;
				}
				}
				%>

				<div id="submit">
					<input type="submit" value="관심 영화 등록" />
				</div>
			</form>

		</div>
		</p>
		<p>
			<br />
		</p>
		<div style="cursor: pointer; background-color: #DDDDDD; text-align: center; padding-bottom: 10px; padding-top: 10px;" onClick="close_pop();">
			<span class="pop_bt" style="font-size: 13pt;"> 닫기 </span>
		</div>
	</div>

</div>

<!--End Modal-->
<script type="text/javascript">
	jQuery(document).ready(function() {
		$('#myModal').show();
	});
	//팝업 Close 기능
	function close_pop(flag) {
		$('#myModal').hide();
	};
</script>