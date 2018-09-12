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
$(document).ready(function(){
	var select_insitemlistcd = "";
	
	var identifi = "save"; // 버튼 구분 변수
	var tem;
	
    $("#categoryList").on("change", function(){ // 카테고리 변경시 서브카테고리 값 리로드
    	var upcd = $(this).val();
        console.log(upcd);
        
        $.ajax({
    		type: 'GET',
    		url: 'get_1st_categoryList.do',
    		dataType: "json",
    		data: {
    			"upcd" : upcd,
    		},
            success: function(data){
            	$('#1st_categoryList').empty();
            	var temp = "";
            	var idcnt = 0;
            	for(var i=0;i<data.length;i++){
            		temp += "<option id='p"+idcnt+"' value='"+data[i]['cdno']+"'>"+data[i]['cdname']+"</option>";
            		idcnt++;
            	}
            	$('#1st_categoryList').append(temp);
            }
    	 });
    });
	
	function today_itemList_func(){
		var code = $("#1st_categoryList option:selected").val();
		$('#today_result_view').empty();
		$.ajax({
    		type: 'GET',
    		url: 'get_today_ItItemList.do',
    		dataType: "json",
    		data: {
    			"itemclscd" : code,
    		},
            success: function(data){
            	var temp = "";
            	var idcnt = 0;
            	for(var i=0;i<data.length;i++){
            		temp += "<tr id='to"+idcnt+"'>";
            		temp += "<td>"+data[i]['itemcd']+"</td><td>"+data[i]['itemname']+"</td><td>"+data[i]['madenmcd']+"</td><td>"+data[i]['madename']+"</td>";
            		temp += "<td>"+data[i]['itemunitcd']+"</td><td>"+data[i]['itemunitname']+"</td><td>"+data[i]['insamt']+"</td>";
            		temp += "<td style='display:none'>"+data[i]['insitemlistcd']+"</td>";            		
            		temp += "</tr>";
            		idcnt++;
            	}
            	
            	$('#today_result_view').append(temp);
            }
    	 });		
	}
    
	
    function reload(){
    	var code = $("#1st_categoryList option:selected").val();
    	
    	$('#item_result_view').empty();
    	
    	$.ajax({
    		type: 'GET',
    		url: 'get_Category_Result.do',
    		dataType: "json",
    		data: {
    			"itemclscd" : code,
    		},
            success: function(data){
            	var temp = "";
            	var idcnt = 0;
            	for(var i=0;i<data.length;i++){
            		temp += "<tr id='r"+idcnt+"'>";
            		temp += "<td>"+data[i]['itemcd']+"</td><td>"+data[i]['itemname']+"</td><td>"+data[i]['madenmcd']+"</td><td>"+data[i]['madename']+"</td>";
            		temp += "<td>"+data[i]['itemunitcd']+"</td><td>"+data[i]['itemunitname']+"</td><td>"+data[i]['stockamt']+"</td>";
            		if(data[i]['stockyn']=='Y'){
            			temp += "<td><input type='checkbox' id='ch_stockyn' name='ch_stockyn' checked></td>"
            		}else{
            			temp += "<td><input type='checkbox' id='ch_stockyn' name='ch_stockyn'></td>"
            		}
            		
            		if(data[i]['useyn']=='Y'){
            			temp += "<td><input type='checkbox' id='ch_useyn' name='ch_useyn' checked></td>"
            		}else{
            			temp += "<td><input type='checkbox' id='ch_useyn' name='ch_useyn'></td>"
            		}
            		temp += "</tr>";
            		idcnt++;
            	}
            	
            	$('#item_result_view').append(temp);
            }
    	 });
    }
    
    $("#selectbtn").click(function(){
    	console.log($("#1st_categoryList option:selected").val());
    	var code = $("#1st_categoryList option:selected").val();
    	$('#item_result_view').empty();
    	
    	if($("#categoryList option:selected").val()=="none"){
    		alert('카테고리를 모두 선택해주세요.');
    	}else{
    		$.ajax({
        		type: 'GET',
        		url: 'get_Category_Result.do',
        		dataType: "json",
        		data: {
        			"itemclscd" : code,
        		},
                success: function(data){
                	var temp = "";
                	var idcnt = 0;
                	for(var i=0;i<data.length;i++){                		
                		temp += "<tr id='r"+idcnt+"'>";
                		temp += "<td>"+data[i]['itemcd']+"</td><td>"+data[i]['itemname']+"</td><td>"+data[i]['madenmcd']+"</td><td>"+data[i]['madename']+"</td>";
                		temp += "<td>"+data[i]['itemunitcd']+"</td><td>"+data[i]['itemunitname']+"</td><td>"+data[i]['stockamt']+"</td>";
                		if(data[i]['stockyn']=='Y'){
                			temp += "<td><input type='checkbox' id='ch_stockyn' name='ch_stockyn' checked></td>"
                		}else{
                			temp += "<td><input type='checkbox' id='ch_stockyn' name='ch_stockyn'></td>"
                		}
                		
                		if(data[i]['useyn']=='Y'){
                			temp += "<td><input type='checkbox' id='ch_useyn' name='ch_useyn' checked></td>"
                		}else{
                			temp += "<td><input type='checkbox' id='ch_useyn' name='ch_useyn'></td>"
                		}
                		temp += "</tr>";
                		idcnt++;
                	}
                	
                	$('#item_result_view').append(temp);
                	
                	today_itemList_func();

                }
        	 });
    	}
    });
    
    $(document).on("click", "#item_result_view tr", function() {
    		// 현재 클릭된 Row(<tr>)
    		var tr = $(this);
    		var td = tr.children();

    		document.getElementById('itemcd').value=td.eq(0).text();
    		document.getElementById('itemname').value=td.eq(1).text();
    		document.getElementById('madename').value=td.eq(3).text();
    		document.getElementById('itemunitname').value=td.eq(5).text();
    		document.getElementById('stockamt').value="";
	});
    
    $(document).on("click", "#today_result_view tr", function() {
		// 현재 클릭된 Row(<tr>)
		var tr = $(this);
		var td = tr.children();

		document.getElementById('itemcd').value=td.eq(0).text();
		document.getElementById('itemname').value=td.eq(1).text();
		document.getElementById('madename').value=td.eq(3).text();
		document.getElementById('itemunitname').value=td.eq(5).text();
		document.getElementById('stockamt').value=td.eq(6).text();
		document.getElementById('insitemlistcd').value=td.eq(7).text();
		tem = td.eq(6).text();

	});
    
    $(document).on("click", "#svbtn", function() {
    	if(document.getElementById('stockamt').value=="" || document.getElementById('stockamt').value=="0"){
    		alert('수량을 확인해주세요.');
    	}else{
    		if(identifi=="save"){
    			$.ajax({
	        		type: 'POST',
	        		url: 'insert_ititemList.do',
	        		data: {
	        			"itemcd": $('#itemcd').val(),
	        			"insamt": $('#stockamt').val(),
	        			"insuser": $('#loginid').val(),
	        		},
	                success: function(data){
	                	$.ajax({
	    	        		type: 'POST',
	    	        		url: 'update_ItemList_ItItemList.do',
	    	        		data: {
	    	        			"stockamt": $('#stockamt').val(),
	    	        			"itemcd": $('#itemcd').val(),
	    	        		},
	    	                success: function(data){
	    	                	reload();
	    	                	today_itemList_func();
	    	                }
	    	        	 });
	                }
	        	 });
    			}else{
    				$.ajax({
    	        		type: 'POST',
    	        		url: 'update_today_ItItemList.do',
    	        		data: {
    	        			"stockamt": $('#stockamt').val(),
    	        			"insitemlistcd": $('#insitemlistcd').val(),
    	        		},
    	                success: function(data){
    	                	if(tem == $('#insitemlistcd').val()){
    	                		alert('입고수량을 다시 확인해주세요.')
    	                	}else{
    	                		$.ajax({
    		    	        		type: 'POST',
    		    	        		url: 'update_ItemList_ItItemList.do',
    		    	        		data: {
    		    	        			"stockamt": $('#stockamt').val()-tem,
    		    	        			"itemcd": $('#itemcd').val(),
    		    	        		},
    		    	                success: function(data){
    		    	                	reload();
    		    	                	today_itemList_func();
    		    	                }
    		    	        	 });
    	                	}
    	                }
    	        	});
    			}
    		}
    	});
    
    $(document).on("click", "#upbtn", function() {
    	identifi = "update";
	});
});
</script>
<body>
<div class="layer">
  <div class="layer_inner">
    <div class="content">
    	<h1>전체 리스트</h1>
    	<div id="categoryList_Div"> <!-- 상품관리목록이 들어갈 div -->
    		<select id="categoryList" name="categoryList">
    		<option value="none">선택</option>
    			<c:forEach items="${itemCategoryList}" var="category">
    				<option value="${category.cdno}">${category.cdname}</option>
    			</c:forEach>
    		</select>
    		<select id="1st_categoryList" name="1st_categoryList">
    		
    		</select>
    		<input type="button" id="selectbtn" name="selectbtn" value="조회"><br>
    	</div>
    	<div>
    		<table border="2"  id="item_table">
    			<thead>
	    			<tr>
	    				<td>상품코드</td>
	    				<td>상품명</td>
	    				<td>제조사코드</td>
	    				<td>제조사명</td>
	    				<td>단위코드</td>
	    				<td>단위명</td>
	    				<td>재고수량</td>
	    				<td>재고여부</td>
	    				<td>사용여부</td>
	    			</tr>
	    		</thead>
	    		<tbody id="item_result_view">
	    		
	    		</tbody>
    		</table>
    	</div>
    	
    	<div>
    		<h1>금일 입고리스트</h1>
    		<table border="2" id="today_itemList">
    			<thead>
    				<tr>
    					<td>상품코드</td>
    					<td>상품명</td>
    					<td>제조사코드</td>
    					<td>제조사명</td>
    					<td>단위코드</td>
    					<td>단위명</td>
    					<td>입고수량</td>
    				</tr>
    			</thead>
    			<tbody id="today_result_view">
    			
    			</tbody>
    		</table>
    	</div>
    	
    	<div id="input_item"><!-- 데이터 입력 및 수정 테이블 -->
    	<h1>입고내용</h1>
    		<table id="itemInput" border="2">
    			<tr>
    				<td>상품코드:<input type="text" name="itemcd" id="itemcd" readOnly></td>
    			</tr>
    			<tr>
    				<td>상품명:<input type="text" name="itemname" id="itemname" readOnly></td>
    			</tr>
    			<tr>
    				<td>제조사:<input type="text" name="madename" id="madename" readOnly></td>
    			</tr>
    			<tr>
    				<td>단위명:<input type="text" name="itemunitname" id="itemunitname" readOnly></td>
    			</tr>
    			<tr>
    				<td>입고수량:<input type="text" name="stockamt" id="stockamt"></td>
    			</tr>
    			<tr style="display:none">
    				<td><input type="hidden" name="insitemlistcd" id="insitemlistcd" value=""></td>
    			</tr>
    			<tr>
    				<td>
    					<input type="hidden" name="loginid" id="loginid" value="<%=id%>">
						<input type="button" name="updateCode" id="upbtn" value="수정">
						<input	type="button" name="saveCode" id="svbtn" value="저장">
    				</td>
    			</tr>
    		</table>
    	</div>
    </div>
  </div>
</div>
</body>
</html>