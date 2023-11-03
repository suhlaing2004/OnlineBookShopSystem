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
	
</head>
<style>
	.searchinputuser{
	width:1035px;
	margin-left:300px;
	border-radius:5px;
	height:30px;border-color:#ec2727;
	font-family:'Times New Roman', Times, serif;
	font-size:18px;
}
.logo h2{
	 font-family: Times New Roman, Times, serif;
}
.sidebar li div{
	 font-family: Times New Roman, Times, serif;
	 font-size:19px;
}
#booktable thead tr th{
	 font-family: "Times New Roman", Times, serif;
	 font-size:16px;
	 text-align:left;
}
#myTable tr td{
	 font-family: "Times New Roman", Times, serif;
	 text-align:left;
}
#edbtn{
		font-family: Times New Roman, Times, serif;
		text-decoration:none;
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
  <button id="addcatebtn">User Register List</button><br><br>
  <input type="text" id="search" 
	onkeyup="search()" placeholder="Search By Name or Email or Phone No or Address." data-search class="searchinputuser"><br><br>
          <table id="booktable" >
            <thead>
            	<tr>
              	  	<th>User Name</th>
                	<th>User Email</th>
               		<th>Phone Number</th>
                	<th>Address</th>
                	<th>Option</th>
            	</tr>
            </thead>
            <TBODY id="myTable">
             <c:forEach var="user" items="${list}">
            <tr class="tablerow">
               <td class="name">${user.username}</td>
				<td class="email">${user.email}</td>
				<td>${user.phonenumber}</td>
				<td>${user.address}</td>
                <td> <span><a href="deleteuser/${user.id}" id="edbtn">Delete</a></span></td>
               
            </tr>
            </c:forEach>
            </TBODY>
          </table> 
          
          <a href="OnlineBookStoreSystem/registerlist/1">1</a>
           <a href="OnlineBookStoreSystem/registerlist/2">2</a>
            <a href="OnlineBookStoreSystem/registerlist/3">3</a>
	<script>
	function search() {
		var input, filter, found, table, tr, td, i, j;
	    input = document.getElementById("search");
	    filter = input.value.toUpperCase();
	    table = document.getElementById("myTable");
	    tr = table.getElementsByTagName("tr");
	    
	    for (i = 0; i < tr.length; i++) {
	    	var nameMatch=false;
	    	var emailMatch=false;
	    	var phoneMatch=false;
	    	var addressMatch=false;
	    	
	    	td = tr[i].getElementsByTagName("td")[0]; // User Name column
	        if (td) {
	          var nameValue = td.textContent || td.innerText;
	          if (nameValue.toUpperCase().indexOf(filter) > -1) {
	            nameMatch = true;
	          }
	        }
	    	
	    	td=(tr)[i].getElementsByTagName("td")[1];//Email coloumn
	    	if(td){
	    		var emailValue=td.textContext || td.innerText;
	    		if(emailValue.toUpperCase().indexOf(filter)>-1){
	    			emailMatch=true;
	    		}
	    	}
	    	
	    	td = tr[i].getElementsByTagName("td")[2]; // User Name column
	        if (td) {
	          var phoneValue = td.textContent || td.innerText;
	          if (phoneValue.toUpperCase().indexOf(filter) > -1) {
	            phoneMatch = true;
	          }
	        }
	    	
	    	td=(tr)[i].getElementsByTagName("td")[3];//Email coloumn
	    	if(td){
	    		var addressValue=td.textContext || td.innerText;
	    		if(addressValue.toUpperCase().indexOf(filter)>-1){
	    			addressMatch=true;
	    		}
	    	}
	       
	    		
	    		
	    	if (nameMatch || emailMatch || phoneMatch || addressMatch) {
	            tr[i].style.display = "";
	          } else {
	            tr[i].style.display = "none";
	          }
	    	
	    	
	    }
	    
		}
	</script>
</body>
</html>