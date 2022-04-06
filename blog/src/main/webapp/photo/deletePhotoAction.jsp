<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "dao.*"%>
<%@ page import="java.io.*" %>
<%	
	// 1) 테이블 데이터 삭제 <- photoNo 
	// 2) upload 폴더에 이미지 삭제 < - photoName 

	int photoNo = Integer.parseInt(request.getParameter("photoNo"));
	String photoPw = request.getParameter("photoPw");
	
	PhotoDao photoDao = new PhotoDao();
	String photoName = photoDao.selectPhotoName(photoNo);
	
	
	//1)테이블 데이터 삭제
	int delRow = photoDao.deletePhoto(photoNo,photoPw);
		
	//2) 폴더 이미지 삭제 
	if(delRow == 1){
		String path = application.getRealPath("upload"); // application(현재 프로젝트)안에 upload 폴더의 실제 폴더 경로
		File file =new File(path + "\\" + photoName); // java.io.file잘못된 파일을 불러온다.
		file.delete();;
		
	}else{
		System.out.println("삭제 실패");
	}
	
	response.sendRedirect(request.getContextPath()+"/photo/photoList.jsp");
%>