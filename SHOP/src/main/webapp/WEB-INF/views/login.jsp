<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<c:url value='resources/css/loginpage.css'/>" />
<title>Insert title here</title>
</head>
<script type="text/javascript">
	function check() {
		console.log('id = ' + loginForm.id.value + ' password = ' + loginForm.password.value);
		if(loginForm.id.value=="" || loginForm.password.value==""){
			alert('아이디를 입력하세요.');
			return false;
		}else{
			return true;
		}
	}
</script>
<body>
<script>
</script>
<div class="layer">
  <div class="layer_inner">
    <div class="content">
		<form name="loginForm" action="loginProc.do" method="POST" onsubmit="return check()">
			<table>
				<tr>
					<td>아이디 : </td>
					<td><input type="text" name="id"><td>
				</tr>
				<tr>
					<td>비밀번호 : </td>
					<td><input type="password" name="password"><td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="submit" value="로그인">&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="button" value="회원가입" onclick="location='join.do'">
					</td>
				</tr>
			</table>
		</form>   	
    </div>
  </div>
</div>
</body>
</html>