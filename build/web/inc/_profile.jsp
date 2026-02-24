<%@page contentType="text/html; charset=UTF-8"%>


<link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700;800&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">



<style>
    /* --- THEME PINK PASTEL --- */
    :root {
        --pink-primary: #ffb7c5;    /* Hồng chủ đạo */
        --pink-bg: #fff0f5;         /* Nền hồng nhạt cho input */
        --pink-dark: #e88a9e;       /* Hồng đậm cho text/icon */
        --text-color: #555;
    }

    body {
        font-family: 'Nunito', sans-serif;
        background-color: #f8f9fa;
    }

    /* Card hồ sơ chính */
    .profile-card {
        background: #fff;
        border: none;
        border-radius: 20px;
        box-shadow: 0 10px 30px rgba(255, 183, 197, 0.25); /* Đổ bóng hồng nhẹ */
        overflow: hidden;
        position: relative;
    }

    /* Phần nền màu gradient phía trên */
    .profile-header-bg {
        background: linear-gradient(135deg, #ffc3d0 0%, #ffe3e9 100%);
        height: 130px;
        width: 100%;
        position: absolute;
        top: 0;
        left: 0;
    }

    /* Khu vực Avatar */
    .avatar-wrapper {
        position: relative;
        margin-top: 60px; /* Đẩy xuống để avatar nằm giữa ranh giới header */
        margin-bottom: 20px;
        text-align: center;
    }

    .avatar-circle {
        width: 120px;
        height: 120px;
        background-color: #fff;
        border-radius: 50%;
        padding: 5px;
        box-shadow: 0 5px 15px rgba(0,0,0,0.08);
        display: inline-flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto;
    }

    .avatar-icon {
        font-size: 4rem;
        color: var(--pink-dark);
    }

    /* Style cho các ô Input */
    .label-pastel {
        font-size: 0.85rem;
        font-weight: 700;
        color: #888;
        text-transform: uppercase;
        margin-bottom: 6px;
        display: block;
        padding-left: 5px;
    }

    .input-group-pastel {
        background-color: var(--pink-bg);
        border-radius: 15px;
        padding: 10px 15px;
        display: flex;
        align-items: center;
        transition: all 0.3s;
        border: 1px solid transparent;
    }

    .input-group-pastel:hover {
        background-color: #ffeef2;
    }

    .input-group-pastel .icon-box {
        width: 30px;
        color: var(--pink-dark);
        font-size: 1.1rem;
        display: flex;
        justify-content: center;
    }

    .form-control-pastel {
        border: none;
        background: transparent;
        font-weight: 600;
        color: #444;
        width: 100%;
        padding-left: 10px;
    }
    
    .form-control-pastel:focus {
        outline: none;
    }

    /* Buttons */
    .btn-password {
        background-color: var(--pink-primary);
        color: white;
        border: none;
        border-radius: 50px;
        padding: 12px 30px;
        font-weight: 700;
        width: 100%;
        transition: all 0.3s;
        box-shadow: 0 4px 10px rgba(255, 183, 197, 0.4);
    }

    .btn-password:hover {
        background-color: var(--pink-dark);
        color: white;
        transform: translateY(-2px);
    }

    .btn-back {
        background-color: transparent;
        color: #999;
        border: 2px solid #eee;
        border-radius: 50px;
        padding: 10px 30px;
        font-weight: 600;
        width: 100%;
        transition: all 0.3s;
    }

    .btn-back:hover {
        border-color: var(--pink-primary);
        color: var(--pink-dark);
        background-color: #fff;
    }
</style>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-5">
            
            <div class="card profile-card">
                <div class="profile-header-bg"></div>

                <div class="card-body px-4 pb-5 pt-0">
                    
                    <div class="avatar-wrapper">
                        <div class="avatar-circle">
                            <i class="fas fa-user-circle avatar-icon"></i>
                        </div>
                        <h4 class="fw-bold mt-3 mb-1" style="color: #444;">${sessionScope.user.name}</h4>
                        <span class="badge rounded-pill bg-white text-secondary border shadow-sm px-3 py-2">
                            <i class="fas fa-gem me-1 text-warning"></i> Khách hàng thân thiết
                        </span>
                    </div>

                    <form action="profile" method="post" class="mt-4">
                        
                        <div class="mb-3">
                            <label class="label-pastel">Họ và tên</label>
                            <div class="input-group-pastel">
                                <div class="icon-box"><i class="far fa-user"></i></div>
                                <input type="text" class="form-control-pastel" value="${sessionScope.user.name}" readonly>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="label-pastel">Địa chỉ Email</label>
                            <div class="input-group-pastel">
                                <div class="icon-box"><i class="far fa-envelope"></i></div>
                                <input type="email" class="form-control-pastel" value="${sessionScope.user.email}" readonly>
                            </div>
                        </div>

                        <div class="mb-4">
                            <label class="label-pastel">Số điện thoại</label>
                            <div class="input-group-pastel">
                                <div class="icon-box"><i class="fas fa-phone-alt"></i></div>
                                <input type="text" class="form-control-pastel" value="${sessionScope.user.phone}" readonly>
                            </div>
                        </div>

                        <div class="row g-2 mt-4">
                            <div class="col-12">
                                <a href="${pageContext.request.contextPath}/change-password" class="btn btn-password">
                                    <i class="fas fa-key me-2"></i> Đổi mật khẩu
                                </a>
                            </div>
                            <div class="col-12 mt-2">
                                <a href="${pageContext.request.contextPath}/home" class="btn btn-back">
                                    <i class="fas fa-arrow-left me-2"></i> Quay lại trang chủ
                                </a>
                            </div>
                        </div>

                    </form>
                </div>
            </div>

        </div>
    </div>
</div>