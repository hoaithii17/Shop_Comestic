<%@page contentType="text/html; charset=UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:import url="/inc/admin_navbar.jsp" />
<!DOCTYPE html>
<html>
<head>
    <title>Quản lý sản phẩm</title>
    <style>
        body { font-family: Arial; background: #f7f7f7; padding: 20px;}
        table { width: 100%; border-collapse: collapse; background: white; }
        th, td { padding: 10px; border-bottom: 1px solid #ddd; text-align: center; }
        th { background: #d63384; color: white; }
        img { width: 60px; border-radius: 6px; }
        .btn {
            padding: 6px 10px; border-radius: 6px; text-decoration: none; color: white;
        }
        .edit { background: #0d6efd; }
        .delete { background: #dc3545; }
        .add {
            background: #28a745;
            padding: 10px 15px;
            display: inline-block;
            margin-bottom: 15px;
        }
        /* Container thanh tìm kiếm */
.search-toolbar {
    background: white;
    padding: 15px 20px;
    border-radius: 16px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.03);
    margin-bottom: 20px;
    border: 1px solid #f0f0f0;
}

/* Style chung cho Input và Select */
.search-input {
    border-radius: 50px;       /* Bo tròn viên thuốc */
    border: 1px solid #eee;    /* Viền nhạt */
    height: 45px;              /* Chiều cao chuẩn */
    font-size: 0.95rem;
    box-shadow: none;
    transition: all 0.3s;
    background-color: #fcfcfc;
}

/* Hiệu ứng khi bấm vào (Focus) */
.search-input:focus {
    border-color: #d63384;     /* Màu hồng chủ đạo */
    background-color: #fff;
    box-shadow: 0 0 0 4px rgba(214, 51, 132, 0.1); /* Hào quang hồng nhạt */
}

/* Nút Tìm kiếm */
.btn-search {
    background-color: #d63384;
    color: white;
    border-radius: 50px;
    padding: 0 25px;
    height: 45px;
    font-weight: 700;
    border: none;
    transition: all 0.3s;
    white-space: nowrap;
}

.btn-search:hover {
    background-color: #b01b65; /* Màu đậm hơn khi di chuột */
    color: white;
    transform: translateY(-2px);
    box-shadow: 0 4px 10px rgba(214, 51, 132, 0.3);
}
    </style>
    
</head>

<body>

<h2>📦 Quản lý sản phẩm</h2>
<a href="addproduct.jsp" class="btn add">+ Thêm sản phẩm</a>
<div class="search-toolbar">
    
    <form action="${pageContext.request.contextPath}/adminproductfind" method="get" class="d-flex align-items-center gap-3 w-100">
        
        <div class="position-relative" style="min-width: 200px;">
            <i class="fas fa-filter position-absolute text-muted" 
               style="left: 15px; top: 50%; transform: translateY(-50%); font-size: 0.9rem;"></i>
            
            <select name="categoryId" class="form-select search-input ps-5" onchange="this.form.submit()">
                <option value="">Tất cả danh mục</option>
                
                <c:forEach var="c" items="${categories}">
                    <option value="${c.id}" ${param.categoryId == c.id ? 'selected' : ''}>
                        ${c.name}
                    </option>
                </c:forEach>
            </select>
        </div>

        <div class="position-relative flex-grow-1">
            <i class="fas fa-search position-absolute text-muted" 
               style="left: 15px; top: 50%; transform: translateY(-50%); font-size: 0.9rem;"></i>
            
            <input type="text" name="keyword" class="form-control search-input ps-5" 
                   value="${param.keyword}" 
                   placeholder="Nhập tên sản phẩm cần tìm...">
        </div>

        <button type="submit" class="btn btn-search">
            Tìm kiếm
        </button>
        
        <a href="${pageContext.request.contextPath}/adminproductfind" class="btn btn-light rounded-pill border" title="Làm mới">
            <i class="fas fa-sync-alt text-muted"></i>
        </a>

    </form>
</div>
<table>
    <tr>
        <th>ID</th>
        <th>Danh mục</th>
        <th>Tên sản phẩm</th>
        <th>Hình ảnh</th>
        <th>Giá</th>
        <th>Số lượng</th>
        <th class="text-center">Đã bán</th>

        <th>Trạng thái</th>
        <th>Hành động</th>
    </tr>

    <c:forEach var="p" items="${products}">
        <tr>
            <td>${p.id}</td>
            <td>${p.id_category}</td>
            <td>${p.name}</td>
            <td><img src="./assets/images/${p.image}"></td>
            <td>${p.price} ₫</td>
            <td>${p.quantity}</td>
            <td class="text-center">
    <span class="badge bg-info-subtle text-info fw-bold px-3">
        ${p.sold}
    </span>
    
<c:if test="${p.sold >= 20}">
    <span class="badge bg-danger ms-1">HOT</span>
</c:if>

</td>

           <td>
    <c:choose>
        <c:when test="${p.status == 1}">
            Còn bán
        </c:when>
        <c:otherwise>
            Ngưng bán
        </c:otherwise>
    </c:choose>
</td>


            <td>
               <a href="${pageContext.request.contextPath}/admin/editProduct?id=${p.id}"
   class="btn btn-warning">Sửa</a>

                <a class="btn delete" href="deleteProduct?id=${p.id}"
                   onclick="return confirm('Xóa sản phẩm này?')">Xóa</a>
            </td>
        </tr>
    </c:forEach>
</table>

</body>
</html>
