package com.spring.user.vo;

public class UserInfoDetailVO {
	private String id; // 아이디
	private String userInfoDetailCD; // 테이블 기본키
	private String relcd; // 관계번호 외래키 
	private int addrcd; // 우편번호
	private String addname; // 주소
	private String mobiletelno; // 휴대폰번호
	private String hometelno; // 집전화번호 
	private String insuser; // 기존, 신규
	private String insdate; // 가입일자
	private String useyn; // 사용유무
	private String delivname; // 이름
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getUserInfoDetailCD() {
		return userInfoDetailCD;
	}
	public void setUserInfoDetailCD(String userInfoDetailCD) {
		this.userInfoDetailCD = userInfoDetailCD;
	}
	public String getRelcd() {
		return relcd;
	}
	public void setRelcd(String relcd) {
		this.relcd = relcd;
	}
	public int getAddrcd() {
		return addrcd;
	}
	public void setAddrcd(int addrcd) {
		this.addrcd = addrcd;
	}
	public String getAddname() {
		return addname;
	}
	public void setAddname(String addname) {
		this.addname = addname;
	}
	public String getMobiletelno() {
		return mobiletelno;
	}
	public void setMobiletelno(String mobiletelno) {
		this.mobiletelno = mobiletelno;
	}
	public String getHometelno() {
		return hometelno;
	}
	public void setHometelno(String hometelno) {
		this.hometelno = hometelno;
	}
	public String getInsuser() {
		return insuser;
	}
	public void setInsuser(String insuser) {
		this.insuser = insuser;
	}
	public String getInsdate() {
		return insdate;
	}
	public void setInsdate(String insdate) {
		this.insdate = insdate;
	}
	public String getUseyn() {
		return useyn;
	}
	public void setUseyn(String useyn) {
		this.useyn = useyn;
	}
	public String getDelivname() {
		return delivname;
	}
	public void setDelivname(String delivname) {
		this.delivname = delivname;
	}
	@Override
	public String toString() {
		return "UserInfoDetail [id=" + id + ", userInfoDetailCD=" + userInfoDetailCD + ", relcd=" + relcd + ", addrcd="
				+ addrcd + ", addname=" + addname + ", mobiletelno=" + mobiletelno + ", hometelno=" + hometelno
				+ ", insuser=" + insuser + ", insdate=" + insdate + ", useyn=" + useyn + ", delivname=" + delivname
				+ "]";
	}
}
