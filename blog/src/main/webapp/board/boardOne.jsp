<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	// boardList.jsp에서 boardNo를 불러와서 저장하기
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));	
	System.out.println("boardNo -> "+ boardNo);
	
	// categoryName를 공백으로 처리해주고 null이 아니라면 받아온 값을 넣어준다.
	String categoryName = "";
	if(request.getParameter("categoryName")!=null){	
		categoryName = request.getParameter("categoryName");
	}
	System.out.println(request.getParameter("categoryName"));	
	
	CategoryDao categoryDao = new CategoryDao();
	BoardDao boardDao = new BoardDao();

	ArrayList<HashMap<String, Object>> categoryList = categoryDao.CategoryTotal(categoryName);
	ArrayList<Board> List =  boardDao.selectBoardOneList(boardNo);
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>boardOne</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
	<style>
		.container{text-align:center;}
		td,.col-sm-10{text-align:left;}
		.rightbutton{text-align:right;}
		.footer{position: relative; bottom: 0;}
	</style>
</head>
<body>
	<div class="container">
	<jsp:include page="/inc/upMenu.jsp"></jsp:include>
		<div class="text-info">
			<br><h1>상세보기</h1>
		</div>
		<br>
		<div class="row">
			<div class="col-sm-2">
			<!-- category별 게시글 링크 메뉴 -->
				<ul class="list-group">
					<li class="list-group-item bg-info text-light"><b>category</b></li>
						<% for(HashMap<String, Object> m : categoryList) {%>
					<li class="list-group-item bg-light">
						<a href="<%=request.getContextPath()%>/board/boardList.jsp?categoryName=<%=m.get("categoryName")%>" class="text-info">
						<%=m.get("categoryName")%> &nbsp; <span class="badge badge-info"><%=m.get("cnt")%></span></a>
					</li>
						<%}%>
				</ul>
			</div>
			<!-- 게시물 상세보기 -->
			<div class="col-sm-10">
				<table class="table text-info">
				<%for(Board b : List){ %>
					<tr>
						<td class="bg-light">categoryName</td><td><%=b.getCategoryName()%></td>
					</tr>
					<tr>
						<td class="bg-light">boardTitle</td><td><%=b.getBoardTitle()%></td>
					</tr>
					<tr>
						<td class="bg-light">boardContent</td><td><%=b.getBoardContent()%></td>
					</tr>
					<tr>
						<td class="bg-light">createDate </td><td><%=b.getCreateDate()%></td>
					</tr>
					<tr>
						<td class="bg-light">updateDate</td><td><%=b.getUpdateDate()%></td>
					</tr>
					<% } %>
				</table>
				<div class="rightbutton">
					<a href="<%=request.getContextPath()%>/board/boardList.jsp" class="btn btn-link text-info bg-light"> 뒤로가기</a>&nbsp;
					<a href="<%=request.getContextPath()%>/board/deleteBoardFrom.jsp?boardNo=<%=boardNo%>" class="btn btn-link text-light bg-info">삭제</a>
					<a href="<%=request.getContextPath()%>/board/updateBoardFrom.jsp?boardNo=<%=boardNo%>" class="btn btn-link text-light bg-info">수정</a>
				</div>
			</div>
		</div>
	</div>
</body>
</html>