<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.*" %>
 <%
	int guestbookNo = Integer.parseInt(request.getParameter("guestbookNo"));	
	System.out.println(" guestbookNo -> "+  guestbookNo);
 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateGuestbookFrom</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<style>
	.container{text-align:center;}
	td{text-align:left;}
	.rightbutton{text-align:right;}
</style>
</head>
<body>
	<div class="container">
	<br>
	<div class="text-info">
		<h1>방명록 수정</h1>
	</div>
		<br>
		<form method="post" action="<%=request.getContextPath()%>/guestBook/updateGuestbookAction.jsp">
		<table class="table text-info">
			<tr class="bg-light">
				<td>guestBookNo</td>
				<td><input type="text" name="guestbookNo" value="<%=guestbookNo%>"readonly="readonly" class="form-control"></td>
				<td>비밀번호</td>
				<td><input type="password" name="guestbookPw" class="form-control"></td>
			</tr>
			<tr>
				<td colspan="4" class="bg-light">
					<textarea  rows="3" cols="100" name="guestbookContent" class="form-control" ></textarea>
				</td>
			</tr>
		</table>
		<div class="rightbutton">
			<a href="<%=request.getContextPath()%>/guestBook/guestList.jsp" class="btn btn-link text-info bg-light">뒤로가기</a>&nbsp;
			<button type="submit" class="btn btn-link text-light bg-info">수정</button>
		</div>
		</form>
	</div>
</body>
</html>