<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<%
	String id = (String)session.getAttribute("id");
%>
<script type="text/javascript">
	function logout(){
		var con = confirm('접속을 종료하시겠습니까?');
		if(con==true){
			location.href='logout.do';
		}else{}
	}
</script>
<body>
<center>
	<h1>여기가 메인이닷</h1><br/>
	<h2>로그인 한 아이디 : <%=id %></h2><br/>
	<input type="button" onclick="logout();" value="logout"><br/>
	<a href="codemanager.do">코드관리</a><br/>
	<a href="itemList.do">상품관리</a><br/>
	<a href="ititemList.do">입고관리</a><br/>
	<a href="outItemList.do">출고관리</a><br/>
</center>
</body>
</html>