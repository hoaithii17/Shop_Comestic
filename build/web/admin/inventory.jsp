<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/inc/admin_navbar.jsp"/>

<style>
    .action-btn {
        width: 35px;
        height: 35px;
        border-radius: 50%;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        transition: all 0.3s ease;
        border: none;
        margin: 0 3px;
    }
    .action-btn:hover {
        transform: translateY(-3px);
        box-shadow: 0 4px 10px rgba(0,0,0,0.15);
    }
    .current-stock-box {
        background-color: #f8f9fa;
        border-radius: 12px;
        padding: 15px;
        text-align: center;
        margin-bottom: 20px;
        border: 2px dashed #dee2e6;
    }
</style>
<div class="container mt-5">

<h3 class="fw-bold text-danger mb-4">
    <i class="fas fa-warehouse me-2"></i> Quản lý kho hàng
</h3>

<div class="card shadow-lg border-0 rounded-4">
<div class="card-body table-responsive">

<table class="table table-hover align-middle text-center">
<thead class="table-danger">
<tr>
    <th>ID</th>
    <th>Sản phẩm</th>
    <th>Danh mục</th>
    <th>Tồn kho</th>
    <th>Thao tác</th>
</tr>
</thead>

<tbody>
<c:forEach var="p" items="${products}">
<tr>
    <td>#${p.id}</td>
    <td class="fw-bold">${p.name}</td>
    <td>DM ${p.id_category}</td>

    <td>
        <span class="badge rounded-pill
        ${p.quantity > 10 ? 'bg-success' : 'bg-danger'}">
        ${p.quantity}
        </span>
    </td>

    <td>
        <button class="action-btn bg-success text-white"
            data-bs-toggle="modal"
            data-bs-target="#importModal${p.id}">
            <i class="fas fa-plus"></i>
        </button>

        <button class="action-btn bg-warning text-dark"
            data-bs-toggle="modal"
            data-bs-target="#exportModal${p.id}">
            <i class="fas fa-minus"></i>
        </button>

        <button class="action-btn bg-info text-white"
            data-bs-toggle="modal"
            data-bs-target="#adjustModal${p.id}">
            <i class="fas fa-edit"></i>
        </button>
    </td>
</tr>
</c:forEach>
</tbody>
</table>

</div>
</div>
</div>
<c:forEach var="p" items="${products}">

<!-- IMPORT -->
<div class="modal fade" id="importModal${p.id}" tabindex="-1">
<div class="modal-dialog modal-dialog-centered">
<form action="${pageContext.request.contextPath}/admin/inventory"
      method="post" class="modal-content">

<input type="hidden" name="type" value="IMPORT">
<input type="hidden" name="productId" value="${p.id}">

<div class="modal-header">
    <h5 class="modal-title text-success">Nhập kho</h5>
    <button class="btn-close" data-bs-dismiss="modal"></button>
</div>

<div class="modal-body">
    <p>Hiện có: <b>${p.quantity}</b></p>

    <input type="number"
           name="quantity"
           class="form-control mb-2"
           min="1"
           placeholder="Số lượng nhập"
           required>

    <!-- ✅ GIÁ NHẬP -->
    <input type="number"
           step="0.01"
           name="importPrice"
           class="form-control mb-2"
           placeholder="Giá nhập"
           required>

    <textarea name="note"
              class="form-control"
              placeholder="Ghi chú (nhà cung cấp, hóa đơn...)">
    </textarea>
</div>

    

<div class="modal-footer">
    <button class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
    <button class="btn btn-success">Xác nhận</button>
</div>

</form>
</div>
</div>

<!-- EXPORT & ADJUST làm tương tự -->
<!-- EXPORT -->
<div class="modal fade" id="exportModal${p.id}" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <form action="${pageContext.request.contextPath}/admin/inventory"
              method="post" class="modal-content">

            <input type="hidden" name="type" value="EXPORT">
            <input type="hidden" name="productId" value="${p.id}">

            <div class="modal-header">
                <h5 class="modal-title text-warning">Xuất kho</h5>
                <button class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <div class="modal-body">
                <p>Hiện có: <b>${p.quantity}</b></p>

                <input type="number"
                       name="quantity"
                       class="form-control mb-2"
                       min="1"
                       max="${p.quantity}"
                       required>

                <textarea name="note"
                          class="form-control"
                          placeholder="Lý do xuất kho"></textarea>
            </div>

            <div class="modal-footer">
                <button class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                <button class="btn btn-warning">Xác nhận</button>
            </div>

        </form>
    </div>
</div>
<!-- ADJUST -->
<div class="modal fade" id="adjustModal${p.id}" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <form action="${pageContext.request.contextPath}/admin/inventory"
              method="post" class="modal-content">

            <input type="hidden" name="type" value="ADJUST">
            <input type="hidden" name="productId" value="${p.id}">

            <div class="modal-header">
                <h5 class="modal-title text-info">Điều chỉnh kho</h5>
                <button class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <div class="modal-body">
                <p>Số lượng hiện tại: <b>${p.quantity}</b></p>

               <input type="number"
       name="newQuantity"
       class="form-control mb-2"
       min="0"
       required
       placeholder="Số lượng thực tế">

                <textarea name="note"
                          class="form-control"
                          placeholder="Lý do điều chỉnh"></textarea>
            </div>

            <div class="modal-footer">
                <button class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                <button class="btn btn-info text-white">Cập nhật</button>
            </div>

        </form>
    </div>
</div>

</c:forEach>
