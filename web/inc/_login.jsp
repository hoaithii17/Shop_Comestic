<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login Page</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background-color: #fff;
    }

    .vh-100 {
      height: 100vh;
    }

    /* Nút */
    .btn-primary {
      background-color: #007bff;
      border: none;
    }

    .btn-primary:hover {
      background-color: #0056b3;
    }

    /* C?n form lên trên cho hài hòa */
    .form-container {
      margin-top: 60px; /* b?n có th? ch?nh 40-80 tùy ý */
    }

    @media (max-width: 768px) {
      .form-container {
        margin-top: 20px;
      }
    }
  </style>
</head>
<body>

<section class="vh-100">
  <div class="container h-100">
    <div class="row d-flex align-items-start justify-content-center h-100"> <!-- align-items-start thay cho center -->
      
      <!-- Hình minh h?a bên trái -->
      <div class="col-md-6 text-center mt-5">
        <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-login-form/draw2.webp"
             class="img-fluid" alt="Login image" style="max-height: 420px;">
      </div>

      <!-- Form ??ng nh?p bên ph?i -->
      <div class="col-md-6 col-lg-5 form-container">
        <h3 class="mb-4 text-center fw-bold">Information Login</h3>

        <form action="" method="post">
            <div class="link-danger">${error_login}</div>
          <!-- Email -->
          <div class="form-outline mb-3">
              <input type="text" name="emailphone" class="form-control form-control-lg" placeholder="Enter a valid email address" />
          </div>

          <!-- Password -->
          <div class="form-outline mb-3">
            <input type="password" name="password" class="form-control form-control-lg" placeholder="Enter password" />
          </div>

          <!-- Remember + Forgot -->
          <div class="d-flex justify-content-between align-items-center mb-3">
            <div class="form-check">
              <input class="form-check-input" type="checkbox" id="rememberMe" />
              <label class="form-check-label" for="rememberMe">Remember me</label>
            </div>
            <a href="#" class="text-body">Forgot password?</a>
          </div>

          <!-- Nút Login -->
          <div class="text-center">
            <button type="submit" class="btn btn-primary btn-lg w-100">Login</button>
          </div>

          <!-- Link ??ng ký -->
          <p class="text-center mt-3">
            Don?t have an account? <a href="register" class="text-danger">Register</a>
          </p>
        </form>
      </div>

    </div>
  </div>
</section>

</body>
</html>
