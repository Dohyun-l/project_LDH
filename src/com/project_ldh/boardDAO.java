package com.project_ldh;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class boardDAO {
	
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private String sql = "";

	private Connection getConnection() {
		try {
			Context initCTX = new InitialContext();

			DataSource ds = (DataSource) initCTX.lookup("java:comp/env/jdbc/jsp");

			conn = ds.getConnection();
			System.out.println("드라이버로드, 디비연결 성공!");
			System.out.println(conn);

		} catch (NamingException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return conn;
	}

	public void closeDB() {
		try {
			if (rs != null)
				rs.close();
			if (pstmt != null)
				pstmt.close();
			if (conn != null)
				conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void insertBoard(boardBean bb){
		
		try {
			conn = getConnection();
			
			sql = "select max(num) from jsp.notice_ldh";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			int num = 1;
			
			if(rs.next()){
				num = rs.getInt(1) + 1;
			}
		
			sql = "insert into jsp.notice_ldh values(?, ?, ?, ?,"
													+ " ?, ?,"
													+ " now(), ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, num);
			pstmt.setString(2, bb.getId());
			pstmt.setString(3, bb.getPw());
			pstmt.setString(4, bb.getSubject());
			pstmt.setString(5, bb.getContent());
			pstmt.setInt(6, bb.getReadcount());

			pstmt.setString(7, bb.getIp());
			pstmt.setString(8, bb.getFile());
			pstmt.setInt(9, bb.getImportant());
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {

			e.printStackTrace();
		} finally {
			closeDB();
		}
	}
	
	@SuppressWarnings("unchecked")
	public JSONArray getNoticeList(){
		JSONArray noticeList = new JSONArray();
		
		// boardBean bb = null;
		
		try {
			conn = getConnection();
			sql = "select * from jsp.notice_ldh order by num desc";
			pstmt = conn.prepareStatement(sql);
		
			rs = pstmt.executeQuery();
			
			while (rs.next()){
				JSONObject bb = new JSONObject();
				
				bb.put("content", rs.getString("content"));
				bb.put("date", new SimpleDateFormat("yyyy-MM-dd").format(rs.getDate("date")));
				bb.put("file", rs.getString("file"));
				bb.put("id", rs.getString("id"));
				bb.put("important", rs.getInt("important"));
				bb.put("ip", rs.getString("ip"));
				bb.put("num", rs.getInt("num"));
				bb.put("pw", rs.getString("pw"));
				bb.put("readcount", rs.getInt("readcount"));
				bb.put("subject", rs.getString("subject"));
				
				noticeList.add(bb);
				
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return noticeList;
	}
	
	@SuppressWarnings("unchecked")
	public JSONArray getNoticeList(int startRow, int pageSize){
		JSONArray noticeList = new JSONArray();
		
		// boardBean bb = null;
		
		try {
			conn = getConnection();
			sql = "select * from jsp.notice_ldh order by important desc, num desc limit ?, ?";
			pstmt = conn.prepareStatement(sql);
		
			pstmt.setInt(1, startRow-1);
			pstmt.setInt(2, pageSize);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()){
				JSONObject bb = new JSONObject();
				
				bb.put("content", rs.getString("content"));
				bb.put("date", new SimpleDateFormat("yyyy-MM-dd").format(rs.getDate("date")));
				bb.put("file", rs.getString("file"));
				bb.put("id", rs.getString("id"));
				bb.put("important", rs.getInt("important"));
				bb.put("ip", rs.getString("ip"));
				bb.put("num", rs.getInt("num"));
				bb.put("pw", rs.getString("pw"));
				bb.put("readcount", rs.getInt("readcount"));
				bb.put("subject", rs.getString("subject"));
				
				noticeList.add(bb);
				
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return noticeList;
	}
	
	public boardBean readNotice(String num) {
		boardBean bb = null;
		
		try {
			conn = getConnection();
			sql = "select * from jsp.notice_ldh where num=?";
			pstmt = conn.prepareStatement(sql);
		
			pstmt.setString(1, num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				bb = new boardBean();
				
				bb.setContent(rs.getString("content"));
				bb.setDate(rs.getDate("date"));
				bb.setFile(rs.getString("file"));
				bb.setId(rs.getString("id"));
				bb.setImportant(rs.getInt("important"));
				bb.setIp(rs.getString("ip"));
				bb.setNum(rs.getInt("num"));
				bb.setPw(rs.getString("pw"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setSubject(rs.getString("subject"));
				
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
		return bb;
		
	}
	
	public int getBoardCount(){
		int boardCount = 0;
		
		try {
			conn = getConnection();
		
			sql = "select count(*) from jsp.notice_ldh";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				boardCount = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
		return boardCount;
	}
	
	public int updateBoard(boardBean bb) {
		int result = -1;
		
		try {
			conn = getConnection();
		
			sql = "select pw from jsp.notice_ldh where num=?";
			pstmt = conn.prepareStatement(sql);
		
			pstmt.setInt(1, bb.getNum());
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				if(rs.getString(1).equals(bb.getPw())){
					sql = "update jsp.notice_ldh set subject=?, content=?, important=?, file=? where num=?";
					pstmt = conn.prepareStatement(sql);
					
					pstmt.setString(1, bb.getSubject());
					pstmt.setString(2, bb.getContent());
					pstmt.setInt(3, bb.getImportant());
					pstmt.setString(4, bb.getFile());
					pstmt.setInt(5, bb.getNum());
					
					result = pstmt.executeUpdate();
					
				} else {
					result = 0;
				}
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return result;
	}
	
	public void readCnt(String num){
		
		try {
			int cnt = 0;
			
			conn = getConnection();
			sql = "select readcount from jsp.notice_ldh where num=?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				cnt = rs.getInt(1) + 1;
				
				sql = "update jsp.notice_ldh set readcount=? where num=?";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setInt(1, cnt);
				pstmt.setString(2, num);
				
				pstmt.executeUpdate();
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
	}
	
	public int deleteNotice(String num, String pw){
		int result = -1;
		
		try {
			conn = getConnection();
			sql = "select pw from jsp.notice_ldh where num=?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				if(rs.getString(1).equals(pw)){
					sql = "delete from jsp.notice_ldh where num=?";
					pstmt = conn.prepareStatement(sql);
					
					pstmt.setString(1, num);
					
					result = pstmt.executeUpdate();
				} else {
					result = 0;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
		return result;
	}
	
}
