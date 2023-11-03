<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.java.util.common" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Online Book Shop System</title>
<link href="assets/css/main.css" rel="stylesheet">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css">	
</head>
<body style="background-image: url(image/background.jpg);">
 <form:form method="post" action="saveuserloginform" modelAttribute="user">
    <div class="login">
        <h1 style="color:aliceblue;margin-left:10px;font-family:Times New Roman, Times, serif;">User Login Form</h1>
         <c:if test="${wrong_login}">
               <span style="color:red;">Username or Password is wrong!!!</span>
          </c:if><br>
        <i class="fa fa-user" id="icon"></i>
        <form:input type="text" maxlength="50" path="username" required="true" placeholder="User Name" id="emailtext"/><br><br>
        
        <i class="fa fa-user-lock" id="icon"></i>
        <form:input type="password" maxlength="20" path="password" required="true" placeholder="Password" id="pwdtext"/><br><br>
        
        <a href="login">
        	<input type="submit" value="Login" id="loginbtn">
        </a>
    </div>
 </form:form>
 
</body>
</html>