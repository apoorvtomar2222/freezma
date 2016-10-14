<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	
						<tr">
							
							<td colspan="2">
								
									<br>
										<textarea rows="5" class="form-control form-input" placeholder="Write a new Post..." ng-model="postText" ng-disabled="stateDisabled"></textarea>
									<br>
										<button type="button" class="btn btn-primary" style="color: #FFFFFF;" ng-click="AddPost()" ng-disabled="(postText=='') || stateDisabled"><span class="glyphicon glyphicon-pencil"></span>&nbsp;&nbsp;&nbsp;Post&nbsp;&nbsp;&nbsp;</button>
									<br>
								<br>
							</td>
							
						</tr>
</body>
</html>