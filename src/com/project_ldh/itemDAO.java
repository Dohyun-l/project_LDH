package com.project_ldh;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class itemDAO {

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
	
	public void insertItem(itemBean ib){
		try {
			conn = getConnection();
			
			sql = "select max(num) from jsp.item_ldh";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			int num = 1;
			
			if(rs.next()){
				num = rs.getInt(1) + 1;
			}
			
			sql = "insert into jsp.item_ldh values(?, ?, ?, ?,"
												+ " ?, ?, ?, ?,"
												+ " ?, ?)";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			pstmt.setString(2, ib.getName());
			pstmt.setInt(3, ib.getPrice());
			pstmt.setString(4, ib.getSize());
			pstmt.setInt(5, ib.getQty());
			pstmt.setInt(6, ib.getPoint());
			pstmt.setInt(7, 0);
			pstmt.setString(8, ib.getImg_name());
			pstmt.setInt(9, ib.getImg_width());
			pstmt.setInt(10, ib.getImg_height());
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
	}
	
	public int cntItem(){
		int cnt = 0;
		
		try {
			conn = getConnection();
			
			sql = "select count(*) from jsp.item_ldh";
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
	public JSONArray readItem(){
		JSONArray itemList = new JSONArray();
		JSONObject initItem = null;
		
		try {
			conn = getConnection();
			sql = "select * from jsp.item_ldh";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				
				initItem = new JSONObject();
				
				initItem.put("num", rs.getInt("num"));
				initItem.put("name", rs.getString("name"));
				initItem.put("price", rs.getInt("price"));
				initItem.put("size", rs.getString("size"));
				initItem.put("qty", rs.getInt("qty"));
				initItem.put("point", rs.getInt("point"));
				initItem.put("readcount", rs.getInt("readcount"));
				initItem.put("img_name", rs.getString("img_name"));
				initItem.put("img_width", rs.getInt("img_width"));
				initItem.put("img_height", rs.getInt("img_height"));
				
				itemList.add(initItem);
				
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return itemList;
	}
	
	@SuppressWarnings("unchecked")
	public JSONArray readItem(int startRow, int pageSize){
		JSONArray itemList = new JSONArray();
		JSONObject initItem = null;
		
		try {
			conn = getConnection();
			sql = "select * from jsp.item_ldh order by num desc limit ?, ?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, startRow-1);
			pstmt.setInt(2, pageSize);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				
				initItem = new JSONObject();
				
				initItem.put("num", rs.getInt("num"));
				initItem.put("name", rs.getString("name"));
				initItem.put("price", rs.getInt("price"));
				initItem.put("size", rs.getString("size"));
				initItem.put("qty", rs.getInt("qty"));
				initItem.put("point", rs.getInt("point"));
				initItem.put("readcount", rs.getInt("readcount"));
				initItem.put("img_name", rs.getString("img_name"));
				initItem.put("img_width", rs.getInt("img_width"));
				initItem.put("img_height", rs.getInt("img_height"));
				
				itemList.add(initItem);
				
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return itemList;
	}
	
	public itemBean readItem(String num){
		itemBean ib = null;
		try {
			conn = getConnection();
			sql = "select * from jsp.item_ldh where num=?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				ib = new itemBean();
				
				ib.setImg_height(rs.getInt("img_height"));
				ib.setImg_name(rs.getString("img_name"));
				ib.setImg_width(rs.getInt("img_width"));
				ib.setName(rs.getString("name"));
				ib.setNum(rs.getInt("num"));
				ib.setPoint(rs.getInt("point"));
				ib.setPrice(rs.getInt("price"));
				ib.setQty(rs.getInt("qty"));
				ib.setReadcount(rs.getInt("readcount"));
				ib.setSize(rs.getString("size"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return ib;
	}
	
	public void readCountUp(String num){
		try {
			conn = getConnection();
			sql = "update jsp.item_ldh set readcount = (readcount + 1) where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
	}
	
	public void updateItem(itemBean ib){
		try {
			conn = getConnection();
			sql = "update jsp.item_ldh set name=?, price=?, qty=?, point=?, img_width=?, img_height=? where num=?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, ib.getName());
			pstmt.setInt(2, ib.getPrice());
			pstmt.setInt(3, ib.getQty());
			pstmt.setInt(4, ib.getPoint());
			pstmt.setInt(5, ib.getImg_width());
			pstmt.setInt(6, ib.getImg_height());
			pstmt.setInt(7, ib.getNum());
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
	}
	
	public void deleteItem(String num){
		try {
			conn = getConnection();
			sql = "delete from jsp.item_ldh where num=?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, num);
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
	}
	
}
