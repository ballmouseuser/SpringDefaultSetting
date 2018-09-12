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
<body>
<div class="layer">
  <div class="layer_inner">
    <div class="content">
    
        </div>
  </div>
</div>
</body>
</html>