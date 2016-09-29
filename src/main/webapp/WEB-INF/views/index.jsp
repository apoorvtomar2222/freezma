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
<navbar class="navbar navbar-blurred navbar-fixed-top">
  <div class="container-fluid">
    <div class="navbar-header">
    
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="#">Freezma</a>
      
      
    </div>
    
    <div class="collapse navbar-collapse" id="myNavbar">
       <ul class="nav navbar-nav navbar-right">
       <li class="dropdown">
      
        <li><a href="${pageContext.request.contextPath}/signup" class="btn ">Signup</a></li>
        <li><a href="${pageContext.request.contextPath}/loginpage" class="btn" >LogIn</a></li>
      
      </ul>
      </div>
  </div>
  
  <img id="logo" src="${pageContext.request.contextPath}/resources/images/log.jpg" width="auto;" height="auto;"  style="margin:50px 300px"/>
</navbar>



</body>
</html>