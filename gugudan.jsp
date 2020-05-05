<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구구단</title>
</head>


<body>
	<div id = "container" style="width: 400px">
		
		<% // 2 ~ 9 단 for 문
			for(int i = 2; i <= 9; i++) {
		%>
		
		<div id = "multiple" style="float: left; margin: 10px;">
		<h2 style="margin: 0px" align="center"><%=i + "단" %></h2>
		
		<% // 2 ~ 9 단 계산후 출력 for 문
				for(int j = 1; j <= 9; j++) {
		%>
		
				<%=i + " X " + j + " = " + i*j  %>
				<br>
		
		<% // 2 ~ 9 단 for 문 end
				}
		%>
		
		</div>

		
		<% // 2 ~ 9 단 계산후 출력 for 문 end
			}
		%>
	</div>
</body>
</html>