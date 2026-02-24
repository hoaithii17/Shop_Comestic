<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<section class="container py-5">
    <h2 class="fw-bold mb-4 text-center">🔥 Best Seller</h2>

    <div class="row g-4">
        <c:forEach items="${bestSeller}" var="p">
            <div class="col-md-3">
                <div class="card shadow-sm p-2" style="border-radius:10px;">

                    <!-- IMAGE -->
                    <img src="./assets/images/${p.image}" class="card-img-top"
                         style="height:220px; object-fit:contain;">

                    <div class="card-body text-center">

                        <!-- NAME -->
                        <h6 class="fw-bold">${p.name}</h6>

                        <!-- PRICE -->
                        <p class="fw-bold" style="color:#d63384;">
                            <fmt:formatNumber value="${p.price * 1000}" type="number" pattern="#,###" /> VND
                        </p>

                        <!-- ADD TO CART BUTTON -->
                        <a href="home?id_product=${p.id}"
                           class="btn w-100"
                           style="background:#d63384; border:none; color:white; font-weight:600;">
                           Thêm vào giỏ
                        </a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</section>
