package com.project_ldh;

public class itemBean {
	
	private int num;
	private String name;
	private int price;
	private String size;
	private int qty;
	private int point;
	private int readcount;
	private String img_name;
	private int img_width;
	private int img_height;
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getSize() {
		return size;
	}
	public void setSize(String size) {
		this.size = size;
	}
	public int getQty() {
		return qty;
	}
	public void setQty(int qty) {
		this.qty = qty;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	public int getReadcount() {
		return readcount;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}
	public String getImg_name() {
		return img_name;
	}
	public void setImg_name(String img_name) {
		this.img_name = img_name;
	}
	public int getImg_width() {
		return img_width;
	}
	public void setImg_width(int img_width) {
		this.img_width = img_width;
	}
	public int getImg_height() {
		return img_height;
	}
	public void setImg_height(int img_height) {
		this.img_height = img_height;
	}
	@Override
	public String toString() {
		return "itemBean [num=" + num + ", name=" + name + ", price=" + price + ", size=" + size + ", qty=" + qty
				+ ", point=" + point + ", readcount=" + readcount + ", img_name=" + img_name + ", img_width="
				+ img_width + ", img_height=" + img_height + "]";
	}
	
	
}
