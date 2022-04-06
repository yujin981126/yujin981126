<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%

	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int beginRow = 0;
	int rowPerPage = 10;
	PhotoDao photoDao = new PhotoDao();
	ArrayList<Photo>list = photoDao.selectPhotoListByPage(beginRow,rowPerPage);
	
	int lastPage = 0;
	int totalCount = photoDao.selectPhotoTotalRow();
	lastPage = (int)(Math.ceil((double)totalCount/(double)rowPerPage)); 
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>photoList</title>
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
	<br><h1>이미지 목록</h1>
	</div>
	<br>
		<table class="table text-info">
		<tr class="bg-light">	
		<%
			// 한 행의 5개 이미지 출력 tr안에 td가 5개
			// 이미지가 3개라면 ? 출력 tr 1줄  td 5개
			// 이미지가 5개라면 ? 출력 tr 1줄  td 5개
			// 이미지가 9개라면 ? 출력 tr 2줄  td 10개
			// td의 갯수가 5의 배수가 되도록  
			// 리스트 사이즈가 1~5 라면 td는 5개 
			// list size가 6~10 라면 td는 10개
			System.out.println(list.size()+"<== list.size()");
		
			int endIdx = (((list.size()-1)/5)+1)*5;//5의 배수가 되어야 함
			System.out.println(endIdx+"<== endIdx");
			
			// for(Photo p :list){ //size 만큼 반복 되므로 5의 배수 아닌 경우가 생긴다.
			for( int i = 0; i<endIdx; i++){
				if(i != 0 && i%5 == 0  ){ //5일때 5의 배수일떄 %>
					</tr><tr class="bg-light">
				<%}
				if(i<list.size()){%>
					<td>
					<a href="<%=request.getContextPath()%>/photo/photoOne.jsp?photoNo=<%=list.get(i).getPhotoNo()%>">
					<img src="<%=request.getContextPath()%>/upload/<%=list.get(i).getPhotoName()%>" width = "200" height="200">
					</a>
					</td>
					<%}else{%>
						<td>&nbsp;</td>
					<% 
				}
			}%>
		</tr>
	</table>
	<div class="right">
	<a href="<%=request.getContextPath()%>/photo/insertPhotoFrom.jsp" class="btn btn-link text-light bg-info">이미지 업로드</a>
	</div>
</div>
</body>
</html>