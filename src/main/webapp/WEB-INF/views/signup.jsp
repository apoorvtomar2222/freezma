<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>





<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<title>signup</title>


<c:import url="head-meta.jsp" />

<style>
body {
	background-image: url('resources/images/signup.jpg');
	background-repeat: no-repeat;
	background-attachment: fixed;
	background-position: center;
}
</style>
</head>


<body>
	<c:import url="head.jsp" />
	<br>
	<br>
	<br>
	<br>
	<br>


	<div align="center">

		<c:if test="${not empty passwordmismatch}">
			<br>
			<label class="alert alert-danger">Password Mismatch</label>
			<br>
		</c:if>

		<c:if test="${not empty useralreadyexists}">
			<br>
			<label class="alert alert-danger">Username Already Exists</label>
			<br>
		</c:if>

		<c:if test="${not empty success}">
			<br>
			<label class="alert alert-success">User Created Successfully</label>
			<br>
		</c:if>

		<form:form action="insertuser" method="post" modelAttribute="newuser">
			<table cellspacing="100">
				<tr>
					<td colspan="2" align="center"><h2>SIGN UP</h2></td>
				</tr>

				<tr>
					<td>Username:</td>
					<td><form:input type="" path="Username" /> <label
						class="text text-danger"></label><form:errors path="username" /></td>
       			</tr>

				<tr>
					<td>Password:</td>
					<td><form:input type="password" path="Password" /> <label class="text text-danger"> </label><form:errors path="password" /></td>
				</tr>


				<tr>
					<td>Confirm Password:</td>
					<td><form:input type="password" path="CPassword" /><label class="text text-danger"> </label><form:errors path="CPassword" /></td>
				</tr>

				<tr>
					<td>E-mail:</td>
					<td><form:input path="Email" type="" /><label class="text text-danger"></label><form:errors path="email" /></td>
				</tr>

				<tr>
					<td>Gender:</td>
					<td><form:radiobutton path="Gender" value="M" />Male <form:radiobutton
							path="Gender" value="F" />Female</td>
				</tr>

				<tr>
					<td>Contact No:</td>
					<td><form:input path="Phone" type="" /> <label
						class="text text-danger"></label><form:errors path="phone" /></td>
				</tr>



				<tr>
					<td>Location</td>
					<td><form:input path="address" type="" /> <label class="text text-danger"></label><form:errors path="address" /></td>

				</tr>
				
				<tr>
				&nbsp;&nbsp;
					<td colspan="2" align="center"><input type="submit"
						value="Sign Up" class="btn btn-success" /></td>
				</tr>
			</table>
		</form:form>
	</div>
	<br>
	<br>

</body>
</html>