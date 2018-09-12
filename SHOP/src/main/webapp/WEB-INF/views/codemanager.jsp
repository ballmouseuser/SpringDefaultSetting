<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css"
	href="<c:url value='resources/css/loginpage.css'/>" />
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>

<script type="text/javascript">

var identifi = "";
var tr = "";
var td = "";

function clear(){
	document.getElementById('cdno').value=""; document.getElementById('cdlvl').value="";
	document.getElementById('upcd').value=""; document.getElementById('cdname').value="";
	document.getElementById('cdlvl').readOnly=true; document.getElementById('upcd').readOnly=true; document.getElementById('cdname').readOnly=true;
	
	var addbtn = document.getElementById('addbtn'); addbtn.disabled = false;
	var upbtn = document.getElementById('upbtn'); upbtn.disabled = false;
	var svbtn = document.getElementById('svbtn');	svbtn.disabled = 'disabled';
	
	document.getElementById('useyn').checked=false;
}



function addCode(){
	document.getElementById('cdlvl').readOnly=false; document.getElementById('upcd').readOnly=false; document.getElementById('cdname').readOnly=false;
	
	document.getElementById('cdno').value=""; document.getElementById('cdlvl').value="";
	document.getElementById('upcd').value=""; document.getElementById('cdname').value="";
	
	var upbtn = document.getElementById('upbtn'); upbtn.disabled = 'disabled';
	var svbtn = document.getElementById('svbtn');	svbtn.disabled = false;
	
	identifi = "add";
}
/**
 * 저장버튼이 활성화가 된 상태에서 클릭시 추가인지 수정인지 구분, 추가인 경우 데이터 삽입 후 페이지 리로딩, 수정인경우 데이터 수정 후 해당 데이터만 다시 가져옴
 */
function saveCode(){
	if(document.getElementById('cdlvl').value=="" || document.getElementById('upcd').value=="" || document.getElementById('cdname').value==""){
		alert('빈칸이 존재합니다. 확인해주세요.');
	}else{
		if(identifi == 'add'){	
			var checkuseyn = "false";
			if(document.getElementById('useyn').checked==true){
				var checkuseyn = "true";
			}

			 $.ajax({
	             type: 'POST',
	             url: 'saveCode.do',
	             data: {
	                 "cdlvl" : $('#cdlvl').val(),
	                 "upcd" : $('#upcd').val(),
	                 "cdname" : $('#cdname').val(),
	                 "insuser" : $('#loginid').val(),
	                 "useyn" : checkuseyn
	             },
	             success: function(data){
	            	 /* document.getElementById('cdno').value=""; document.getElementById('cdno').readOnly=true;
	            	 document.getElementById('cdlvl').value=""; document.getElementById('cdlvl').readOnly=true;
	            	 document.getElementById('upcd').value=""; document.getElementById('upcd').readOnly=true;
	            	 document.getElementById('cdname').value=""; document.getElementById('cdname').readOnly=true;
	            	 document.getElementById('useyn').checked=true; */
	            	 
	            	 clear();
	            	 /**
	         		 * 데이터 추가 후 페이지 이동을 통한 새로고침
	         	     */
	            	 $.ajax({
	            		type: 'GET',
	            		url: 'reflashList.do',
	            		dataType: "json",
		                success: function(data){
		                		/* $('#get_info > tbody').empty();
			                	for(var i=0; i<data.length; i++){
			                		var temp = '';
			                		temp +=  '<tr><td>'+data[i]['cdno']+'</td><td>'+data[i]['cdlvl']+'</td><td>'+data[i]['upcd']+'</td><td>'+data[i]['cdname']+'</td>';
			                		if(data[i]['useyn']=='Y'){
			                			temp += '<td><input type="checkbox" id="useyn" name="useyn" checked></td></tr>';
			                		}else{
			                			temp += '<td><input type="checkbox" id="useyn" name="useyn"></td></tr>';
			                		}
			                		$('#get_info').append(temp);
			                	} */
			                	window.location.href = "codemanager.do";
		                }
	            	 });
	             }
	         });
		/**
		 * 수정 클릭 후 저장 클릭하면 입력 필드의 값을 ajax 방식으로 전송 후 db에 저장, 완료시 수정 값 tr 필드 데이터 페이지 이동 없이 변경
	     */
		}else {
			var checkuseyn = "false";
			if(document.getElementById('useyn').checked==true){
				var checkuseyn = "true";
			}
			$.ajax({
	             type: 'POST',
	             url: 'updateCode.do',
	             data: {
	                 "cdlvl" : $('#cdlvl').val(),
	                 "upcd" : $('#upcd').val(),
	                 "cdname" : $('#cdname').val(),
	                 "insuser" : $('#loginid').val(),
	                 "useyn" : checkuseyn,
	                 "cdno" : $('#cdno').val(),
	             },
	             success: function(data){
	            	 $("#get_info tr:eq("+(tr.index()+1)+") td:eq(1)").text(document.getElementById('cdlvl').value);
	            	 $("#get_info tr:eq("+(tr.index()+1)+") td:eq(2)").text(document.getElementById('upcd').value);
	            	 $("#get_info tr:eq("+(tr.index()+1)+") td:eq(3)").text(document.getElementById('cdname').value);
	            	 
	            	 if(document.getElementById('useyn').checked == true){
	            		 $("#get_info tr:eq("+(tr.index()+1)+") td:eq(4)").text("");
	            		 $("#get_info tr:eq("+(tr.index()+1)+") td:eq(4)").append("<input type='checkbox' name='checkUseYN' id='checkUseYN' value='Y' checked>");
	            	 }else{
	            		 $("#get_info tr:eq("+(tr.index()+1)+") td:eq(4)").text("");
	            		 $("#get_info tr:eq("+(tr.index()+1)+") td:eq(4)").append("<input type='checkbox' name='checkUseYN' id='checkUseYN' value='N'>");
	            	 }

	            	 /* document.getElementById('cdno').value=""; document.getElementById('cdno').readOnly=true;
	            	 document.getElementById('cdlvl').value=""; document.getElementById('cdlvl').readOnly=true;
	            	 document.getElementById('upcd').value=""; document.getElementById('upcd').readOnly=true;
	            	 document.getElementById('cdname').value=""; document.getElementById('cdname').readOnly=true;
	            	 document.getElementById('useyn').checked=true; */
	            	 
	            	 clear();

	              }
	         });
		}
	}
}
/**
 * 수정 버튼 클릭시 입력필드 활성화 및 버튼 활성화
 */
function updateCode(){
	if(document.getElementById('cdno').value==""){
		alert('수정할 항목을 선택 후 버튼을 눌러주세요.');
	}else{
		var addbtn = document.getElementById('addbtn');	addbtn.disabled = 'disabled';
		var svbtn = document.getElementById('svbtn');	svbtn.disabled = false;
		document.getElementById('cdlvl').readOnly=false; document.getElementById('upcd').readOnly=false; document.getElementById('cdname').readOnly=false;
		
		identifi = "update";
		
	}
}

/**
 * 테이블의 특정 td 클릭시 해당 td의 tr의 값을 가져와 입력필드에 셋팅
 */
$(document).ready(function(){
	$("#get_info tr").click(function() {

		var str = ""
		var tdArr = new Array(); // 배열 선언

		// 현재 클릭된 Row(<tr>)
		tr = $(this);
		td = tr.children();

		console.log("클릭한 Row의 모든 데이터 : " + tr.text());

		// 반복문을 이용해서 배열에 값을 담아 사용할 수 도 있다.
		td.each(function(i) {
			tdArr.push(td.eq(i).text());
		});
		document.getElementById('cdno').value=td.eq(0).text();
		document.getElementById('cdlvl').value=td.eq(1).text();
		document.getElementById('upcd').value=td.eq(2).text();
		document.getElementById('cdname').value=td.eq(3).text(); 

		if(document.getElementById('checkUseYN').checked == true){
			document.getElementById('useyn').checked=true;
		}else{
			document.getElementById('useyn').checked=false;
		}
	});
});
</script>

<body>
	<div class="layer">
		<div class="layer_inner">
			<div class="content">
				<h1>전체리스트</h1>
				<table border="2" id="get_info">
				<thead>
					<tr>
						<td>코드번호</td>
						<td>코드레벨</td>
						<td>상위코드</td>
						<td>코드이름</td>
						<td>사용여부</td>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${orderList}" var="orderList">
						<tr>
							<td>${orderList.cdno}</td>
							<td>${orderList.cdlvl}</td>
							<td>${orderList.upcd}</td>
							<td>${orderList.cdname}</td>
							<td><c:choose>
									<c:when test="${orderList.useyn eq 'Y'}">
										<input type="checkbox" name="checkUseYN" id="checkUseYN" value="Y" checked>
									</c:when>
									<c:otherwise>
										<input type="checkbox" name="checkUseYN" id="checkUseYN" value="N">
									</c:otherwise>
								</c:choose></td>
						</tr>
					</c:forEach>
				</tbody>
				</table>
				<br>
				<div class="result_view">
					<table border="2">
						<tr>
							<td>코드내용</td>
						</tr>
						<tr>
							<td>
							코드번호 : <input type="text" id="cdno" name="cdno" readonly><br>
							 코드레벨 : <input type="text" id="cdlvl" name="cdlvl" readonly><br>
							 상위코드 : <input type="text" id="upcd" name="upcd" readonly><br>
							 코드이름 : <input type="text" id="cdname" name="cdname" readonly><br>
							 사용여부 : <input type="checkbox" id="useyn" name="useyn">체크<br>
							 <%
							 	String id = (String)session.getAttribute("id");
							 %>
							 <input type="hidden" name="loginid" id="loginid" value="<%=id%>">
							 <input type="button" name="addCode" id="addbtn" onclick="addCode();" value="추가">
							 <input type="button" name="updateCode" id="upbtn" onclick="updateCode();" value="수정">
							 <input	type="button" name="saveCode" id="svbtn" onclick="saveCode();" disabled value="저장">
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
</body>
</html>