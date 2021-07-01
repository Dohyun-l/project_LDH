package com.project_ldh;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class talkDAO {
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
	
	public int createTalk(talkDTO tdto){
		int result = -1;
		int idx = 0;
		
		try {
			conn = getConnection();
			sql = "select * from talk where title=?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, tdto.getTitle());
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = 0;
			} else {
				sql = "select count(*) from talk";
				pstmt = conn.prepareStatement(sql);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					idx = rs.getInt(1) + 1;
				}
				
				sql = "insert into talk values(?,?,?,?)";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setInt(1, idx);
				pstmt.setString(2, tdto.getMaster());
				pstmt.setString(3, tdto.getTitle());
				pstmt.setString(4, tdto.getFilename());
				
				result = pstmt.executeUpdate();
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return result;
	}
	
	public List getTalkList(){
		List talkList = new ArrayList();
		
		try {
			conn = getConnection();
			sql = "select * from talk order by idx desc";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				talkDTO tdto = new talkDTO();
				
				tdto.setIdx(rs.getInt("idx"));
				tdto.setMaster(rs.getString("master"));
				tdto.setTitle(rs.getString("title"));
				tdto.setFilename(rs.getString("filename"));
				
				talkList.add(tdto);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return talkList;
	}
	
	public talkDTO getTalkInfo(int idx) {
		talkDTO tdto = null;
		
		try {
			conn = getConnection();
			sql = "select * from talk where idx=?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, idx);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				tdto = new talkDTO();
				
				tdto.setIdx(rs.getInt("idx"));
				tdto.setMaster(rs.getString("master"));
				tdto.setTitle(rs.getString("title"));
				tdto.setFilename(rs.getString("filename"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return tdto;
	}
}
