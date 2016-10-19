<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
 <!-- <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.6/angular.min.js"></script>
 -->
 <c:import url="head-meta.jsp"></c:import>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Profile</title>
</head>
 <style>
 body {
      font: 20px Montserrat, sans-serif;
      line-height: 1.8;
   }
  p {font-size: 16px;}
  .margin {margin-bottom: 45px;}
  .bg-1 
  {
      background-color: #1abc9c; /* Green */
      color: #ffffff;
  }
  .bg-2 
  {
      background-color: #474e5d; /* Dark Blue */
      color: #ffffff;
  }
  .bg-3 
  {
      background-color: #ffffff; /* White */
      color: #555555;
  }
  .bg-4 
  {
      background-color: #2f2f2f; /* Black Gray */
      color: #fff;
  }
  
  
  </style>
<script>
	var myApp = angular.module('myApp', []);
	
	myApp.service('fileUpload', ['$http', function ($http) 
	      {
	    		this.uploadFileToUrl = function(file ,paramuser, uploadUrl)
	    		{
	        	var fd = new FormData();
	        	fd.append('file', file);
	    
	   	     	return $http.post(uploadUrl, fd, 
	   	     {
	            		transformRequest: angular.identity,
	            headers: {'Content-Type': undefined , user: paramuser}
	        }).then(
                    function(response){
                        return response.data;
                    }, 
                    function(errResponse){
                        console.error('Error while updating User');
                        return "error";
                    }
            );
	    }
	}]);
	
	myApp.directive('fileModel', ['$parse', function ($parse) {
	    return {
	        restrict: 'A',
	        link: function(scope, element, attrs) {
	            var model = $parse(attrs.fileModel);
	            var modelSetter = model.assign;
	            
	            element.bind('change', function(){
	                scope.$apply(function(){
	                    modelSetter(scope, element[0].files[0]);
	                });
	            });
	        }
	    };
	}]);
	
	
	myApp.factory('UserService', ['$http', '$q', function($http, $q){
	    return {
	    			getUserDetails: function(){
	                    return $http.post('http://localhost:9000/freezma/getUserDetails/')
	                            .then(
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
	    
	    updateUserDetails: function(item){
            return $http.post('http://localhost:9000/freezma/updateUserDetails/', item)
                    .then(
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
 	    updatePassword: function(item)
	    {
            return $http.post('http://localhost:9000/freezma/updatePassword/', item)
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
	    updateImage: function(item)
	    {
            return $http.post('http://localhost:9000/freezma/updateImage/', item)
                   .then
                    (
                            function(response)
                            {
                            	console.log($scope.updateImage);
                                return response.data;
                            }, 
                            function(errResponse)
                            {
                                console.error('Error while updating User');
                                return $q.reject(errResponse);
                            }
                    );
		}
};}]);
	
	
	myApp.controller("abc",['$scope', 'UserService', 'fileUpload' ,function($scope , $UserService,$fileUpload ) {
		$scope.data = ${data};
		/* $scope.mydata = ${mydata};
		 */$scope.myerror = "";
		/* console.log($scope.data);
		 */$scope.userdata;
		$scope.userdatatemp;
		
		$scope.passwordupdated;
		
		$scope.edit = false;
		$scope.password=false;
		
		$scope.uploadProfileImage;
		
		$scope.UserPasswordDetails = 	
		{ 
				
				OldPassword: "",
				NewPassword: "",
				ConfirmNewPassword: ""
		};
		
		 
		$scope.CheckForGender = function()
		{
			if( $scope.userdatatemp.ProfileGender != 'M' && $scope.userdatatemp.ProfileGender != 'F' )
				$scope.genderCheck = true;
			else
				$scope.genderCheck = false;
		
				$scope.updateOverall();
		}
		
		$scope.CheckForEmail = function()
		{
			var reg = /\S+@\S+\.\S+/;
			
			if ($scope.emailCheck=!reg.test( $scope.userdatatemp.ProfileEmail ))
			$scope.emailCheck = true;
			else
			$scope.emailCheck = false;
			$scope.updateOverall();
		}
 		
		$scope.CheckForPhone = function()
		{
			var reg = /^[7-9][0-9]{9}$/;
		
			if ($scope.phoneCheck = !reg.test( $scope.userdatatemp.ProfilePhone ))
				$scope.phoneCheck=true;
			else
				$scope.phoneCheck=false;
				$scope.updateOverall();
		}
		
		$scope.CheckForUsername = function()
		{
			var reg = /[a-zA-Z_][0-9a-zA-Z_]*/;
		
			if ($scope.nameCheck = !reg.test( $scope.userdatatemp.ProfileName ))
				$scope.nameCheck=true;
			else
				$scope.nameCheck=false;
				$scope.updateOverall();
		}
 
		 
		$scope.updateOverall = function()
		{
			$scope.overallValidationCheck = $scope.genderCheck ||$scope.emailCheck ||$scope.phoneCheck ||$scope.nameCheck ||$scope.oldpasswordCheck;
					
		}
		
	 
		 $scope.CheckForOldPassword = function()
			{
				var reg = /^.{6,15}$/;
			
				if ($scope.oldpasswordCheck = !reg.test( $scope.UserPasswordDetails.OldPassword))
					
					$scope.oldpasswordCheck=true;
				else
					$scope.oldpasswordCheck=false;
				
					$scope.updateOverallPassword();
			}
		
		 $scope.CheckForNewPassword = function()
			{
				var reg = /^.{6,15}$/;
			
				if ($scope.newpasswordCheck = !reg.test( $scope.UserPasswordDetails.NewPassword))
					
					$scope.newpasswordCheck=true;
				else
					$scope.newpasswordCheck=false;
				
					$scope.updateOverallPassword();
			}
		
		 
		 $scope.CheckPassword = function()
		 {
			if ($scope.UserPasswordDetails.NewPassword != $scope.UserPasswordDetails.ConfirmNewPassword) 
		 	
				$scope.matchpasswordCheck=true;
			else
				$scope.matchpasswordCheck=false;
		 }
		 
		 $scope.updateOverallPassword = function()
		 {
			 $scope.overallValidationPasswordCheck = $scope.oldpasswordCheck || $scope.newpasswordCheck || $scope.matchpasswordCheck;
		 }
 	
		$UserService.getUserDetails().then(
				
				function(response)
				{
					$scope.userdata = response;
					$scope.userdatatemp = angular.copy( response );
					console.log( $scope.userdata );
					console.log( $scope.userdatatemp );
				}
				,
				function(errResponse)
				{
					console.log('Error in getting User Data');
				}
		);
		
			$scope.toggleUpdatePassword = function(response)
		{
			console.log(JSON.stringify($scope.UserPasswordDetails));
				
			$UserService.updatePassword(JSON.stringify($scope.UserPasswordDetails)).then
			(
			function(response)
			{
				console.log( response.status );
				
				$scope.passwordupdated = response.status;
				
				window.setTimeout(function()
    			{
    				$scope.$apply( $scope.passwordupdated = '' );
    			},3000);
				
			}
		 ,
		 function(errResponse)
		 	{
				console.log('Error in updating User Data');
			}

			
			)};
		
		$scope.setFile= function(e)
		{
			$scope.fileforupload = e.target.files[0];
			
			console.log($scope.fileforupload);
						
			
		};
		
		
		
		$scope.toggleChangeUpdate = function(response)
		{  
			
			console.log( "this is change pass"+JSON.stringify($scope.userdatatemp) );
			
			$UserService.updateUserDetails(JSON.stringify($scope.userdatatemp)).then(
					
					function(response)
					{
						if( response.status == "Updated" )
						{
							$scope.userdata = angular.copy( $scope.userdatatemp );
							$scope.updated = response.status;
							
							window.setTimeout(function()
				        			{
				        	$scope.$apply($scope.updated='');
				        			},3000);
							console.log(response.status);
				
						$UserService.getUserDetails().then(
								
								function(response)
								{
									$scope.userdata = response;
									console.log( $scope.userdata );
								}
								,
								function(errResponse)
								{
									console.log('Error in getting User Data');
								}
						);

						
					
						
						
						}	
						
						
					}
					,
					function(errResponse)
					{
						console.log('Error in updating User Data');
					}
			);
		}
		
		
		
		$scope.letitbe = function()
		{
			
			console.log( $scope.userdata );
			console.log( $scope.userdatatemp );
		}
		
		 
		$scope.CheckValidFileType = function(inp) 
		{
			
			console.log(inp);
			

			if (inp != ".jpg")
				$scope.$apply($scope.myerror = "error");
			else
				$scope.$apply($scope.myerror = "");

			console.log($scope.myerror);
		}
			

		$("#ffub").click(function() {
			$("#ffu").trigger('click');
		});
		
		$scope.fileforupload=null;

		$("#ffu").on('change',function(e) 
		{
					var filename = e.target.files[0].name;
					
					$scope.fileforupload = e.target.files[0];
					
					var file = $scope.fileforupload;
					
					console.log($scope.fileforupload);
					
						var uploadUrl = "http://localhost:9000/freezma/updateProfilePicture/";
				  	        
			   		    var res = $fileUpload.uploadFileToUrl(file ,$scope.userdata.ProfileName , uploadUrl).then
				  	        
			   		    (
				            		function(response)
				            		{
				            			$scope.response = response.status;
				            			$scope.imagesrc = response.imagesrc;
				            			$scope.userdata.ProfileImage = angular.copy(response.imagesrc);
				            			
				            			console.log( $scope.response );
				            			console.log( $scope.imagesrc );
				            			
				            			if( $scope.response == "Uploaded" )
				            			{
				            				$scope.picUpdated = true;

				            				$scope.currentImage = '${pageContext.request.contextPath}/' + $scope.imagesrc;
				            				
				            				
				            			}
				            			else
				            			{
											$scope.picUpdatedWithError = true;
				            				
				            	}
				            			
					    				
				            		}
					            , 
					                function(errResponse)
					                {
					                	console.error('Error while Updating User.');
					                } 
				        	);
				  			
			$scope.CheckValidFileType(filename.substring(filename.indexOf('.'), filename.length));
					
		});
}]);
</script>


<body ng-app="myApp" ng-controller="abc">
<c:import url="head.jsp"></c:import>
<br><br>


<div class="container-fluid bg-1 text-center">
<br><br><br>



<div>
  		<button type="button" class="btn btn-info btn-sm pull-left" data-toggle="modal" data-target="#myModal">Change Password</button>

  		<div class="modal fade" id="myModal" role="dialog">
    	<div class="modal-dialog">
    
      	<div class="modal-content">
        
        
        
        <div style="color: black;" class="modal-header">
         			 <button type="button" class="close" data-dismiss="modal">&times;</button>
          			 <h4 class="modal-title">Change Password</h4>
        </div>
        
        <div class="modal-body">
				<div  style="color: black;" ng-if="password">
				<div>
						<label>Old Password</label>
						<input type="password" class="form-control"  ng-if="password" value="{{UserPasswordDetails.OldPassword}}" ng-model="UserPasswordDetails.OldPassword" ng-change="CheckForOldPassword();"/>
						<label ng-if="oldpasswordCheck">Password Should be betweeen 6 to 15 Character</label>							
		
				</div>
				
				<br>
				<div>
						<label>New Password</label>
						<input type="password" class="form-control"  ng-if="password" value="{{UserPasswordDetails.NewPassword}}" ng-model="UserPasswordDetails.NewPassword" ng-change="CheckForNewPassword();"/>
						<label ng-if="newpasswordCheck">New Password should be between 6 to 15 Character</label>	
				</div>
				<br>
				
				
				<div>
						<label>Confirm New Password</label>
						<input type="password" class="form-control" ng-if="password" value="{{UserPasswordDetails.ConfirmNewPassword}}" ng-model="UserPasswordDetails.ConfirmNewPassword" ng-change="CheckPassword();"/>							
						<label ng-if="matchpasswordCheck">New Password and Confirm Password Mismatch</label>
        		</div>
        		</div>
        </div>
       
        <div class="modal-footer">
        		<div>
        			<button class="btn btn-danger pull-left" ng-click="password=!password;">
							<span ng-if="!password">Click to Change Password</span>
							<span ng-if="password">Let It Be</span>
					</button>
				

			<button class="btn btn-success" ng-if="password" ng-disabled="overallValidationPasswordCheck" >
				<span ng-click="toggleUpdatePassword();">Save</span>
			 	<label class="alert alert-success" style="position: absolute; top: 490px; left: 530px;" ng-if="passwordupdated=='Updated'">Updated</label>
			 	<label class="alert alert-danger" style="position: absolute; top: 490px; left: 530px; " ng-if="passwordupdated=='Password Incorrect'">Incorrect Password</label>
			</button>
        		  
          </div>
          
 		</div>         
 	  	</div>
      </div>
    </div>
 </div>
  





	<div>
		<a href= "${ pageContext.request.contextPath}/searchnewfreind" class="btn btn-warning pull-right">All Profile</a>
	</div>
	<br><br><br>
	<div class="col-sm-3">
 			<img id="profileImage" class="img-circle margin" ng-src="{{userdata.ProfileImage}}" style="display:inline" alt="ProfileImage" height=" 350px" width="300px" align="center">	
			<button id="ffub" class="btn btn-link">Choose Image</button>
			<input type="file" id="ffu" style="opacity:0"  />
			<div class="text text-danger" ng-if=" myerror =='error' " >Invalid Image Type</div>
 
 	</div>
 	
<br><br><br><br><br>
 
<div class="col-sm-9">
<div class="row">
 		<div>
 		<div class="col-xs-6">Profile Name</div>
 		<div class="col-xs-6">	
 				<label ng-if="!edit">{{userdata.ProfileName}}</label>
				<input style="text-transform: capitalize;"type="text" class="form-control" value="{{userdatatemp.ProfileName}}" ng-model="userdatatemp.ProfileName" ng-if="edit" ng-change="CheckForUsername();"/>
				<label ng-if="nameCheck" class="text text-danger"> UserName not Correct</label>
		</div> 
		</div>
		<br>
		<div>
		<div class="col-xs-6">Profile Gender</div>
 		<div class="col-xs-6">
				<label ng-if="!edit">{{userdata.ProfileGender}}</label>
				<select ng-if="edit" value="{{userdatatemp.ProfileGender}}" ng-model="userdatatemp.ProfileGender">
  						<option value="M">Male</option>
  						<option value="F">Female</option>
  				</select>
  		</div>
  		</div>
  		
  		<br>
  	<div>	
  	<div class="col-xs-6">ProfileEmail</div>
  		<div class="col-xs-6">
  			<label ng-if="!edit">{{userdata.ProfileEmail}}</label>
			<input type="text" class="form-control" value="{{userdatatemp.ProfileEmail}}" ng-model="userdatatemp.ProfileEmail" ng-if="edit" ng-change="CheckForEmail();"/>
			<label ng-if="emailCheck" class="text text-danger">Email Id not correct</label>
  		</div>
  	
  	</div>
  	<br>
  	<div>
  	<div class="col-xs-6">ProfileAddress</div>
  	<div class="col-xs-6">
  		<label ng-if="!edit">{{userdata.ProfileAddress}}</label>
		<input type="text" class="form-control" value="{{userdatatemp.ProfileAddress}}" ng-model="userdatatemp.ProfileAddress" ng-if="edit" />							
  	</div>
  	</div>
 <br>
 	<div>
 	<div class="col-xs-6">ProfilePhone</div>
 	<div class="col-xs-6">
 		<label ng-if="!edit">{{userdata.ProfilePhone}}</label>
		<input type="text" class="form-control" value="{{userdatatemp.ProfilePhone}}" ng-model="userdatatemp.ProfilePhone" ng-if="edit" ng-change="CheckForPhone();"/>
		<label ng-if="phoneCheck">Incorrect Phone Number</label>
  	</div>
	</div>
	
	<div>
 	<div class="col-xs-6">
 			<button class="btn btn-success" ng-click="letitbe(); edit = !edit;">
			<span ng-if="!edit">Edit</span>
			<span ng-if="edit">Let It Be</span>
			</button>
 	</div>

 	<div class="col-xs-6">
 			<button ng-click="toggleChangeUpdate(); edit = !edit;" class="btn btn-danger" ng-disabled="overallValidationCheck" >
			<span ng-if="edit" ng-click="toggleChangeUpdate(); ">Update</span>
			</button>
			<!-- <div>
			<label class="alert alert-success" ng-if="updated=='Updated'">Updated</label>
			</div> -->
	</div>
	</div>
  </div>
 </div>
</div>


<%-- 


		<table class="table ">
			<tbody>
			
			<tr>
				<td>User Name:</td>
				<td>
							<label ng-if="!edit">{{userdata.ProfileName}}</label>
							<input type="text" class="form-control" value="{{userdatatemp.ProfileName}}" ng-model="userdatatemp.ProfileName" ng-if="edit" ng-change="CheckForUsername();"/>
							<label ng-if="nameCheck" class="text text-danger"> UserName not Correct</label>
				</td>
			</tr>
			
		
			<tr>
				<td>Gender:</td>
				<td>
					<label ng-if="!edit">{{userdata.ProfileGender}}</label>
					<select ng-if="edit" value="{{userdatatemp.ProfileGender}}" ng-model="userdatatemp.ProfileGender">
  						<option value="M">Male</option>
  						<option value="F">Female</option>
  					</select>
  				</td>
			</tr>
			
			
				
 			<tr>
				<td>Email:</td>
				<td>
							<label ng-if="!edit">{{userdata.ProfileEmail}}</label>
							<input type="text" class="form-control" value="{{userdatatemp.ProfileEmail}}" ng-model="userdatatemp.ProfileEmail" ng-if="edit" ng-change="CheckForEmail();"/>
							<label ng-if="emailCheck" class="text text-danger">Email Id not correct</label>
				</td>
			</tr>
 					
			<tr>
				<td>Address:</td>
				<td><label ng-if="!edit">{{userdata.ProfileAddress}}</label>
					<input type="text" class="form-control" value="{{userdatatemp.ProfileAddress}}" ng-model="userdatatemp.ProfileAddress" ng-if="edit" />							
				</td>
			</tr>
			<tr>
				<td>Contact No:</td>
				<td><label ng-if="!edit">{{userdata.ProfilePhone}}</label>
					<input type="text" class="form-control" value="{{userdatatemp.ProfilePhone}}" ng-model="userdatatemp.ProfilePhone" ng-if="edit" ng-change="CheckForPhone();"/>
					<label ng-if="phoneCheck">Incorrect Phone Number</label>
				</td>							
			</tr>
				
				
			<tr>
				<td>
					<button class="btn btn-link" ng-click="letitbe(); edit = !edit;">
							<span ng-if="!edit">Edit</span>
							<span ng-if="edit">Let It Be</span>
					</button>
				</td>
			
				<td>
							<button class="btn btn-success" ng-if="edit" ng-disabled="overallValidationCheck" >
								<span ng-click="toggleChangeUpdate();">Update</span>
							</button>
				</td>
			</tr>
		</tbody>
	 </table>
	 <table style="width: 80%;" class="table">
					
					<tr>
						<ul style="font-style: italic;font-weight: bold;font-size: 16px;font-family: Segoe UI, Tahoma, sans-serif; color: #333333; padding: 5px; opacity: 0.8; line-height: 20px;" class="list-group">
							
							<a href="${pageContext.request.contextPath}/forum/{{userdata.ProfileName}}" class="list-group-item profile-list-group-item"><li> Forums</li></a>
							<a href="${pageContext.request.contextPath}/gallery/{{userdata.ProfileName}}" class="list-group-item profile-list-group-item"><li> Gallery</li></a>							
						</ul>
					</tr>
									  	
					<br>
									  	
				</table>
				
				
				 --%>
		<br><br>		
				
<div class="container-fluid bg-3 text-center">

  <div class="row">
	 <div style="border-style: groove; margin:40px; " class="col-sm-3">
  		<h1 style="font-family:tahoma;">Gallery</h1> 
      <a href="${pageContext.request.contextPath}/blog/"><img src="${pageContext.request.contextPath}/resources/images/blog.jpg" class="img-responsive margin" style="width:100%" alt="Image"></a>
    
    </div>

    <div style="border-style: groove; margin:40px;"class="col-sm-3">
  		<h1 style="font-family:tahoma;">Blogs</h1> 
      <a href="${pageContext.request.contextPath}/blog/"><img src="${pageContext.request.contextPath}/resources/images/blog.jpg" class="img-responsive margin" style="width:100%" alt="Image"></a>
    
    </div>

    <div  style="border-style: groove; margin:40px;"class="col-sm-3">
  		<h1 style="font-family:tahoma; ">Forum</h1> 
      <a href="${pageContext.request.contextPath}/forum/"><img src="${pageContext.request.contextPath}/resources/images/forum.jpg" class="img-responsive margin" style="width:100%" alt="Image"></a>
    
    </div>
    
  </div>
</div>
<!-- 
				
				
				
				
<table class=table>
<tbody ng-if="password">
					<tr>
					<td>Old Password</td>
					<td>
					<input type="text" class="form-control"  ng-if="password" value="{{UserPasswordDetails.OldPassword}}" ng-model="UserPasswordDetails.OldPassword" ng-change="CheckForOldPassword();"/>
					<label ng-if="oldpasswordCheck">Password Should be betweeen 6 to 15 Character</label>							
					</td>
					</tr>
					
					<tr>
					<td>New Password</td>
					<td><input type="text" class="form-control"  ng-if="password" value="{{UserPasswordDetails.NewPassword}}" ng-model="UserPasswordDetails.NewPassword" ng-change="CheckForNewPassword();"/>
					<label ng-if="newpasswordCheck">New Password should be between 6 to 15 Character</label>
					</td>
					</tr>
					
					<tr>
					<td>Confirm New Password</td>
					<td><input type="text" class="form-control" ng-if="password" value="{{UserPasswordDetails.ConfirmNewPassword}}" ng-model="UserPasswordDetails.ConfirmNewPassword" ng-change="CheckPassword();"/>							
					<label ng-if="matchpasswordCheck">New Password and Confirm Password Mismatch</label></td>
					</tr>
</tbody>
</table>
 					<button class="btn btn-danger pull-left" ng-click="password=!password;">
							<span ng-if="!password">Change Password</span>
							<span ng-if="password">Let It Be</span>
					</button>
				

			<button class="btn btn-success" ng-if="password" ng-disabled="overallValidationPasswordCheck" >
				<span ng-click="toggleUpdatePassword();">Save</span>
			 	<label class="alert alert-success" style="position: absolute; top: 490px; left: 530px;" ng-if="passwordupdated=='Updated'">Updated</label>
			 	<label class="alert alert-danger" style="position: absolute; top: 490px; left: 530px; " ng-if="passwordupdated=='Password Incorrect'">Incorrect Password</label>
			</button>
			
 -->				
<br>


<!-- 

<div style="padding:10px; "class="container">
  		<button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal">Change Password</button>

  		Modal
  		<div class="modal fade" id="myModal" role="dialog">
    	<div class="modal-dialog">
    
      	Modal content
      	<div class="modal-content">
        
        
        
        <div class="modal-header">
         			 <button type="button" class="close" data-dismiss="modal">&times;</button>
          			
          			
          			
          			<h4 class="modal-title">Change Password</h4>
        </div>
        
        
        <div class="modal-body">
				<div ng-if="password">
				<div>
						<label>Old Psssword</label>
						<input type="text" class="form-control"  ng-if="password" value="{{UserPasswordDetails.OldPassword}}" ng-model="UserPasswordDetails.OldPassword" ng-change="CheckForOldPassword();"/>
						<label ng-if="oldpasswordCheck">Password Should be betweeen 6 to 15 Character</label>							
				</div>
				
				<br>
				<div>
						<label>New Password</label>
						<input type="text" class="form-control"  ng-if="password" value="{{UserPasswordDetails.NewPassword}}" ng-model="UserPasswordDetails.NewPassword" ng-change="CheckForNewPassword();"/>
						<label ng-if="newpasswordCheck">New Password should be between 6 to 15 Character</label>	
				</div>
				<br>
				<div>
						<label>Confirm New Psssword</label>
						<input type="text" class="form-control" ng-if="password" value="{{UserPasswordDetails.ConfirmNewPassword}}" ng-model="UserPasswordDetails.ConfirmNewPassword" ng-change="CheckPassword();"/>							
						<label ng-if="matchpasswordCheck">New Password and Confirm Password Mismatch</label>
        		</div>
        		</div>
        </div>
       
        <div class="modal-footer">
        		<div>
        			<button class="btn btn-danger pull-left" ng-click="password=!password;">
							<span ng-if="!password">Click to Change Password</span>
							<span ng-if="password">Let It Be</span>
					</button>
				

			<button class="btn btn-success" ng-if="password" ng-disabled="overallValidationPasswordCheck" >
				<span ng-click="toggleUpdatePassword();">Save</span>
			 	<label class="alert alert-success" style="position: absolute; top: 490px; left: 530px;" ng-if="passwordupdated=='Updated'">Updated</label>
			 	<label class="alert alert-danger" style="position: absolute; top: 490px; left: 530px; " ng-if="passwordupdated=='Password Incorrect'">Incorrect Password</label>
			</button>
        		  
          </div>
          
 		</div>         
    </div>
      
      
      </div>
      
    </div>
    </div>
  

				
				
	 -->			
				
				
				
				

<br><br><br><br>
</body>

 </html>