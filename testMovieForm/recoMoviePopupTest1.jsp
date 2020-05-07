<%@ page import="org.jsoup.Jsoup"%>
<%@ page import="org.jsoup.nodes.Document"%>
<%@ page import="org.jsoup.nodes.Element"%>
<%@ page import="org.jsoup.select.Elements"%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="./styles/recoMoviePopupTest1Style.css">

<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">
<script src="//code.jquery.com/jquery.js"></script>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>

</head>
<body>

	<div id="container">
		<form action="recoMovieAction.jsp" method="post">
			<div class="lst_wrap">
				<div class="lst_detail_t1">
					<!-- Modal -->
					<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">

								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
									<h4 class="modal-title">
									<img class="titleLogoImg" src="./images/smallMovieLogo2.png">
									오늘의 추천 영화
									</h4>

								</div>
								<div class="modal-body">
									<div id="carousel-example-generic" class="carousel slide">

										<!-- Wrapper for slides -->
										<div class="carousel-inner">
											<div class="item active">
												<div>
													<img class="firstImg" src="./images/movieLogo2.png">
												</div>
												
											</div>
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
													//dscDate[x][y] = outlineArr[2].substring(0, outlineArr[2].indexOf("개봉"));

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

											<div class="item">

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
											</div>


											<%
												thumbHref[i][j] = null;
											} else {
												s--;
											}
											}
											%>
										</div>
										<!-- Controls -->
										<a class="left carousel-control" href="#carousel-example-generic" data-slide="prev"> <span class="icon-prev"></span>
										</a> <a class="right carousel-control" href="#carousel-example-generic" data-slide="next"> <span class="icon-next"></span>
										</a>

									</div>
								</div>

								<div class="modal-footer">
									<input type="submit" class="btn btn-default" value="관심 영화 등록" />
								</div>
							</div>
							<!-- /.modal-content -->
						</div>
						<!-- /.modal-dialog -->
					</div>
					<!-- /.modal -->
				</div>

			</div>

		</form>

	</div>
	<script type="text/javascript">
		$('.carousel').carousel();
		$('#myModal').modal()
	</script>
</body>
</html>