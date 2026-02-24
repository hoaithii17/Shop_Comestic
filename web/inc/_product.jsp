<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="row g-4">

    <c:forEach items="${listProduct}" var="p">
        <div class="col-md-3">
            <div class="card shadow-sm p-2" style="border-radius: 10px;">

                <!-- Ảnh sản phẩm -->
                <img src="./assets/images/${p.image}" 
                     class="card-img-top"
                     style="height: 230px; object-fit: contain;">

                <div class="card-body text-center">

                    <!-- Tên sản phẩm -->
                    <h6 class="fw-bold" style="min-height: 40px;">
                        ${p.name}
                    </h6>

                    <!-- Giá -->
                    <p class="fw-bold" style="color:#d63384;">
                        <fmt:formatNumber value="${p.price * 1000}" pattern="#,###" /> VND
                    </p>
                    <c:if test="${p.quantity <= 0}">
    <button class="btn btn-secondary w-100" disabled>Hết hàng</button>
</c:if>
<c:if test="${p.quantity > 0}">
    <p class="text-muted small mb-1">
        <i class="fas fa-box"></i>
        Còn lại: <strong>${p.quantity}</strong> sản phẩm
    </p>
</c:if>

<p class="small mb-1">
    <span class="badge bg-info-subtle text-info fw-bold px-3">
        🔥 Đã bán ${p.sold}
    </span>
</p>
    


                    <!-- NÚT THÊM GIỎ HÀNG -->
                    <c:choose>
    <%-- Nếu đang xem theo category --%>
    <c:when test="${not empty param.id_category}">
        <a href="product?id_product=${p.id}&id_category=${param.id_category}" 
           class="btn btn-primary w-100"
           style="background-color: #d63384; border: none;">
            Thêm vào giỏ
        </a>
    </c:when>

    <%-- Nếu không có category (ALL products) --%>
    <c:otherwise>
        <a href="product?id_product=${p.id}" 
           class="btn btn-primary w-100"
           style="background-color: #d63384; border: none;">
            Thêm vào giỏ
        </a>
    </c:otherwise>
</c:choose>


                </div>
            </div>
        </div>
    </c:forEach>

</div>
