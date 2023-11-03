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
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
<link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
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
    
<div class="addcategory">
<form:form method="POST" action="/OnlineBookShopSystem/editsave" modelAttribute="bookedit" enctype="multipart/form-data">
	
            <h3 class="catetext">Edit Book</h3><br>
            <form:hidden path="id" value="${booktoedit.id}"/>
            <h4 class="catanamespan">Book Name:</h4>
            <form:input type="text" path="name" value="${booktoedit.name}" required="true"  class="catenameadd"/><br><br>


            <h4 class="catanamespan">Book Image:</h4>
            <form:input type="file" path="image" size="50"  required="true" alt="add image" class="catenameadd"/><br><br>
            
            <h4 class="catanamespan">Book Price:</h4>
            <form:input type="text" path="price" value="${booktoedit.price}" required="true" class="catenameadd"/><br><br>

            <h4 class="catanamespan">Category Name:</h4>
            <form:select  path="category_id" required="true">
				<c:forEach var="category" items="${catagoriesList}">
					<form:option value="${category.id}">${category.name}</form:option>
			    </c:forEach>
			</form:select>

            <button id="catabtn" type="submit">Edit Save</button>
           <!-- <button id="catabtn">Cancle</button> --> 
          </form:form>
	</div>
<script>
	var category = document.getElementById("category");
	category.value="${booktoedit.category_id}";
	
</script>      

</body>
</html>