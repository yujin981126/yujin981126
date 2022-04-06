<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="vo.*" %>
<%@ page import ="dao.*" %>
<%

	request.setCharacterEncoding("utf-8");	
	//넘겨온 문자들 저장해주기
	
	int boardNo  = Integer.parseInt(request.getParameter("boardNo"));
	String boardPw = request.getParameter("boardPw");
	System.out.println(boardNo+" boardNo-> "+boardPw+"-> boardPw");
	
	BoardDao boardDao = new BoardDao();
	boardDao.deleteBoard(boardNo, boardPw);
	
	response.sendRedirect(request.getContextPath()+"/board/boardList.jsp");
	
%>