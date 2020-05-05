<%@ page import="org.jsoup.Jsoup" %>
<%@ page import="org.jsoup.nodes.Document" %>
<%@ page import="org.jsoup.nodes.Element" %>
<%@ page import="org.jsoup.select.Elements" %>

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
	try {
		Document doc = Jsoup.connect("https://www.newneek.co/library").get();
		
		Elements tt = doc.select(".text-table");
		Elements span = tt.select(".holder");
		int i = 0;
		for(Element e: span) {
			if(i > 5) {
				break;
			}
			i++;
%>
				<p><%=e %></p>
<%
		}
	} catch(Exception e) {
		e.printStackTrace();
	}

%>

</body>
</html>