<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.*" %>
<%
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 3;
	int beginRow = (currentPage-1)*rowPerPage;
	GuestbookDao guestbookDao = new GuestbookDao();
	ArrayList<Guestbook> list = guestbookDao.selectGuestbookListByPage(beginRow, rowPerPage);
	
	int lastPage = 0;
	int totalCount = guestbookDao.selectGuestbookTotalRow();
	lastPage = (int)(Math.ceil((double)totalCount/(double)rowPerPage)); 
	// 5.0/2.0= 2.5 
	// 5.0/2.0 =3.0
	// 4.0/2.0 =2.0

	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>guestList</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
	<style>
		.container{text-align:center;}
		td{text-align:left;}
		.right{text-align:right;}
		.footer{position: absolute; bottom: 0;}
	</style>
</head>
<body>
<div class="container">
	<jsp:include page="/inc/upMenu.jsp"></jsp:include>
	<div class="text-info">
	<br><h1>방명록</h1>
	</div>
	<br>
	<!-- 입력 테이블 -->
	<form method="post" action="<%=request.getContextPath()%>/guestBook/insertGuestbookAction.jsp">
		<table class="table text-info">
			<tr class="bg-light text-info" >
				<td >글쓴이</td>
				<td><input type="text" name="writer" class="form-control"></td>
				<td>비밀번호</td>
				<td><input type="password" name="guestbookPw" class="form-control"></td>
				<td>
				<div class="right">
				<button type="submit" class="btn btn-link text-light bg-info">등록</button>
				</div>
				</td>
			</tr>
			<tr>
				<td colspan="5" >
					<textarea rows="3" cols="50" name="guestbookContent" class="form-control"></textarea>
				</td>
			</tr>
		</table>
	</form>
	<!-- 방명록 보여주는 테이블 -->
	<table class="table text-info">
		<% for(Guestbook g : list) {%>
			<tr>
				<td class="bg-light"><%=g.getWriter()%></td>
				<td class="bg-light right"><%=g.getCreateDate()%></td>
			</tr>
			<tr>
				<td>┕> <%=g.getGuestbookContent()%></td>
				<td class="right"> 
					<a href="<%=request.getContextPath()%>/guestBook/updateGuestbookFrom.jsp?guestbookNo=<%=g.getGuestbookNo()%>" class="btn btn-link text-light bg-info">수정</a> 
					<a href="<%=request.getContextPath()%>/guestBook/deleteGuestbookFrom.jsp?guestbookNo=<%=g.getGuestbookNo()%>" class="btn btn-link text-light bg-info">삭제</a> 
				</td>
			</tr>
		<%}%>
	</table>
	<!--  1보다 클때 이전 -->
	<%if(currentPage>1) {%>
	<a href="<%=request.getContextPath()%>/guestBook/guestList.jsp?currentPage=<%=currentPage-1%>" class="btn btn-link text-light bg-info">이전</a>
	<%} %>
	
	<!--  마지막 페이지 보다 작을때 이전 -->
	<%if(currentPage < lastPage) {%>
	<a href="<%=request.getContextPath()%>/guestBook/guestList.jsp?currentPage=<%=currentPage+1%>" class="btn btn-link text-light bg-info">다음</a>
	<%} %> 
</div>

</body>
</html>