<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<c:url value='resources/css/loginpage.css'/>" />
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="http://rawgit.com/vitmalina/w2ui/master/dist/w2ui.min.js"></script>
<link rel="stylesheet" type="text/css" href="http://rawgit.com/vitmalina/w2ui/master/dist/w2ui.min.css" />
<title>Insert title here</title>
</head>
<%
	String id = (String)session.getAttribute("id");
%>
<script type="text/javascript">
$(document).ready(function(){
	var identifi = ""; // 버튼 구분 변수
	
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
    
    function reload(){
    	var code = $("#1st_categoryList option:selected").val();
    	
    	$('#view_result').empty();
    	
    	/* $.ajax({
    		type: 'GET',
    		url: 'get_Category_Result.do',
    		dataType: "json",
    		data: {
    			"itemclscd" : code,
    		},
            success: function(data){ */
                /* var temp = "";
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
            	
            	$('#view_result').append(temp);
            }
    	 }); */
    }
    
    $("#selectbtn").click(function(){
    	console.log($("#1st_categoryList option:selected").val());
    	var code = $("#1st_categoryList option:selected").val();
    	$('#view_result').empty();
    	
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
                	
                	$('#view_result').append(temp);
                }
        	 });
    	}
    });
    
    $(document).on("click", "#view_result tr", function() {
    		// 현재 클릭된 Row(<tr>)
    		tr = $(this);
    		td = tr.children();

    		document.getElementById('itemcd').value=td.eq(0).text();
    		document.getElementById('itemname').value=td.eq(1).text();
	});
    
    $(document).on("click", "#addbtn", function() {
    	document.getElementById('itemcd').value="";
		document.getElementById('itemname').value="";
		
		identifi = "add";
	});
    
    $(document).on("click", "#svbtn", function() {
    	if(document.getElementById('itemname').value==""){
    		alert('공백이 존재합니다. 확인해주세요.');
    	}else{
    		if(identifi=="add"){
	    		var code = $("#1st_categoryList option:selected").val();
	    		var checkuseyn = "false";
				if(document.getElementById('useyn').checked==true){
					var checkuseyn = "true";
				}
	    		$.ajax({
	        		type: 'POST',
	        		url: 'insert_itemList.do',
	        		data: {
	        			"itemname": $('#itemname').val(),
	        			"madenmcd": $('#getMakeCompany').val(),
	        			"itemunitcd": $('#getHowCount').val(),
	        			"insuser": $('#loginid').val(),
	        			"useyn" : checkuseyn,
	        			"itemclscd": code,
	        			
	        		},
	                success: function(data){
	                	reload();
	                }
	        	 });
    		}else{
    			var checkuseyn = "false";
				if(document.getElementById('useyn').checked==true){
					var checkuseyn = "true";
				}
    			$.ajax({
	        		type: 'POST',
	        		url: 'update_itemList.do',
	        		data: {
	        			"itemname": $('#itemname').val(),
	        			"madenmcd": $('#getMakeCompany').val(),
	        			"itemunitcd": $('#getHowCount').val(),
	        			"insuser": $('#loginid').val(),
	        			"useyn" : checkuseyn,
	        			"itemcd": $('#itemcd').val(),
	        		},
	                success: function(data){
	                	reload();
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
    		<table border="2"  id="view_table">
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
	    		<tbody id="view_result">
	    			
	    		</tbody>
    		</table>
    	</div>
    	<div id="result_Item_Div"><!-- 데이터 입력 및 수정 테이블 -->
    		<table id="itemInput" border="2">
    			<tr>
    				<td>상품코드:<input type="text" name="itemcd" id="itemcd" readOnly></td>
    			</tr>
    			<tr>
    				<td>상품명:<input type="text" name="itemname" id="itemname"></td>
    			</tr>
    			<tr>
    				<td>
    				제조사: 
    				<select id="getMakeCompany" name="getMakeCompany">
    					<c:forEach items="${getMakeCompany}" var="getMakeCompany">
    						<option value="${getMakeCompany.cdno}">${getMakeCompany.cdname}</option>
    					</c:forEach>
    				</select>
    				단위명:
    				<select id="getHowCount" name="getHowCount">
    					<c:forEach items="${getHowCount}" var="getHowCount">
    						<option value="${getHowCount.cdno}">${getHowCount.cdname}</option>
    					</c:forEach>
    				</select>
    				</td>
    			</tr>
    			<tr>
    				<td>사용여부:<input type="checkbox" name="useyn" id="useyn" checked></td>
    			</tr>
    			<tr>
    				<td>
    					<input type="hidden" name="loginid" id="loginid" value="<%=id%>">
					    <input type="button" name="addCode" id="addbtn" value="추가">
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