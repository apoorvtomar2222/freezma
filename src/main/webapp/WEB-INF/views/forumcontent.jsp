<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Forum Content</title>
</head>
<script>

var myApp = angular.module("myApp",[])


 	myApp.factory('UserService', ['$http', '$q', function($http, $q){
	    return {
	    			getforumDetails: function(){
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
	    
};}]); 
 
/* myApp.factory('UserService',['$http','$q',function($http , $q){
	return
	{
		getuserDetails: function()
		{
		return $http.post('http://localhost:9000/freezma/getuserdetail')
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

	};}]); */
myApp.controller("abc",['$scope,$UserService', function($scope , $UserService)
    {
	$scope.userdata;
	
	$UserService.getforumDetails().then(
			function(response)
			{
				$scope.userdata = response;
				console.log($scope.userdata);
			},
			function(errResponse)
			{
				console.log('Error while getting user data');
			}
			
	
	);
	
	
		
}]);



</script>


<body>
hiiiiiiiiiiiiii
</body>
</html>