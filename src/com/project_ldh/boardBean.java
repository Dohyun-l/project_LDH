package com.project_ldh;

import java.sql.Date;

public class boardBean {

	private int num;
	private String id;
	private String pw;
	private String subject;
	private String content;
	private int readcount;
	private Date date;
	private String ip;
	private String file;
	private int important;
	
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
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getReadcount() {
		return readcount;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public String getFile() {
		return file;
	}
	public void setFile(String file) {
		this.file = file;
	}
	public int getImportant() {
		return important;
	}
	public void setImportant(int important) {
		this.important = important;
	}
	@Override
	public String toString() {
		return "boardBean [num=" + num + ", id=" + id + ", pw=" + pw + ", subject=" + subject + ", content=" + content
				+ ", readcount=" + readcount + ", date=" + date + ", ip=" + ip + ", file=" + file + ", important="
				+ important + "]";
	}
	
}
