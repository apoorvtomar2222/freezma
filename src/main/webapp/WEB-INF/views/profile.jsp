<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
 <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.6/angular.min.js"></script>
<c:import url="head-meta.jsp"></c:import>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Profile</title>
</head>

<style>

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
		$scope.myerror = "";
		
		$scope.userdata;
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
			$scope.overallValidationCheck = $scope.genderCheck;
			$scope.overallValidationCheck = $scope.emailCheck;
			$scope.overallValidationCheck = $scope.phoneCheck;
			$scope.overallValidationCheck = $scope.nameCheck;
			$scope.overallValidationCheck = $scope.oldpasswordCheck;
				
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
		
		$scope.uploadProfileImage = function(img)
		{
	
			console.log(img);
	/* 		$UserService.updateImage(JSON.stringify($scope.updateProfileImage)).then
				(
			function(response)
				{
					if(response.status =="Updated")
					{
					System.out.println("Success");
					}
					
				}
				,
			function(errResponse)
		 		{
				console.log('Error in updating User Data');
				}

				)
 */ 		
		};

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
			
			console.log( JSON.stringify($scope.userdatatemp) );
			
			$UserService.updateUserDetails(JSON.stringify($scope.userdatatemp)).then(
					
					function(response)
					{
						if( response.status == "Updated" )
						{
							$scope.userdata = angular.copy( $scope.userdatatemp );
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

<br>

<br>
<br>
<br>
<br>
<br>

 <div class="col-md-3 well">
      <div class="well">
  

<table class="table ">

	
			<tbody>

			<tr>
				<td></td>
				<td> <br>
					 <img id="profileImage" ng-src="{{userdata.ProfileImage}}"height=" 150px" width="200px" align="center">	
					 <button id="ffub" class="btn btn-link">Choose Image</button>
					 
					 <input type="file" id="ffu" style="opacity:0"  />
					 
					 <div class="text text-danger" ng-if=" myerror =='error' " >Invalid Image Type</div>
				</td>
			</tr>


			
					<tr>
						<td>User Name:</td>
						<td>
							<label ng-if="!edit">{{userdata.ProfileName}}</label>
							<input type="text" class="form-control" value="{{userdatatemp.ProfileName}}" ng-model="userdatatemp.ProfileName" ng-if="edit" ng-change="CheckForUsername();"/>
							<label ng-if="nameCheck" class="text text-danger"> UserName not Correct</label>
						</td>
					</tr>
			
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
	</div>

<div class="well">
        <p><a href="#">Interests</a></p>
        <p>
          <span class="label label-default">News</span>
          <span class="label label-primary">W3Schools</span>
          <span class="label label-success">Labels</span>
          <span class="label label-info">Football</span>
          <span class="label label-warning">Gaming</span>
          <span class="label label-danger">Friends</span>
        </p>
      </div>
      
      <div class="alert alert-success fade in">
        <a href="#" class="close" data-dismiss="alert" aria-label="close">�</a>
        <p><strong>Ey!</strong></p>
        People are looking at your profile. Find out who.
      </div>
      <p><a href="#">Link</a></p>
      <p><a href="#">Link</a></p>
      <p><a href="#">Link</a></p>

    </div>
	 </div>




  <div class="col-md-9">
    
      <div class="row">
        <div class="col-sm-12">
          <div class="panel panel-default text-left">
            <div class="panel-body">
              <p contenteditable="true">Status: Feeling Blue</p>
              <button type="button" class="btn btn-default btn-sm">
                <span class="glyphicon glyphicon-thumbs-up"></span> Like
              </button>
            </div>
          </div>
        </div>
      </div>
      
      <div class="row">
        <div class="col-sm-3">
          <div class="well">
           <p>John</p>
           <img src="bird.jpg" class="img-circle" height="55" width="55" alt="Avatar">
          </div>
        </div>
        <div class="col-sm-9">
          <div class="well">
            <p>Just Forgot that I had to mention something about someone to someone about how I forgot something, but now I forgot it. Ahh, forget it! Or wait. I remember.... no I don't.</p>
          </div>
        </div>
      </div>
      <div class="row">
        <div class="col-sm-3">
          <div class="well">
           <p>Bo</p>
           <img src="bandmember.jpg" class="img-circle" height="55" width="55" alt="Avatar">
          </div>
        </div>
        <div class="col-sm-9">
          <div class="well">
            <p>Just Forgot that I had to mention something about someone to someone about how I forgot something, but now I forgot it. Ahh, forget it! Or wait. I remember.... no I don't.</p>
          </div>
        </div>
      </div>
  




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
</body>
					<button class="btn btn-danger pull-right" ng-click="password=!password;">
							<span ng-if="!password">Change Password</span>
							<span ng-if="password">Let It Be</span>
					</button>
							<button class="btn btn-success" ng-if="password" ng-disabled="overallValidationPasswordCheck" >
							
								<span ng-click="toggleUpdatePassword();">Save</span>
			 <label class="alert alert-success" style="position: absolute; top: 490px; left: 530px;" ng-if="passwordupdated=='Updated'">Updated</label>
			 <label class="alert alert-danger" style="position: absolute; top: 490px; left: 530px; " ng-if="passwordupdated=='Password Incorrect'">Incorrect Password</label>
			
					</button>
			 
		 </div>
 

 </html>