package com.spring.user.dao;

import org.apache.ibatis.annotations.Param;

public interface UserInfoDAO {
	/* 로그인 */
	public int login(String id, String pw);
	/*회원가입*/
	public int insertUser(@Param("id") String id, @Param("pw")String pw, @Param("name")String name);
	/*아이디중복검사*/
	public String checkid(String id);
}
