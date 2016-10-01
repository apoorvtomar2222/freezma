<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="shortcut icon" href="flavicon.ico">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>my home page</title>
<c:import url="head-meta.jsp"></c:import>
<style>
body {
    background-image: url('resources/images/background.jpg');
    background-repeat: no-repeat;
    background-attachment: fixed;
    background-position: center;
}
</style>
</head>
<body>
<c:import url="head.jsp"></c:import>
  <img id="logo" src="${pageContext.request.contextPath}/resources/images/log.jpg" width="auto;" height="auto;"  style="margin:50px 300px"/>
</navbar>



</body>
</html>