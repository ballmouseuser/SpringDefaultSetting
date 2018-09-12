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
    function detailcheck(){
    	if(detailForm.delivname.value=="" || detailForm.addrcd.value=="" || detailForm.addrname.value=="" || (detailForm.mobiletelno.value=="" && detailForm.hometelno.value=="")){
    		alert('빈칸이 존재합니다. 확인해주세요.');
    		return false;
    	}else{
    		return true;
    	}
    }
	
</script>
<body>
<div class="layer">
  <div class="layer_inner">
    <div class="content">
		<!-- start detail -->	
		<div id="detaillayer">
			<form name="detailForm" action="detailProc.do" method="POST" onsubmit="return detailcheck()">
				<table>
					<tr>
						<td>성명 : </td>
						<td><input type="text" name="delivname" placeholder="성명을 입력하세요."></td>
					</tr>
					<tr>
						<td>관계 : </td>
						<td>
							<select name="selectRelation" id="selectRelation">
								<c:forEach var="listCMV" items="${listCMV}">
									<option value="${listCMV.cdno}">${listCMV.cdname}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<td>우편번호 : </td>
						<td><input type="text" name="addrcd" placeholder="우편번호"></td>
					</tr>
					<tr>
						<td>주소 : </td>
						<td><input type="text" name="addrname" placeholder="주소를 입력하세요."></td>
					</tr>
					<tr>
						<td>휴대전화번호 : </td>
						<td><input type="text" name="mobiletelno" placeholder="휴대전화"></td>
					</tr>
					<tr>
						<td>집전화번호 : </td>
						<td><input type="text" name="hometelno" placeholder="집번호"></td>
					</tr>
					<tr>
						<td>사용여부 : </td>
						<td><input type="checkbox" name="useyn" checked="checked">사용</td>
					</tr>
					<tr>
						<td colspan="2" align="center">
							<input type="submit" value="저장">
							<%
								String id = (String)session.getAttribute("id");
							%>
							<input type="hidden" name="detailID" value="<%=id %>">
						</td>
					</tr>
				</table>
			</form>
		</div>
		<!-- end detail -->
  </div>
</div>
</div>
</body>
</html>