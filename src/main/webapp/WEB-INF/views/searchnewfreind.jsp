<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<title>Search New Friend</title>

<c:import url="head-meta.jsp"></c:import>
</head>
<script type="text/javascript">
	var myApp = angular.module('myApp', ["myApp1"]);
	
	myApp.factory('UserService', ['$http', '$q', function($http, $q){
		
	    return {
	    	
			fetchAllItems: function() 
			{
									return $http
											.post('http://localhost:9000/freezma/fetchAllItems/')
											.then(
													function(response) 
													{
														return response.data;
														console.log(response.data);
														//$scope.data = angular.copy( response );
														
													},
													function(errResponse) 
													{
														console.error('Error while sending data');
														return $q.reject(errResponse);
													});
								
			},
		AcceptRequest : function(item)
		{
			return $http.post('http://localhost:9000/freezma/AcceptRequest/',item)
				.then
					(
						function(response)
						{
							return response.data;
						},
						function(errResponse)
						{
							console.error('Error while sending data');
							return $q.reject(errResponse);
						}	
					);
		}

		,
	    IgnoreFriend: function(item)
	    {
            					return $http.post('http://localhost:9000/freezma/IgnoreFriend/', item)
                    						.then
                    						(
                            					function(response)
                            					{
                                					return response.data;
                            					}, 
                            						function(errResponse)
                            					{
                                					console.error('Error while updating User');
                                					return $q.reject(errResponse);
                            					}
                    						);
         }

,
RemoveFriend: function(item)
{
    					return $http.post('http://localhost:9000/freezma/RemoveFriend/', item)
            						.then
            						(
                    					function(response)
                    					{
                        					return response.data;
                    					}, 
                    						function(errResponse)
                    					{
                        					console.error('Error while updating User');
                        					return $q.reject(errResponse);
                    					}
            						);
 }


		
,
		AddFriend: function(item)
	    {
            					return $http.post('http://localhost:9000/freezma/AddFriend/', item)
                    						.then
                    						(
                            					function(response)
                            					{
                                					return response.data;
                            					}, 
                            						function(errResponse)
                            					{
                                					console.error('Error while updating User');
                                					return $q.reject(errResponse);
                            					}
                    						);
         }
	
	,
	 	Delete: function(item)
		{
								return $http.post('http://localhost:9000/freezma/Delete/', item)
									.then(
											function(response)
										{
											return response.data;
										},		
											function(errResponse)
										{
											return $q.reject(errResponse);
										}
										);
	
		}
	
	}
}]);
	
	
	myApp.controller("abc", ['$scope','UserService',function($scope, $UserService) 
			{
			$scope.data;
			$scope.password=false;
			$scope.currentUser = '${pageContext.request.userPrincipal.name}';
			$scope.FriendName;
			$scope.frequest;
			$scope.cfrequest;
			$scope.ProfileID;
			$scope.toggle = false;
			
$UserService.fetchAllItems().then
(
					function(response) 
					{
						$scope.data = response;
            			console.log($scope.data);
					}
			,
					function(errResponse)
					{
						console.error('Error while Sending Data.');
					}
);
		

$scope.AddFriend = function(ProfileID, ProfileName )
{
			$scope.frequest = {"ProfileID" : ProfileID ,"FriendID": ProfileName};
		 	console.log($scope.frequest);
			$UserService.AddFriend(JSON.stringify($scope.frequest))
         		.then
         		(

        			

         			function(response)
         				{
         				
         					console.log( response );
         				
         				//$scope.data.ProfileAssociation = response.ProfileAssociation;
         					if( response.status == "Updated" )
         					{
         						$scope.update = response.status;
    						
         						for( i = 0 ; i < $scope.data.length ; i++ )
         						{
         							if( $scope.data[i].ProfileID == response.ProfileID )
         							{
         								$scope.data[i].ProfileAssociation = response.ProfileAssociation;
         							
         		         				break;
         							}
         						}
         						window.setTimeout(function()
 		                 				{
 		                 					$scope.$apply( $scope.update = '' );
 		                 				},3000);
         						
         						console.log( $scope.data )
         					}
         											
		}
	            , 
	                function(errResponse)
	                	{
	                		console.error('Error while Updating User.');
	                	}	 
					 );
			
};
			$scope.updateOverall = function()
			{
				$scope.overallValidationCheck = $scope.toggle;
			};

			
			
//////////////////////////////////////			
			$scope.RemoveFriend = function(ProfileID , ProfileName)
			{
					$scope.frequest = {"ProfileID" : ProfileID , "FriendName":ProfileName}
					
					$UserService.RemoveFriend(JSON.stringify($scope.frequest))
						.then(
								function(response)
									{
										$scope.update=response.status;
										if(response.status =="Deleted")
											{
											for( i = 0 ; i < $scope.data.length ; i++ )
			         						{
			         							if( $scope.data[i].ProfileID == response.ProfileID )
			         							{
			         								$scope.data[i].ProfileAssociation = response.ProfileAssociation;
			         								break;	
			         							}
			         						
			         							window.setTimeout(function()
			     		                 				{
			     		                 					$scope.$apply( $scope.update = '' );
			     		                 				},3000);
			     		         				
			         						}
			         		
												console.log(response.status);
											}
		
									},
								function(errResponse)
									{
										console.error('Error while Updating Error');
									}
								);
			};

			
$scope.AcceptRequest = function(ProfileID , ProfileName)
		{
				$scope.frequest = {"ProfileID" : ProfileID , "FriendName":ProfileName}
				
				$UserService.AcceptRequest(JSON.stringify($scope.frequest))
					.then(
							function(response)
								{
									$scope.update=response.status;	
									if(response.status =="Updated")
										{
										for( i = 0 ; i < $scope.data.length ; i++ )
		         						{
		         							if( $scope.data[i].ProfileID == response.ProfileID )
		         							{
		         								$scope.data[i].ProfileAssociation = response.ProfileAssociation;
		         								break;
		         							}
		         						}
		         		
											console.log(response.status);
										}

			        				window.setTimeout(function()
			        				{
			        					$scope.$apply( $scope.update = '' );
			        				},3000);
									
								},
							function(errResponse)
								{
									console.error('Error while Updating Error');
								}
							);
		};

$scope.Delete = function(ProfileID, ProfileName )
{
	$scope.cfrequest = {"ProfileID" : ProfileID ,"FriendID": ProfileName};
	console.log($scope.cfrequest);
	$UserService.Delete(JSON.stringify($scope.cfrequest))
			.then(
      			function(response)
      				{
      					$scope.update=response.status;
      					console.log( response.status );
      					console.log( response);
 					
      					if( response.status == "Deleted" )
      					{
 							for( i = 0 ; i < $scope.data.length ; i++ )
     						{
     							if( $scope.data[i].ProfileID == response.ProfileID )
     							{
     								$scope.data[i].ProfileAssociation = response.ProfileAssociation;
     								break;
     							}
     							
     							
     						}
 							window.setTimeout(function()
		                 				{
		                 					$scope.$apply( $scope.update = '' );
		                 				},3000);
		         				
     		
 							$scope.deleterequest = response.status;
      				
      						
      					}
 						$scope.toggle = false;
      				}, 
	             function(errResponse)
	                {
	                	console.error('Error while Updating User.');
	                } 
  	 				);
};


$scope.IgnoreFriend = function(ProfileID, ProfileName )
{
	$scope.cfrequest = {"ProfileID" : ProfileID ,"FriendID": ProfileName};
	console.log($scope.cfrequest);
	$UserService.IgnoreFriend(JSON.stringify($scope.cfrequest))
			.then(
      			function(response)
      				{	

  						
						console.log( response.status );
 						if( response.status == "Deleted" )
      					{
 							for( i = 0 ; i < $scope.data.length ; i++ )
     						{
     							if( $scope.data[i].ProfileID == response.ProfileID )
     							{
     								$scope.data[i].ProfileAssociation = response.ProfileAssociation;
     								break;
     							}
     						}
     		
 							$scope.deleterequest = response.status;
      						console.log( response.status );
      						
      					}
 						$scope.toggle = false;
      				}, 
	             function(errResponse)
	                {
	                	console.error('Error while Updating User.');
	                } 
  	 				);
};


}]);

</script>

<body ng-app="myApp" ng-controller="abc">
<c:import url="head.jsp"></c:import>
<br><br><br><br><br><br>


	<div class="container">
	
		<table class="table " ng-repeat="data in data">
			<tbody>
				<tr>
				<input type="hidden" value="{{ data.ProfileID}}" />
				<td><img ng-src="{{data.ProfileImage}}" class="img-rounded" height=" 150px" width="200px" /></td>
				<td>UserName :{{data.ProfileName}}<br>Email ID : {{data.ProfileEmail}}<br>{{data.ProfileID}}</td>
			
			
				<td>
	 			<button type="button"  class="btn btn-success" ng-show="data.ProfileAssociation =='notfriend'"  ng-click="AddFriend(data.ProfileID,data.ProfileName);">Add friend</button>
				<button type="button"  class="btn btn-success"  ng-show="data.ProfileAssociation=='pendingrequest'" ng-click="AcceptRequest(data.ProfileID ,data.ProfileName)">Accept Request</button>
				<button type="button"  class="btn btn-success"  ng-show="data.ProfileAssociation=='pendingrequest'" ng-click="IgnoreFriend(data.ProfileID ,data.ProfileName)" >Ignore</button>
				<button type="button" class="btn btn-success" ng-model= "data.ProfileAssociation"  value="{{data.ProfileAssociation}}" ng-show="data.ProfileAssociation=='Sent'" ng-click="Delete(data.ProfileID,data.ProfileName);">Cancel Request(click to undo)</button>
  				
   				<button type="button" ng-show="data.ProfileAssociation=='Friend'" class="btn btn-success " ng-click="password=!password;" > 
    			<span ng-if="!password" >FRIends</span>
			 	<span  ng-if="password" >let it be</span>
			 	</button>
    	
    			<button ng-show="data.ProfileAssociation=='Friend'|| " ng-if="password" class="btn btn-danger">
    			<span  ng-click="RemoveFriend(data.ProfileID ,data.ProfileName)">Remove friend</span>
			 	</button>
    			</td>
    			
    	 	<td>
				<label class="alert alert-success" ng-show="data.ProfileAssociation=='Sent'&& update == 'Updated'">Sent</label>
			</td>	      
	
	
	
			 	
		<!-- 
						<!-- <button  ng-if="password" ng-click="RemoveFriend(data.ProfileID ,data.ProfileName)">Remove friend</button>
			 	<button  ng-if="password" ng-click="password=!password;)">let it be</button></td>
	
		
			 	<button type="button" class="btn btn-success" ng-show="data.ProfileAssociation=='Friend'" >Friends</button>

			 	<a href= "${ pageContext.request.contextPath}/viewprofile/{{data.ProfileName}}" type="button" class="btn btn-success pull-right">View Profile</a>
 -->				
				</tr>
			</tbody>
		</table>
	</div>
</body>
</html>