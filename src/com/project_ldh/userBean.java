package com.project_ldh;

import java.sql.Date;

public class userBean {

	private int num;
	private String id;
	private String pw;
	private String name;
	private String tel;
	private String birth;
	private int gender;
	private String email;
	private String addr;
	private Date cdate;
	private String rec;
	private int point;
	private int su;
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
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public int getGender() {
		return gender;
	}
	public void setGender(int gender) {
		this.gender = gender;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public Date getCdate() {
		return cdate;
	}
	public void setCdate(Date cdate) {
		this.cdate = cdate;
	}
	public String getRec() {
		return rec;
	}
	public void setRec(String rec) {
		this.rec = rec;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	public int getSu() {
		return su;
	}
	public void setSu(int su) {
		this.su = su;
	}
	
	@Override
	public String toString() {
		return "userBean [num=" + num + ", id=" + id + ", pw=" + pw + ", name=" + name + ", tel=" + tel + ", birth="
				+ birth + ", gender=" + gender + ", email=" + email + ", addr=" + addr + ", cdate=" + cdate + ", rec="
				+ rec + ", point=" + point + ", su=" + su + "]";
	}

	
}
