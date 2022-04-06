<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.util.*" %>
<%
   Class.forName("org.mariadb.jdbc.Driver");
   Connection conn = null;
   String dburl = "jdbc:mariadb://localhost:3306/blog";
   String dbuser = "root";
   String dbpw = "java1234";
   conn = DriverManager.getConnection(dburl, dbuser, dbpw);
   String sql = "SELECT category_name categoryName FROM category ORDER BY category_name ASC";
   PreparedStatement stmt = conn.prepareStatement(sql);
   ResultSet rs = stmt.executeQuery();
   ArrayList<String> list = new ArrayList<String>();
   
   while(rs.next()) {
      list.add(rs.getString("categoryName"));
   }
   conn.close();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>insertBoardForm</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
	<style>
		.container{text-align:center;}
		td{text-align:left;}
		.rightbutton{text-align:right;}
	</style>
</head>
<body>
	<div class="container">
	<jsp:include page="/inc/upMenu.jsp"></jsp:include><br>
	<div class="text-info"><br><h1>입력</h1></div>
	   <form method="post" action="<%=request.getContextPath()%>/board/insertBoardAction.jsp">
	      <table class="table text-info">
	      	<tr>
	            <td class="bg-light">cetegoryName</td>
	            <td>
	               <select name="categoryName" class="form-select">
	                  <%for(String s : list) { %>
	                        <option value="<%=s%>"><%=s%></option>
	                  <%}%>
	               </select>
	        </tr>
	        <tr>
				<td class="bg-light">boardTitle</td>
				<td>
					<input name="boardTitle" type="text" class="form-control">
				</td>
			</tr>
			<tr>
				<td class="bg-light">boardContent</td>
				<td>
				<textarea name="boardContent" rows="10" cols="100" class="form-control"></textarea>
				</td>
			</tr>
			<tr>
				<td class="bg-light">boardPw</td>
				<td>
				<input name="boardPw" type="password"  class="form-control">
				</td>
			</tr>
	      </table>
	   <div class="rightbutton">
		     <a href="<%=request.getContextPath()%>/board/boardList.jsp" class="btn btn-link text-info bg-light">뒤로가기</a>
		     <button type="submit" class="btn btn-link text-light bg-info">제출</button>
	     </div>
	   </form>
   </div>
</body>
</html>