<%@page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700;800&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">


<style>
    /* --- THEME PINK PASTEL --- */
    :root {
        --pink-primary: #ffb7c5;
        --pink-bg: #fff0f5;
        --pink-dark: #e88a9e;
        --pink-hover: #ff9eb5;
        --text-gray: #555;
    }

    body {
        font-family: 'Nunito', sans-serif;
        background-color: #f8f9fa;
    }

    /* Card chứa form */
    .password-card {
        background: #fff;
        border: none;
        border-radius: 20px;
        box-shadow: 0 10px 30px rgba(255, 183, 197, 0.25);
        padding: 2rem;
        position: relative;
        overflow: hidden;
    }

    /* Icon ổ khóa tròn ở trên cùng */
    .lock-icon-wrapper {
        width: 80px;
        height: 80px;
        background-color: var(--pink-bg);
        color: var(--pink-dark);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 20px auto;
        font-size: 2rem;
        box-shadow: 0 4px 10px rgba(0,0,0,0.05);
    }

    /* Style tiêu đề */
    .page-title {
        color: #444;
        font-weight: 800;
        text-align: center;
        margin-bottom: 30px;
    }

    /* Input Fields */
    .label-pastel {
        font-size: 0.85rem;
        font-weight: 700;
        color: #777;
        margin-bottom: 6px;
        display: block;
        padding-left: 5px;
    }

    .input-group-pastel {
        background-color: var(--pink-bg);
        border-radius: 15px;
        padding: 8px 15px;
        display: flex;
        align-items: center;
        border: 1px solid transparent;
        transition: all 0.3s;
        position: relative; /* Để đặt nút con mắt */
    }

    .input-group-pastel:focus-within {
        background-color: #fff;
        border-color: var(--pink-primary);
        box-shadow: 0 0 0 4px rgba(255, 183, 197, 0.2);
    }

    .input-group-pastel .icon-left {
        width: 30px;
        color: var(--pink-dark);
        font-size: 1.1rem;
        text-align: center;
    }

    .form-control-pastel {
        border: none;
        background: transparent;
        font-weight: 600;
        color: #444;
        width: 100%;
        padding-left: 10px;
        padding-right: 35px; /* Chừa chỗ cho nút con mắt */
    }
    .form-control-pastel:focus { outline: none; }

    /* Nút con mắt hiện/ẩn pass */
    .toggle-password {
        position: absolute;
        right: 15px;
        cursor: pointer;
        color: #aaa;
        transition: 0.3s;
    }
    .toggle-password:hover { color: var(--pink-dark); }

    /* Buttons */
    .btn-submit {
        background: linear-gradient(135deg, var(--pink-hover), var(--pink-dark));
        color: white;
        border: none;
        border-radius: 50px;
        padding: 12px;
        font-weight: 700;
        width: 100%;
        transition: all 0.3s;
        box-shadow: 0 4px 15px rgba(232, 138, 158, 0.4);
    }
    .btn-submit:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(232, 138, 158, 0.6);
        color: white;
    }

    .btn-cancel {
        color: #888;
        background: transparent;
        border: 2px solid #eee;
        border-radius: 50px;
        padding: 10px;
        font-weight: 600;
        width: 100%;
        transition: 0.3s;
        display: block;
        text-align: center;
        text-decoration: none;
        margin-top: 10px;
    }
    .btn-cancel:hover {
        background: #fff;
        border-color: var(--pink-primary);
        color: var(--pink-dark);
    }
    
    /* Alert Custom */
    .alert-custom {
        border-radius: 15px;
        border: none;
        font-weight: 600;
        font-size: 0.9rem;
    }
</style>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-5 col-lg-4">
            
            <div class="password-card">
                <div class="lock-icon-wrapper">
                    <i class="fas fa-lock"></i>
                </div>
                <h4 class="page-title">Đổi Mật Khẩu</h4>

                <c:if test="${not empty msg}">
                    <div class="alert alert-${msgType} alert-custom shadow-sm text-center mb-4">
                        <i class="fas fa-info-circle me-1"></i> ${msg}
                    </div>
                </c:if>

                <form action="change-password" method="post">
                    
                    <div class="mb-3">
                        <label class="label-pastel">Mật khẩu hiện tại</label>
                        <div class="input-group-pastel">
                            <div class="icon-left"><i class="fas fa-key"></i></div>
                            <input type="password" name="oldPassword" id="oldPass" class="form-control-pastel" required placeholder="••••••">
                            <i class="far fa-eye toggle-password" onclick="togglePass('oldPass', this)"></i>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="label-pastel">Mật khẩu mới</label>
                        <div class="input-group-pastel">
                            <div class="icon-left"><i class="fas fa-unlock-alt"></i></div>
                            <input type="password" name="newPassword" id="newPass" class="form-control-pastel" required placeholder="Nhập mật khẩu mới">
                            <i class="far fa-eye toggle-password" onclick="togglePass('newPass', this)"></i>
                        </div>
                    </div>

                    <div class="mb-4">
                        <label class="label-pastel">Xác nhận mật khẩu</label>
                        <div class="input-group-pastel">
                            <div class="icon-left"><i class="fas fa-check-circle"></i></div>
                            <input type="password" name="confirmPassword" id="confirmPass" class="form-control-pastel" required placeholder="Nhập lại mật khẩu mới">
                            <i class="far fa-eye toggle-password" onclick="togglePass('confirmPass', this)"></i>
                        </div>
                    </div>

                    <div class="d-grid gap-2">
                        <button type="submit" class="btn btn-submit">
                            Xác nhận thay đổi
                        </button>
                        <a href="profile" class="btn btn-cancel">
                            Hủy bỏ
                        </a>
                    </div>
                </form>
            </div>

        </div>
    </div>
</div>

<script>
    function togglePass(inputId, icon) {
        const input = document.getElementById(inputId);
        if (input.type === "password") {
            input.type = "text";
            icon.classList.remove("fa-eye");
            icon.classList.add("fa-eye-slash");
        } else {
            input.type = "password";
            icon.classList.remove("fa-eye-slash");
            icon.classList.add("fa-eye");
        }
    }
</script>