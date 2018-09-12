package com.spring.user.dao;

import org.apache.ibatis.annotations.Param;

public interface UserInfoDetailDAO {
	public int insertUserInfoDetail(@Param("id") String id, @Param("userinfodetailcd") String userinfodetailcd, @Param("relcd") String relcd,  @Param("addrcd") String addrcd,
			 @Param("addrname") String addrname, @Param("mobiletelno") String mobiletelno, @Param("hometelno")String hometelno, @Param("insuser") String insuser, @Param("insdate") String insdaterelcd,
			 @Param("useyn") String useyn, @Param("delivname") String delivname);
	
	public String selectUIDCD();
}
