package com.project_ldh;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class qnaDAO {
	
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
	
	public int getBoardCount(){
		int cnt = 0;
		
		try {
			conn = getConnection();
			sql = "select count(*) from jsp.qna_ldh where re_lev=0";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				cnt = rs.getInt(1);				
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return cnt;
	}
	
	
	@SuppressWarnings("unchecked")
	public JSONArray getNoticeList(){
		JSONArray noticeList = new JSONArray();

		
		try {
			conn = getConnection();
			sql = "select * from jsp.qna_ldh order by num desc";
			pstmt = conn.prepareStatement(sql);
		
			rs = pstmt.executeQuery();
			
			while (rs.next()){
				JSONObject qb = new JSONObject();
				
				qb.put("content", rs.getString("content"));
				qb.put("date", new SimpleDateFormat("yyyy-MM-dd").format(rs.getDate("date")));
				qb.put("id", rs.getString("id"));
				qb.put("re_ref", rs.getInt("re_ref"));
				qb.put("re_lev", rs.getInt("re_lev"));
				qb.put("re_seq", rs.getInt("re_seq"));
				qb.put("ip", rs.getString("ip"));
				qb.put("num", rs.getInt("num"));
				qb.put("pw", rs.getString("pw"));
				qb.put("subject", rs.getString("subject"));
				
				noticeList.add(qb);
				
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

		
		try {
			conn = getConnection();
			sql = "select * from jsp.qna_ldh where re_lev=0 order by num desc limit ?, ?";
			pstmt = conn.prepareStatement(sql);
		
			pstmt.setInt(1, startRow-1);
			pstmt.setInt(2, pageSize);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()){
				JSONObject qb = new JSONObject();
				
				qb.put("content", rs.getString("content"));
				qb.put("date", new SimpleDateFormat("yyyy-MM-dd").format(rs.getDate("date")));
				qb.put("id", rs.getString("id"));
				qb.put("re_ref", rs.getInt("re_ref"));
				qb.put("re_lev", rs.getInt("re_lev"));
				qb.put("re_seq", rs.getInt("re_seq"));
				qb.put("ip", rs.getString("ip"));
				qb.put("num", rs.getInt("num"));
				qb.put("pw", rs.getString("pw"));
				qb.put("subject", rs.getString("subject"));
				
				noticeList.add(qb);
				
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return noticeList;
	}

	@SuppressWarnings("unchecked")
	public JSONArray getReQnaList(String re_ref){
		JSONArray noticeList = new JSONArray();

		
		try {
			conn = getConnection();
			sql = "select * from jsp.qna_ldh where re_lev !=0 and re_ref=? order by re_ref desc, re_seq asc";
			pstmt = conn.prepareStatement(sql);
		
			pstmt.setString(1, re_ref);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()){
				JSONObject qb = new JSONObject();
			
				qb.put("content", rs.getString("content"));
				qb.put("date", new SimpleDateFormat("yyyy-MM-dd").format(rs.getDate("date")));
				qb.put("id", rs.getString("id"));
				qb.put("re_ref", rs.getInt("re_ref"));
				qb.put("re_lev", rs.getInt("re_lev"));
				qb.put("re_seq", rs.getInt("re_seq"));
				qb.put("ip", rs.getString("ip"));
				qb.put("num", rs.getInt("num"));
				qb.put("pw", rs.getString("pw"));
				qb.put("subject", rs.getString("subject"));
				
				noticeList.add(qb);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return noticeList;
	}
	
	public void insertBoard(qnaBean qb){
		
		try {
			conn = getConnection();
			
			sql = "select max(num) from jsp.qna_ldh";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			int num = 1;
			
			if(rs.next()){
				num = rs.getInt(1) + 1;
			}
		
			sql = "insert into jsp.qna_ldh values(?, ?, ?, ?,"
													+ " ?, ?, ?, ?,"
													+ " now(), ?)";
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, num);
			pstmt.setString(2, qb.getId());
			pstmt.setString(3, qb.getPw());
			pstmt.setString(4, qb.getSubject());
			pstmt.setString(5, qb.getContent());
			pstmt.setInt(6, num);
			pstmt.setInt(7, qb.getRe_lev());
			pstmt.setInt(8, qb.getRe_seq());
			pstmt.setString(9, qb.getIp());
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {

			e.printStackTrace();
		} finally {
			closeDB();
		}
	}
	
	public int deleteQna(String num, String checkPw, String id){
		int result = -1;
		
		try {
			conn = getConnection();
			sql = "select pw, id from jsp.qna_ldh where num=?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				if (rs.getString(2).equals(id)){
					if (rs.getString(1).equals(checkPw)){
						
						sql = "select re_lev, re_ref from jsp.qna_ldh where num=?";
						pstmt = conn.prepareStatement(sql);
						
						pstmt.setString(1, num);
						
						rs = pstmt.executeQuery();
						
						if(rs.next()){
							
							if(rs.getInt("re_lev") == 0){
								sql = "delete from jsp.qna_ldh where re_ref=?";
								pstmt = conn.prepareStatement(sql);
								
								pstmt.setInt(1, rs.getInt("re_ref"));
								
								result = pstmt.executeUpdate();
							} else {
								sql = "delete from jsp.qna_ldh where num=?";
								pstmt = conn.prepareStatement(sql);
								
								pstmt.setString(1, num);
								
								result = pstmt.executeUpdate();
							}
						}
					} else {
						result = 0;
					}
				} else {
					result = -2;
				}
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return result;
	}
	
	public int updateContent(String num, String content){
		int result = -1;
		try {
			conn = getConnection();
			sql = "update jsp.qna_ldh set content=? where num=?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, content);
			pstmt.setString(2, num);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return result;
	}
	
	public qnaBean getQna(String num, String re_lev){
		qnaBean qb = null;
		
		try {
			conn = getConnection();
			
			sql = "select * from jsp.qna_ldh where num=? and re_lev=?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, num);
			pstmt.setString(2, re_lev);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				qb = new qnaBean();
				
				qb.setNum(rs.getInt("num"));
				qb.setSubject(rs.getString("subject"));
				qb.setContent(rs.getString("content"));
				qb.setDate(rs.getDate("date"));
				qb.setId(rs.getString("id"));
				qb.setIp(rs.getString("ip"));
				qb.setPw(rs.getString("pw"));
				qb.setRe_lev(rs.getInt("re_lev"));
				qb.setRe_ref(rs.getInt("re_ref"));
				qb.setRe_seq(rs.getInt("re_seq"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
		return qb;
	}
	
	public void insertQnaComment(qnaBean qb){
		int num = 0;		
		
		try {
			conn = getConnection();
			
			sql = "select max(num) from jsp.qna_ldh";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				num = rs.getInt(1) + 1;
			}
			
			System.out.println("답글번호 계산 완료 : " + num);
		
			sql = "update jsp.qna_ldh set re_seq = re_seq+1 "
					+ "where re_ref=? and re_seq>?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, qb.getRe_ref());
			pstmt.setInt(2, qb.getRe_seq());
			
			pstmt.executeUpdate();
			System.out.println("답글쓰기 완료");
			
			sql = "insert into jsp.qna_ldh values(?, ?, ?, ?,"
												+ " ?, ?, ?, ?,"
												+ " now(), ?)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			pstmt.setString(2, qb.getId());
			pstmt.setString(3, qb.getPw());
			pstmt.setString(4, qb.getSubject());
			pstmt.setString(5, qb.getContent());
			pstmt.setInt(6, qb.getRe_ref());	// re_ref(원글의 그룹번호 사용)
			pstmt.setInt(7, qb.getRe_lev()+1);	// re_lev + 1
			pstmt.setInt(8, qb.getRe_seq()+1); // re_seq + 1
			pstmt.setString(9, qb.getIp());
			
			pstmt.executeUpdate();
			System.out.println("답글달기 성공!");
		
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}		
	}
}
