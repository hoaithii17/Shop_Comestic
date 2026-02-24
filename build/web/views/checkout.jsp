<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <title>Thanh toán đơn hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <style>
        body { background-color: #fff5f8; }
        .form-control:focus {
            border-color: #d63384;
            box-shadow: 0 0 0 0.25rem rgba(214, 51, 132, 0.25);
        }
        .btn-pink {
            background-color: #d63384;
            color: white;
            border: none;
            transition: all 0.3s;
        }
        .btn-pink:hover {
            background-color: #b02a6b;
            color: white;
            transform: translateY(-2px);
        }
        .card-summary {
            background: white;
            border-radius: 20px;
        }
    </style>
</head>
<body>

    <div class="container py-5">
        
        <div class="mb-4">
            <a href="${pageContext.request.contextPath}/cart" class="text-decoration-none fw-bold" style="color:#d63384;">
                <i class="fas fa-arrow-left me-2"></i>Quay lại giỏ hàng
            </a>
        </div>

        <div class="row g-4">
            
            <div class="col-lg-7">
                <div class="card border-0 shadow-sm rounded-4">
                    <div class="card-header bg-white border-0 pt-4 px-4">
                        <h4 class="fw-bold text-dark"><i class="fas fa-shipping-fast me-2 text-muted"></i>Thông tin giao hàng</h4>
                    </div>
                    <div class="card-body p-4">
                        
                        <form action="${pageContext.request.contextPath}/order" method="post" id="checkoutForm">
                            
                            <div class="mb-3">
                                <label class="form-label fw-bold text-muted small">Họ và tên</label>
                                <input type="text" name="customerName" class="form-control form-control-lg" 
                                       placeholder="Ví dụ: Nguyễn Văn A" required>
                            </div>

                            <div class="row g-3 mb-3">
                                <div class="col-md-6">
                                    <label class="form-label fw-bold text-muted small">Số điện thoại</label>
                                    <input type="tel" name="customerPhone" class="form-control form-control-lg" 
                                           placeholder="0912..." required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label fw-bold text-muted small">Email (Tùy chọn)</label>
                                    <input type="email" name="customerEmail" class="form-control form-control-lg" 
                                           placeholder="email@example.com">
                                </div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-bold text-muted small">Địa chỉ nhận hàng</label>
                                <textarea name="customerAddress" class="form-control" rows="2" 
                                          placeholder="Số nhà, tên đường, phường/xã..." required></textarea>
                            </div>

                            <div class="mb-4">
                                <label class="form-label fw-bold text-muted small">Ghi chú đơn hàng</label>
                                <textarea name="orderNote" class="form-control" rows="2" 
                                          placeholder="Ví dụ: Giao hàng giờ hành chính..."></textarea>
                            </div>

                            <hr class="text-muted opacity-25">

                            <h6 class="fw-bold mb-3">Phương thức thanh toán</h6>
                            <div class="d-flex gap-3 mb-4">
                                <div class="form-check border rounded p-3 flex-fill">
                                    <input class="form-check-input" type="radio" name="paymentMethod" id="cod" value="COD" checked>
                                    <label class="form-check-label fw-bold" for="cod">
                                        <i class="fas fa-money-bill-wave text-success me-2"></i> Tiền mặt (COD)
                                    </label>
                                </div>
                                <div class="form-check border rounded p-3 flex-fill text-muted" style="background: #f8f9fa;">
                                    <input class="form-check-input" type="radio" name="paymentMethod" id="bank" value="BANK" disabled>
                                    <label class="form-check-label" for="bank">
                                        <i class="fas fa-university me-2"></i> Chuyển khoản (Bảo trì)
                                    </label>
                                </div>
                            </div>

                            <button type="submit" class="btn btn-pink w-100 py-3 rounded-pill fw-bold fs-5 shadow">
                                XÁC NHẬN ĐẶT HÀNG
                            </button>
                        </form>

                    </div>
                </div>
            </div>

            <div class="col-lg-5">
                <div class="card border-0 shadow card-summary sticky-top" style="top: 2rem;">
                    <div class="card-body p-4">
                        <h5 class="fw-bold mb-4 text-dark">Đơn hàng của bạn</h5>

                        <c:set var="finalTotal" value="0"/>
                        
                        <div class="mb-4" style="max-height: 300px; overflow-y: auto;">
                            <c:forEach items="${cart}" var="p">
                                <div class="d-flex align-items-center mb-3">
                                    <img src="./assets/images/${p.image}" class="rounded" width="50" height="50" style="object-fit:cover;">
                                    <div class="ms-3 flex-grow-1">
                                        <h6 class="mb-0 small fw-bold text-dark">${p.name}</h6>
                                        <small class="text-muted">x ${p.quantity}</small>
                                    </div>
                                    <div class="text-end fw-bold text-dark small">
                                        <fmt:formatNumber value="${p.price * p.quantity * 1000}" pattern="#,###"/> đ
                                    </div>
                                </div>
                                <c:set var="finalTotal" value="${finalTotal + (p.price * p.quantity * 1000)}"/>
                            </c:forEach>
                        </div>

                        <hr>

                        <div class="d-flex justify-content-between mb-2 small text-muted">
                            <span>Tạm tính</span>
                            <span><fmt:formatNumber value="${finalTotal}" pattern="#,###"/> đ</span>
                        </div>
                        <div class="d-flex justify-content-between mb-3 small text-muted">
                            <span>Phí vận chuyển</span>
                            <span><fmt:formatNumber value="${finalTotal * 0.1}" pattern="#,###"/> đ</span>
                        </div>

                        <div class="d-flex justify-content-between fw-bold fs-5 text-danger pt-2 border-top">
                            <span>Tổng thanh toán</span>
                            <span><fmt:formatNumber value="${finalTotal * 1.1}" pattern="#,###"/> đ</span>
                        </div>

                    </div>
                </div>
            </div>

        </div>
    </div>

</body>
</html>