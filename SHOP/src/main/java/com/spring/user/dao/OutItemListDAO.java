package com.spring.user.dao;

import java.util.ArrayList;

import com.spring.user.vo.OutItemListVO;

public interface OutItemListDAO {
	public ArrayList<OutItemListVO> today_OutItemList_Select();
	
	public int today_OutItemList_update(String checkuser, String checkyn, String delivyn, String delivcorpcd, String delivno, String outitemlistcd);
}
