package dao;
import java.util.*;
import vo.*;
import java.sql.*;

public class BoardDao {
	public BoardDao() {}
	
	// 전체 게시물의 갯수를 보여주는 메소드
	public int selectBoardTotalRow() throws Exception{
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		
		// 데이터베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		
		/* "select count(*) from guestbook";*/
		
		String sql = "select count(*) cnt from board";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); 
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		
		if(rs.next()) {
			row = rs.getInt("cnt");
		}
		rs.close();
		stmt.close();
		conn.close();
		return row;
	}
	
	//  마지막 페이지 수를 계산하는 메소드
	public int lastPageBoard(int beginRow, int Row,String categoryName) throws Exception{
		int lastPage = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		
		Connection conn = null;

		String dburl = "jdbc:mariadb://localhost:3306/blog"; 
		String dbuser = "root"; 
		String dbpw = "java1234"; 
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		
		String sql ="";
		PreparedStatement stmt = null;
		
		if(categoryName.equals("")){ 
			// 카테고리를 선택하지 않아 전체 행으로 페이지를 나눌때 
			sql = "select count(*) cnt from board";
			stmt = conn.prepareStatement(sql);
			
		}else{
			// 선택한 카테고리 갯수로 페이지를 나눌때
			sql = "select count(*) cnt from board where category_name =?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1,categoryName);
		}
		ResultSet totalRowRs = stmt.executeQuery();
		
		int totalRow= 0; // 선택된 카테고리 행의 갯수
		if(totalRowRs.next()){
		 	totalRow = totalRowRs.getInt("cnt");
			System.out.println(totalRow + "<--totalRow");
		}
		if(totalRow % Row == 0){ // ex) 40 나머지 4는 0
			lastPage = totalRow / Row;
		}else{ // ex) 31%4 == 1 
			lastPage = (totalRow / Row) + 1;
		}
		System.out.println(lastPage + "<--lastPage");
		
		totalRowRs.close();
		conn.close();
		return lastPage;
	}
	
	//board No에 따른 상세보기 메서드
	public ArrayList<Board> selectBoardOneList(int boardNo) throws Exception {
		ArrayList<Board> list = new ArrayList<Board>();
		
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); 
		
		String sql = "select category_name categoryName,board_title boardTitle,board_content boardContent,create_date createDate,update_date updateDate from board where board_no =?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, boardNo);
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			Board b = new Board();
			b.setCategoryName(rs.getString("categoryName"));
			b.setBoardTitle(rs.getString("boardTitle"));
			b.setBoardContent(rs.getString("boardContent"));
			b.setCreateDate(rs.getString("createDate"));
			b.setUpdateDate(rs.getString("updateDate"));
			list.add(b);
		}
		stmt.close();
		conn.close();
		return list;
	}
	
	// board를 삭제하는 메소드
	public int deleteBoard(int boardNo, String boardPw) throws Exception{
		int row= 0;
		Class.forName("org.mariadb.jdbc.Driver");
		
		// 데이터베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); 
		
		String sql = "DELETE FROM board WHERE board_no = ? AND board_pw= ?";
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, boardNo);
		stmt.setString(2, boardPw);
		System.out.println(stmt+" <-- sql deleteBoard"); 
		row = stmt.executeUpdate();
		
		stmt.close();
		conn.close();
		return row;
		
	}
	
	// board를 입력하는 메소드
	public void insertBoard(Board board) throws Exception {
		Class.forName("org.mariadb.jdbc.Driver");
		
		// 데이터베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		
		String sql = "insert into board(category_name,board_title,board_content,board_pw,create_date,update_date) value (?,?,?,?,now(),now())";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); 
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, board.getCategoryName());
		stmt.setString(2, board.getBoardTitle());
		stmt.setString(3, board.getBoardContent());
		stmt.setString(4, board.getBoardPw());
		
		int row = stmt.executeUpdate();
		if(row == 1) {
			System.out.println("입력성공");
		} else {
			System.out.println("입력실패");
		}
		stmt.close();
		conn.close();
	}
	
	//board를 수정하는 메소드
	public int updateBoard(Board board) throws Exception {
		int row = 0;
		
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); 
		
		String sql = "update board set category_name=?, board_title=?, board_content=?, update_date = NOW() WHERE board_no =?  AND board_pw=?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, board.getCategoryName());
		stmt.setString(2, board.getBoardTitle());
		stmt.setString(3, board.getBoardContent());
		stmt.setInt(4, board.getBoardNo());
		stmt.setString(5, board.getBoardPw());
		row = stmt.executeUpdate(); 
		
		System.out.println(stmt+" <-- sql updateBoard"); 
		row = stmt.executeUpdate();
		
		stmt.close();
		conn.close();
		
		return row;
	}
}

