<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- HEADER & NAVBAR TĨNH -->
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/navbar.jsp" %>

<div class="container py-5">
    <h2 class="mb-4">Danh sách sản phẩm</h2>

    <!-- BODY DYNAMIC -->
    <!-- BODY DYNAMIC -->
<c:import url="/inc/_product.jsp" />

</div>

<!-- FOOTER -->
<%@ include file="../inc/footer.jsp" %>
