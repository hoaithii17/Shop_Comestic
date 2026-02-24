<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thêm sản phẩm mới | Admin</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

    <style>
        :root {
            --primary-pink: #d63384;
            --light-pink: #fff0f6;
            --text-dark: #333;
            --input-border: #ced4da;
            --input-focus: #d63384;
        }

        body {
            font-family: 'Nunito', sans-serif;
            background-color: #f8f9fa;
            color: var(--text-dark);
        }

        /* --- Card Style --- */
        .card-form {
            border: none;
            border-radius: 16px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
            background: white;
            overflow: hidden;
        }

        .card-header-custom {
            background-color: white;
            padding: 20px 30px;
            border-bottom: 1px solid #f0f0f0;
        }

        /* --- Form Input Styling --- */
        .form-label {
            font-weight: 700;
            color: #555;
            font-size: 0.9rem;
            margin-bottom: 8px;
        }

        .form-control, .form-select {
            border-radius: 10px;
            padding: 10px 15px;
            border: 1px solid var(--input-border);
            font-size: 0.95rem;
            transition: all 0.3s;
        }

        /* Hiệu ứng khi bấm vào ô input (Focus màu hồng) */
        .form-control:focus, .form-select:focus {
            border-color: var(--input-focus);
            box-shadow: 0 0 0 0.25rem rgba(214, 51, 132, 0.15);
        }

        /* --- Buttons --- */
        .btn-save {
            background-color: var(--primary-pink);
            color: white;
            border: none;
            padding: 10px 30px;
            border-radius: 50px;
            font-weight: 700;
            transition: 0.3s;
        }
        .btn-save:hover {
            background-color: #b01b65;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(214, 51, 132, 0.3);
        }

        .btn-cancel {
            background-color: #f1f3f5;
            color: #666;
            border: none;
            padding: 10px 30px;
            border-radius: 50px;
            font-weight: 600;
            margin-right: 10px;
            text-decoration: none;
            display: inline-block;
        }
        .btn-cancel:hover {
            background-color: #e9ecef;
            color: #333;
        }
        
        .section-title {
            color: var(--primary-pink);
            font-weight: 800;
            margin-bottom: 5px;
        }
    </style>
</head>
<body>

    <c:import url="/inc/admin_navbar.jsp" />

    <div class="container py-5">
        
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h3 class="section-title"><i class="fas fa-plus-circle me-2"></i>Thêm Sản Phẩm Mới</h3>
                <p class="text-muted mb-0">Điền thông tin chi tiết để tạo sản phẩm mới vào kho.</p>
            </div>
            <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-outline-secondary rounded-pill">
                <i class="fas fa-arrow-left me-2"></i>Quay lại danh sách
            </a>
        </div>

        <div class="row justify-content-center">
            <div class="col-lg-10">
                <div class="card card-form">
                    <div class="card-body p-4 p-md-5">
                        
                        <form action="${pageContext.request.contextPath}/addproduct" method="post">
                            
                            <div class="row g-4 mb-4">
                                <div class="col-md-12">
                                    <label class="form-label">Tên sản phẩm <span class="text-danger">*</span></label>
                                    <input type="text" name="name" class="form-control" placeholder="Ví dụ: Son Kem Lì 3CE..." required>
                                </div>
                                <div class="col-md-12">
                                    <label class="form-label">Link Hình ảnh (URL)</label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-white"><i class="fas fa-image text-muted"></i></span>
                                        <input type="text" name="image" class="form-control" placeholder="Nhập tên file ảnh (vd: son3ce.jpg) hoặc đường dẫn...">
                                    </div>
                                    <div class="form-text">Nên sử dụng ảnh kích thước vuông để hiển thị đẹp nhất.</div>
                                </div>
                            </div>

                            <div class="row g-4 mb-4">
                                <div class="col-md-4">
                                    <label class="form-label">Giá bán (VNĐ) <span class="text-danger">*</span></label>
                                    <div class="input-group">
                                        <input type="number" name="price" class="form-control" placeholder="0" min="0" required>
                                        <span class="input-group-text bg-light">đ</span>
                                    </div>
                                </div>
                                
                                <div class="col-md-4">
                                    <label class="form-label">Số lượng kho <span class="text-danger">*</span></label>
                                    <input type="number" name="quantity" class="form-control" placeholder="0" min="1" value="10" required>
                                </div>

                                <div class="col-md-4">
                                    <label class="form-label">Danh mục</label>
                                    <select name="category" class="form-select">
                                        <option value="1">Chăm sóc da</option>
                                        <option value="2">Trang điểm</option>
                                        <option value="3">Chăm sóc tóc</option>
                                        <option value="4">Chăm sóc cơ thể</option>
                                        
                                        <%-- <c:forEach items="${listCC}" var="c">
                                            <option value="${c.cid}">${c.cname}</option>
                                        </c:forEach> --%>
                                    </select>
                                </div>
                            </div>


                            <hr class="my-4" style="border-color: #eee;">

                            <div class="d-flex justify-content-end">
                                <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-cancel">Hủy bỏ</a>
                                <button type="submit" class="btn btn-save">
                                    <i class="fas fa-save me-2"></i>Lưu sản phẩm
                                </button>
                            </div>

                        </form>

                    </div>
                </div>
            </div>
        </div>

    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>