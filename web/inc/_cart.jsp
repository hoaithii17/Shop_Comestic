<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html; charset=UTF-8"%>
<c:if test="${not empty error}">
    <div class="alert alert-danger">${error}</div>
    <c:remove var="error" scope="session"/>
</c:if>

<style>
    /* Ẩn nút tăng giảm mặc định của input number */
    input[type=number]::-webkit-inner-spin-button, 
    input[type=number]::-webkit-outer-spin-button { 
        -webkit-appearance: none; 
        margin: 0; 
    }
    
    .hover-shadow-md {
        transition: all 0.3s ease;
    }
    .hover-shadow-md:hover {
        transform: translateY(-2px);
        box-shadow: 0 .5rem 1rem rgba(0,0,0,.15)!important;
    }
    
    .btn-pink {
        background-color: #d63384;
        color: white;
        border: none;
    }
    .btn-pink:hover {
        background-color: #b02a6b;
        color: white;
    }
    
    /* Sticky sidebar cho cột phải */
    .sticky-summary {
        position: -webkit-sticky;
        position: sticky;
        top: 2rem; /* Cách mép trên 2rem khi cuộn */
        z-index: 1020;
    }
</style>

<section class="py-5" style="background-color: #fff5f8; min-height: 100vh;">
  <div class="container">

    <div class="d-flex justify-content-between align-items-center mb-4">
      <h3 class="fw-bold" style="color:#d63384;">Giỏ hàng (${cart.size()})</h3>
      <a href="home" class="text-decoration-none fw-bold" style="color:#d63384;">
        <i class="fas fa-chevron-left me-1"></i> Tiếp tục mua sắm
      </a>
    </div>

    <div class="row g-4">

      <div class="col-lg-8">
        
        <c:set var="total" value="0"/>

        <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
            <div class="card-body p-0">
                
                <c:if test="${empty cart}">
                    <div class="text-center p-5">
                        <img src="./assets/icon/empty-cart.png" width="80" class="mb-3 opacity-50">
                        <p class="text-muted">Giỏ hàng của bạn đang trống</p>
                    </div>
                </c:if>

                <c:forEach items="${cart}" var="product" varStatus="status">
                    <div class="p-3 p-md-4 ${!status.last ? 'border-bottom' : ''} bg-white hover-shadow-md position-relative">
                        <div class="row align-items-center g-3">
                            
                            <div class="col-12 col-md-5 d-flex align-items-center">
                                <div class="position-relative flex-shrink-0">
                                    <img src="./assets/images/${product.image}" class="rounded-3"
                                         style="width:80px; height:80px; object-fit: cover; border:1px solid #fce4ec;">
                                </div>
                                <div class="ms-3">
                                    <h6 class="fw-bold text-dark mb-1">${product.name}</h6>
                                    <p class="text-muted small mb-0">Đơn giá: <fmt:formatNumber value="${product.price * 1000}" pattern="#,###" /> đ</p>
                                </div>
                            </div>

                           <div class="col-6 col-md-4">
    <form action="cart" method="post" class="d-flex align-items-center">
        <input type="hidden" name="id_product" value="${product.id}">
        
        <input type="hidden" name="action" value="update"> 

        <div class="d-flex flex-column">
            <span class="text-muted fst-italic mb-1" style="font-size: 10px;">Nhập số & bấm lưu:</span>

            <div class="input-group input-group-sm" style="width: 140px;">
                <input type="number" name="quantity" value="${product.quantity}" min="1"
                       class="form-control text-center fw-bold border-success text-success"
                       style="background-color: #f8fff9;"
                       onchange="this.form.submit()"> 
                
                <button type="submit" 
                        class="btn btn-success text-white px-3"
                        title="Bấm để cập nhật giá tiền">
                    <i class="fas fa-check"></i>
                </button>
            </div>
        </div>
    </form>
</div>

                            <div class="col-6 col-md-3 text-end">
                                <h6 class="fw-bold" style="color:#d63384;">
                                    <fmt:formatNumber value="${product.price * product.quantity * 1000}" pattern="#,###" /> đ
                                </h6>
                                
                                <form action="cart" method="post" class="d-inline-block mt-1">
                                    <input type="hidden" name="id_product" value="${product.id}">
                                    <button type="submit" name="action" value="delete"
                                            class="btn btn-link text-muted text-decoration-none p-0 btn-sm"
                                            style="font-size: 0.85rem;">
                                        <i class="far fa-trash-alt me-1"></i> Xóa
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                    <c:set var="total" value="${total + (product.price * product.quantity * 1000)}"/>
                </c:forEach>

            </div>
            
            <c:if test="${not empty cart}">
                <div class="card-footer bg-light p-3 text-end">
                    <a href="cart?clear=OK" class="text-muted text-decoration-none small">
                        <i class="fas fa-trash me-1"></i> Xóa tất cả sản phẩm
                    </a>
                </div>
            </c:if>
        </div>
      </div>

      <div class="col-lg-4">
        <div class="sticky-summary">
            <div class="card border-0 shadow rounded-4" style="background-color: white;">
              <div class="card-body p-4">
    
                <h5 class="fw-bold mb-4">Tổng quan đơn hàng</h5>
    
                <div class="d-flex justify-content-between mb-3 text-muted">
                  <span>Tạm tính</span>
                  <span><fmt:formatNumber value="${total}" pattern="#,###" /> đ</span>
                </div>
    
                <div class="d-flex justify-content-between mb-3 text-muted">
                  <span>Phí vận chuyển (10%)</span>
                  <span><fmt:formatNumber value="${total * 0.1}" pattern="#,###" /> đ</span>
                </div>
                
                <hr class="my-4" style="border-style: dashed; color: #adb5bd;">
    
                <div class="d-flex justify-content-between align-items-center mb-4">
                  <span class="fw-bold fs-5">Tổng cộng</span>
                  <span class="fw-bold fs-4" style="color:#d63384;">
                    <fmt:formatNumber value="${total * 1.1}" pattern="#,###" /> đ
                  </span>
                </div>
                
                <div class="mb-4">
                    <p class="small fw-bold text-muted mb-2">Chấp nhận thanh toán:</p>
                    <div class="d-flex gap-2 opacity-75">
                         <img src="./assets/icon/mastercard.png" width="36">
                         <img src="./assets/icon/vietcombank.png" width="36">
                         <img src="./assets/icon/vietinbank.png" width="36">
                    </div>
                </div>
    
                <c:if test="${not empty cart}">
    <a href="./views/checkout.jsp" 
       class="btn btn-pink w-100 py-3 rounded-pill fw-bold shadow-sm text-uppercase text-decoration-none d-block text-center">
      Tiến hành thanh toán
    </a>
</c:if>

<c:if test="${empty cart}">
    <button disabled class="btn btn-secondary w-100 py-3 rounded-pill fw-bold text-uppercase">
        Giỏ hàng trống
    </button>
</c:if>
    
                <div class="text-center mt-3">
                    <small class="text-muted">
                        <i class="fas fa-shield-alt me-1"></i> Bảo mật thanh toán 100%
                    </small>
                </div>
    
              </div>
            </div>
        </div>
      </div>

    </div>
  </div>
</section>