package com.project_ldh;

import java.sql.Timestamp;

public class cartBean {

	private int num;
	private String id;
	private int itemnum;
	private int ea;
	private Timestamp cartdate;
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getItemnum() {
		return itemnum;
	}
	public void setItemnum(int itemnum) {
		this.itemnum = itemnum;
	}
	public int getEa() {
		return ea;
	}
	public void setEa(int ea) {
		this.ea = ea;
	}
	public Timestamp getCartdate() {
		return cartdate;
	}
	public void setCartdate(Timestamp cartdate) {
		this.cartdate = cartdate;
	}
	
	@Override
	public String toString() {
		return "cartBean [num=" + num + ", id=" + id + ", itemnum=" + itemnum + ", ea=" + ea + ", cartdate=" + cartdate
				+ "]";
	}
}
