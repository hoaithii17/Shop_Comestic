<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý đơn hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    
    <style>
        :root {
            --primary-pink: #d63384;
            --light-pink: #fff0f6;
            --card-shadow: 0 4px 20px rgba(0,0,0,0.05);
        }

        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        /* --- Card Style --- */
        .card-table {
            border: none;
            border-radius: 16px;
            box-shadow: var(--card-shadow);
            overflow: hidden;
        }

        .card-header-custom {
            background-color: white;
            padding: 20px 25px;
            border-bottom: 1px solid #f0f0f0;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
        }

        /* --- Table Style --- */
        .table-custom thead th {
            background-color: var(--light-pink);
            color: var(--primary-pink);
            font-weight: 700;
            border: none;
            padding: 15px;
            font-size: 0.9rem;
            text-transform: uppercase;
        }

        .table-custom tbody td {
            padding: 15px;
            vertical-align: middle;
            border-bottom: 1px solid #f8f9fa;
            color: #555;
            font-size: 0.95rem;
        }

        .table-custom tbody tr:hover {
            background-color: #fffcfd; /* Hiệu ứng hover hồng rất nhạt */
        }

        /* --- Status Badges (Style Pastel) --- */
    /* --- Status Badges (Sắc nét & Dễ đọc hơn) --- */
    .badge-soft {
        padding: 8px 12px;       /* Tăng padding chút cho thoáng */
        border-radius: 8px;      /* Bo góc vuông nhẹ cho hiện đại */
        font-weight: 700;        /* Chữ đậm hẳn lên */
        font-size: 0.85rem;      /* Tăng size chữ một xíu */
        letter-spacing: 0.3px;   /* Giãn chữ nhẹ cho dễ đọc */
        border: 1px solid transparent; /* Chuẩn bị border */
    }

    /* 0. Đang xử lý - Màu Cam Vàng (Nổi bật nhưng không chói) */
    .badge-soft-warning {
        background-color: #fff8c5; /* Nền vàng nhạt */
        color: #9a6e03;            /* Chữ nâu vàng đậm -> Rất rõ */
        border-color: #ffeeba;
    }

    /* 1. Đang đóng gói - Màu Tím Nhạt (Sang trọng) */
    .badge-soft-primary {
        background-color: #e0cffc; /* Nền tím khoai môn nhạt */
        color: #592d8f;            /* Chữ tím đậm */
        border-color: #d1b8f5;
    }

    /* 2. Đang vận chuyển - Màu Xanh Dương (Tin cậy) */
    .badge-soft-info {
        background-color: #dbeafe; /* Nền xanh biển nhạt */
        color: #1e40af;            /* Chữ xanh biển đậm */
        border-color: #bfdbfe;
    }

    /* 3. Hoàn thành - Màu Xanh Lá (Tươi mát) */
    .badge-soft-success {
        background-color: #dcfce7; /* Nền xanh lá mạ nhạt */
        color: #14532d;            /* Chữ xanh rêu đậm -> Cực nét */
        border-color: #bbf7d0;
    }

    /* 4. Đã hủy - Màu Đỏ Hồng (Cảnh báo nhẹ nhàng) */
    .badge-soft-danger {
        background-color: #fee2e2; /* Nền hồng đỏ nhạt */
        color: #991b1b;            /* Chữ đỏ thẫm */
        border-color: #fecaca;
    }
        /* --- Action Buttons --- */
        .btn-action {
            width: 35px;
            height: 35px;
            border-radius: 50%;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            transition: all 0.2s;
            border: 1px solid transparent;
        }
        
        .btn-view {
            background-color: var(--light-pink);
            color: var(--primary-pink);
        }
        .btn-view:hover {
            background-color: var(--primary-pink);
            color: white;
        }

        .btn-delete {
            background-color: #fff5f5;
            color: #dc3545;
        }
        .btn-delete:hover {
            background-color: #dc3545;
            color: white;
        }

        /* --- Search Input --- */
        .search-box {
            position: relative;
        }
        .search-box input {
            border-radius: 20px;
            padding-left: 35px;
            border: 1px solid #eee;
        }
        .search-box i {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: #aaa;
        }
    </style>
</head>
<body>

    <c:import url="/inc/admin_navbar.jsp"/>

    <div class="container py-5">
        
        <div class="card card-table">
            
            <div class="card-header-custom">
                <div>
                    <h4 class="fw-bold mb-1" style="color: var(--primary-pink);">Quản lý Đơn hàng</h4>
                    <small class="text-muted">Tổng số đơn hàng: <strong>${list.size()}</strong></small>
                </div>
                
                <div class="d-flex gap-2">
                    <div class="search-box">
                        <i class="fas fa-search"></i>
                        <input type="text" class="form-control" placeholder="Tìm theo Mã/Tên...">
                    </div>
                    
                    <select class="form-select" style="border-radius: 20px; width: 150px; border-color: #eee;">
                        <option value="">Tất cả</option>
                        <option value="0">Đang xử lý</option>
                        <option value="2">Đang giao</option>
                        <option value="3">Hoàn thành</option>
                    </select>
                </div>
            </div>

            <div class="table-responsive">
                <table class="table table-custom mb-0">
                    <thead>
                        <tr>
                            <th class="ps-4">Mã ĐH</th>
                            <th>Khách hàng</th>
                            <th>Ngày đặt</th>
                            <th>Tổng tiền</th>
                            <th>Trạng thái</th>
                            <th class="text-end pe-4">Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:if test="${empty list}">
                            <tr>
                                <td colspan="6" class="text-center py-5">
                                    <img src="https://cdn-icons-png.flaticon.com/512/4076/4076432.png" width="80" class="mb-3 opacity-50">
                                    <p class="text-muted">Chưa có đơn hàng nào.</p>
                                </td>
                            </tr>
                        </c:if>

                        <c:forEach var="o" items="${list}">
                            <tr>
                                <td class="ps-4 fw-bold">#${o.id}</td>
                                
                                <td>
                                    <div class="d-flex flex-column">
                                        <span class="fw-bold text-dark">${o.fullname}</span>
                                        </div>
                                </td>

                                <td>
                                    <i class="far fa-calendar-alt me-1 text-muted"></i>
                                    <fmt:formatDate value="${o.orderDate}" pattern="dd/MM/yyyy HH:mm"/>
                                </td>

                                <td class="fw-bold" style="color: #333;">
                                    <fmt:formatNumber value="${o.totalMoney}" pattern="#,###"/> đ
                                </td>

                                <td>
                                    <c:choose>
                                        <c:when test="${o.status == 0}">
                                            <span class="badge badge-soft badge-soft-warning">
                                                <i class="fas fa-clock me-1"></i> Đang xử lý
                                            </span>
                                        </c:when>
                                        <c:when test="${o.status == 1}">
                                            <span class="badge badge-soft badge-soft-primary">
                                                <i class="fas fa-box me-1"></i> Đang đóng gói
                                            </span>
                                        </c:when>
                                        <c:when test="${o.status == 2}">
                                            <span class="badge badge-soft badge-soft-info">
                                                <i class="fas fa-shipping-fast me-1"></i> Đang vận chuyển
                                            </span>
                                        </c:when>
                                        <c:when test="${o.status == 3}">
                                            <span class="badge badge-soft badge-soft-success">
                                                <i class="fas fa-check-circle me-1"></i> Đã giao hàng
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-soft badge-soft-danger">
                                                <i class="fas fa-times-circle me-1"></i> Đã hủy
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <td class="text-end pe-4">
                                    <a href="${pageContext.request.contextPath}/admin/order?action=view&id=${o.id}" 
                                       class="btn-action btn-view me-2" 
                                       title="Xem chi tiết" data-bs-toggle="tooltip">
                                        <i class="fas fa-eye"></i>
                                    </a>

                                    <a href="${pageContext.request.contextPath}/admin/order?action=delete&id=${o.id}" 
                                       class="btn-action btn-delete" 
                                       onclick="return confirm('Bạn có chắc chắn muốn xóa đơn hàng #${o.id}? Hành động này không thể hoàn tác!')"
                                       title="Xóa đơn hàng" data-bs-toggle="tooltip">
                                        <i class="fas fa-trash-alt"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <div class="card-footer bg-white border-0 py-3 d-flex justify-content-end">
                <nav>
                    <ul class="pagination pagination-sm mb-0">
                        <li class="page-item disabled"><a class="page-link" href="#">Trước</a></li>
                        <li class="page-item active"><a class="page-link bg-pink border-pink" href="#" style="background-color: var(--primary-pink); border-color: var(--primary-pink);">1</a></li>
                        <li class="page-item"><a class="page-link text-pink" href="#" style="color: var(--primary-pink);">2</a></li>
                        <li class="page-item"><a class="page-link text-pink" href="#" style="color: var(--primary-pink);">3</a></li>
                        <li class="page-item"><a class="page-link" href="#" style="color: var(--primary-pink);">Sau</a></li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Kích hoạt Tooltip của Bootstrap 5
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
          return new bootstrap.Tooltip(tooltipTriggerEl)
        })
    </script>
</body>
</html>