package com.spring.user;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.user.dao.CodeMngDAO;
import com.spring.user.dao.ItItemListDAO;
import com.spring.user.dao.ItemListDAO;
import com.spring.user.dao.OutItemListDAO;
import com.spring.user.dao.UserInfoDAO;
import com.spring.user.dao.UserInfoDetailDAO;
import com.spring.user.vo.CodeMngVO;
import com.spring.user.vo.ItItemListVO;
import com.spring.user.vo.ItemListVO;
import com.spring.user.vo.OutItemListVO;
import com.spring.user.vo.UserInfoDetailVO;
import com.spring.user.common.*;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Autowired
	private SqlSession sqlSession;
	private UserInfoDAO userInfoDAO;
	private HttpSession session;
	
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate);
		
		return "home";
	}
	
	@RequestMapping(value = "/login.do", method = RequestMethod.GET)
	public String login(Model model) {
		return "login";
	}
	
	@RequestMapping(value = "/logout.do", method = RequestMethod.GET)
	public String logout(Model model, HttpServletRequest request) {
		session = request.getSession();
		if(session==null) {
			return "redirect:login.do";
		}else {
			session.invalidate();
			return "redirect:login.do";			
		}
	}
	
	@RequestMapping(value = "/join.do", method = RequestMethod.GET)
	public String join(Model model) {
		return "join";
	}
	
	@RequestMapping(value = "/main.do", method = RequestMethod.GET)
	public String main(Model model) {
		return "main";
	}
	
	@RequestMapping(value = "/loginProc.do", method = RequestMethod.POST)
	public void loginProc(Model model, HttpServletRequest request, HttpServletResponse response) throws IOException {
		userInfoDAO = sqlSession.getMapper(UserInfoDAO.class);
		
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		
		UserLibrary userLibrary = new UserLibrary();
				
		int res = userInfoDAO.login(id, password);
		
		if(res>0) {
			session = request.getSession();
			session.setAttribute("id", id);
			userLibrary.checkUserInfo(response, id+"님 환영합니다.", "main.do");
		}else {
			userLibrary.checkUserInfo(response, "아이디와 비밀번호를 확인하세요.", "login.do");
		}
	}
	
	@RequestMapping(value = "/joinProc.do", method = RequestMethod.POST)
	public void joinProc(Model model, HttpServletRequest request, HttpServletResponse response) throws IOException {		
		userInfoDAO = sqlSession.getMapper(UserInfoDAO.class);
		UserLibrary userLibrary = new UserLibrary();
		
		userLibrary.encodingUTF8(response, request);
		
		String id = request.getParameter("id");
		String pw = request.getParameter("password1");
		String name = request.getParameter("name");
		
		int res = userInfoDAO.insertUser(id, pw, name);
		
		if(res>0) {
			session = request.getSession();
			session.setAttribute("id", id);				
			userLibrary.checkUserInfo(response, "상세정보를 입력합니다.", "detail.do");
		}else {
			userLibrary.checkUserInfo(response, "로그인 정보를 확인해주세요.", "join.do");
		}
	}
	@ResponseBody
	@RequestMapping(value = "/checkId.do", method = RequestMethod.POST)
	public String checkId(Model model, HttpServletRequest request, HttpServletResponse response) {
		userInfoDAO = sqlSession.getMapper(UserInfoDAO.class);
		String id = request.getParameter("id");
		String checkId = userInfoDAO.checkid(id);
		return checkId;
	}
	
	@RequestMapping(value = "/detail.do", method = RequestMethod.GET)
	public String detail(Model model) {
		CodeMngDAO codeMngDAO = sqlSession.getMapper(CodeMngDAO.class);
		ArrayList<CodeMngVO> listCMV = codeMngDAO.getRelation();
		model.addAttribute("listCMV", listCMV);
		return "userinfodetail";
	}
	
	@RequestMapping(value = "/detailProc.do", method = RequestMethod.POST)
	public void detailProc(Model model, HttpServletRequest request, HttpServletResponse response) throws IOException {
		UserInfoDetailDAO userInfoDetailDAO = sqlSession.getMapper(UserInfoDetailDAO.class);
		
		UserLibrary userLibrary = new UserLibrary();
		userLibrary.encodingUTF8(response, request);
				
		String id = request.getParameter("detailID");
		String delivname = request.getParameter("delivname");
		String relcd = request.getParameter("selectRelation");
		String addrcd = request.getParameter("addrcd");
		String addrname = request.getParameter("addrname");
		String mobiletelno = request.getParameter("mobiletelno");
		String hometelno = request.getParameter("hometelno");
		
		String uIDCD = userInfoDetailDAO.selectUIDCD();
		int plusUIDCD = Integer.parseInt(uIDCD.substring(1))+1;
		String userinfodetailcd = String.format("%08d", plusUIDCD);
		
		String useyn = "N";
		
		if(request.getParameter("useyn")!=null) {
			useyn = "Y";			
		}
		

		int res = userInfoDetailDAO.insertUserInfoDetail(id, "U"+userinfodetailcd, relcd, addrcd, addrname, mobiletelno, hometelno, "", "", useyn, delivname);
		
		if(res>0) {
			userLibrary.checkUserInfo(response, "회원가입이 완료되었습니다.", "login.do");
		}
	}
	
	@RequestMapping(value = "/codemanager.do", method = RequestMethod.GET)
	public String code_manage(Model model) throws IOException {
		CodeMngDAO codeMngDAO = sqlSession.getMapper(CodeMngDAO.class);
		ArrayList<CodeMngVO> list = codeMngDAO.orderbyCodeMng();
		model.addAttribute("orderList", list);
		return "codemanager";
	}
	
	@RequestMapping(value = "/saveCode.do", method = RequestMethod.POST)
	public void saveCode(Model model, HttpServletRequest request, HttpServletResponse response) throws IOException {
		CodeMngDAO codeMngDAO = sqlSession.getMapper(CodeMngDAO.class);
		
		String useyn = "Y";
		if(request.getParameter("useyn").equals("false")) {
			useyn = "N";			
		}
		codeMngDAO.saveCode(request.getParameter("cdlvl"), request.getParameter("upcd"), request.getParameter("cdname"), request.getParameter("insuser"), useyn);
	}
	
	@ResponseBody
	@RequestMapping(value = "/reflashList.do", method = RequestMethod.GET)
	public ArrayList<CodeMngVO> reflashList(Model model, HttpServletRequest request, HttpServletResponse response) {
		CodeMngDAO codeMngDAO = sqlSession.getMapper(CodeMngDAO.class);
		ArrayList<CodeMngVO> list = codeMngDAO.orderbyCodeMng();
		return list;
	}
	
	@ResponseBody
	@RequestMapping(value = "/updateCode.do", method = RequestMethod.POST)
	public void updateCode(Model model, HttpServletRequest request, HttpServletResponse response) {
		CodeMngDAO codeMngDAO = sqlSession.getMapper(CodeMngDAO.class);
		String useyn = "Y";
		if(request.getParameter("useyn").equals("false")) {
			useyn = "N";			
		}
		codeMngDAO.updateCode(request.getParameter("cdlvl"), request.getParameter("upcd"), request.getParameter("cdname"), request.getParameter("insuser"), useyn, request.getParameter("cdno"));
	}
	
	@RequestMapping(value = "/itemList.do", method = RequestMethod.GET)
	public String itemList(Model model) {
		CodeMngDAO codeMngDAO = sqlSession.getMapper(CodeMngDAO.class);
		ArrayList<CodeMngVO> itemCategoryList = codeMngDAO.getItemCategory();
		ArrayList<CodeMngVO> getmakeCompany = codeMngDAO.getMakeCompany();
		ArrayList<CodeMngVO> getHowCount = codeMngDAO.getHowCount();
		model.addAttribute("itemCategoryList", itemCategoryList);
		model.addAttribute("getMakeCompany", getmakeCompany);
		model.addAttribute("getHowCount", getHowCount);
		return "itemList";
	}
	
	@ResponseBody
	@RequestMapping(value = "/get_1st_categoryList.do", method = RequestMethod.GET)
	public ArrayList<CodeMngVO> get_1st_categoryList(Model model, HttpServletRequest request, HttpServletResponse response) {
		CodeMngDAO codeMngDAO = sqlSession.getMapper(CodeMngDAO.class);
		ArrayList<CodeMngVO> get_1st_categoryList = codeMngDAO.get_1st_categoryList(request.getParameter("upcd"));
		return get_1st_categoryList;
	}
	
	@ResponseBody
	@RequestMapping(value = "/get_Category_Result.do", method = RequestMethod.GET)
	public ArrayList<ItemListVO> get_Category_Result(Model model, HttpServletRequest request, HttpServletResponse response) {
		ItemListDAO itemListDAO = sqlSession.getMapper(ItemListDAO.class);
		ArrayList<ItemListVO> get_Category_Result = itemListDAO.get_Category_Result(request.getParameter("itemclscd"));
		return get_Category_Result;
	}
	
	@ResponseBody
	@RequestMapping(value = "/insert_itemList.do", method = RequestMethod.POST)
	public void insert_itemList(Model model, HttpServletRequest request, HttpServletResponse response) {
		ItemListDAO itemListDAO = sqlSession.getMapper(ItemListDAO.class);
		String useyn = "Y";
		if(request.getParameter("useyn").equals("false")) {
			useyn = "N";			
		}
		itemListDAO.insert_itemList(request.getParameter("itemname"), request.getParameter("madenmcd"), request.getParameter("itemunitcd"), request.getParameter("insuser"), useyn, request.getParameter("itemclscd"));
	}
	
	@ResponseBody
	@RequestMapping(value = "/update_itemList.do", method = RequestMethod.POST)
	public void update_itemList(Model model, HttpServletRequest request, HttpServletResponse response) {
		ItemListDAO itemListDAO = sqlSession.getMapper(ItemListDAO.class);
		String useyn = "Y";
		if(request.getParameter("useyn").equals("false")) {
			useyn = "N";			
		}
		itemListDAO.update_itemList(request.getParameter("itemname"), request.getParameter("madenmcd"), request.getParameter("itemunitcd"), request.getParameter("insuser"), useyn, request.getParameter("itemcd"));
	}
	
	@RequestMapping(value = "/ititemList.do", method = RequestMethod.GET)
	public String ititemList(Model model) {
		CodeMngDAO codeMngDAO = sqlSession.getMapper(CodeMngDAO.class);
		ArrayList<CodeMngVO> itemCategoryList = codeMngDAO.getItemCategory();
		model.addAttribute("itemCategoryList", itemCategoryList);
		return "ititemList";
	}
	
	@ResponseBody
	@RequestMapping(value = "/insert_ititemList.do", method = RequestMethod.POST)
	public void update_ititemList(Model model, HttpServletRequest request, HttpServletResponse response) {
		ItItemListDAO itItemListDAO = sqlSession.getMapper(ItItemListDAO.class);
		itItemListDAO.insert_ItItemList(request.getParameter("itemcd"), Integer.parseInt(request.getParameter("insamt")), request.getParameter("insuser"));
	}
	
	@ResponseBody
	@RequestMapping(value = "/update_ItemList_ItItemList.do", method = RequestMethod.POST)
	public void update_ItemList_ItItemList(Model model, HttpServletRequest request, HttpServletResponse response) {
		ItemListDAO itemListDAO = sqlSession.getMapper(ItemListDAO.class);
		itemListDAO.update_ItemList_ItItemList(Integer.parseInt(request.getParameter("stockamt")), request.getParameter("itemcd"));
	}
	
	
	@RequestMapping(value = "/get_today_ItItemList.do", method = RequestMethod.GET)
	public ArrayList<ItItemListVO> get_today_ItItemList(Model model, HttpServletRequest request, HttpServletResponse response) {
		ItItemListDAO itItemListDAO = sqlSession.getMapper(ItItemListDAO.class);
		ArrayList<ItItemListVO> list = itItemListDAO.get_today_ItItemList(request.getParameter("itemclscd"));
		System.out.println("여긴옴?"+list);
		return list;
	}
	
	@ResponseBody
	@RequestMapping(value = "/update_today_ItItemList.do", method = RequestMethod.POST)
	public void update_today_ItItemList(Model model, HttpServletRequest request, HttpServletResponse response) {
		ItItemListDAO itItemListDAO = sqlSession.getMapper(ItItemListDAO.class);
		itItemListDAO.update_today_ItItemList(Integer.parseInt(request.getParameter("stockamt")), request.getParameter("insitemlistcd"));
	}
	
	
	@RequestMapping(value = "/outItemList.do", method = RequestMethod.GET)
	public String outItemList(Model model) throws IOException {
		OutItemListDAO outItemListDAO = sqlSession.getMapper(OutItemListDAO.class);
		ArrayList<OutItemListVO> list = outItemListDAO.today_OutItemList_Select();
		model.addAttribute("outItemList", list);
		return "outItemList";
	}
	
	@RequestMapping(value = "/history_Reload.do", method = RequestMethod.GET)
	public ArrayList<OutItemListVO> history_Reload(Model model) throws IOException {
		OutItemListDAO outItemListDAO = sqlSession.getMapper(OutItemListDAO.class);
		ArrayList<OutItemListVO> list = outItemListDAO.today_OutItemList_Select();
		return list;
	}
	
	@ResponseBody
	@RequestMapping(value = "/update_OutItemList.do", method = RequestMethod.POST)
	public void update_OutItemList(Model model, HttpServletRequest request, HttpServletResponse response) {
		OutItemListDAO outItemListDAO = sqlSession.getMapper(OutItemListDAO.class);
		String checkyn = request.getParameter("checkyn");
		String delivyn = request.getParameter("delivyn");
		String delivcorpcd = request.getParameter("delivcorpcd");
		String delivno = request.getParameter("delivno");
		String outitemlistcd = request.getParameter("outitemlistcd");
		String insuser = request.getParameter("insuser");
		System.out.println(insuser);
		System.out.println(outitemlistcd);
		
		if(checkyn.equals("true") && delivyn.equals("true")) {
				outItemListDAO.today_OutItemList_update(insuser, "Y", "Y", delivcorpcd, delivno, outitemlistcd);
		}else {
				outItemListDAO.today_OutItemList_update(insuser, "Y", "N", "", "", outitemlistcd);
		}

	}
}
