<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết đơn hàng #${order.id}</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

    <style>
        :root {
            --primary-pink: #d63384;
            --light-pink: #fff0f6;
            --text-dark: #333;
            --card-shadow: 0 4px 20px rgba(0,0,0,0.05);
        }

        body {
            font-family: 'Nunito', sans-serif;
            background-color: #f8f9fa;
            color: var(--text-dark);
        }

        /* Card Styles */
        .card-admin {
            border: none;
            border-radius: 16px;
            box-shadow: var(--card-shadow);
            margin-bottom: 24px;
            overflow: hidden;
        }

        .card-header-admin {
            background-color: #fff;
            border-bottom: 1px solid #f0f0f0;
            padding: 20px 25px;
            font-weight: 700;
            font-size: 1.1rem;
            color: var(--primary-pink);
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        /* Customer Info List */
        .info-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        .info-list li {
            padding: 12px 0;
            border-bottom: 1px solid #f8f9fa;
            display: flex;
            align-items: flex-start;
        }
        .info-list li:last-child { border-bottom: none; }
        
        .info-icon {
            width: 35px;
            height: 35px;
            background-color: var(--light-pink);
            color: var(--primary-pink);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            flex-shrink: 0;
        }

        .info-content small {
            display: block;
            color: #888;
            font-size: 0.85rem;
            font-weight: 600;
            text-transform: uppercase;
        }
        .info-content span {
            font-weight: 600;
            color: #444;
        }

        /* Table Styles */
        .table-custom thead th {
            background-color: var(--light-pink);
            color: var(--primary-pink);
            font-weight: 700;
            border: none;
            padding: 15px;
        }
        .table-custom td {
            padding: 15px;
            vertical-align: middle;
            border-bottom: 1px solid #f0f0f0;
        }
        
        /* Status Select Custom */
        .form-select-custom {
            border-radius: 10px;
            border: 1px solid #eee;
            padding: 10px 15px;
        }
        .form-select-custom:focus {
            border-color: var(--primary-pink);
            box-shadow: 0 0 0 0.25rem rgba(214, 51, 132, 0.1);
        }

        .btn-update {
            background-color: var(--primary-pink);
            color: white;
            border: none;
            border-radius: 10px;
            padding: 10px 20px;
            font-weight: 600;
            transition: 0.3s;
        }
        .btn-update:hover {
            background-color: #b01b65;
            color: white;
        }
        
        /* Total Money Box */
        .total-box {
            background-color: var(--light-pink);
            padding: 20px;
            border-radius: 12px;
            text-align: right;
        }
    </style>
</head>
<body>

    <c:import url="/inc/admin_navbar.jsp" />

    <div class="container py-5">
        
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h6 class="text-muted text-uppercase mb-1">Quản lý đơn hàng</h6>
                <h3 class="fw-bold mb-0">Chi tiết đơn hàng <span style="color: var(--primary-pink);">#${order.id}</span></h3>
            </div>
            <div>
                <a href="${pageContext.request.contextPath}/admin/orders" class="btn btn-outline-secondary rounded-pill px-4">
                    <i class="fas fa-arrow-left me-2"></i>Quay lại danh sách
                </a>
                <button onclick="window.print()" class="btn btn-light border rounded-pill px-4 ms-2">
                    <i class="fas fa-print me-2"></i>In hóa đơn
                </button>
            </div>
        </div>

        <div class="row g-4">
            
            <div class="col-lg-4">
                
                <div class="card card-admin">
                    <div class="card-header-admin">
                        <span><i class="fas fa-tasks me-2"></i>Trạng thái đơn hàng</span>
                    </div>
                    <div class="card-body p-4">
    <form action="${pageContext.request.contextPath}/admin/order" method="post" 
      class="d-flex align-items-center gap-3 p-3 bg-white rounded shadow-sm border">
    
    <input type="hidden" name="action" value="updateStatus">
    <input type="hidden" name="orderId" value="${order.id}">

    <div class="flex-grow-1">
        <label for="statusSelect" class="form-label fw-bold small text-muted text-uppercase mb-1">
            Chọn trạng thái mới:
        </label>
        <div class="input-group">
             <span class="input-group-text bg-white text-muted">
                <i class="fas fa-exchange-alt"></i>
            </span>
            <select id="statusSelect" name="status" class="form-select form-select-admin" style="font-weight: 500;">
                 <option value="0" ${order.status == 0 ? "selected" : ""} data-icon="fa-clock">Đang xử lý</option>
                 <option value="1" ${order.status == 1 ? "selected" : ""} data-icon="fa-box">Đang đóng gói</option>
                 <option value="2" ${order.status == 2 ? "selected" : ""} data-icon="fa-truck">Đang vận chuyển</option>
                 <option value="3" ${order.status == 3 ? "selected" : ""} data-icon="fa-check-circle">Đã giao hàng</option>
                 <option value="4" ${order.status == 4 ? "selected" : ""} data-icon="fa-times-circle">Đã hủy</option>
            </select>
        </div>
    </div>

    <div class="mt-4"> <button type="submit" class="btn btn-admin-primary px-4 py-2 rounded-pill shadow-sm">
            <i class="fas fa-check me-2"></i>Cập nhật
        </button>
    </div>
</form>
                    </div>
                </div>

                <div class="card card-admin">
                    <div class="card-header-admin">
                        <span><i class="fas fa-user-circle me-2"></i>Thông tin khách hàng</span>
                    </div>
                    <div class="card-body p-4">
                        <ul class="info-list">
                            <li>
                                <div class="info-icon"><i class="fas fa-user"></i></div>
                                <div class="info-content">
                                    <small>Người nhận</small>
                                    <span>${order.fullname}</span>
                                </div>
                            </li>
                            <li>
                                <div class="info-icon"><i class="fas fa-envelope"></i></div>
                                <div class="info-content">
                                    <small>Email</small>
                                    <span>${order.email}</span>
                                </div>
                            </li>
                            <li>
                                <div class="info-icon"><i class="fas fa-phone-alt"></i></div>
                                <div class="info-content">
                                    <small>Số điện thoại</small>
                                    <span>${order.phoneNumber}</span>
                                </div>
                            </li>
                            <li>
                                <div class="info-icon"><i class="fas fa-map-marker-alt"></i></div>
                                <div class="info-content">
                                    <small>Địa chỉ giao hàng</small>
                                    <span>${order.address}</span>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>

                <div class="card card-admin">
                    <div class="card-header-admin">
                        <span><i class="fas fa-sticky-note me-2"></i>Ghi chú</span>
                    </div>
                    <div class="card-body p-4">
                        <p class="mb-0 fst-italic text-muted">
                            ${empty order.note ? "Không có ghi chú từ khách hàng." : order.note}
                        </p>
                    </div>
                </div>

            </div>

            <div class="col-lg-8">
                <div class="card card-admin h-100">
                    <div class="card-header-admin">
                        <span><i class="fas fa-box-open me-2"></i>Danh sách sản phẩm</span>
                        <span class="badge bg-light text-dark border">Ngày đặt: <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/></span>
                    </div>
                    
                    <div class="table-responsive">
                        <table class="table table-custom table-hover mb-0">
                            <thead>
                                <tr>
                                    <th class="ps-4">Sản phẩm</th>
                                    <th class="text-center">Đơn giá</th>
                                    <th class="text-center">Số lượng</th>
                                    <th class="text-end pe-4">Thành tiền</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="i" items="${items}">
                                    <tr>
                                        <td class="ps-4">
                                            <div class="d-flex align-items-center">
                                                <div class="rounded-3 bg-light d-flex align-items-center justify-content-center me-3" style="width: 45px; height: 45px; border: 1px solid #eee;">
                                                    <i class="fas fa-cube text-secondary"></i>
                                                </div>
                                                <div class="fw-bold text-dark">${i.productName}</div>
                                            </div>
                                        </td>
                                        <td class="text-center">
                                            <fmt:formatNumber value="${i.price}" type="currency" currencySymbol=""/> đ
                                        </td>
                                        <td class="text-center">
                                            <span class="badge rounded-pill bg-light text-dark border px-3 py-2">x${i.quantity}</span>
                                        </td>
                                        <td class="text-end pe-4 fw-bold" style="color: var(--primary-pink);">
                                            <fmt:formatNumber value="${i.price * i.quantity}" type="currency" currencySymbol=""/> đ
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <div class="card-footer bg-white border-0 p-4">
                        <div class="row justify-content-end">
                            <div class="col-md-6 col-lg-5">
                                <div class="total-box">
                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                        <span class="text-muted">Tạm tính:</span>
                                        <span class="fw-bold"><fmt:formatNumber value="${order.totalMoney}" type="currency" currencySymbol=""/> đ</span>
                                    </div>
                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                        <span class="text-muted">Phí vận chuyển:</span>
                                        <span class="fw-bold">0 đ</span>
                                    </div>
                                    <hr style="border-top: 1px dashed #bbb;">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <span class="fs-5 fw-bold text-dark">Tổng cộng:</span>
                                        <span class="fs-3 fw-bold" style="color: var(--primary-pink);">
                                            <fmt:formatNumber value="${order.totalMoney}" type="currency" currencySymbol=""/> đ
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>

        </div> </div> <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>