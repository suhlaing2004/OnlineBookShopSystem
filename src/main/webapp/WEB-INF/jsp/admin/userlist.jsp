<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.java.bean.*" %>
<%
    if(session.getAttribute("adminSession") != null){
    	Admin admin=(Admin)session.getAttribute("adminSession");
    	
    }else{
    	response.sendRedirect("adminlogin");
    }
   

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Online Book Shop System</title>
<LINK REL="STYLESHEET" HREF="${pageContext.request.contextPath}/css/stylea.css" >
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css">
</head>
<style>
	.logo h2{
	 font-family: Times New Roman, Times, serif;
	}
.sidebar li div{
	 font-family: Times New Roman, Times, serif;
	 font-size:19px;
	}
</style>
<body>
	<div class="container">
        <div class="topbar">
        <div class="logo">
            <h2>OnlineBookShop.</h2>
        </div>
      
    </div>
    <div class="sidebar">
        <ul>
            <li>
                <a href="dashboard">
                    <i class="fa fa-th-large"></i>
                    <div>Dashboard</div>
                </a>
            </li>
            <li>
                <a href="viewcatagory">
                    <i class="fa fa-chart-bar"></i>
                    <div>Catagories</div>
                </a>
            </li>
            <li>
                <a href="viewbook">
                    <i class="fa fa-book"></i>
                    <div>Books</div>
                </a>
            </li>
           <li>
                <a href="order">
                    <i class="fa fa-shopping-bag"></i>
                    <div>Orders</div>
                </a>
            </li>
            <li>
                <a href="registerlist">
                    <i class="fas fa-users"></i>
                    <div>User List</div>
                </a>
            </li>
            
            <li>
                <a href="signOut" onclick="return confirm('Are you sure SignOut?')">
                    <i class="fa fa-sign-out"></i>
                    <div>Sign Out</div>
                </a>
            </li>
        </ul>
    </div>
   <a href="registerlist">
         <button class="regilist" style="position:absolute;margin-left:300px;margin-top:200px;color:hsl(0, 100%, 50%);background:hsl(0, 100%, 90%);border-color:hsl(0, 100%, 50%);font-size:30px;">Register Users List</button>
   </a>
    
</body>
</html>