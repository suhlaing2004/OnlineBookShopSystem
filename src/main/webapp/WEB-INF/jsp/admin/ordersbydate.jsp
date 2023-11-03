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
	#ebbtn{
		font-family: "Times New Roman", Times, serif;
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
   <button id="addcatebtn">Order List By Date</button>
   <button id="addcatebtn"><a href="${pageContext.request.contextPath}/order" id="ebbtn">Cancle</a></button><br><br>
         <table id="booktable" >
         <thead>
           <tr>
               <th>UserName</th>
             	<th>BookName</th>
              	<th>Price</th>
              	<th>Quantity</th>
              	<th>Date</th>
            </tr>
            </thead>
             <TBODY id="myTable" data-current-page="1" aria-live="polite" >
              <c:forEach var="orderbydate" items="${obydatelist}">
			<tr>
				<c:set var="total" value="${total + orderbydate.price * orderbydate.quantity}"></c:set>
				<td>${orderbydate.user_name}</td>
				<td>${orderbydate.book_name}</td>
				<td>${orderbydate.price}</td>
				<td>${orderbydate.quantity}</td>
				<td>${orderbydate.date}</td>
				
			</tr>
			</c:forEach>
			</TBODY>
          </table> 
          <span style="margin-left:300px;"><b>Today's total sales:${total}</b></span>
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