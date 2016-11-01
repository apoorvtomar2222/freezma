<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<link rel="shortcut icon" href="flavicon.ico">
<meta name=viewport content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
   <title>my home page</title>
	<c:import url="head-meta.jsp"></c:import>
</head>
<script>
	var myApp1 = angular.module("myApp1", []);
	
	myApp1.factory('UserServiceHead', ['$http', '$q', function($http, $q){
		
	    return {
	    	

			GetAllFriends: function(item){
                return $http.post('http://localhost:9000/freezma/GetAllFriends/', item)
                        .then(
                                function(response){
                                    return response.data;
                                }, 
                                function(errResponse){
                                    console.error('Error while updating User');
                                    return $q.reject(errResponse);
                                }
                        );                    
			}    }
	}]);
	
	myApp1.controller('abc1', ['$scope','UserServiceHead',function($scope, $UserServiceHead) 
	             			{
							console.log('Head');
		
	             			$scope.data;
	             			
	             			$scope.currentUser = '${pageContext.request.userPrincipal.name}';
	             			$scope.frequest = {currentUser : $scope.currentUser};
	             			console.log($scope.frequest);
	         
/* 	        
	        $UserService.fetchAllfriends().then
	             (
	             					function(response) 
	             					{
	             						$scope.data1 = response;
	                         			console.log("data received on head.jsp page" + $scope.data1);
	             					}
	             			,
	             					function(errResponse)
	             					{
	             						console.error('Error while Sending Data.');
	             					}
	             );
 */
 
	           			
	             $UserServiceHead.GetAllFriends(JSON.stringify($scope.frequest))
	             	        .then(
	             	        		function(response)
	             	        		{
	              	        			try
	             	        			{
	             	        				$scope.AllMyFriends = response.AllMyFriends;
	             	        				
	             	        				console.log("All my friend"+ $scope.AllMyFriends );
	             	        				
	             		            		
	             	        			}
	             	        			catch(e)
	             	        			{
	             	        				console.log( e );
	             	        				$scope.AllMyFriends = [];
	             	        			}
	             	        			
	             	        			//console.log("Friends:");
	             	        			//console.log($scope.AllMyFriends);
	             	        			
	             	        			$scope.AllMyFriendsEmpty = ($scope.AllMyFriends.length == 0);
	             	        		}
	             	            , 
	             	                function(errResponse)
	             	                {
	             	                	console.error('Error while getting Friends.');
	             	                } 
	             	    	);
	             			
	             			}]);
	             		
	//angular.bootstrap( document.getElementById('chat') , ['myApp1'] );
</script>
	


<div ng-app="myApp1" ng-controller="abc1" >
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



					



<!-- <div>
  <button data-target="#demo" class="btn btn-info"  data-toggle="collapse">Simple collapsible</button>
<div id="demo" class="collapse" >HI</div>
</div>
 -->



<div  class="container" style="width: 250px;  background-color:rgba(0,0,0,0.8);color:white; position:fixed; bottom:0; right:0;">

	<div ng-repeat="x in AllMyFriends">
	
	<div class="col-lg-offset-4"><img ng-src={{x.Image}} width="15px;" height = "20px;">
  	
  	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {{x.Name}}</div>
  </div>
</div>








</div>
</html>