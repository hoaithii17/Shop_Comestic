<%@page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style>
    /* --- THEME PINK PASTEL (Đồng bộ với trang chi tiết) --- */
    :root {
        --pink-primary: #ffb7c5;
        --pink-light: #fff0f5;
        --pink-dark: #e88a9e;
        --text-gray: #495057;
        --green-pastel: #d1e7dd;
        --green-text: #0f5132;
        --orange-pastel: #ffe5d0;
        --orange-text: #fd7e14;
    }

    body {
        font-family: 'Nunito', sans-serif;
        background-color: #f8f9fa;
        color: var(--text-gray);
    }

    /* Tiêu đề */
    .page-title {
        color: #333;
        font-weight: 800;
        position: relative;
        display: inline-block;
        margin-bottom: 30px;
    }
    
    .page-title::after {
        content: '';
        position: absolute;
        bottom: -8px;
        left: 0;
        width: 50px;
        height: 4px;
        background-color: var(--pink-primary);
        border-radius: 2px;
    }

    /* Card bao quanh bảng */
    .table-card {
        background: #fff;
        border: none;
        border-radius: 16px;
        box-shadow: 0 4px 20px rgba(0,0,0,0.03);
        overflow: hidden; /* Để bo góc table */
    }

    /* Tùy chỉnh Table */
    .table-pastel thead {
        background-color: var(--pink-light);
    }

    .table-pastel th {
        color: var(--pink-dark);
        font-weight: 700;
        border: none;
        padding: 18px;
        font-size: 0.95rem;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }

    .table-pastel td {
        padding: 18px;
        vertical-align: middle;
        border-bottom: 1px solid #f1f1f1;
        font-weight: 600;
    }

    .table-pastel tr:last-child td {
        border-bottom: none;
    }
    
    .table-pastel tbody tr:hover {
        background-color: #fffcfd; /* Hiệu ứng hover hồng rất nhạt */
    }

    /* Badge trạng thái tùy chỉnh */
    .badge-pastel-process {
        background-color: var(--orange-pastel);
        color: var(--orange-text);
        padding: 8px 12px;
        border-radius: 8px;
        font-weight: 700;
    }

    .badge-pastel-success {
        background-color: var(--green-pastel);
        color: var(--green-text);
        padding: 8px 12px;
        border-radius: 8px;
        font-weight: 700;
    }

    /* Nút xem chi tiết */
    .btn-view-detail {
        background-color: #fff;
        border: 2px solid var(--pink-primary);
        color: var(--pink-dark);
        border-radius: 50px;
        padding: 6px 20px;
        font-size: 0.9rem;
        font-weight: 700;
        transition: all 0.3s;
    }

    .btn-view-detail:hover {
        background-color: var(--pink-primary);
        color: #fff;
        box-shadow: 0 4px 10px rgba(255, 183, 197, 0.5);
    }
    
    /* Trạng thái trống */
    .empty-state {
        text-align: center;
        padding: 60px 20px;
    }
    .empty-icon {
        font-size: 4rem;
        color: #e9ecef;
        margin-bottom: 20px;
    }
</style>

<div class="container py-5">
    
    <div class="d-flex align-items-center mb-2">
        <h3 class="page-title"><i class="fas fa-shopping-bag me-2" style="color: var(--pink-primary);"></i>Đơn hàng của tôi</h3>
    </div>

    <div class="table-card">
        <div class="table-responsive">
            <table class="table table-pastel table-hover mb-0 align-middle">
                <thead>
                    <tr>
                        <th class="ps-4">Mã ĐH</th>
                        <th>Ngày đặt</th>
                        <th>Tổng tiền</th>
                        <th class="text-center">Trạng thái</th>
                        <th class="text-end pe-4">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:if test="${empty orders}">
                        <tr>
                            <td colspan="5">
                                <div class="empty-state">
                                    <div class="empty-icon"><i class="fas fa-box-open"></i></div>
                                    <h5 class="fw-bold text-muted mb-3">Bạn chưa có đơn hàng nào</h5>
                                    <p class="text-muted mb-4">Hãy khám phá thêm các sản phẩm tuyệt vời của chúng tôi nhé!</p>
                                    <a href="${pageContext.request.contextPath}/home" class="btn btn-view-detail px-4 py-2">
                                        Mua sắm ngay
                                    </a>
                                </div>
                            </td>
                        </tr>
                    </c:if>

                    <c:forEach items="${orders}" var="o">
                        <tr>
                            <td class="ps-4">
                                <span class="fw-bold" style="color: #333;">#${o.id}</span>
                            </td>
                            <td class="text-muted">
                                <i class="far fa-calendar-alt me-1 small"></i>
                                <fmt:formatDate value="${o.orderDate}" pattern="dd/MM/yyyy HH:mm"/>
                            </td>
                            <td>
                                <span class="fw-bold" style="color: var(--pink-dark);">
                                    <fmt:formatNumber value="${o.totalMoney}" pattern="#,###"/> đ
                                </span>
                            </td>
     <td class="text-center">
    <div class="status-badge">
        <c:choose>
            <c:when test="${o.status == 0}">
                <span style="background-color:#fff0f6; color:#d63384; padding:8px 16px; border-radius:8px; font-weight:700;">
                    <i class="fas fa-hourglass-start me-1"></i> Đang xử lý
                </span>
            </c:when>
            <c:when test="${o.status == 1}">
                <span style="background-color:#ffe5b4; color:#ff7f00; padding:8px 16px; border-radius:8px; font-weight:700;">
                    <i class="fas fa-box me-1"></i> Đang đóng gói
                </span>
            </c:when>
            <c:when test="${o.status == 2}">
                <span style="background-color:#d4edda; color:#28a745; padding:8px 16px; border-radius:8px; font-weight:700;">
                    <i class="fas fa-truck me-1"></i> Đang vận chuyển
                </span>
            </c:when>
            <c:when test="${o.status == 3}">
                <span style="background-color:#cfe2ff; color:#0d6efd; padding:8px 16px; border-radius:8px; font-weight:700;">
                    <i class="fas fa-check-circle me-1"></i> Đã giao hàng
                </span>
            </c:when>
            <c:when test="${o.status == 4}">
                <span style="background-color:#f8d7da; color:#dc3545; padding:8px 16px; border-radius:8px; font-weight:700;">
                    <i class="fas fa-times-circle me-1"></i> Đã hủy
                </span>
            </c:when>
        </c:choose>
    </div>
</td>


                            </td>
                            <td class="text-end pe-4">
                                <a href="${pageContext.request.contextPath}/order-detail?id=${o.id}" class="btn btn-view-detail text-decoration-none">
                                    Chi tiết <i class="fas fa-arrow-right ms-1"></i>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>