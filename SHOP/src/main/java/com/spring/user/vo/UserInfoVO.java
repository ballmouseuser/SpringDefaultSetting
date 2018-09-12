package com.spring.user.vo;

import java.sql.Date;

public class UserInfoVO {
	private String id;
	private String pw;
	private String name;
	private Date insDate;
	private char useYN;
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
	public Date getInsDate() {
		return insDate;
	}
	public void setInsDate(Date insDate) {
		this.insDate = insDate;
	}
	public char getUseYN() {
		return useYN;
	}
	public void setUseYN(char useYN) {
		this.useYN = useYN;
	}
	@Override
	public String toString() {
		return "UserInfoVO [id=" + id + ", pw=" + pw + ", name=" + name + ", insDate=" + insDate + ", useYN=" + useYN
				+ "]";
	}
}
