package com.spring.user.vo;

public class ItItemListVO {
	private String itemcd;
	private String insitemlistcd;
	private int insamt;
	private String insdate;
	private String insuser;
	
	private String itemname;
	private String madenmcd;
	private String madename;
	private String itemunitcd;
	private String itemunitname;
	public String getItemcd() {
		return itemcd;
	}
	public void setItemcd(String itemcd) {
		this.itemcd = itemcd;
	}
	public String getInsitemlistcd() {
		return insitemlistcd;
	}
	public void setInsitemlistcd(String insitemlistcd) {
		this.insitemlistcd = insitemlistcd;
	}
	public int getInsamt() {
		return insamt;
	}
	public void setInsamt(int insamt) {
		this.insamt = insamt;
	}
	public String getInsdate() {
		return insdate;
	}
	public void setInsdate(String insdate) {
		this.insdate = insdate;
	}
	public String getInsuser() {
		return insuser;
	}
	public void setInsuser(String insuser) {
		this.insuser = insuser;
	}
	public String getItemname() {
		return itemname;
	}
	public void setItemname(String itemname) {
		this.itemname = itemname;
	}
	public String getMadenmcd() {
		return madenmcd;
	}
	public void setMadenmcd(String madenmcd) {
		this.madenmcd = madenmcd;
	}
	public String getMadename() {
		return madename;
	}
	public void setMadename(String madename) {
		this.madename = madename;
	}
	public String getItemunitcd() {
		return itemunitcd;
	}
	public void setItemunitcd(String itemunitcd) {
		this.itemunitcd = itemunitcd;
	}
	public String getItemunitname() {
		return itemunitname;
	}
	public void setItemunitname(String itemunitname) {
		this.itemunitname = itemunitname;
	}
	@Override
	public String toString() {
		return "ItItemListVO [itemcd=" + itemcd + ", insitemlistcd=" + insitemlistcd + ", insamt=" + insamt
				+ ", insdate=" + insdate + ", insuser=" + insuser + ", itemname=" + itemname + ", madenmcd=" + madenmcd
				+ ", madename=" + madename + ", itemunitcd=" + itemunitcd + ", itemunitname=" + itemunitname + "]";
	}
}
