package com.project_ldh;

public class talkDTO {

	private int idx;
	private String master;
	private String title;
	private String filename;
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getMaster() {
		return master;
	}
	public void setMaster(String master) {
		this.master = master;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	@Override
	public String toString() {
		return "talkDTO [idx=" + idx + ", master=" + master + ", title=" + title + ", filename=" + filename + "]";
	}
}
