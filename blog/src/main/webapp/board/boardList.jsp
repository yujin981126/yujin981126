<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	
	//boardList 페이지를 실핼하면 최근 10개의 목록을 보여주고 1페이지로 설정
	int currentPage=1;
	System.out.println(currentPage+"<--currentPage");		
	if(request.getParameter("currentPage") !=null){ // 이전 다음 링크를 통해서 왔다면 
		currentPage=Integer.parseInt(request.getParameter("currentPage"));
	}
	// 페이지만 바뀌면 끝나는게 아니라 실제로 가지고오는 데이터가 변경 되어야 한다.

	int Row =10;// 보여줄 페이지 행수 
	int beginRow = (currentPage-1)*Row; // 보고 싶은 행의 갯수 
	
	// categoryName를 공백으로 처리해주고 null이 아니라면 받아온 값을 넣어준다.
	String categoryName = "";
	if(request.getParameter("categoryName")!=null){	
		categoryName = request.getParameter("categoryName");
	}
	System.out.println(request.getParameter("categoryName"));	

	BoardDao boardDao = new BoardDao();
	CategoryDao categoryDao = new CategoryDao();
	
	ArrayList<HashMap<String, Object>> categoryList = categoryDao.CategoryTotal(categoryName);
	ArrayList<Board> list= categoryDao.selectBoardCategory(beginRow,Row ,categoryName);
	
	// 전체 게시물 갯수
	int totalRow = boardDao.selectBoardTotalRow();		
	// 마지막 페이지 수
	int lastPage = boardDao.lastPageBoard(beginRow,Row,categoryName);

%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>boardList</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
	<style>
		.container{text-align:center;}
		.rightbutton{text-align:right;}
		td{text-align:left;}
	</style>
</head>
<body>
	<div class="container">
	<jsp:include page="/inc/upMenu.jsp"></jsp:include>
	<div class="text-info">
	<br>
		<h1>목록 &nbsp;<span class="badge badge-info"><%=totalRow%></span></h1>
		</div>
		<br>
		<div class="row">
			<div class="col-sm-2">
			<!-- category별 게시글 링크 메뉴 -->
			<div>
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
		</div>	
		<div class="col-sm-10">
		<!-- category별 게시글 메뉴 -->
			<table class="table text-info">
				<tr class="bg-info text-light">
					<td>categoryName</td>
					<td>boardTitle</td>
					<td>createDate</td>
				</tr>		
				<tr>
					<%for(Board b : list) {%>
							<td><%=b.getCategoryName()%></td>
							<td><a href="<%=request.getContextPath()%>/board/boardOne.jsp?boardNo=<%=b.getBoardNo()%>" class="text-info"><b><%=b.getBoardTitle()%></b></a></td>
							<td><%=b.getCreateDate()%></td></tr>
					<%}%>
			</table>
			<!-- 페이지 부분 -->
				<!-- 현재페이지가 1이면 이전페이지가 존자해서는 안된다. -->
					<%if (currentPage > 1){%>
						<a href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=currentPage-1%>&categoryName=<%=categoryName%>"class="btn btn-link text-info bg-light">이전</a>
					<%}%>
		
				<!-- 마지막 페이지라면 다음페이지가 존재해서는 안된다. -->
					<%if(currentPage < lastPage){%>
						<a href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=currentPage+1%>&categoryName=<%=categoryName%>" class="btn btn-link text-info bg-light">다음</a>
					<%}%>
					</div>
				</div>
			<div class="rightbutton">
				<a href="<%=request.getContextPath()%>/board/insertBoardFrom.jsp" class="btn btn-link text-light bg-info">게시글입력</a>
			</div>
		</div>
</body>
</html>