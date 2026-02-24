<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Đăng ký tài khoản</title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

  <style>
    body {
      background: #fff5fa;
      font-family: "Poppins", sans-serif;
    }

    .register-card {
      background: #ffffff;
      padding: 35px;
      border-radius: 20px;
      box-shadow: 0px 10px 30px rgba(255, 100, 150, 0.15);
    }

    .form-control {
      border-radius: 12px;
      border: 1px solid #ffc9e1;
    }

    .form-control:focus {
      border-color: #ff7eb3;
      box-shadow: 0 0 0 0.15rem rgba(255, 126, 179, 0.25);
    }

    .btn-pink {
      background: linear-gradient(90deg, #ff7eb3, #ff65a3);
      border: none;
      border-radius: 25px;
      padding: 10px;
      font-weight: 600;
      color: white;
    }

    .btn-pink:hover {
      background: linear-gradient(90deg, #ff5c9a, #ff3d85);
      color: white;
    }

    .title {
      color: #ff3d85;
      font-weight: 700;
    }
  </style>
</head>

<body>

<section class="py-5">
  <div class="container">
    <div class="row align-items-center justify-content-center">

      <!-- ẢNH -->
      <div class="col-md-6 text-center mb-4">
        <img src="assets/icon/register.png" alt="cosmetic" class="img-fluid" style="max-height: 420px;">
      </div>

      <!-- FORM -->
      <div class="col-md-6">
        <div class="register-card">

          <h3 class="text-center mb-3 title">Tạo tài khoản mới</h3>
          <p class="text-center text-muted mb-4">Tham gia để nhận ưu đãi mỹ phẩm dành riêng cho bạn ✿</p>

          <span class="text-danger">${user_exist}</span>

          <form action="" method="post">

            <!-- Họ tên -->
            <div class="mb-3">
              <label class="form-label">Họ và tên</label>
              <input type="text" name="name" class="form-control" required>
            </div>

            <!-- Email -->
            <div class="mb-3">
              <label class="form-label">Email</label>
              <input type="text" name="email" class="form-control" required>
              <span class="text-danger">${err_email}</span>
            </div>

            <!-- Số điện thoại -->
            <div class="mb-3">
              <label class="form-label">Số điện thoại</label>
              <input type="text" name="phone" class="form-control" required>
              <span class="text-danger">${err_phone}</span>
            </div>

            <!-- Mật khẩu -->
            <div class="mb-3">
              <label class="form-label">Mật khẩu</label>
              <input type="password" name="password" class="form-control" required>
            </div>

            <!-- Nhập lại mật khẩu -->
            <div class="mb-3">
              <label class="form-label">Nhập lại mật khẩu</label>
              <input type="password" name="repassword" class="form-control" required>
              <span class="text-danger">${err_repassword}</span>
            </div>

            <!-- Điều khoản -->
            <div class="form-check mb-3">
              <input class="form-check-input" type="checkbox" required>
              <label class="form-check-label">
                Tôi đồng ý với <a href="#" style="color:#ff3d85;">Điều khoản dịch vụ</a>
              </label>
            </div>

            <!-- Nút -->
            <button type="submit" class="btn btn-pink w-100 mb-3">Đăng ký</button>

            <p class="text-center">
              Đã có tài khoản?
              <a href="login" style="color:#ff3d85;">Đăng nhập ngay</a>
            </p>

          </form>

        </div>
      </div>

    </div>
  </div>
</section>

</body>
</html>
