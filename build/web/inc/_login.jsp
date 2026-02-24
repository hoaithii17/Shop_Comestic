<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Đăng nhập - Mỹ phẩm</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

  <style>
    body {
      background: linear-gradient(to right, #ffe6f2, #fff5fa);
      font-family: "Poppins", sans-serif;
    }

    .login-card {
      background: #ffffffcc;
      backdrop-filter: blur(6px);
      padding: 35px;
      border-radius: 25px;
      box-shadow: 0px 10px 25px rgba(255, 150, 170, 0.25);
    }

    .btn-pink {
      background: linear-gradient(90deg, #ff7eb3, #ff65a3);
      border: none;
      color: white;
      font-weight: 600;
      border-radius: 30px;
    }

    .btn-pink:hover {
      background: linear-gradient(90deg, #ff5c9a, #ff3d85);
      color: white;
    }

    .form-control {
      border-radius: 20px;
      border: 1px solid #ffc7dd;
    }

    .form-control:focus {
      border-color: #ff7eb3;
      box-shadow: 0 0 0 0.2rem rgba(255, 126, 179, 0.25);
    }

    .login-title {
      font-weight: 700;
      color: #ff3d85;
    }
  </style>
</head>

<body>

<section class="vh-100 d-flex align-items-center">
  <div class="container">

    <div class="row align-items-center justify-content-center">
      
      <!-- Hình minh hoạ mỹ phẩm -->
      <div class="col-md-6 text-center">
        <img src="./assets/icon/login.png"
             class="img-fluid"
             alt="cosmetic"
             style="max-height: 420px;">
      </div>

      <!-- Form Đăng nhập -->
      <div class="col-md-5">
        <div class="login-card">

          <h3 class="text-center mb-4 login-title">Chào mừng trở lại</h3>
          <p class="text-center text-muted mb-4">Đăng nhập để tiếp tục mua sắm mỹ phẩm ✿</p>

          <form action="" method="post">

            <div class="text-danger mb-2">${error_login}</div>

            <!-- Email / Phone -->
            <div class="mb-3">
              <input type="text" name="emailphone" class="form-control" placeholder="Email hoặc số điện thoại">
            </div>

            <!-- Password -->
            <div class="mb-3">
              <input type="password" name="password" class="form-control" placeholder="Mật khẩu">
            </div>

            <!-- Remember + Forgot -->
            <div class="d-flex justify-content-between mb-3">
              <div>
                <input type="checkbox" id="rememberMe">
                <label for="rememberMe" class="ms-1">Ghi nhớ tôi</label>
              </div>
              <a href="#" style="color:#ff3d85;">Quên mật khẩu?</a>
            </div>

            <!-- Button -->
            <button type="submit" class="btn btn-pink w-100 btn-lg">Đăng nhập</button>

            <!-- Register -->
            <p class="text-center mt-3">
              Chưa có tài khoản?
              <a href="register" style="color:#ff3d85; font-weight:600;">Đăng ký ngay</a>
            </p>

          </form>

        </div>
      </div>

    </div>

  </div>
</section>

</body>
</html>
