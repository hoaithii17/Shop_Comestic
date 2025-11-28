<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@page import="data.utils.API" %>
<nav class="navbar navbar-expand-lg bg-body-tertiary">
  <div class="container-fluid">
    <a class="navbar-brand" href="#"> 
        <img src="assets/icon/logo.png" with="50 height="50"/>
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0" style="margin: 0 auto">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="#">Home</a>
        </li>
        
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            Category
          </a>
          <ul class="dropdown-menu">
              <c:forEach items="${listCategory}" var="c">
            <li><a class="dropdown-item" href="#">
                    ${c.getName()}
                </a></li>
              </c:forEach>
          </ul>
        </li>
        <c:if test="${user==null}">
        <li class="nav-item">
          <a class="nav-link" href="login">Login</a>
        </li>
        </c:if>
        <c:if test="${user!=null}">
            <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            Hi 
            <c:set var="s" value="${user.getName()}"></c:set>
            <%
                String name= (String)pageContext.getAttribute("s");
                out.print(API.getName(name));
                %>
          </a>
          <ul class="dropdown-menu">
              
              <li><a class="dropdown-item" href="#">Profile</a></li><!-- comment -->
                <li><a class="dropdown-item" href="./views/logout.jsp">Logout</a></li>
                    
             
          </ul>
        </li> 
        </c:if>
        <li class="nav-item">
          <a class="nav-link" href="cart">
          <img src="assets/icon/cart.png" width="30" height="30"/>
          
          <%-- S?A L?I: Tính t?ng s? l??ng (quantity) c?a t?t c? s?n ph?m trong gi? hàng --%>
          <c:set var="totalQuantity" value="${0}"/>
          <c:if test="${sessionScope.cart != null}">
              <c:forEach var="item" items="${sessionScope.cart}">
                  <c:set var="totalQuantity" value="${totalQuantity + item.quantity}"/>
              </c:forEach>
          </c:if>
          (${totalQuantity})
          <%-- ${fn:length(sessionScope.cart)} ?ã ???c thay th? --%>

          </a>
        </li>
      </ul>
      <form class="d-flex" role="search">
        <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search"/>
        <button class="btn btn-outline-success" type="submit">Search</button>
      </form>
    </div>
  </div>
</nav>