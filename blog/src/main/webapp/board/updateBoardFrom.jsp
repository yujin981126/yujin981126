<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.util.*" %>
<%@ page import ="java.sql.*" %>
<%@ page import ="vo.*" %>
<%
	// boardList.jsp에서 boardNo를 불러와서 저장하기
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));	
	System.out.println("boardNo -> "+ boardNo);
	
	//Maria DB에 연동하기 
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	String dburl = "jdbc:mariadb://localhost:3306/blog";
	String dbuser = "root";
	String dbpw = "java1234";
	conn = DriverManager.getConnection(dburl, dbuser, dbpw);
	System.out.println(conn + " <-- conn");
	
	/*
	select category_name categoryName,board_title boardTitle,board_content boardContent,create_date createDate,update_date updateDate from board where board_no =?
	*/
	String boardNoSql =" select category_name categoryName,board_title boardTitle,board_content boardContent,create_date createDate,update_date updateDate from board where board_no =?";
	PreparedStatement boardNoStmt = conn.prepareStatement(boardNoSql);
	boardNoStmt.setInt(1, boardNo);
	ResultSet boardNoRs = boardNoStmt.executeQuery();

	
	// 묶어주기 
	Board b = null;
	if(boardNoRs.next()) {
		b = new Board();
		b.setCategoryName(boardNoRs.getString("categoryName"));
		b.setBoardTitle(boardNoRs.getString("boardTitle"));
		b.setBoardContent(boardNoRs.getString("boardContent"));
		b.setCreateDate(boardNoRs.getString("createDate"));
		b.setUpdateDate(boardNoRs.getString("updateDate"));
	}

	//category 목록
	String categorySql = "select category_name category from category";
	PreparedStatement categoryStmt = conn.prepareStatement(categorySql);
	ResultSet categoryRs = categoryStmt.executeQuery();
	ArrayList<String> categoryList = new ArrayList<String>();
	while(categoryRs.next()){
		categoryList.add(categoryRs.getString("category"));
	}
	

	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>updateBoardFrom</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
		<style>
		.container{text-align:center;}
		.rightbutton{text-align:right;}
		.textleft{text-align:left;}
	</style>
</head>
<body>
	<div class="container">
<jsp:include page="/inc/upMenu.jsp"></jsp:include><br>
	<div class="text-info">
		<br><h1>수정 </h1>
	</div>
	<br>
		<form method ="post" action="<%=request.getContextPath()%>/board/updateBoardAction.jsp" >
			<table class="table text-info textleft">
				<tr>
					<td class="bg-light">boardNo</td>
					<td><input type="text" name="boardNo" value="<%=boardNo%>" readonly="readonly" class="form-control"></td>
				</tr>
				<tr>
					<td class="bg-light">categoryName</td>
					<td>
						<select name="categoryName" class="form-control">
							<%for(String s:categoryList) {
								if(s.equals(b.getCategoryName())){%>
									<option selected ="selected" value ="<%=s%>"><%=s%></option>
								<%} else {%>
									<option value="<%=s%>"><%=s%></option>
								<%}%>
							<%}%>
						</select>
					</td>
				</tr>
				<tr>
					<td class="bg-light">boardTilte</td>
					<td><input type="text" name="boardTitle" value="<%=b.getBoardTitle()%>"class="form-control"></td>
				</tr>
				<tr>
					<td class="bg-light">boardContent</td>
					<td>
					<textarea name="boardContent" rows="10" cols="100" class="form-control"></textarea>
					</td>
				</tr>
				<tr>
					<td class="bg-light">boardPw</td>
					<td><input type="password" name="boardPw" value="" class="form-control"></td>
				</tr>
			</table>
			<div class="rightbutton">
				<a href="./boardList.jsp" class="btn btn-link text-info bg-light">뒤로가기</a>
				<button type="submit" class="btn btn-link text-light bg-info">수정</button>
			</div>
		</form>
	</div>
</body>
</html>