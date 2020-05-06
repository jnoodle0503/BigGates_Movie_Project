<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">
<script src="//code.jquery.com/jquery.js"></script>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
</head>
<body>

	<form>
		<!-- Modal -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<h4 class="modal-title">Modal title</h4>

					</div>
					<div class="modal-body">
						<div id="carousel-example-generic" class="carousel slide">
							<!-- Indicators -->
							<ol class="carousel-indicators">
							<li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
								<%
									for (int i = 0; i < 4; i++) {
								%>
								
								<li data-target="#carousel-example-generic" data-slide-to=<%=i + 1 %>></li>
								<%
									}
								%>
							</ol>
							<!-- Wrapper for slides -->
							<div class="carousel-inner">
								<div class="item active">
									<img src="//external-content.duckduckgo.com/iu/?u=http%3A%2F%2Ffarm5.static.flickr.com%2F4021%2F4598417969_c1b1129e4e_o.png&f=1&nofb=1" alt="" />

								</div>
								<%
									for (int i = 1; i < 5; i++) {
								%>

								<div class="item">
									<img src="http://placehold.it/900x500/666/" alt="" />
									<div class="carousel-caption">
										<h3>Second slide label</h3>

										<p>Second slide Caption.</p>
									</div>
								</div>

								<%
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
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal-dialog -->
		</div>
	</form>
	<!-- /.modal -->
	<script type="text/javascript">
		$('.carousel').carousel();
		$('#myModal').modal()
	</script>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#recoMovie").load("./recoMoviePopupTest1.jsp");
			//$("#modalBtn").click();
		})
	</script>

</body>
</html>