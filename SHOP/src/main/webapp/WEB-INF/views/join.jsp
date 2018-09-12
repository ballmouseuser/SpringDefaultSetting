<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<c:url value='resources/css/loginpage.css'/>" />
<script type="text/javascript" src="http://code.jquery.com/jquery-3.2.0.min.js" ></script>
<title>Insert title here</title>
</head>
<script type="text/javascript">
	function check() {
		console.log('id = '+joinForm.id.value+ ' pw1 = '+ joinForm.password1.value + ' pw2 = '+ joinForm.password2.value + ' name = ' + joinForm.name.value );
		if(joinForm.id.value=="" || joinForm.password1.value=="" || joinForm.password2.value=="" || joinForm.name.value==""){
			alert('빈칸이 존재합니다. 확인해주세요.');
			return false;
		}else{
			var pw = joinForm.password1.value;
	        var pwck = joinForm.password2.value;
			if(pw != pwck){
				alert('비밀번호가 다릅니다. 확인해주세요.');
				joinForm.password1.value = "";
				joinForm.password2.value = "";
				return false;				
			}else{
				var pw = joinForm.password1.value;
				if(pw.length>=5 && pw.length<=10){
					/* document.getElementById('joinlayer').style.display="none";
					document.getElementById('detaillayer').style.display="block"; */
				 	return true;
				}else{
					alert('비밀번호는 5~10 자리만 입력해주세요.');
					joinForm.password1.value = "";
					joinForm.password2.value = "";
					return false;
				}
			}
		}
	}
	
	$(document).ready(function(){
        $('#checkid').on('click', function(){
            $.ajax({
                type: 'POST',
                url: 'checkId.do',
                data: {
                    "id" : $('#id').val()
                },
                success: function(data){
                    if($.trim(data) != joinForm.id.value){
                    	var button_joinus = document.getElementById('joinbtn');
                    	button_joinus.disabled = false;
                    	alert('사용 가능한 아이디 입니다.');
                    }else if($.trim(data) == ''){
                    	alert('아이디 입력란이 비어있습니다..');
                    }else{
                    	alert('사용이 불가능한 아이디 입니다.');
                    }
                }
            });    //end ajax    
        });    //end on    
    });

</script>
<body>
<div class="layer">
  <div class="layer_inner">
    <div class="content">
    	
    	<!-- start join -->
    	<div id="joinlayer">
		    <h1>회원가입</h1>
				<form name="joinForm" action="joinProc.do" method="POST" onsubmit="return check()">
					<table>
						<tr>
							<td>아이디 : </td>
							<td><input type="text" name="id" id="id"><td>
							<td><input type="button" id="checkid" value="중복확인"></td>
						</tr>
						<tr>
							<td>비밀번호입력 : </td>
							<td><input type="password" name="password1"><td>
						</tr>
						<tr>
							<td>비밀번호확인 : </td>
							<td><input type="password" name="password2"><td>
						</tr>
						<tr>
							<td>이름 : </td>
							<td><input type="text" name="name"><td>
						</tr>
						<tr>
							<td colspan="2" align="center">
								<input type="submit" id="joinbtn" value="회원가입" disabled>&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="button" value="돌아가기" onclick="location='login.do'">
							</td>
						</tr>
					</table>
				</form>
		</div>
		<!-- end join -->
		
	  </div>
	</div>
</div>
</body>
</html>