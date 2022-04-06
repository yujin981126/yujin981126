<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.*" %>
<%
	// photoList.jsp에서 photoNo를 불러와서 저장하기
	int photoNo = Integer.parseInt(request.getParameter("photoNo"));	
	System.out.println("photoNo -> "+ photoNo);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>deletePhotoFrom</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<style>
		.container{text-align:center;}
		td{text-align:left;}
		.rightbutton{text-align:right;}
</style>
</head>
<body>
	<div class="container">
	<jsp:include page="/inc/upMenu.jsp"></jsp:include>
	<div class="text-info">
	<br><h1>이미지삭제</h1>
	</div>
	<br>
		<form method="post" action="<%=request.getContextPath()%>/photo/deletePhotoAction.jsp">
			<table class="table text-info">
				<tr class="bg-light">
					<td>photoNo</td>
					<td><input type="text" name="photoNo" value="<%=photoNo%>"readonly="readonly" class="form-control"></td>
				</tr>
				<tr class="bg-light">
					<td>비밀번호</td>
					<td>
					<input type="password" name="photoPw" class="form-control">
					</td>
				</tr>
			</table>
		<div class="rightbutton">
				<a href="<%=request.getContextPath()%>/photo/photoList.jsp" class="btn btn-link text-info bg-light"> 뒤로가기</a>&nbsp;
				<button type="submit" class="btn btn-link text-light bg-info" >삭제</button>
		</div>
		</form>
	</div>
</body>
</html>