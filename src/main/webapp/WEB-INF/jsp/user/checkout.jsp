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
	#hadertext{
		font-family:"Times New Roman", Times, serif;
		font-size:18px;
	}
</style>
<body style="background-color:aliceblue">
	<div class="checkout">
      <h3 id="infotext">Your Information</h3>
        <hr>
        <span id="spantext">Name:</span><span id="spanvalue">${user.username}</span>
     
        <span id="spantext">PhoneNumber:</span><span id="spanvalue">${user.address}</span>
        <hr>
        <h3 id="infotext">Your Books Order</h3>
        <hr>
        <table cellpadding="2" cellspacing="2" border="1" id="tableorder">
            <tr>
              <th>Book Name</th>
              <th>Book Price</th>
              <th>Quantity</th>
              <th>Sub Total</th>
          </tr>
          <c:forEach items="${cart}" var="x">
		<tr>
			<c:set var="total"
				value="${total + x.book.price * x.quantity}"></c:set>
			<td>${x.book.name}</td>
			<td>${x.book.price} ks</td>
			<td>${x.quantity}</td>
			<td>${x.book.price * x.quantity} ks</td>
		</tr>
		</c:forEach>
      </table>
      <!-- <span id="totalammount">Your Delievery Charges:</span><span id="delivalue">${4000} ks (in Yangoon)</span><br> -->
      	<span id="totalammount">Your Total Ammout:</span><span id="ammountvalue">${total} ks</span>
    </div>
    <button id="ordecomfirmbtn">Your Order is Comfirm.Thank You Very Much For Your Purchase!!!</button> <br>
    <a href="logout"><button id="ordecomfirmbtn" onclick="return confirm('Are you sure SignOut?')">LogOut</button></a>
</body>
</html>