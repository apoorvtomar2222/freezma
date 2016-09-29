<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<c:import url="head-meta.jsp"></c:import>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Profile</title>
</head>

<style>

</style>

<script>
	var myApp = angular.module('myApp', []);
	
	
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
	    };
	 
	}]);
	
	
	myApp.controller("abc",['$scope', 'UserService',function($scope , $UserService ) {
		$scope.data = ${data};
		$scope.myerror = "";
		
		$scope.userdata;
		$scope.userdatatemp;
		
		$scope.edit = false;
			
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

		$("#ffu").on(
				'change',
				function(e) {
					var filename = e.target.files[0].name;
					//alert( filename.substring( filename.indexOf('.') , filename.length ) );
					$scope.CheckValidFileType(filename.substring(filename.indexOf('.'), filename.length));
		});
}]);
</script>


<body ng-app="myApp" ng-controller="abc">
	<c:choose>
		<c:when test="${not empty pageContext.request.userPrincipal}">
			<li><a href="${pageContext.request.contextPath}/index">${pageContext.request.userPrincipal.name}</a></li>
			<li><a href="${pageContext.request.contextPath}/logout">Log
					Out</a></li>

		</c:when>

		<c:otherwise>
			<li><a href="${pageContext.request.contextPath}/signup"><span
					class="glyphicon glyphicon-user"></span> Sign Up</a></li>
			<li><a href="${pageContext.request.contextPath}/loginpage"><span
					class="glyphicon glyphicon-log-in"></span> Login</a></li>
		</c:otherwise>
	</c:choose>



<div class="container">
<table class="table ">

	
			<tbody>

			<tr>
				<td> <br>
					 <img id="profileImage" ng-src="{{data.ProfileImage}}"height=" 150px" width="200px">	
					 <button id="ffub" class="btm btn-link">Choose Image</button>
					 <input type="file" id="ffu" style="opacity: 0;" />
					 <div class="text text-danger" ng-if=" myerror =='error' ">Invalid Image Type</div>
				</td>
			</tr>

			<tr>
						<td>User Name:</td>
						<td>
							<label ng-if="!edit">{{userdata.ProfileName}}</label>
							<input type="text" class="form-control" value="{{userdatatemp.ProfileName}}" ng-model="userdatatemp.ProfileName" ng-if="edit"/>
						</td>
					</tr>
				
				<tr>
					<td>Gender:</td>
					<td><label ng-if="!edit">{{userdata.ProfileGender}}</label>
					<input type="text" class="form-control" value="{{userdatatemp.ProfileGender}}" ng-model="userdatatemp.ProfileGender" ng-if="edit"/>							
							
					</td>
				</tr>
				
				<tr>
					<td>Address:</td>
					<td><label ng-if="!edit">{{userdata.ProfileAddress}}</label>
					<input type="text" class="form-control" value="{{userdatatemp.ProfileAddress}}" ng-model="userdatatemp.ProfileAddress" ng-if="edit"/>							
					</td>
				</tr>
				<tr>
				
					<td>Contact No:</td>
					<td><label ng-if="!edit">{{userdata.ProfilePhone}}</label>
					<input type="text" class="form-control" value="{{userdatatemp.ProfilePhone}}" ng-model="userdatatemp.ProfilePhone" ng-if="edit"/>
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
							<button class="btn btn-success" ng-if="edit" >
								<span ng-click="toggleChangeUpdate();">Update</span>
							</button>
				</td>
			</tr>
		</tbody>
	 </table>
	</div>
</body>

</html>