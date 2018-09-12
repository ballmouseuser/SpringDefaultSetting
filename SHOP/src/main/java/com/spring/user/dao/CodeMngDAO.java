package com.spring.user.dao;

import java.util.ArrayList;

import com.spring.user.vo.CodeMngVO;

public interface CodeMngDAO {
	public ArrayList<CodeMngVO> getRelation();
	
	public ArrayList<CodeMngVO> orderbyCodeMng();
	
	public int saveCode(String cdlvl, String upcd, String cdname, String insuser, String useyn);
	
	public int updateCode(String cdlvl, String upcd, String cdname, String insuser, String useyn, String cdno);
	
	public ArrayList<CodeMngVO> getItemCategory();
	
	public ArrayList<CodeMngVO> getMakeCompany();
	
	public ArrayList<CodeMngVO> getHowCount();
	
	public ArrayList<CodeMngVO> get_1st_categoryList(String upcd);
}
