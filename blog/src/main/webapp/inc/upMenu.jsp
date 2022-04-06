<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<style>
	.nav{
		width:100%;
	}
</style>
<div class="btn-group nav">
		<a href="<%=request.getContextPath()%>/index.jsp" class="btn btn-info">Home</a>
		<a href="<%=request.getContextPath()%>/board/boardList.jsp" class="btn btn-info">게시판</a>
		<a href="<%=request.getContextPath()%>/guestBook/guestList.jsp" class="btn btn-info">방명록</a>
		<a href="<%=request.getContextPath()%>/photo/photoList.jsp" class="btn btn-info">갤러리</a>
		<a href="<%=request.getContextPath()%>" class="btn btn-info">PDF자료실</a>
</div>

