<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.*" %>

<%
	request.setCharacterEncoding("utf-8");	
	//넘겨온 문자들 저장해주기
	
	Guestbook guestbook = new Guestbook();
	guestbook.setGuestbookNo(Integer.parseInt(request.getParameter("guestbookNo")));
	guestbook.setGuestbookPw(request.getParameter("guestbookPw"));
	
	System.out.println(" guestbookNo -> "+  guestbook.getGuestbookNo());	
	System.out.println(" guestbookPw -> "+  guestbook.getGuestbookPw());
	
	
	GuestbookDao guestbookDao = new GuestbookDao();
	guestbookDao.deleteGuestbook(guestbook.getGuestbookNo(), guestbook.getGuestbookPw());
	
	response.sendRedirect(request.getContextPath()+"/guestBook/guestList.jsp");
%>