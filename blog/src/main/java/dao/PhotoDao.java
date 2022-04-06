package dao;
import java.sql.*;
import vo.*;
import java.util.*;
public class PhotoDao {
	public PhotoDao() {}
	
	//이미지 이름을 반환하는 메서드 
	public String selectPhotoName(int photoNo) {
		String photoName ="";
		//select photo_name from photo where photo_no =?
		return photoName;
	}
	
	public void insertPhoto(Photo photo) throws Exception {
	
		Class.forName("org.mariadb.jdbc.Driver");
		// 데이터베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		/*
		"INSERT INTO photo(photo_name,
							photo_original_name, 
							photo_type, 
							photo_pw,
							writer, 
							create_date, 
							update_date) 
		VALUES(?,?,?,?,?,NOW(),NOW())
		 */
		String sql = "INSERT INTO photo(photo_name,photo_original_name, photo_type, photo_pw,writer, create_date, update_date) VALUES(?,?,?,?,?,NOW(),NOW())";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); 
		stmt = conn.prepareStatement(sql);
		
		stmt.setString(1, photo.getPhotoName());
		stmt.setString(2, photo.getPhotoOriginalName());
		stmt.setString(3, photo.getPhotoType());
		stmt.setString(4, photo.getPhotoPw());
		stmt.setString(5, photo.getWriter());
		
		int row = stmt.executeUpdate();
		if(row == 1) {
			System.out.println("입력성공");
		} else {
			System.out.println("입력실패");
		}
		stmt.close();
		conn.close();
	}
	
	public int deletePhoto (int photoNo, String photoPw) throws Exception{ //photoNo,photoPw
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); 
		
		String sql = "DELETE FROM photo WHERE photo_no=? AND photo_pw=?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, photoNo);
		stmt.setString(2, photoPw);
		row = stmt.executeUpdate();
		
		stmt.close();
		conn.close();
		return row;
	}
	
	public int selectPhotoTotalRow() {
		int total = 0;
		return total;
	}
	
	public ArrayList<Photo> selectPhotoListByPage(int beginRow,int rowPerPage) throws Exception{
		ArrayList<Photo> list = new ArrayList<Photo>();

		Class.forName("org.mariadb.jdbc.Driver");
		// 데이터베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); 
		/*
		 select photo_no photoNo, photo_name photoName from photo order by create_date DESC limit ?,? 
		 
		 */
		String sql = "select photo_no photoNo, photo_name photoName from photo order by create_date DESC limit ?,?";
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1,beginRow);
		stmt.setInt(2,rowPerPage);
		rs = stmt.executeQuery();
		while(rs.next()) {
			Photo p = new Photo();
			p.setPhotoNo(rs.getInt("photoNo"));
			p.setPhotoName(rs.getString("photoName"));
			list.add(p);
		}
		return list;
		
	}
	public Photo selectPhotoOne(int PhotoNo) throws Exception{
		Photo photo = null;
		return photo;
	}
	
	public ArrayList<Photo> selectPhotoOneList(int photoNo) throws Exception {
		ArrayList<Photo> list = new ArrayList<Photo>();
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); 
		
		String sql = "select photo_name photoName,writer,create_date createDate,update_date updateDate from photo where photo_no=?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, photoNo);
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			Photo p = new Photo();
			p.setPhotoName(rs.getString("photoName"));
			p.setWriter(rs.getString("writer"));
			p.setCreateDate(rs.getString("createDate")); 
			p.setUpdateDate(rs.getString("updateDate")); 
			list.add(p);
		}
		stmt.close();
		conn.close();
		return list;
	}
}