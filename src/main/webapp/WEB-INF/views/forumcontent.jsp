<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<c:import url="head-meta.jsp"></c:import>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<script>

var myapp = angular.module('myApp',[]);


myapp.factory=('UserService',['$http','$q',function($http,$q)
             {
	return
	{
		sentForumContent:function(item)
		return $http.post('http//localhost:9000/freezma/sentForumContent/',item)
		.then
		(
				function(response)
				{
					return response.data;
				}
				,
				function(errResponse)
				{
					
					console.error('erro while sending data');
					return $q.reject(errResponse);
				}
		
		);
		
		
	};
	}   ]);
myapp.controller('abc',['$scope','UserService',function($scope,$UserService)
		{
		$scope.forumcontent="";
		
		sentForumContent = function (forumcontent)
		{
			alert("hi");
			console.log(JSON.stringify($scope.forumcontent));
			
			$UserService.sentForumContent(JSON.stringify($scope.forumcontent)).then(
					
					function(response)
					{
						if(response.status=='updated')
							{
							
							
							console.log(response.status);
							}
					},
					function(errRresponse)
					{
						console.log('Error in updating user data');
					}
			
			
			)
			};
		
		
		}]);
</script>





<body ng-app="myApp" ng-controller="abc" style="background-image: url('${pageContext.request.contextPath}/resources/images/1C.jpg');">
	<c:import url="head.jsp" />

	<br>
	<br>
	<br>
	<br>

	<div class="container" style="background-color: rgba(0,0,0,0.4); padding:10px; color: white;">
		<div style="color: white;"class="table">
			<div class="row"  style= " text-align:center;   padding:2px; text-transform: capitalize" >
	
				<div>
					<div style="font-size: 70px; font-family: tahoma;" >${ForumWriter} Blog</div>
				</div>
	
				<div>
					<div style="font-size: 30px;">Topic Name : ${ForumTopicname}</div>
				</div>
				
				<div>
					<div  style="font-size: 30px;">Topic Desciption : ${ForumTopicdescription}</div>
				</div>
	
		</div>				
	</div>
</div>
<br><br>


<div>

<div style ="border: solid 1px; padding: 20px; "class="container">


<textarea class="form-control" placeholder="Write a Post" ng-model="forumcontent"></textarea>
<br>
<button class="btn btn-success pull-right" ng-click="sentForumContent(forumcontent);">Submit</button>

</div>



</div>




<br><br>
<br><br>

















<div>

<div id="myCarousel" class="carousel slide" >
  <!-- Indicators -->
  <ol class="carousel-indicators">
    <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
    <li data-target="#myCarousel" data-slide-to="1"></li>
    <li data-target="#myCarousel" data-slide-to="2"></li>
    <li data-target="#myCarousel" data-slide-to="3"></li>
  </ol>

  <!-- Wrapper for slides -->
  <div class="carousel-inner" style="background-color:rgba(0,0,0,0.5);" role="listbox">
    <div class="item active">
      
    </div>

    <div class="item">
      <img src="${pageContext.request.contextPath}/resources/images/1C.jpg" alt="Chania">
    </div>

    <div class="item">
      <img src="${pageContext.request.contextPath}/resources/images/2c.jpg" alt="Flower">
    </div>

    <div class="item">
      <img src="img_flower2.jpg" alt="Flower">
    </div>
  </div>

  <!-- Left and right controls -->
  <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
    <span class="sr-only">Previous</span>
  </a>
  <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
    <span class="sr-only">Next</span>
  </a>
</div>








</body>
</html>