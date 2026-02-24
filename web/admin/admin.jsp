<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang chủ Admin | Beauty Shop</title>

    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700;800&display=swap" rel="stylesheet">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

    <style>
        :root {
            --primary-pink: #d63384;
            --hover-pink: #e64980;
            --bg-light: #f8f9fa;
        }

        body {
            font-family: 'Nunito', sans-serif;
            background-color: var(--bg-light);
        }

        /* Banner chào mừng */
        .welcome-section {
            background: linear-gradient(135deg, #fff0f6 0%, #ffe3e3 100%);
            border-radius: 20px;
            padding: 40px;
            margin-bottom: 40px;
            position: relative;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(214, 51, 132, 0.1);
        }

        .welcome-content h2 {
            color: var(--primary-pink);
            font-weight: 800;
            margin-bottom: 10px;
        }

        /* Các thẻ điều hướng nhanh (Quick Access Cards) */
        .nav-card {
            background: white;
            border-radius: 20px;
            padding: 30px;
            text-align: center;
            transition: all 0.3s ease;
            border: 1px solid rgba(0,0,0,0.05);
            height: 100%;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-decoration: none;
            color: #555;
            box-shadow: 0 5px 15px rgba(0,0,0,0.03);
        }

        .nav-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(214, 51, 132, 0.15);
            border-color: #ffc9db;
        }

        .icon-box {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            margin-bottom: 20px;
            transition: 0.3s;
        }

        /* Màu sắc riêng cho từng thẻ */
        .card-product .icon-box { background: #ffe3e3; color: #e03131; }
        .nav-card:hover .icon-box { transform: scale(1.1); }

        .card-order .icon-box { background: #e7f5ff; color: #1971c2; }
        .card-user .icon-box { background: #fff9db; color: #f08c00; }
        .card-stat .icon-box { background: #ebfbee; color: #2f9e44; }

        .card-title {
            font-weight: 700;
            font-size: 1.2rem;
            margin-bottom: 5px;
            color: #333;
        }
        
        .card-desc {
            font-size: 0.9rem;
            color: #888;
        }
    </style>
</head>
<body>

    <c:import url="/inc/admin_navbar.jsp" />

    <div class="container py-5">
        
        <div class="welcome-section">
            <div class="row align-items-center">
                <div class="col-md-8 welcome-content">
                    <h2>Xin chào, ${sessionScope.admin.username}! 👋</h2>
                    <p class="mb-0 text-muted fs-5">Chào mừng bạn quay trở lại trang quản trị Beauty Shop.</p>
                    <p class="mt-2 text-muted"><small><i class="far fa-clock me-1"></i> Chúc bạn một ngày làm việc hiệu quả!</small></p>
                </div>
                <div class="col-md-4 text-end d-none d-md-block">
                    <img src="https://cdn-icons-png.flaticon.com/512/2922/2922510.png" width="150" style="opacity: 0.8;">
                </div>
            </div>
        </div>

        <h5 class="fw-bold mb-4 text-secondary text-uppercase ls-1">Truy cập nhanh</h5>
        
        <div class="row g-4">
            
            <div class="col-md-6 col-lg-3">
                <a href="${pageContext.request.contextPath}/admin/products" class="nav-card card-product">
                    <div class="icon-box">
                        <i class="fas fa-box-open"></i>
                    </div>
                    <div class="card-title">Sản phẩm</div>
                    <div class="card-desc">Quản lý kho hàng & Giá</div>
                </a>
            </div>

            <div class="col-md-6 col-lg-3">
                <a href="${pageContext.request.contextPath}/admin/orders" class="nav-card card-order">
                    <div class="icon-box">
                        <i class="fas fa-clipboard-list"></i>
                    </div>
                    <div class="card-title">Đơn hàng</div>
                    <div class="card-desc">Xử lý đơn & Vận chuyển</div>
                </a>
            </div>

            <div class="col-md-6 col-lg-3">
                <a href="${pageContext.request.contextPath}/admin/users" class="nav-card card-user">
                    <div class="icon-box">
                        <i class="fas fa-users"></i>
                    </div>
                    <div class="card-title">Khách hàng</div>
                    <div class="card-desc">Quản lý tài khoản User</div>
                </a>
            </div>

            <div class="col-md-6 col-lg-3">
                <a href="${pageContext.request.contextPath}/admin/statistics" class="nav-card card-stat">
                    <div class="icon-box">
                        <i class="fas fa-chart-pie"></i>
                    </div>
                    <div class="card-title">Báo cáo</div>
                    <div class="card-desc">Xem doanh thu & Biểu đồ</div>
                </a>
            </div>

        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>