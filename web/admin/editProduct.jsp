<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cập nhật sản phẩm #${product.id}</title>

    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

    <style>
        :root {
            --primary-color: #4e73df;
            --secondary-color: #858796;
            --accent-color: #d63384; /* Màu hồng cũ của bạn giữ làm điểm nhấn */
            --bg-color: #f3f4f6;
        }

        body {
            font-family: 'Nunito', sans-serif;
            background-color: var(--bg-color);
            color: #444;
        }

        /* Card Styling */
        .card-custom {
            border: none;
            border-radius: 20px;
            background: #fff;
            box-shadow: 0 10px 40px rgba(0,0,0,0.06);
            overflow: hidden;
            transition: transform 0.2s;
        }

        .card-header-custom {
            background: linear-gradient(135deg, #ffffff 0%, #f8f9fc 100%);
            border-bottom: 1px solid #edf2f9;
            padding: 25px 30px;
        }

        /* Form Controls */
        .form-control, .form-select {
            border-radius: 10px;
            border: 1px solid #e3e6f0;
            padding: 12px 15px;
            font-size: 0.95rem;
            transition: all 0.3s;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--accent-color);
            box-shadow: 0 0 0 4px rgba(214, 51, 132, 0.1);
        }

        .form-floating > label {
            padding-left: 15px;
        }

        /* Image Preview Box */
        .img-preview-container {
            width: 100%;
            height: 350px;
            border-radius: 15px;
            border: 2px dashed #e3e6f0;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            position: relative;
            background-color: #fafbfc;
        }

        .img-preview-container img {
            max-width: 100%;
            max-height: 100%;
            object-fit: contain;
            transition: transform 0.3s ease;
        }
        
        .img-preview-container:hover img {
            transform: scale(1.05);
        }

        /* Buttons */
        .btn-update {
            background: linear-gradient(45deg, #d63384, #c02672);
            color: white;
            border: none;
            border-radius: 50px;
            padding: 12px 40px;
            font-weight: 700;
            letter-spacing: 0.5px;
            box-shadow: 0 4px 15px rgba(214, 51, 132, 0.4);
            transition: all 0.3s ease;
        }

        .btn-update:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(214, 51, 132, 0.6);
            color: white;
        }

        .btn-back {
            border-radius: 50px;
            padding: 8px 20px;
            font-weight: 600;
            transition: all 0.2s;
        }
        
        .badge-id {
            background-color: #eef2f7;
            color: var(--primary-color);
            padding: 5px 12px;
            border-radius: 8px;
            font-weight: 800;
            font-size: 0.9rem;
        }
    </style>
</head>

<body>

<div class="container py-5">
    
    <form action="${pageContext.request.contextPath}/admin/editProduct" method="post">
        <input type="hidden" name="id" value="${product.id}">

        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h2 class="fw-bolder mb-1" style="color: #2c3e50;">Cập nhật sản phẩm</h2>
                <div class="d-flex align-items-center gap-2">
                    <span class="text-muted">Mã sản phẩm:</span>
                    <span class="badge-id">#${product.id}</span>
                </div>
            </div>
            <a href="${pageContext.request.contextPath}/adminproductfind" class="btn btn-outline-secondary btn-back">
                <i class="fas fa-arrow-left me-2"></i>Quay lại danh sách
            </a>
        </div>

        <div class="row g-4">
            <div class="col-lg-8">
                <div class="card card-custom h-100">
                    <div class="card-header-custom">
                        <h5 class="m-0 fw-bold text-secondary"><i class="fas fa-info-circle me-2"></i>Thông tin chi tiết</h5>
                    </div>
                    <div class="card-body p-4">
                        
                        <div class="form-floating mb-4">
                            <input type="text" name="name" class="form-control" id="productName" 
                                   placeholder="Nhập tên sản phẩm" value="${product.name}" required>
                            <label for="productName">Tên sản phẩm</label>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-4">
                                <div class="form-floating">
                                    <input type="number" name="price" class="form-control" id="productPrice" 
                                           placeholder="Giá" value="${product.price}" min="0" required>
                                    <label for="productPrice">Giá bán (VND)</label>
                                </div>
                            </div>
                            <div class="col-md-6 mb-4">
                                <div class="form-floating">
                                    <input type="number" class="form-control bg-light" id="productQty" 
                                           value="${product.quantity}" readonly>
                                    <label for="productQty">Tồn kho (Không sửa)</label>
                                </div>
                            </div>
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-bold text-muted small text-uppercase">Danh mục sản phẩm</label>
                            <div class="input-group">
                                <span class="input-group-text bg-white border-end-0"><i class="fas fa-tags text-muted"></i></span>
                                <select name="category" class="form-select border-start-0 ps-0">
                                    <option value="1" ${product.id_category == 1 ? "selected" : ""}>Chăm sóc da (Skincare)</option>
                                    <option value="2" ${product.id_category == 2 ? "selected" : ""}>Trang điểm (Makeup)</option>
                                    <option value="3" ${product.id_category == 3 ? "selected" : ""}>Chăm sóc tóc</option>
                                    <option value="4" ${product.id_category == 4 ? "selected" : ""}>Chăm sóc cơ thể</option>
                                </select>
                            </div>
                        </div>

                        <div class="mb-2">
                            <label class="form-label fw-bold text-muted small text-uppercase">Trạng thái kinh doanh</label>
                            <select name="status" class="form-select">
    <option value="1" ${product.status == 1 ? "selected" : ""}>
        🟢 Đang kinh doanh
    </option>
    <option value="0" ${product.status == 0 ? "selected" : ""}>
        🔴 Ngừng kinh doanh
    </option>
</select>

                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-4">
                <div class="card card-custom h-100">
                    <div class="card-header-custom">
                        <h5 class="m-0 fw-bold text-secondary"><i class="fas fa-image me-2"></i>Hình ảnh</h5>
                    </div>
                    <div class="card-body p-4 text-center">
                        
                        <div class="img-preview-container mb-3">
                            <img id="imgPreview" src="${product.image}" 
                                 onerror="this.src='https://placehold.co/400x400?text=No+Image'" 
                                 alt="Preview ảnh sản phẩm">
                        </div>

                        <div class="form-floating mb-3">
                            <input type="text" name="image" class="form-control" id="imgLink" 
                                   placeholder="Link ảnh" value="${product.image}"
                                   oninput="updateImagePreview()">
                            <label for="imgLink">Đường dẫn ảnh (URL)</label>
                        </div>
                        
                        <small class="text-muted d-block mb-4">
                            *Paste link ảnh mới để xem trước ngay lập tức.
                        </small>

                        <hr class="my-4">

                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-update btn-lg">
                                <i class="fas fa-save me-2"></i>Lưu thay đổi
                            </button>
                            <a href="${pageContext.request.contextPath}/adminproductfind" class="btn btn-light text-muted">
                                Hủy bỏ
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>

<script>
    function updateImagePreview() {
        const url = document.getElementById('imgLink').value;
        const img = document.getElementById('imgPreview');
        if (url && url.trim() !== '') {
            img.src = url;
        } else {
            // Ảnh mặc định nếu xóa trống link
            img.src = 'https://placehold.co/400x400?text=No+Image'; 
        }
    }
</script>

</body>
</html>