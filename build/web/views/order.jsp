<%@page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Đặt hàng thành công</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body { background-color: #fff5f8; min-height: 100vh; display: flex; align-items: center; justify-content: center; }
        .success-card {
            background: white;
            border-radius: 20px;
            text-align: center;
            max-width: 500px;
            width: 100%;
            animation: slideUp 0.5s ease;
        }
        @keyframes slideUp {
            from { transform: translateY(50px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }
        .icon-box {
            width: 80px; height: 80px;
            background: #d1e7dd;
            color: #198754;
            border-radius: 50%;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 40px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>

    <div class="container p-3">
        <div class="success-card shadow p-5 mx-auto">
            
            <div class="icon-box">
                <i class="fas fa-check"></i>
            </div>

            <h2 class="fw-bold text-success mb-3">Đặt hàng thành công!</h2>
            
            <p class="text-muted mb-4">
                Cảm ơn bạn đã mua sắm tại cửa hàng.<br>
                Chúng tôi sẽ liên hệ với bạn sớm nhất để xác nhận đơn hàng.
            </p>

            <div class="d-grid gap-2">
                <a href="${pageContext.request.contextPath}/home" class="btn btn-dark rounded-pill py-3 fw-bold">
                    <i class="fas fa-home me-2"></i> Quay về trang chủ
                </a>
                
                <a href="${pageContext.request.contextPath}/order-detail?id=${orderId}"
  class="btn btn-outline-danger rounded-pill py-3 fw-bold border-0" style="background-color: #fff0f6;"> <i class="fas fa-shopping-bag me-2"></i> Xem đơn hàng đã mua </a>

                  
            </div>

        </div>
    </div>

</body>
</html>