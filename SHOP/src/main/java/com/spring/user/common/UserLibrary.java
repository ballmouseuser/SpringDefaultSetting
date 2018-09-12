package com.spring.user.common;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UserLibrary {
	
	/**
	 * 아이디와 비밀번호가 DB에 존재하지 않는 경우에만 호출하여 Alert창 발생되는 메소드
	 * @param response
	 * @throws IOException
	 */
	public void checkUserInfo(HttpServletResponse response, String msg, String url) throws IOException {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<script>alert('"+msg+"');</script>");
		out.flush();
		out.println("<script>location.href='"+url+"';</script>");
		out.flush();
	}
	
	public void encodingUTF8(HttpServletResponse response, HttpServletRequest request) throws UnsupportedEncodingException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
	}
}
