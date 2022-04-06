<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="vo.*" %>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.util.*" %>
<%@ page import ="dao.*" %>
<%
	request.setCharacterEncoding("utf-8");	
	//넘겨온 문자들 저장해주기
	Board board = new Board();
	board.setCategoryName(request.getParameter("categoryName"));	
	board.setBoardTitle(request.getParameter("boardTitle"));	
	board.setBoardContent(request.getParameter("boardContent"));	
	board.setBoardPw(request.getParameter("boardPw"));
	
	// 디버그 
	System.out.println("categoryName->" +board.getCategoryName());
	System.out.println("boardTitle->" +board.getBoardTitle());
	System.out.println("boardContent->" +board.getBoardContent());
	System.out.println("boardPw->" +board.getBoardPw());

	BoardDao boardDao = new BoardDao();
	boardDao.insertBoard(board);
	
	response.sendRedirect(request.getContextPath()+"/board/boardList.jsp");
%>