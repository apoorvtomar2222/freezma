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
	
	myApp.controller("abc",function($scope)
		{
		
			$scope.data=${data};	
			
		})
};	

</script>
<body ng-app="myApp" ng-controller="abc">
<c:import url="head.jsp"></c:import>
</body>
<br><br><br><br><br><br><br><br>

<div class="container">
								
<table class="table ">
			<thead>
				<tr>
					<th>Blog</th>
					<th>Owner ID</th>
					<th>Description</th>
					<th>Button</th>
				</tr>
			</thead>
			
			<tbody>
				<tr ng-repeat="x in data">
					
					<td>{{x.BlogID}}</td>
					<td>{{x.OwnerID}}</td>
					<td>{{x.Description}}</td>
					<td>	
							<div>
							<a type="button" href="${pageContext.request.contextPath}/view/" class="btn btn-success ">VIEW</a>
							</div>
<div>
<a href="${pageContext.request.contextPath}/addblog/{{x.OwnerID}}" type="button" class="btn-center btn-success btn pull-right" align="right">Add Blog</a>
</div>

							<div>
								<a href="${pageContext.request.contextPath}/update/" class="btn btn-danger">UPDATE</a>
							</div>
	
							<div>
								<a href="${pageContext.request.contextPath}/delete/" class="btn btn-danger">DELETE</a>
							</div>
					</td>
			</tr>
			</tbody>
		</table>	
	</html> 
	</div>