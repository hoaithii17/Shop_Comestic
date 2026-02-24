<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
<style>
    /* --- STYLE CHO NOTIFICATION --- */
    .notify-card {
        background: white;
        border-radius: 16px;
        box-shadow: 0 4px 20px rgba(0,0,0,0.05);
        overflow: hidden;
        border: 1px solid rgba(0,0,0,0.02);
    }

    .notify-header {
        padding: 20px 25px;
        border-bottom: 1px solid #f0f0f0;
        display: flex;
        justify-content: space-between;
        align-items: center;
        background: #fff;
    }

    .notify-title {
        color: #d63384; /* Màu hồng chủ đạo */
        font-weight: 800;
        font-size: 1.1rem;
        margin: 0;
        display: flex;
        align-items: center;
    }

    .badge-count {
        background: #d63384;
        color: white;
        font-size: 0.75rem;
        padding: 4px 10px;
        border-radius: 20px;
        margin-left: 10px;
    }

    /* List Items */
    .notify-list {
        max-height: 400px; /* Giới hạn chiều cao, cuộn nếu dài */
        overflow-y: auto;
    }

    .notify-item {
        display: flex;
        align-items: flex-start;
        padding: 15px 25px;
        border-bottom: 1px dashed #f0f0f0;
        transition: all 0.2s ease;
        text-decoration: none;
        color: #333;
    }

    .notify-item:last-child { border-bottom: none; }
    .notify-item:hover { background-color: #fff0f6; /* Hover hồng nhạt */ }

    .notify-icon {
        width: 45px; height: 45px;
        background: #e7f5ff; /* Xanh nhạt */
        color: #0d6efd;
        border-radius: 50%;
        display: flex; align-items: center; justify-content: center;
        font-size: 1.2rem;
        margin-right: 15px;
        flex-shrink: 0;
    }

    .notify-content p { margin: 0; font-size: 0.95rem; }
    .notify-content strong { color: #d63384; }
    
    .notify-time {
        font-size: 0.8rem;
        color: #888;
        margin-top: 4px;
        display: block;
    }

    /* Empty State */
    .empty-notify {
        text-align: center;
        padding: 40px 20px;
        color: #aaa;
    }
    .empty-notify i { font-size: 3rem; margin-bottom: 15px; opacity: 0.5; }
    
    /* Scrollbar đẹp */
    .notify-list::-webkit-scrollbar { width: 6px; }
    .notify-list::-webkit-scrollbar-thumb { background-color: #eee; border-radius: 10px; }
</style>

<div class="notify-card">
    
    <div class="notify-header">
        <h5 class="notify-title">
            <i class="fas fa-bell me-2"></i> Thông báo đơn hàng
            <c:if test="${not empty notifications}">
                <span class="badge-count">${notifications.size()} mới</span>
            </c:if>
        </h5>
        <c:if test="${not empty notifications}">
            <a href="#" class="text-muted small text-decoration-none">Đánh dấu đã đọc</a>
        </c:if>
    </div>

    <div class="notify-list">
        
        <c:if test="${empty notifications}">
            <div class="empty-notify">
                <i class="far fa-bell-slash"></i>
                <p>Hiện tại chưa có đơn hàng mới nào.</p>
            </div>
        </c:if>

        <c:if test="${not empty notifications}">
            <c:forEach var="o" items="${notifications}">
                <a href="${pageContext.request.contextPath}/admin/order?action=view&id=${o.id}" class="notify-item">
                    
                    <div class="notify-icon">
                        <i class="fas fa-shopping-bag"></i>
                    </div>
                    
                    <div class="notify-content">
                        <p>
                            Khách hàng <strong>${o.fullname}</strong> vừa đặt đơn hàng mới 
                            <span class="fw-bold">#${o.id}</span>
                        </p>
                        <span class="notify-time">
                            <i class="far fa-clock me-1"></i>
                            <fmt:formatDate value="${o.orderDate}" pattern="dd/MM/yyyy HH:mm"/>
                        </span>
                    </div>
                </a>
            </c:forEach>
        </c:if>

    </div>
    
    <c:if test="${not empty notifications}">
        <div class="text-center py-2 bg-light border-top">
            <a href="${pageContext.request.contextPath}/admin/orders" class="small fw-bold text-decoration-none" style="color:#d63384;">Xem tất cả</a>
        </div>
    </c:if>
</div>