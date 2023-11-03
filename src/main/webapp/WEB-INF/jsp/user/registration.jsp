<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.java.util.common"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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

 <form:form modelAttribute="user" action="register" method="post">
    <div class="login">
        <h1 style="color:aliceblue;margin-left:10px;font-family:Times New Roman, Times, serif;">Registration Form</h1><br>
        
        <i class="fa fa-user" id="icon"></i>
        <form:input type="text" maxlength="50" path="username" required="true" pattern="^[A-Za-z\s]+$"  placeholder="UserName" id="nametext"/><br><br>
        
        <i class="fa fa-envelope" id="icon"></i>
        <form:input path="email" required="true" type="text"  placeholder="suhlaing@gmail.com" onkeyup="validateEmail()" id="emailtext"/><br>
        <span id="email-error" style="color:red;"></span><br><br>
        
        <i class="fa fa-user-lock" id="icon"></i>
        <form:input type="password" maxlength="20" path="password" required="true" placeholder="Password" id="pwdtext"/><br><br>
        
        <i class="fa fa-phone" id="icon"></i>
        <form:input type="number" path="phonenumber" required="true" placeholder="+959XXXXXXXXX" onkeyup="validatePhone()" id="phoneno"/><br>
        <span id="phone-error" style="color:red;"></span><br><br>
        
        <i class="fa fa-address-book" rows="5" cols="50" id="icon"></i>
        <form:textarea rows="3" cols="50" maxlength="50" path="address" required="true" placeholder="Receiving Address" id="addrtext"/><br><br>
        
        <input type="submit" value="Register" id="loginbtn">
     
    </div>
</form:form>
</body>
<script src="<%=common.url%>/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	var emailtext = document.getElementById("emailtext");
	var emailError = document.getElementById("email-error")
	
	function validateEmail(){
		if(!emailtext.value.match(/^[A-Za-z\._\-0-9]*[@][A-Za-z]*[\.][a-z]{2,4}$/)){
			emailError.innerHTML = "Please enter a valid email";
			emailtext.style.borderBottomColor = "red";
			return false;
		}
		emailError.innerHTML="";
		emailtext.style.borderBottomColor="green";
		return true;
	}
	
</script>
<script type="text/javascript">
	var phoneno = document.getElementById("phoneno");
	var phoneError = document.getElementById("phone-error")
	
	function validatePhone(){
		if(!phoneno.value.match(/^\+?95[1-9]\d{9}$/)){
			phoneError.innerHTML = "Please enter a valid phone";
			phoneno.style.borderBottomColor = "red";
			return false;
		}
		phoneError.innerHTML="";
		phoneno.style.borderBottomColor="green";
		return true;
	}
	
</script>
</html>