<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<c:url value='resources/css/loginpage.css'/>" />
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<title>Insert title here</title>
</head>
<%
	String id = (String)session.getAttribute("id");
%>
<script type="text/javascript">
var status = "default";

function loadDelivcorpcd(upcd){
	$.ajax({
		type: 'GET',
        url: 'get_1st_categoryList.do',
        data: {
        	"upcd" : upcd,
        },
        success: function(data){
        		var temp = "";
        		for(var i=0; i<data.length; i++){
        			temp += "<option id='op"+i+"' value='"+data[i]['cdno']+"'>"+data[i]['cdname']+"</option>"
        		}
        		$('#sel_delivcorpcd').append(temp);
        }		
	});
}

$(document).ready(function(){
	loadDelivcorpcd('C0080');

	$(document).on("click", "#today_outItemList_tbody tr", function() {
		// 현재 클릭된 Row(<tr>)
		var tr = $(this);
		var td = tr.children();
	
		document.getElementById('txt_itemcd').value=td.eq(0).text();
		document.getElementById('txt_itemname').value=td.eq(1).text();
		document.getElementById('txt_madename').value=td.eq(2).text();
		document.getElementById('txt_itemunitname').value=td.eq(4).text();
		document.getElementById('txt_delivamt').value=td.eq(5).text();
		document.getElementById('txt_insuser').value=td.eq(6).text();
		document.getElementById('txt_name').value=td.eq(7).text();
		document.getElementById('txt_relname').value=td.eq(8).text();
		document.getElementById('txt_addrcd').value=td.eq(9).text();
		document.getElementById('txt_addrname').value=td.eq(10).text();
		document.getElementById('txt_mobiletelno').value=td.eq(11).text();
		document.getElementById('txt_hometelno').value=td.eq(12).text();
		document.getElementById('txt_outitemlistcd').value=td.eq(13).text();
		
		if(td.eq(14).find('input[type="checkbox"]').is(':checked')){
			document.getElementById('chk_checkyn').checked=true;
		}else{
			document.getElementById('chk_checkyn').checked=false;
		}
		
		if(td.eq(15).find('input[type="checkbox"]').is(':checked')){
			document.getElementById('chk_delivyn').checked=true;
		}else{
			document.getElementById('chk_delivyn').checked=false;
		}
		
	});
	
	$(document).on("click", "#btn_update", function() {
		status = "update";
	});
	$(document).on("click", "#btn_save", function() {
		if(status=="default" || document.getElementById('txt_itemcd').value==""){
			alert('수정할 항목을 클릭 후 수정버튼을 눌러주세요.');
			status="default";
		}else{
			var chk_checkyn = $('#chk_checkyn').is(':checked');
			var chk_delivyn = $('#chk_delivyn').is(':checked');
			if(chk_checkyn==false && chk_delivyn==true){
				alert('배송을 하기 위해 검수여부를 체크해주세요.');
			}else if(chk_delivyn==true && $("#txt_delivno").val() == ""){
				alert('송장번호를 입력해주세요.');
			}else{
				$.ajax({
					type: 'POST',
			        url: 'update_OutItemList.do',
			        data: {
			        	"insuser" : $("#loginid").val(),
			        	"checkyn" : chk_checkyn,
			        	"delivyn" : chk_delivyn,
			        	"delivcorpcd" : $("#sel_delivcorpcd option:selected").val(),
			        	"delivno" : $("#txt_delivno").val(),
			        	"outitemlistcd" : $("#txt_outitemlistcd").val(),
			        },
			        success: function(data){
			        	$.ajax({
							type: 'POST',
					        url: 'update_ItemList_ItItemList.do',
					        data: {
					        	"stockamt" : -$("#txt_delivamt").val(),
					        	"itemcd" : $("#txt_itemcd").val(),
					        },
					        success: function(data){
					        	
					        	window.location.reload();
					        }		
						});
			        }		
				});
			}
		}
	});
});
</script>
<body>
<div class="layer">
  <div class="layer_inner">
    <div class="content">
    	<h1>금일 출고 리스트</h1>
    	<table id="today_outItemList" border="1">
    		<thead>
	    		<tr>
	    			<td>상품코드</td>
	    			<td>상품명</td>
	    			<td>제조사코드</td>
	    			<td>제조사명</td>
	    			<td>단위명</td>
	    			<td>출고수량</td>
	    			<td>회원아이디</td>
	    			<td>이름</td>
	    			<td>관계</td>
	    			<td>우편번호</td>
	    			<td>주소</td>
	    			<td>휴대전화</td>
	    			<td>집전화</td>
	    			<td>검수여부</td>
	    			<td>배송여부</td>
	    		</tr>
    		</thead>
    		<tbody id="today_outItemList_tbody">
    			<c:forEach items="${outItemList}" var="outItem">
    				<tr>
    					<td>${outItem.itemcd}</td>
		    			<td>${outItem.itemname}</td>
		    			<td>${outItem.madenmcd}</td>
		    			<td>${outItem.madename}</td>
		    			<td>${outItem.itemunitname}</td>
		    			<td>${outItem.delivamt}</td>
		    			<td>${outItem.insuser}</td>
		    			<td>${outItem.delivname}</td>
		    			<td>${outItem.relcd}</td>
		    			<td>${outItem.addrcd}</td>
		    			<td>${outItem.addrname}</td>
		    			<td>${outItem.mobiletelno}</td>
		    			<td>${outItem.hometelno}</td>
		    			<td style='display:none'>${outItem.outitemlistcd}</td>
		    			<td>
		    				<c:choose>
		    					<c:when test="${outItem.checkyn=='Y'}"><input type="checkbox" id="outItem_checkyn" checked></c:when>
		    					<c:when test="${outItem.checkyn=='N'}"><input type="checkbox" id="outItem_checkyn"></c:when>
		    				</c:choose>
		    			</td>
		    			<td>
		    				<c:choose>
		    					<c:when test="${outItem.delivyn=='Y'}"><input type="checkbox" id="outItem.delivyn" checked></c:when>
		    					<c:when test="${outItem.delivyn=='N'}"><input type="checkbox" id="outItem.delivyn"></c:when>
		    				</c:choose>
		    			</td>
    				</tr>
    			 </c:forEach>
    		</tbody>
    	</table>
    	<h1>출고 확인</h1>
    	<input type="button" id="btn_update" value="수정">
    	<input type="button" id="btn_save" value="저장">
    	<table id="today_outItemList_view" border="1">
    		<tr>
    			<td>상품코드:<input type="text" id="txt_itemcd" readOnly></td>
    			<td>상품명:<input type="text" id="txt_itemname" readOnly></td>
    			<td>제조사:<input type="text" id="txt_madename" readOnly></td>
    			<td>단위:<input type="text" id="txt_itemunitname" readOnly></td>
    			<td>출고수량:<input type="text" id="txt_delivamt" readOnly></td>
    		</tr>
    		<tr>
    			<td>회원아이디:<input type="text" id="txt_insuser" readOnly></td>
    			<td>회원이름:<input type="text" id="txt_name" readOnly></td>
    			<td>관계:<input type="text" id="txt_relname" readOnly></td>
    			<td>우편번호:<input type="text" id="txt_addrcd" readOnly></td>
    			<td>주소:<input type="text" id="txt_addrname" readOnly></td>
    		</tr>
    		<tr>
    			<td>휴대전화:<input type="text" id="txt_mobiletelno" readOnly></td>
    			<td>집전화:<input type="text" id="txt_hometelno" readOnly></td>
    		</tr>
    		<tr>
    			<td>검수여부:<input type="checkbox" id="chk_checkyn"></td>
    			<td>배송여부:<input type="checkbox" id="chk_delivyn"></td>
    			<td>배송회사:<select id="sel_delivcorpcd"></select></td>
    			<td>송장번호:<input type="text" id="txt_delivno"></td>
    			<td style='display:none'><input type="text" id="txt_outitemlistcd"></td>
    		</tr>
    	</table>
    	<input type="hidden" id="loginid" value="<%=id %>">
    </div>
  </div>
</div>
</body>
</html>