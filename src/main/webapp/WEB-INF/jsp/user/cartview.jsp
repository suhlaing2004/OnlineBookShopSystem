<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.java.util.common" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Online Book Shop System</title>
 <meta content="" name="description">
  <meta content="" name="keywords">

  <!-- Favicons -->
  <link href="assets/img/favicon.png" rel="icon">
  <link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Google Fonts -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,600;1,700&family=Amatic+SC:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&family=Inter:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="${common.url}/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="${common.url}/assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="${common.url}/assets/vendor/aos/aos.css" rel="stylesheet">
  <link href="${common.url}/assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
  <link href="${common.url}/assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css">

  <!-- Template Main CSS File -->
  <link REL="STYLESHEET" HREF="${common.url}/assets/css/main.css">
</head>
<style>
	#orderbtn{
		margin-left:80px;
		font-family: "Times New Roman", Times, serif;
		border-radius: 5px;
  		border-color: #ec2727;
 		background-color:aliceblue;
  		text-decoration:none;
	}
	#shoppingtext{
		margin-top:100px;
		margin-left:80px;
		color:#ec2727;
		font-family:Times New Roman, Times, serif;
	}
	#table{
		width:80%;
		margin-left:80px;
		border-color:#ec2727;
		table-radius:5px;
	}
	#hadertext{
		font-family:"Times New Roman", Times, serif;
		font-size:18px;
	}
</style>
<body style="background-color:aliceblue">

  <!-- ======= Header ======= -->
  <header id="header" class="header fixed-top d-flex align-items-center">
    <div class="container d-flex align-items-center justify-content-between">

      <a href="index" class="logo d-flex align-items-center me-auto me-lg-0">
        <!-- Uncomment the line below if you also wish to use an image logo -->
        <!-- <img src="assets/img/logo.png" alt=""> -->
        <h1 id="text1">Online Book Shop<span>.</span></h1>
      </a>

      <nav id="navbar" class="navbar">
        <ul>
          <li><a href="index" id="hadertext">Home</a></li>
         <li class="dropdown"><a href="#" id="hadertext"><span>Category</span> <i class="bi bi-chevron-down dropdown-indicator"></i></a>
             <ul>
              <c:forEach var="c" items="${catalist}">
			
			<a href="searchbook/${c.id}">${c.name}</a>	
				
			</c:forEach>
             
            </ul>
          </li>
          <li><a href="book" id="hadertext">Book</a></li>
          
         
             <!--  <li><a href="login" id="hadertext">User Login</a></li>
              <li><a href="register" id="hadertext">Create New Account</a></li>
              <li><a href="logout">Logout</a></li>
              <li><a href="adminlogin">Admin Login</a></li> -->

          <li><a href="cartview"><i class="fa fa-shopping-bag" style="font-size:21px;"></i></a></li>
          <li><a href="logout" id="hadertext" onclick="return confirm('Are you sure SignOut?')">Logout</a></li>
        </ul>
      </nav><!-- .navbar -->
      
      <i class="mobile-nav-toggle mobile-nav-show bi bi-list"></i>
      <i class="mobile-nav-toggle mobile-nav-hide d-none bi bi-x"></i>
	 </div>
  </header><!-- End Header -->
  	<form:form method="post" modelattribute="order" action="saveorder">
	<h3 id="shoppingtext">Your Shopping Cart</h3>
	
	<table cellpadding="2" cellspacing="2" border="1" id="table">
		<tr>
			<th>Option</th>
			<th>Name</th>
			<th>Photo</th>
			<th>Price</th>
			<th>Quantity</th>
			<th>Sub Total</th>
		</tr>
		
		<c:set var="total" value="0"></c:set>
		<c:forEach var="item" items="${sessionScope.cart }">
			<c:set var="total"
				value="${total + item.book.price * item.quantity }"></c:set>
			<tr>
				<td align="center"><a
					href="${pageContext.request.contextPath }/cart/remove/${item.book.id }"
					onclick="return confirm('Are you sure remove?')"><i style="color:red;" class="fa fa-trash"></i></a></td>
				<td>${item.book.name }</td>
				<td><img src="/OnlineBookShopSystem/showImage/${item.book.id}" width="80"></td>
				<td>${item.book.price } ks</td>
				<td>${item.quantity }</td>
				<td>${item.book.price * item.quantity } ks</td>
			</tr>
		</c:forEach>
		<tr>
			<td colspan="6" align="right"><b>Total</b></td>
			<td><b>${total } ks</b></td>
		</tr>
	</table>
	
	<br>

	<button type="submit" onclick="return confirm('Are you sure order?')" id="orderbtn" >Order</button>
	<button id="orderbtn"><a href="${pageContext.request.contextPath }/book">ContinueShopping</a></button>
	</form:form>
  
</body>
</html>