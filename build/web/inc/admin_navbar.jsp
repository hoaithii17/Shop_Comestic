<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
    :root {
        --admin-bg: #fff0f6;
        --admin-text: #d63384;
        --admin-hover: #ffffff;
        --admin-shadow: rgba(214, 51, 132, 0.15);
        --navbar-height: 70px;
    }

    .navbar-admin {
        background-color: var(--admin-bg);
        border-bottom: 1px solid #ffcce3;
        box-shadow: 0 4px 12px var(--admin-shadow);
        padding: 0 1.5rem;
        height: var(--navbar-height);
        display: flex;
        align-items: center;
    }

    .brand-text {
        color: var(--admin-text);
        font-size: 1.3rem;
        font-weight: 800;
        letter-spacing: 0.5px;
        white-space: nowrap;
    }

    .nav-link-admin {
        color: var(--admin-text) !important;
        font-weight: 600;
        padding: 8px 16px !important;
        border-radius: 50px;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        white-space: nowrap;
        font-size: 0.95rem;
        margin: 0 2px;
    }

    .nav-link-admin:hover {
        background-color: var(--admin-hover);
        transform: translateY(-2px);
        box-shadow: 0 4px 10px var(--admin-shadow);
    }
    
    .dropdown-menu-admin {
        background-color: #fff;
        border: 1px solid #ffcce3;
        border-radius: 12px;
        box-shadow: 0 5px 20px rgba(0,0,0,0.05);
        margin-top: 15px;
    }

    .avatar-circle {
        width: 38px; height: 38px; 
        background: #d63384; color: white; 
        border-radius: 50%; 
        display: flex; align-items: center; justify-content: center; 
        margin-right: 10px; 
        font-weight: bold; font-size: 1rem;
    }
</style>

<nav class="navbar navbar-expand-lg navbar-admin sticky-top">
    <div class="container-fluid">

        <a class="navbar-brand d-flex align-items-center" href="${pageContext.request.contextPath}/admin">
            <div style="background: white; padding: 6px; border-radius: 50%; margin-right: 12px;">
                <img src="${pageContext.request.contextPath}/assets/icon/logoo.png" width="32" height="32">
            </div>
            <span class="brand-text">Admin Panel</span>
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#adminNav">
            <i class="fas fa-bars" style="color: #d63384; font-size: 1.5rem;"></i>
        </button>

        <div class="collapse navbar-collapse" id="adminNav">

            <ul class="navbar-nav mx-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link nav-link-admin" href="${pageContext.request.contextPath}/adminproductfind">
                        <i class="fas fa-box-open"></i> Sản phẩm
                    </a>
                </li>
                <li class="nav-item">
    <a class="nav-link nav-link-admin" href="${pageContext.request.contextPath}/admin/inventory">
        <i class="fas fa-warehouse"></i> Kho hàng
    </a>
</li>
<li class="nav-item">
    <a class="nav-link nav-link-admin" href="${pageContext.request.contextPath}/lskh">
        <i class="fas fa-history"></i> Lịch sử kho
    </a>
</li>



                <li class="nav-item">
                    <a class="nav-link nav-link-admin" href="${pageContext.request.contextPath}/admin/categories">
                        <i class="fas fa-tags"></i> Danh mục
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link nav-link-admin" href="${pageContext.request.contextPath}/admin/users">
                        <i class="fas fa-users"></i> Người dùng
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link nav-link-admin" href="${pageContext.request.contextPath}/admin/orders">
                        <i class="fas fa-clipboard-list"></i> Đơn hàng
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link nav-link-admin" href="${pageContext.request.contextPath}/admin/statistics">
                        <i class="fas fa-chart-line"></i> Thống kê
                    </a>
                </li>
            </ul>

            <ul class="navbar-nav align-items-center">

                <!-- 🔔 CHUÔNG THÔNG BÁO -->
                <li class="nav-item me-3 d-none d-lg-block">
                    <a href="${pageContext.request.contextPath}/notifications" class="nav-link position-relative" style="color: #d63384; padding: 5px;"
                        onclick="markAsRead()">

                        <i class="fas fa-bell fa-lg"></i>

                        <span id="notify-count"
                              class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger border border-white"
                              style="font-size: 0.6rem; display:none;">
                        </span>
                    </a>
                </li>

                <!-- ADMIN LOGIN / PROFILE -->
                <c:if test="${admin == null}">
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/admin/login" 
                           class="btn btn-sm btn-outline-danger rounded-pill px-4 fw-bold">
                            <i class="fas fa-sign-in-alt me-2"></i> Đăng nhập
                        </a>
                    </li>
                </c:if>

                <c:if test="${admin != null}">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle d-flex align-items-center p-0" data-bs-toggle="dropdown">

                            <div class="avatar-circle">
                                ${fn:toUpperCase(fn:substring(admin.name, 0, 1))}
                            </div>

                            <div class="d-flex flex-column" style="line-height: 1.2;">
                                <span style="color:#333; font-weight:700; font-size:0.9rem;">
                                    Xin chào, ${admin.name}
                                </span>
                                <span style="color:#888; font-size:0.75rem; font-weight:600;">Admin</span>
                            </div>
                        </a>

                        <ul class="dropdown-menu dropdown-menu-end dropdown-menu-admin">
                            <li>
                                <a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/admin/logout">
                                    <i class="fas fa-sign-out-alt me-2"></i> Đăng xuất
                                </a>
                            </li>
                        </ul>
                    </li>
                </c:if>

            </ul>
        </div>
    </div>
</nav>

<!-- ======================= JS THÔNG BÁO ======================= -->

<script>
function loadNotification() {
    fetch("${pageContext.request.contextPath}/admin/notification")
        .then(res => res.json())
        .then(count => {
            const badge = document.getElementById("notify-count");

            if (count > 0) {
                badge.innerText = count;
                badge.style.display = "inline-block";
            } else {
                badge.style.display = "none";
            }
        });
}

function markAsRead() {
    fetch("${pageContext.request.contextPath}/admin/mark-read", { method: "POST" })
        .then(() => {
            document.getElementById("notify-count").style.display = "none";
        });
}

loadNotification();
setInterval(loadNotification, 5000);
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
