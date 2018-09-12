package com.spring.user.dao;

import java.util.ArrayList;

import com.spring.user.vo.ItItemListVO;

public interface ItItemListDAO {
	public int insert_ItItemList(String itemcd, int insamt, String insuser);
	
	public ArrayList<ItItemListVO> get_today_ItItemList(String cdno);
	
	public int update_today_ItItemList(int insamt, String insitemlistcd);
}
