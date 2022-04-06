package dao;

import java.sql.*;
import java.util.*;

import vo.Board;

public class CategoryDao {
	public CategoryDao(){}
	
	
	// 카테고리과 카테고리 별 갯수를 알려주는 메소드 
	public ArrayList<HashMap<String, Object>> CategoryTotal(String categoryName) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>(); // 객체에 저장한 정보를 ArrayList형식으로 저장할 변수 선언
		
		Class.forName("org.mariadb.jdbc.Driver");
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog"; 
		String dbuser = "root"; 
		String dbpw = "java1234"; 
		
		String sql = "SELECT category_name categoryName, COUNT(*) cnt FROM board GROUP BY category_name";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		stmt = conn.prepareStatement(sql); 
		rs = stmt.executeQuery(); 
		// 데이터베이스 로직 끝

		// 데이터 변환(가공)
		while(rs.next()) { 
			HashMap<String, Object> map = new HashMap<String, Object>(); 
			map.put("cnt", rs.getInt("cnt"));
			map.put("categoryName", rs.getString("categoryName"));
			list.add(map); 
		}
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
	}
	
	// 카테고리에 따라 분류해주는 메소드
	public ArrayList<Board> selectBoardCategory(int beginRow, int Row ,String categoryName) throws Exception{
			ArrayList<Board> list = new ArrayList<Board>();
			
			Class.forName("org.mariadb.jdbc.Driver");
			
			Connection conn = null;

			String dburl = "jdbc:mariadb://localhost:3306/blog"; 
			String dbuser = "root"; 
			String dbpw = "java1234"; 
			conn = DriverManager.getConnection(dburl, dbuser, dbpw);
			
			String sql = ""; 
			PreparedStatement stmt = null;
			
			if(categoryName.equals("")){ 
				//카테고리가 ""일때  보드
				sql = "SELECT board_no boardNo,category_name categoryName, board_title boardTitle, create_date createDate FROM board ORDER BY create_date DESC LIMIT ?,?";
				stmt = conn.prepareStatement(sql);
				stmt.setInt(1,beginRow);
				stmt.setInt(2,Row);
				
			}else{
				//카테고리를 선택하였을때 보드
				sql = "SELECT board_no boardNo,category_name categoryName, board_title boardTitle, create_date createDate FROM board WHERE category_name=? ORDER BY create_date DESC LIMIT ?,?";
				stmt = conn.prepareStatement(sql);
				stmt.setString(1,categoryName);
				stmt.setInt(2,beginRow);
				stmt.setInt(3,Row);
			}
			ResultSet boardRs = stmt.executeQuery();
			
			while(boardRs.next()) {
				Board b = new Board(); 
				b.setBoardNo(boardRs.getInt("boardNo"));
				b.setCategoryName(boardRs.getString("categoryName"));
				b.setBoardTitle(boardRs.getString("boardTitle"));
				b.setCreateDate(boardRs.getString("createDate")); 
				list.add(b);
			}
			stmt.close();
			conn.close();
			return list;
		}
}
