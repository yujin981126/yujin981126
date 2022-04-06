<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="vo.*" %>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.util.*" %>
<%@ page import ="dao.*" %>
<%
	request.setCharacterEncoding("utf-8");	

	Board board = new Board();
	board.setBoardNo(Integer.parseInt(request.getParameter("boardNo")));
	board.setCategoryName(request.getParameter("categoryName"));	
	board.setBoardTitle(request.getParameter("boardTitle"));	
	board.setBoardContent(request.getParameter("boardContent"));	
	board.setBoardPw(request.getParameter("boardPw"));
	
	// 디버그 
	System.out.println("boardNo->" +board.getBoardNo());
	System.out.println("categoryName->" +board.getCategoryName());
	System.out.println("boardTitle->" +board.getBoardTitle());
	System.out.println("boardContent->" +board.getBoardContent());
	System.out.println("boardPw->" +board.getBoardPw());

	BoardDao boardDao = new BoardDao();
	boardDao.updateBoard(board);
	
	// 리스트 페이지로 이동 
	response.sendRedirect(request.getContextPath()+"/board/boardList.jsp");
%>