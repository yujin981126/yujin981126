<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.*" %>

<%
	request.setCharacterEncoding("utf-8");	
	//넘겨온 문자들 저장해주기
	
	Guestbook guestbook = new Guestbook();
	guestbook.setWriter(request.getParameter("writer"));
	guestbook.setGuestbookPw(request.getParameter("guestbookPw"));
	guestbook.setGuestbookContent(request.getParameter("guestbookContent"));
	
	GuestbookDao guestbookDao = new GuestbookDao();
	guestbookDao.insertGuestbook(guestbook);
	
	response.sendRedirect(request.getContextPath()+"/guestBook/guestList.jsp");
%>