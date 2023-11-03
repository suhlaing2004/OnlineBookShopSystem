<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Online Book Shop System</title>
</head>
<!-- Favicons -->
  <link href="assets/img/favicon.png" rel="icon">
  <link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Google Fonts -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,600;1,700&family=Amatic+SC:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&family=Inter:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="assets/vendor/aos/aos.css" rel="stylesheet">
  <link href="assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
  <link href="assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css">

  <!-- Template Main CSS File -->
  <link href="assets/css/main.css" rel="stylesheet">

<body>
</head>
<style>
	#hadertext{
		font-family:"Times New Roman", Times, serif;
		font-size:18px;
	}
</style>
<body>

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

          <li><a href="login" id="hadertext">User Login</a></li>
          <li><a href="register" id="hadertext">Create New Account</a></li>
           <!-- <li><a href="logout">Logout</a></li>
              <li><a href="adminlogin">Admin Login</a></li> -->
          <li><a href="cartview"><i class="fa fa-shopping-bag" style="font-size:21px;"></i></a></li>
        </ul>
      </nav><!-- .navbar -->
      
      <i class="mobile-nav-toggle mobile-nav-show bi bi-list"></i>
      <i class="mobile-nav-toggle mobile-nav-hide d-none bi bi-x"></i>


      

    </div>
  </header><!-- End Header -->
  
  <main class="main">
    <div class="image">
      <img src="image/book.jpg">
    </div>
    <div class="note">
      <h2 id="text2"><i>Your Can Buy<br>Your Require Books</i></h2>
     <a href="book"><button id="searchbtn">Search Book</button></a> 
    </div>
    
  </main><!-- End #main -->
</body>
</html>