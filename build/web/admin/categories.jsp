<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Danh mục | Admin</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700;800&display=swap" rel="stylesheet">
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
            font-family: 'Nunito', sans-serif;
        }

        /* Card Container */
        .card-table {
            border: none;
            border-radius: 16px;
            box-shadow: var(--card-shadow);
            background: white;
            overflow: hidden;
        }

        .card-header-custom {
            background-color: white;
            padding: 25px 30px;
            border-bottom: 1px solid #f0f0f0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        /* Table Styling */
        .table-custom thead th {
            background-color: var(--light-pink);
            color: var(--primary-pink);
            font-weight: 700;
            border: none;
            padding: 15px 20px;
            text-transform: uppercase;
            font-size: 0.9rem;
        }

        .table-custom tbody td {
            padding: 15px 20px;
            vertical-align: middle;
            border-bottom: 1px solid #f8f9fa;
            color: #555;
            font-weight: 600;
        }

        .table-custom tbody tr:hover { background-color: #fffcfd; }

        /* Buttons */
        .btn-add {
            background-color: var(--primary-pink);
            color: white;
            border-radius: 50px;
            padding: 10px 25px;
            font-weight: 700;
            border: none;
            transition: 0.3s;
        }
        .btn-add:hover { background-color: #b01b65; color: white; transform: translateY(-2px); }

        .btn-action {
            width: 35px; height: 35px;
            border-radius: 50%;
            display: inline-flex; align-items: center; justify-content: center;
            border: none; transition: 0.2s; text-decoration: none;
        }
        .btn-edit { background: #e7f5ff; color: #0d6efd; }
        .btn-edit:hover { background: #0d6efd; color: white; }
        
        .btn-delete { background: #fff5f5; color: #dc3545; }
        .btn-delete:hover { background: #dc3545; color: white; }

        /* Modal Styling */
        .modal-content { border-radius: 16px; border: none; }
        .modal-header { border-bottom: 1px solid #f0f0f0; background: var(--light-pink); border-radius: 16px 16px 0 0; }
        .modal-title { color: var(--primary-pink); font-weight: 800; }
        .form-control:focus { border-color: var(--primary-pink); box-shadow: 0 0 0 0.25rem rgba(214, 51, 132, 0.15); }
    </style>
</head>
<body>

    <c:import url="/inc/admin_navbar.jsp" />

    <div class="container py-5">
        
        <div class="row justify-content-center">
            <div class="col-lg-10">
                
                <div class="card card-table">
                    
                    <div class="card-header-custom">
                        <div>
                            <h4 class="fw-bold mb-1" style="color: var(--primary-pink);">
                                <i class="fas fa-tags me-2"></i>Quản lý Danh mục
                            </h4>
                            <p class="text-muted mb-0 small">Danh sách các loại sản phẩm hiện có</p>
                        </div>
                        <button class="btn btn-add" data-bs-toggle="modal" data-bs-target="#addCategoryModal">
                            <i class="fas fa-plus me-2"></i>Thêm danh mục
                        </button>
                    </div>

                    <div class="table-responsive">
                        <table class="table table-custom table-hover mb-0">
                            <thead>
                                <tr>
                                    <th width="10%" class="text-center">ID</th>
                                    <th width="60%">Tên danh mục</th>
                                    <th width="30%" class="text-center">Hành động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="c" items="${categories}">
                                    <tr>
                                        <td class="text-center text-muted">#${c.id}</td>
                                        
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <div class="rounded p-2 bg-light me-3 text-pink">
                                                    <i class="fas fa-folder text-warning"></i>
                                                </div>
                                                <span>${c.name}</span>
                                            </div>
                                        </td>

                                        <td class="text-center">
                                            <button class="btn-action btn-edit me-2" 
                                                    onclick="openEditModal('${c.id}', '${c.name}')"
                                                    title="Sửa">
                                                <i class="fas fa-pen"></i>
                                            </button>

                                            <a href="${pageContext.request.contextPath}/admin/categories?action=delete&id=${c.id}" 
                                               class="btn-action btn-delete"
                                               onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục: ${c.name}?')"
                                               title="Xóa">
                                                <i class="fas fa-trash"></i>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div> </div>
        </div>
    </div>

    <div class="modal fade" id="addCategoryModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="fas fa-plus-circle me-2"></i>Thêm Danh Mục Mới</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="${pageContext.request.contextPath}/admin/categories" method="post">
                    <div class="modal-body p-4">
                        <input type="hidden" name="action" value="add">
                        <div class="mb-3">
                            <label class="form-label fw-bold">Tên danh mục</label>
                            <input type="text" name="name" class="form-control" placeholder="Nhập tên danh mục..." required>
                        </div>
                    </div>
                    <div class="modal-footer border-0">
                        <button type="button" class="btn btn-light rounded-pill px-4" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-add px-4">Thêm mới</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div class="modal fade" id="editCategoryModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="fas fa-edit me-2"></i>Cập nhật Danh Mục</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="${pageContext.request.contextPath}/admin/categories" method="post">
                    <div class="modal-body p-4">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="id" id="edit-id">
                        
                        <div class="mb-3">
                            <label class="form-label fw-bold">Tên danh mục</label>
                            <input type="text" name="name" id="edit-name" class="form-control" required>
                        </div>
                    </div>
                    <div class="modal-footer border-0">
                        <button type="button" class="btn btn-light rounded-pill px-4" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-primary rounded-pill px-4" style="background: var(--primary-pink); border:none;">Lưu thay đổi</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Hàm này được gọi khi bấm nút "Sửa"
        function openEditModal(id, name) {
            // 1. Điền dữ liệu cũ vào Form trong Modal
            document.getElementById('edit-id').value = id;
            document.getElementById('edit-name').value = name;
            
            // 2. Mở Modal lên
            var editModal = new bootstrap.Modal(document.getElementById('editCategoryModal'));
            editModal.show();
        }
    </script>

</body>
</html>