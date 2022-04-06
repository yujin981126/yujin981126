<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertPhotoFrom</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
	<style>
		.container{text-align:center;}
		td{text-align:left;}
		.right{text-align:right;}
	</style>
</head>
<body>
<div class="container">
	<jsp:include page="/inc/upMenu.jsp"></jsp:include>
	<div class="text-info">
	<br><h1>이미지 등록</h1><br>
	</div>
	<!-- form은 문자열만 넘길 수 있다. 기본값 문자열-->
	<!-- 이미지 파일을 넘길 수 없고 기본값을 변경해야 한다.-->
	<!-- 기본값을 - multipart/form-data 로 변경하면 기본값이 문자열애서 바이너리 타입으로 변경됨-->
	<form action="<%=request.getContextPath() %>/photo/insertPhotoAction.jsp" method="post" enctype="multipart/form-data">
		<table class="table text-info">
			<tr>
				<td class="bg-light">이미지파일</td>
				<td><input type="file" name="photo"></td>
			</tr>
			<tr>
				<td class="bg-light">비밀번호</td>
				<td><input type="password" name="photoPw"></td>
			</tr>
			<tr>
				<td class="bg-light">글쓴이</td>
				<td><input type="text" name="writer"></td>
			</tr>
		</table>
		<a href="<%=request.getContextPath()%>/photo/photoList.jsp" class="btn btn-link text-info bg-light">뒤로가기</a>
		<button type="submit" class="btn btn-link text-light bg-info" > 업로드</button>
	</form>
	</div>
</body>
</html>