<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/references/js/stomp.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/references/js/sockjs-0.3.4.min.js"></script>

<link rel="shortcut icon" href="flavicon.ico">
<meta name=viewport content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
   <title>my home page</title>
	<c:import url="head-meta.jsp"></c:import>
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
 
 
 				var ws;
 				var stompClient;
 
	             ws = new SockJS("/freezma/chat");
	             
	             stompClient = Stomp.over(ws);
	             
	             stompClient.connect({},function(frame)
	           		{
	            	 stompClient.subscribe("/topic/chat",function(message)
	           			{
	           		 		console.log("Received " + message.body);
	           		 		$('#message12').prepend(message.body);
	           				 		
	           			});
	            	 
	            	 stompClient.subscribe("/user/queue/private",function(message)
	 	           			{
	            		 		alert(message.body);
	 	           			});
	            	 
	            	 
	            	 
	           		},
	             			
	           		function(error)
	           		{
	             		console.log("Stomp protocol error   " + error);
	             			
	           		}); 
	            
	           /*   window.setTimeout( function(){
	            	 stompClient.send('/app/chat',{}, "BA" );
	             } , 1000 );
	            */  
	         
				$scope.msg = '';
    			$scope.currentlogin= '${pageContext.request.userPrincipal.name}';
    		    
    			
    			
    			$scope.SendMsg = function(msg)
	             {
		             var data = {"msg": msg , "CurrentUser": $scope.currentlogin,"OpenChatName":  $scope.openchatname};
		             stompClient.send('/app/chat',{},JSON.stringify(data));
		         };
		         
		         
		        $scope.openchatname= ''; 
					
				$scope.openchatnamecheck=false;
		         
		        $scope.Open = function(name)
	    			{
	    				 $scope.openchatname = name;
	    				
	    					$scope.openchatnamecheck=true;
	    				    
	    				 
	    			/* 	alert("hi" +$scope.openchatname);  */
	    			};
    			
    			
    			
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
 
<br><br><br><br><br>
							<div class="col-xs-6">
							</div>



							

<div  class="container" style="width: 250px;  background-color:rgba(0,0,0,0.8);color:white; position:fixed; bottom:0; right:0;">
	<div ng-repeat="x in AllMyFriends">
	
	<div ng-click="Open(x.Name);" class="col-lg-offset-4"><img ng-src={{x.Image}} width="15px;" height = "20px;">
  	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{{x.Name}}</div>
</div>





</div>


								<!-- This is for chat-->

<div ng-show="openchatnamecheck"  class="container">
    <div class="row">
        <div class="col-md-5">
            <div class="panel panel-primary">
                <div class="panel-heading" id="accordion">
                    <span class="glyphicon glyphicon-comment"></span> Chat
                    <div class="btn-group pull-right">
                        <a type="button" class="btn btn-default btn-xs" data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
                            <span class="glyphicon glyphicon-chevron-down"></span>
                        </a>
                    </div>
                </div>
                
                
            <div class="panel-collapse collapse" id="collapseOne">
                <div class="panel-body">
             
             <!--
                    <ul class="chat">
                        <li class="left clearfix"><span class="chat-img pull-left">
                            <img src="http://placehold.it/50/55C1E7/fff&text=U" alt="User Avatar" class="img-circle" />
                        </span>
                            <div class="chat-body clearfix">
                                
                            </div>
                        </li>
                        <li class="right clearfix"><span class="chat-img pull-right">
                            <img src="http://placehold.it/50/FA6F57/fff&text=ME" alt="User Avatar" class="img-circle" />
                        </span>
                            <div class="chat-body clearfix">
																			<div class="header">
										                                    <small class=" text-muted"><span class="glyphicon glyphicon-time"></span>13 mins ago</small>
										                                    <strong class="pull-right primary-font">Bhaumik Patel</strong>
										                                </div>
										                                 <p>
										                                    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur bibendum ornare
										                                    dolor, quis ullamcorper ligula sodales.
										                                </p>
										 
 
                            </div>
                        </li>
                        <li class="left clearfix"><span class="chat-img pull-left">
                            <img src="http://placehold.it/50/55C1E7/fff&text=U" alt="User Avatar" class="img-circle" />
                        </span>
                            <div class="chat-body clearfix">
								                                 <div class="header">
								                                    <strong class="primary-font">Jack Sparrow</strong> <small class="pull-right text-muted">
								                                        <span class="glyphicon glyphicon-time"></span>14 mins ago</small>
								                                </div>
								                                <p>
								                                    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur bibendum ornare
								                                    dolor, quis ullamcorper ligula sodales.
								                                </p> 
                            </div>
                  </li>
                        <li class="right clearfix"><span class="chat-img pull-right">
                            <img src="http://placehold.it/50/FA6F57/fff&text=ME" alt="User Avatar" class="img-circle" />
                        </span>
                            <div class="chat-body clearfix">
                                <div class="header">
                                    <small class=" text-muted"><span class="glyphicon glyphicon-time"></span>15 mins ago</small>
                                    <strong class="pull-right primary-font">Bhaumik Patel</strong>
                                </div>
                                <p>
                                    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur bibendum ornare
                                    dolor, quis ullamcorper ligula sodales.
                                </p>
                            </div>
                        </li>
                    </ul>
                </div> -->
                
                
                
                <div class="panel-footer">
                    <div class="input-group">
                    
						<label id="message12"></label>
					    <input id="btn-input" type="text" ng-model="msg" id="messageText"  class="form-control input-sm" placeholder="Type your message here..." />
                        <span class="input-group-btn">
                            <button class="btn btn-warning btn-sm"  ng-click="SendMsg(msg,$scope.currentUser, $scope.openchatname);" id="btn-chat">Send</button>
                        </span>
                    </div>
                </div>
            </div>
            </div>
        </div>
    </div>
</div>
</div>

							