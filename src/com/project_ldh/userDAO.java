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

public class userDAO {

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

	// udao.insertUser(ub);
	public int insertUser(userBean ub) {
		int rec = 0;

		try {
			conn = getConnection();

			// sql = "select max(num) from jsp.user_ldh";
			sql = "select max(num) from jsp.user_ldh";
			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();

			int num = 1;

			if (rs.next()) {
				num = rs.getInt(1) + 1;
			}

			sql = "insert into jsp.user_ldh values(?, ?, ?, ?, ?, ?, ?, ?, ?, now(), ?, 0, 0)";
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, num);
			pstmt.setString(2, ub.getId());
			pstmt.setString(3, ub.getPw());
			pstmt.setString(4, ub.getName());
			pstmt.setString(5, ub.getTel());
			pstmt.setString(6, ub.getBirth());
			pstmt.setInt(7, ub.getGender());
			pstmt.setString(8, ub.getEmail());
			pstmt.setString(9, ub.getAddr());
			pstmt.setString(10, ub.getRec());

			if (ub.getRec() != null) {
				rec = 1;
			}

			pstmt.executeUpdate();
			System.out.println("회원가입 성공!");

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}

		return rec;
	}

	// udao.insertUser(ub);

	public void recPoint(String rec, int up){
		try {
			conn = getConnection();
			sql = "select point from jsp.user_ldh where id=?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, rec);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				int pointState = rs.getInt(1) + up;
				
				sql = "update jsp.user_ldh set point=? where id=?";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setInt(1, pointState);
				pstmt.setString(2, rec);
				
				pstmt.executeUpdate();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
	}
	
	
	
	
	public int idCheck(String id) {

		int result = 1;
		try {
			conn = getConnection();
			sql = "select * from jsp.user_ldh where id=?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, id);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				result = 1;
			} else {
				result = 0;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return result;
	}

	public int emailCheck(String email) {
		int result = 1;
		try {
			conn = getConnection();
			sql = "select * from jsp.user_ldh where email=?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, email);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				result = 1;
			} else {
				result = 0;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return result;
	}

	public int login(userBean ub) {
		int result = -1;
		try {
			conn = getConnection();
			sql = "select pw from jsp.user_ldh where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, ub.getId());
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				if(rs.getString(1).equals(ub.getPw())){
					result = 1;
				} else {
					result = 0;
				}
			} else {
				result = -1;
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
		return result;
	}
	
	public int pointPnt(String id){
		int point = 0;
		
		try {
			System.out.println(id);
			conn = getConnection();
			sql = "select point from jsp.user_ldh where id=?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				point = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
		return point;
	}
	
	public userBean readInfo(String id){
		userBean ub = null;
		
		try {
			conn = getConnection();
			sql = "select * from jsp.user_ldh where id=?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				
				ub = new userBean();
				
				ub.setAddr(rs.getString("addr"));
				ub.setBirth(rs.getString("birth"));
				ub.setCdate(rs.getDate("cdate"));
				ub.setEmail(rs.getString("email"));
				ub.setGender(rs.getInt("gender"));
				ub.setId(rs.getString("id"));
				ub.setName(rs.getString("name"));
				ub.setNum(rs.getInt("num"));
				ub.setPoint(rs.getInt("point"));
				ub.setPw(rs.getString("pw"));
				ub.setRec(rs.getString("rec"));
				ub.setSu(rs.getInt("su"));
				ub.setTel(rs.getString("tel"));
		
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
		return ub;
	}
	
	public int updateUser(userBean ub){
		int result = -1;
		try {
			conn = getConnection();		
			sql = "select pw from jsp.user_ldh where id=?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, ub.getId());
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				if(ub.getPw().equals(rs.getString(1))){
					sql = "update jsp.user_ldh set tel=?, email=?, addr=?, gender=? where id=?";
					pstmt = conn.prepareStatement(sql);
					
					pstmt.setString(1, ub.getTel());
					pstmt.setString(2, ub.getEmail());
					pstmt.setString(3, ub.getAddr());
					pstmt.setInt(4, ub.getGender());
					pstmt.setString(5, ub.getId());
					
					pstmt.executeUpdate();
					
					System.out.println("업데이트 완료");
					
					result = 1;
				} else {
					result = -1;
				}
			} else {
				result = 0;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return result;
	}
	
	public int deleteUser(String id, String pw){
		int result = -1;
		try {
			conn = getConnection();
			sql = "select pw from jsp.user_ldh where id=?";
			pstmt = conn.prepareStatement(sql);
		
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				if(rs.getString(1).equals(pw)){
					sql = "delete from jsp.user_ldh where id=?";
					pstmt = conn.prepareStatement(sql);
					
					pstmt.setString(1, id);
					
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
	
	public int suUser(String id) {
		int su = 0;
		
		try {
			conn = getConnection();		
			sql = "select su from jsp.user_ldh where id=?";
			pstmt = conn.prepareStatement(sql);
		
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				su = rs.getInt(1);
			}
		
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
		return su;
	}

	public JSONArray readAllUser(){
		JSONArray userList = new JSONArray();
		JSONObject initUser = null;
		
		try {
			conn = getConnection();
			sql = "select * from jsp.user_ldh";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				initUser = new JSONObject();
				
				initUser.put("num", rs.getInt("num"));
				initUser.put("id", rs.getString("id"));
				initUser.put("pw", rs.getString("pw"));
				initUser.put("name", rs.getString("name"));
				initUser.put("tel", rs.getString("tel"));
				initUser.put("birth", rs.getString("birth"));
				initUser.put("gender", rs.getInt("gender"));
				initUser.put("email", rs.getString("email"));
				initUser.put("addr", rs.getString("addr"));
				initUser.put("cdate", rs.getString("cdate"));
				initUser.put("rec", rs.getString("rec"));
				initUser.put("point", rs.getInt("point"));
				initUser.put("su", rs.getInt("su"));
				
				userList.add(initUser);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return userList;
	}
	
}
