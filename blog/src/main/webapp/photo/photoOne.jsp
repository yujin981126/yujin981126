<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	// photoList.jsp에서 photoNo를 불러와서 저장하기
	int photoNo = Integer.parseInt(request.getParameter("photoNo"));	
	System.out.println("photoNo -> "+ photoNo);
	
	PhotoDao photoDao = new PhotoDao();
	ArrayList<Photo> list = photoDao.selectPhotoOneList(photoNo);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<title>photoList</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
	<style>
		.container ,.imgCenter{text-align:center;}
		td{text-align:left;}
		.rightbutton{text-align:right;}
	</style>
</head>
<body>
	<div class="container">
	<jsp:include page="/inc/upMenu.jsp"></jsp:include>
		<div class="text-info">
			<br><h1>이미지상세보기</h1>
		</div>
		<br>
				<table class="table text-info">
				<% for(Photo p : list) {%>
					<tr>
						<td class="bg-light">photoNo</td><td><%=photoNo %></td>
						<td class="bg-light">writer</td><td><%=p.getWriter() %></td>
					</tr>
					<tr>
						<td class="bg-light">createDate </td><td><%=p.getCreateDate() %></td>
						<td class="bg-light">updateDate</td><td><%=p.getUpdateDate() %></td>
					</tr>
					<tr>
						<td colspan="4" class="imgCenter">
						<img src="<%=request.getContextPath()%>/upload/<%=p.getPhotoName()%>"></td>
					</tr>

					<% } %>
				</table>
				<div class="rightbutton">
					<a href="<%=request.getContextPath()%>/photo/photoList.jsp" class="btn btn-link text-info bg-light">뒤로가기</a>&nbsp;
					<a href="<%=request.getContextPath()%>/photo/deletePhotoFrom.jsp?photoNo=<%=photoNo%>" class="btn btn-link text-light bg-info">삭제</a>
				</div>
			</div>
</body>
</html>