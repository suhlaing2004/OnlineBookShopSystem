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
<LINK REL="STYLESHEET" HREF="${common.url}/assets/css/pagination.css" >
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
	#booktable tr th{
		font-family: "Times New Roman", Times, serif;
	 	font-size:16px;
	 	text-align:left;
	}
	#booktable tr td{
		font-family: "Times New Roman", Times, serif;
	 	font-size:16px;
	 	text-align:left;
	}
	#addcatebtn{
    margin-top:100px;
    margin-left:300px;    
    width:20%;
    font-size: 17px;
    border-radius: 5px;
    border-color: #ec2727;
    background-color:aliceblue;
    font-family: 'Times New Roman', Times, serif;
    cursor: pointer;
}
	#orderbtn{
		width:20%;
		font-size:17px;
		border-radius:5px;
		border-color:#ec2727;
		background-color:aliceblue;
		font-family:'Times New Roman',Times, serif;
		cursor:pointer;
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
    <a href="ordersbydatelist"><button  id="addcatebtn">Order by date List</button></a>
   <a href="orderslist"><button id="orderbtn">Order List</button></a>
   <a href="orderdetaillist"><button id="orderbtn">OrderDetail List</button></a><br><br>
   <input type="text" id="search" 
	onkeyup="search()" placeholder="Search By User Name or Book Name or Quantity." data-search class="searchinputuser"><br><br>
          <table id="booktable" >
          <thead>
            <tr>
                <th>User Name</th>
                <th>Date</th>
                <th>Book Name</th>
                <th>Quantity</th>
         
            </tr>
            </thead>
            <TBODY id="myTable" data-current-page="1" aria-live="polite" >
              <c:forEach var="order" items="${olist}">
			<tr class="tablerow">
				
				<td class="user_name">${order.user_name}</td>
				<td>${order.date}</td>
				<td>${order.book_name}</td>
				<td>${order.quantity}</td>
			
				
			</tr>
			</c:forEach>
			 </TBODY>
          </table> 
          <nav class="pagination-container">
      <button class="pagination-button" id="prev-button" aria-label="Previous page" title="Previous page">
        &lt;
      </button>
  
      <div id="pagination-numbers">
  
      </div>
  
      <button class="pagination-button" id="next-button" aria-label="Next page" title="Next page">
        &gt;
      </button>
    </nav>
         
	<script>
	function search() {
	    var input, filter, table, tr, td, i;
	    input = document.getElementById("search");
	    filter = input.value.toUpperCase();
	    table = document.getElementById("myTable");
	    tr = table.getElementsByTagName("tr");

	    for (i = 0; i < tr.length; i++) {
	      var nameMatch = false;
	      var booknameMatch = false;
	      var quantityMatch=false;
	    
	      
	      td = tr[i].getElementsByTagName("td")[0]; 
	      if (td) {
	        var nameValue = td.textContent || td.innerText;
	        if (nameValue.toUpperCase().indexOf(filter) > -1) {
	          nameMatch = true;
	        }
	      }
	      
	      td = tr[i].getElementsByTagName("td")[2]; // Book Price column
	      if (td) {
	        var booknameValue = td.textContent || td.innerText;
	        if (booknameValue.toUpperCase().indexOf(filter) > -1) {
	          booknameMatch = true;
	        }
	      }
	      
	      td = tr[i].getElementsByTagName("td")[3];
	      if(td){
	    	  var quantityValue=td.textContext || td.innerText;
	    	  if(quantityValue.toUpperCase().indexOf(filter)>-1){
	    		  quantityMatch=true;
	    	  }
	      }
	      
	      
	      
	      if (nameMatch || booknameMatch || quantityMatch) {
	        tr[i].style.display = "";
	      } else {
	        tr[i].style.display = "none";
	      }
	    }
	  }
	</script>
	<script>
	const paginationNumbers = document.getElementById("pagination-numbers");
	   const paginatedList = document.getElementById("myTable");
	   const listItems = paginatedList.querySelectorAll("tr");
	   const nextButton = document.getElementById("next-button");
	   const prevButton = document.getElementById("prev-button");

	   
		 
	   const paginationLimit = 10;
	   const pageCount = Math.ceil(listItems.length / paginationLimit);
	   let currentPage = 1;

	   const disableButton = (button) => {
	     button.classList.add("disabled");
	     button.setAttribute("disabled", true);
	   };

	   const enableButton = (button) => {
	     button.classList.remove("disabled");
	     button.removeAttribute("disabled");
	   };

	   const handlePageButtonsStatus = () => {
	     if (currentPage === 1) {
	       disableButton(prevButton);
	     } else {
	       enableButton(prevButton);
	     }

	     if (pageCount === currentPage) {
	       disableButton(nextButton);
	     } else {
	       enableButton(nextButton);
	     }
	   };

	   const handleActivePageNumber = () => {
	     document.querySelectorAll(".pagination-number").forEach((button) => {
	       button.classList.remove("active");
	       const pageIndex = Number(button.getAttribute("page-index"));
	       if (pageIndex == currentPage) {
	         button.classList.add("active");
	       }
	     });
	   };

	   const appendPageNumber = (index) => {
	     const pageNumber = document.createElement("button");
	     pageNumber.className = "pagination-number";
	     pageNumber.innerHTML = index;
	     pageNumber.setAttribute("page-index", index);
	     pageNumber.setAttribute("aria-label", "Page " + index);

	     paginationNumbers.appendChild(pageNumber);
	   };

	   const getPaginationNumbers = () => {
	     for (let i = 1; i <= pageCount; i++) {
	       appendPageNumber(i);
	     }
	   };
		
	   const tableRows=paginatedList.querySelectorAll("tr.tablerow");
	   const setCurrentPage = (pageNum) => {
	     currentPage = pageNum;

	     handleActivePageNumber();
	     handlePageButtonsStatus();
	     
	     const prevRange = (pageNum - 1) * paginationLimit;
	     const currRange = pageNum * paginationLimit;

	     listItems.forEach((item, index) => {
	     
	       if (index >= prevRange && index < currRange) {
	         item.style.display="";
	       }else{
	    	   item.style.display="none"
	       }
	     });
	   };

	   window.addEventListener("load", () => {
	     getPaginationNumbers();
	     setCurrentPage(1);

	     prevButton.addEventListener("click", () => {
	       setCurrentPage(currentPage - 1);
	     });

	     nextButton.addEventListener("click", () => {
	       setCurrentPage(currentPage + 1);
	     });

	     document.querySelectorAll(".pagination-number").forEach((button) => {
	       const pageIndex = Number(button.getAttribute("page-index"));

	       if (pageIndex) {
	         button.addEventListener("click", () => {
	           setCurrentPage(pageIndex);
	         });
	       }
	     });
	   });
	</script>
</body>
</html>