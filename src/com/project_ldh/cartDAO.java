package com.project_ldh;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class cartDAO {
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
	
	public void insertCart(cartBean cb){
		try {
			conn = getConnection();
			sql = "select max(num) from jsp.cart_ldh";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			int num = 1;
			if(rs.next()){
				num = rs.getInt(1) + 1;
			}
			
			sql = "insert into jsp.cart_ldh values(?, ?, ?, ?, now())";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			pstmt.setString(2, cb.getId());
			pstmt.setInt(3, cb.getItemnum());
			pstmt.setInt(4, cb.getEa());
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
	}
	
	public JSONArray getCartList(String id){
		JSONArray cartList = new JSONArray();
		JSONObject initCart = null;
		
		try {
			conn = getConnection();
			sql = "select c.num, c.cartdate, sum(c.ea), c.itemnum, i.name, i.price, i.size, i.img_name "
					+ "from jsp.cart_ldh c join jsp.item_ldh i "
					+ "on c.itemnum = i.num "
					+ "where c.id =? "
					+ "group by c.itemnum";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				initCart = new JSONObject();
				
				initCart.put("cartNum", rs.getInt("num"));
				initCart.put("cartDate", rs.getString("cartdate"));
				initCart.put("cartQty", rs.getInt("sum(c.ea)"));
				initCart.put("cartItemNum", rs.getInt("itemnum"));
				initCart.put("cartName", rs.getString("name"));
				initCart.put("cartPrice", rs.getInt("price"));
				initCart.put("cartSize", rs.getString("size"));
				initCart.put("cartImg_name", rs.getString("img_name"));
				
				cartList.add(initCart);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return cartList;
	}
	
	
}
