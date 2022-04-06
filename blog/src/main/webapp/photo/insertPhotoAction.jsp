<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import = "com.oreilly.servlet.MultipartRequest" %>
<%@ page import = "java.io.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	/*
	request.getParameter()대신 다른 api를 사용해야하는데 복잡
	cos.jar 같은 외부라이브러리 (API) 를 사용하자
	*/
	request.setCharacterEncoding("utf-8");
	// 동일한 이름이 존재 할때 이름을 바꿔준다.
	// 자동으로 파일이 받아진다.
	String path = application.getRealPath("upload"); //application변수 톰겟을 가르키는 변수
	DefaultFileRenamePolicy rp = new DefaultFileRenamePolicy();
	MultipartRequest multiReq = new MultipartRequest(request,path,1024*1024*100,"utf-8",rp);
	
	
	// request 대신 multiReq
	String writer = multiReq.getParameter("writer");
	String photoPw = multiReq.getParameter("photoPw");
	
	// 이미지 <input type="file" name="photo">
	String photoOriginalName = multiReq.getOriginalFileName("photo"); 
	String photoName = multiReq.getFilesystemName("photo"); // new DefaultFileRenamePolicy()객체를 통해 변경된 이름
	String photoType = multiReq.getContentType("photo");
	
	// 디버깅
	System.out.println("writer-->"+writer);
	System.out.println("photoPw-->"+ photoPw);
	System.out.println("photoOriginalName-->"+ photoOriginalName);
	System.out.println("photoName-->"+ photoName);
	System.out.println("photoType-->"+ photoType);
	
	// 파일 엊로드의 경우 100메가 이하의 image/gif image/png image/jpeg 3가지 이미지 허용 
	if(photoType.equals("image/gif")|| photoType.equals("image/png")||photoType.equals("image/jpeg")){
		//db에 저장
		System.out.println("이미지 확인");
		Photo photo = new Photo();
		photo.setPhotoName(photoName);
		photo.setPhotoOriginalName(photoOriginalName);
		photo.setPhotoType(photoType);
		photo.setPhotoPw(photoPw);
		photo.setWriter(writer) ;
		
		PhotoDao photoDao = new PhotoDao();
		photoDao.insertPhoto(photo);
		response.sendRedirect(request.getContextPath()+"/photo/photoList.jsp");
		
	}else{
		//업로드 취소
		File file =new File(path + "\\" + photoName); // java.io.file잘못된 파일을 불러온다.
		file.delete();;
		response.sendRedirect(request.getContextPath()+"/photo/insertPhotoFrom.jsp");
	}

%>