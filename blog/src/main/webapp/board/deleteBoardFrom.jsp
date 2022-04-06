<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>deleteStudentForm</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
		<style>
		.container{text-align:center;}
		.rightbutton{text-align:right;}
		.textleft{text-align:left;}
	</style>
</head>
<body>
	<div class="container">
	<jsp:include page="/inc/upMenu.jsp"></jsp:include><br>
	<div class="text-info">
		<br><h1>삭제</h1>
	</div>
	<br>
		<form method="post" action="<%=request.getContextPath()%>/board/deleteBoardAction.jsp">
		<table class="table text-info textleft">
			<tr>
				<td class="bg-light ">boardNo</td>
				<td><input type="text" name="boardNo" value="<%=boardNo%>" readonly="readonly" class="form-control"></td>
			</tr>
			<tr>
				<td class="bg-light">boardPw</td>
				<td><input type="password" name="boardPw" class="form-control"></td>
			</tr>
		</table>
			<div class="rightbutton">
				<a href="<%=request.getContextPath()%>/board/boardList.jsp" class="btn btn-link text-info bg-light">뒤로가기</a>
				<button type="submit" class="btn btn-link text-light bg-info">삭제</button>
			</div>
		</form>
	</div>
</body>
</html>