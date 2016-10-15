<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<c:import url="head-meta.jsp"></c:import>
<title>Blog Content</title>
</head>
<script type="text/javascript">
{
var  myapp = angular.module('myapp' , []);

myapp.controller("abc",function($scope)
		{
			$scope.mydata=${mydata};
			console.log("on jsp page"+$scope.mydata);	
		})
};


</script>






 <body>
	<c:import url="head.jsp"></c:import>
	<br><br><br><br><br><br><br><br>
	<div class="container">
	
					<div >
						<div class="row" style="color: white;  background-color: grey; padding:20px; ">
								<h1 style=" text-transform: uppercase"><b>${Username} 's</b> Blog </h1>
								<h2><b>Topic Name :</b>&nbsp;${Topicname}</h2>
								
								<h3>Description :&nbsp;${Description}</h3> 			
					
									
						</div>
						<br><br>
	
	<div  ng-app="myapp" ng-controller="abc">
<!-- 	<table class="table " ng-repeat="x in mydata">
			<tbody  >
		<tr>
				<td>User Name:</td>
				<td>
							<label>{{x.Value}}</label>
				</td>
			</tr>
			
			
				
			</tbody>
	 
	 </table>
 -->						
						
						
						
						
						
						
						
						 <div ng-repeat="x in mydata">
								<div style="font-size:30px; text-transform: capitalize;">${Username} Wrote:</div>
								<div style="font-size:18px; background-color: #D3D3D3; padding:10px;">{{x.Value}}</div>
								 <br><br>
       							
								 <a href="${pageContext.request.contextPath}/like " class="btn btn-info btn-lg center">
         						 <span class="glyphicon glyphicon-thumbs-up"></span> Like
       							 </a>
      								
						</div> 
						
						
					<br><br>
	
						
					
	
			<form:form action="${pageContext.request.contextPath}/addcontent" method="post" modelAttribute="blogcontent">
					<form:input type="hidden" path="BlogID" value="${BlogId}" />
			<br><br>
			<div >
					<form:textarea class="form-control" rows="5"  path="value" />
				
			</div>	
			<br><br>	
				<div>
					<input type="submit" class="btn btn-success btn-center" value="Save" />
				</div>
			
			</form:form>
			<br><br><br>
	</div>
</body> 
</html>