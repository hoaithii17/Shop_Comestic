<%@page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết đơn hàng #${order.id}</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700&display=swap" rel="stylesheet">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        /* --- TÙY CHỈNH THEME PASTEL PINK --- */
        :root {
            --pink-primary: #ffb7c5;    /* Hồng phấn chủ đạo */
            --pink-light: #fff0f5;      /* Nền hồng rất nhạt */
            --pink-dark: #e88a9e;       /* Hồng đậm để làm chữ/border */
            --text-gray: #495057;       /* Màu chữ nội dung */
        }

        body {
            font-family: 'Nunito', sans-serif;
            background-color: #f8f9fa; /* Nền xám nhạt hiện đại */
            color: var(--text-gray);
        }

        /* Card thông tin (Info Box) */
        .info-card {
            background: #fff;
            border: none;
            border-radius: 16px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.03); /* Đổ bóng nhẹ sang trọng */
            height: 100%;
            transition: transform 0.2s;
            overflow: hidden;
        }
        
        .info-card:hover {
            transform: translateY(-3px);
        }

        .info-card .card-body {
            padding: 1.5rem;
        }

        /* Icon tròn bên cạnh tiêu đề */
        .icon-circle {
            width: 40px;
            height: 40px;
            background-color: var(--pink-light);
            color: var(--pink-dark);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1rem;
            font-size: 1.1rem;
        }

        .card-title-custom {
            font-size: 0.95rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            color: #999;
            font-weight: 700;
            margin-bottom: 10px;
        }

        .data-text {
            font-size: 1.05rem;
            font-weight: 600;
            color: #333;
            margin-bottom: 4px;
        }
        
        .sub-text {
            font-size: 0.9rem;
            color: #6c757d;
        }

        /* Bảng sản phẩm */
        .order-table-card {
            border: none;
            border-radius: 16px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.03);
            overflow: hidden;
        }

        .table-custom thead {
            background-color: var(--pink-light);
        }

        .table-custom th {
            color: var(--pink-dark);
            font-weight: 700;
            border: none;
            padding: 18px;
            font-size: 0.95rem;
        }

        .table-custom td {
            padding: 18px;
            vertical-align: middle;
            border-bottom: 1px solid #f1f1f1;
        }

        /* Nút bấm */
        .btn-pink {
            background-color: var(--pink-dark);
            color: white;
            border: none;
            padding: 10px 25px;
            border-radius: 50px;
            font-weight: 600;
            transition: all 0.3s;
        }

        .btn-pink:hover {
            background-color: #d6758b;
            color: white;
            box-shadow: 0 4px 12px rgba(232, 138, 158, 0.4);
        }

        .btn-outline-back {
            border: 2px solid #ddd;
            color: #666;
            background: #fff;
            padding: 8px 20px;
            border-radius: 50px;
            font-weight: 600;
            text-decoration: none;
            transition: 0.3s;
        }
        .btn-outline-back:hover {
            border-color: var(--pink-dark);
            color: var(--pink-dark);
        }

        /* Thanh trạng thái đơn hàng */
        .status-badge {
            background: var(--pink-light);
            color: var(--pink-dark);
            padding: 8px 16px;
            border-radius: 8px;
            font-weight: 700;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>

<div class="container py-5">
    
    <div class="d-flex flex-wrap justify-content-between align-items-center mb-5">
        <div>
            <a href="myorder" class="btn-outline-back mb-3 d-inline-block">
                <i class="fas fa-arrow-left me-2"></i>Quay lại
            </a>
            <h2 class="fw-bold mb-1" style="color: #333;">Chi tiết đơn hàng</h2>
            <div class="d-flex align-items-center gap-2">
                <span class="fs-4 fw-bold" style="color: var(--pink-dark);">#${order.id}</span>
                <span class="text-muted">|</span>
                <span class="text-muted"><i class="far fa-clock me-1"></i> ${order.orderDate}</span>
            </div>
        </div>
        <div>
            <div class="status-badge">
                <i class="fas fa-check-circle me-1"></i> Đã đặt hàng thành công
            </div>
        </div>
    </div>

    <div class="row g-4 mb-5">
        <div class="col-md-4">
            <div class="info-card">
                <div class="card-body">
                    <div class="icon-circle">
                        <i class="fas fa-user"></i>
                    </div>
                    <div class="card-title-custom">Thông tin khách hàng</div>
                    <div class="data-text">${order.fullname}</div>
                    <div class="sub-text">${order.email}</div>
                    <div class="sub-text">${order.phoneNumber}</div>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="info-card">
                <div class="card-body">
                    <div class="icon-circle">
                        <i class="fas fa-map-marker-alt"></i>
                    </div>
                    <div class="card-title-custom">Địa chỉ nhận hàng</div>
                    <div class="data-text" style="line-height: 1.5;">${order.address}</div>
                    <div class="sub-text mt-2">Việt Nam</div>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="info-card">
                <div class="card-body">
                    <div class="icon-circle">
                        <i class="fas fa-sticky-note"></i>
                    </div>
                    <div class="card-title-custom">Ghi chú đơn hàng</div>
                    <div class="fst-italic" style="color: #666;">
                        <c:choose>
                            <c:when test="${not empty order.note}">
                                "${order.note}"
                            </c:when>
                            <c:otherwise>
                                Không có ghi chú nào cho đơn hàng này.
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="card order-table-card">
        <div class="table-responsive">
            <table class="table table-custom mb-0">
                <thead>
                    <tr>
                        <th class="ps-4">Sản phẩm</th>
                        <th class="text-center">Đơn giá</th>
                        <th class="text-center">Số lượng</th>
                        <th class="text-end pe-4">Thành tiền</th>
                    </tr>
                </thead>
                <tbody>
               <c:forEach items="${products}" var="p"> <tr> <td class="ps-4"> <div class="d-flex align-items-center"> <div style="width: 45px; height: 45px; background: #f8f9fa; border-radius: 8px; display: flex; align-items: center; justify-content: center; margin-right: 15px; color: #ccc;"> <i class="fas fa-box"></i> </div> <div> <div class="fw-bold text-dark">${p.name}</div> </div> </div> </td> <td class="text-center"> <fmt:formatNumber value="${p.price}" pattern="#,###"/> đ </td> <td class="text-center"> <span class="badge rounded-pill bg-light text-dark border border-secondary-subtle px-3 py-2"> x${p.quantity} </span> </td> <td class="text-end pe-4 fw-bold text-secondary"> <fmt:formatNumber value="${p.totalPrice}" pattern="#,###"/> đ </td> </tr> </c:forEach>

                    
                    <tr style="background-color: #fffcfd;">
                        <td colspan="3" class="text-end pt-4 pb-4">
                            <span class="text-muted me-3">Tổng giá trị đơn hàng:</span>
                        </td>
                        <td class="text-end pe-4 pt-4 pb-4">
                            <span class="fs-4 fw-bold" style="color: var(--pink-dark);">
                                <fmt:formatNumber value="${order.totalMoney}" pattern="#,###"/> đ
                            </span>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    
    <div class="text-center mt-5">
        <p class="text-muted small">Cảm ơn bạn đã mua sắm tại cửa hàng!</p>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>