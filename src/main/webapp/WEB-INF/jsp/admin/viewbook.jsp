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
<!--  <LINK REL="STYLESHEET" HREF="${common.url}/assets/css/pagination.css" >-->
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
		font-family: Times New Roman, Times, serif;
	 	font-size:19px;
	 	text-align:left;
	}
	#booktable tr td{
		font-family: Times New Roman, Times, serif;
	 	font-size:19px;
	 	text-align:left;
	}
	#edbtn{
		font-family: Times New Roman, Times, serif;
		text-decoration:none;
	}
	.pagination-container{
		margin-left:600px;
		margin-top:80px;
		display: flex;
  		align-items: center;
  		position: absolute;
	}
	.pagination-number,
	.pagination-button{
  		font-size: 1.1rem;
  		background-color: transparent;
  		border: none;
  		margin: 0.25rem 0.25rem;
  		cursor: pointer;
  		height: 2.5rem;
  		width: 2.5rem;
  		border-radius: .2rem;
	}

	.pagination-number:hover,
	.pagination-button:not(.disabled):hover {
 		 background: #fff;
	}

	.pagination-number.active {
 		 color: #fff;
 	 	background: #0085b6;
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
   <a href="addbook"><button id="addcatebtn">Add New Book</button></a><br><br>
   <input type="text" id="search"
  onkeyup="search()" placeholder="Search by Book Name or Price or Category Name." data-search class="searchinputuser"><br><br>
 <c:if test="${not empty resultFlag}">
    <div class="message">
        <c:choose>
            <c:when test="${resultFlag == 1}">
                <p class="success" style="margin-left:300px;color:blue;">Successfully delete book!</p><br>
            </c:when>
            <c:when test="${resultFlag == 0}">
                <p class="error" style="margin-left:300px;color:red;">This book can't be deleted!!!Already Ordered!!</p><br>
            </c:when>
        </c:choose>
    </div>
</c:if>
          <table id="booktable" >
          <thead>
            <tr>
                <th>Book Name</th>
                <th>Book Image</th>
                <th>Book Price</th>
                <th>Category Name</th>
                <th>Option</th>
            </tr>
            </thead>
            <TBody id="myTable" data-current-page="1" aria-live="polite">
             <c:forEach var="b" items="${booklist}">
            <tr class="tablerow">
                <td class="bookname">${b.name}</td>
				<td><img width="150" height="200" src="/OnlineBookShopSystem/showImage/${b.id}"></td>
				<td class="price">${b.price}</td>
				<td class="categoryname">${b.categoryname}</td>
                <td><span><a href="editbook/${b.id}" id="edbtn">Edit</a></span>&nbsp&nbsp&nbsp
                    <span><a href="deletebook/${b.id}" id="edbtn" onclick="return confirm('Are you sure Delete?')">Delete</a></span></td>
               
            </tr>
            </c:forEach>
            </TBody>
          </table> 
            <nav class="pagination-container">
      <button class="pagination-button" id="prev-button" aria-label="Previous page" title="Previous page" >
        &lt;
      </button>
  
      <div id="pagination-numbers" >
  
      </div>
  
      <button class="pagination-button" id="next-button" aria-label="Next page" title="Next page" >
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
      var priceMatch = false;
      var categoryMatch=false;
    
      
      td = tr[i].getElementsByTagName("td")[0]; // Book Name column
      if (td) {
        var nameValue = td.textContent || td.innerText;
        if (nameValue.toUpperCase().indexOf(filter) > -1) {
          nameMatch = true;
        }
      }
      
      td = tr[i].getElementsByTagName("td")[1]; // Book Price column
      if (td) {
        var priceValue = td.textContent || td.innerText;
        if (priceValue.toUpperCase().indexOf(filter) > -1) {
          priceMatch = true;
        }
      }
      
      td = tr[i].getElementsByTagName("td")[3];
      if(td){
    	  var categoryValue=td.textContext || td.innerText;
    	  if(categoryValue.toUpperCase().indexOf(filter)>-1){
    		  categoryMatch=true;
    	  }
      }
      
      
      
      if (nameMatch || priceMatch || categoryMatch) {
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


	 
const paginationLimit = 5;
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