<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.java.util.common" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<LINK REL="STYLESHEET" HREF="${common.url}/assets/css/stylea.css" >
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
                <div class="main">
                    <div class="cards">
                    
                    <div class="card" style="cursor:pointer;">
                        
                            <div class="card-content">
                                <div class="card-name">Users</div>
                                <c:forEach var="countusers" items="${countusers}">
                                <div class="number">${countusers.id}</div></c:forEach>
                                
                            </div>
                            <a href="registerlist">
                            <div class="icon-box">
                                <i class="fa fa-users"></i>
                            </div></a>
                        </div>
                   
                        <div class="card" style="cursor:pointer;">
                        
                            <div class="card-content">
                                <div class="card-name">Catagories</div>
                                <c:forEach var="countcatagories" items="${countcatagories}">
                                <div class="number">${countcatagories.id}</div></c:forEach>
                                
                            </div>
                            <a href="viewcatagory">
                            <div class="icon-box">
                                <i class="fa fa-chart-bar"></i>
                            </div></a>
                        </div>
                        
                        
                        <div class="card" style="cursor:pointer;">
                        
                            <div class="card-content">
                                
                                <div class="card-name">Books</div>
                                <c:forEach var="countbook" items="${countbook}">
                                    <div class="number">${countbook.id}</div>
                                </c:forEach>
                            </div>
                            <a href="viewbook">
                            <div class="icon-box">
                                <i class="fa fa-book"></i>
                            </div></a>
                        </div>
                        <div class="card" style="cursor:pointer;">
                        
                            <div class="card-content">
                                <div class="card-name">Orders</div>
                                <c:forEach var="countorders" items="#{countorders}">
                                    <div class="number">${countorders.id}</div>
                                </c:forEach>
                                
                            </div>
                            <a href="order">
                            <div class="icon-box">
                                <i class="fa fa-shopping-bag"></i>
                            </div></a>
                        </div>
                      
                        </div>
                    </div>
                </div>
        
        </body>
        
</html>