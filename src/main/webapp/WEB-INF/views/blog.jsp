<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>User Blogs</title>
<c:import url="head-meta.jsp"></c:import>
</head>
<script>
{
	var myApp = angular.module('myApp',[]);
	
	myApp.factory('Userservice',['$http','$q'])
	myApp.controller("abc",function($scope)
		{
		
			$scope.data=${value};	
			
		})
};	

</script>
<body ng-app="myApp" ng-controller="abc">
<c:import url="head.jsp"></c:import>
</body>
<br><br><br><br><br><br><br><br>		
	<div class="container">
		<div class="Row">
		<textarea row =10 Placeholder="Write out your mind" class="form-control form-input input-lg "></textarea>
		<br><br>
		<button class="btn btn-success" ng-click="AddPost();">Done</button>	
			</div>

	</div>
	
	</html>