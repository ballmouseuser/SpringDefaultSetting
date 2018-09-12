package com.spring.user.dao;

import java.util.ArrayList;

import com.spring.user.vo.ItemListVO;

public interface ItemListDAO {
	public ArrayList<ItemListVO> get_Category_Result(String itemclscd); 
	
	public int insert_itemList(String itemname, String madenmcd, String itemunitcd, String insuser, String useyn, String itemclscd);
	
	public int update_itemList(String itemname, String madenmcd, String itemunitcd, String insuser, String useyn, String itemcd);
	
	public int update_ItemList_ItItemList(int stockamt, String itemcd);
}
