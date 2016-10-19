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
</head>




<body>
<navbar  class="navbar navbar-inverse navbar-fixed-top">
  <div class="container-fluid">
    <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="#">Freezma</a>
  
      <input type="text" name="search" placeholder="Search Freezma" maxlength="15" size="70" style="padding:10px">
      
    </div>
    
    <div class="collapse navbar-collapse" id="myNavbar">
       <ul class="nav navbar-nav navbar-right">
       <li class="dropdown">


									<%
						if (request.isUserInRole("user"))
						{
							%>
								      <li><a href="${pageContext.request.contextPath}/profile" class="btn ">Home</a></li>
								
							<%							
						}
						%>




  	<c:choose>
		<c:when test="${not empty pageContext.request.userPrincipal}">
			<li><a href="${pageContext.request.contextPath}/profile">${pageContext.request.userPrincipal.name}</a></li>
			<li><a href="${pageContext.request.contextPath}/logout">Log Out</a></li>

		</c:when>

		<c:otherwise>
			<li><a href="${pageContext.request.contextPath}/signup"><span
					class="glyphicon glyphicon-user"></span> Sign Up</a></li>
			<li><a href="${pageContext.request.contextPath}/loginpage"><span
					class="glyphicon glyphicon-log-in"></span> Login</a></li>
		</c:otherwise>
	</c:choose>
</ul>
</div>
  </div>
</navbar>
</body>
</html>