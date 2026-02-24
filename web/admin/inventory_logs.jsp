<%@page contentType="text/html; charset=UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<c:import url="/inc/admin_navbar.jsp" />

<!DOCTYPE html>
<html>
<head>
    <title>Lịch sử kho</title>
    <style>
        body { font-family: Arial; background: #f7f7f7; padding: 20px; }
        h2 { margin-bottom: 20px; }

        table { width: 100%; border-collapse: collapse; background: white; }
        th, td { padding: 10px; border-bottom: 1px solid #ddd; text-align: center; }
        th { background: #343a40; color: white; }

        .type-import { color: green; font-weight: bold; }
        .type-export { color: red; font-weight: bold; }
        .type-adjust { color: orange; font-weight: bold; }

        .badge { padding: 3px 8px; border-radius: 5px; color: white; font-weight: bold; }
        .badge-import { background-color: green; }
        .badge-export { background-color: red; }
        .badge-adjust { background-color: orange; }
    </style>
</head>
<body>

<h2>📦 Lịch sử kho</h2>

<table>
    <tr>
        <th>ID</th>
        <th>Sản phẩm</th>
        <th>Loại</th>
        <th>Số lượng</th>
        <th>Giá nhập</th>
        <th>Ghi chú</th>
        <th>Thời gian</th>
    </tr>

    <c:forEach var="log" items="${logs}">
        <tr>
            <td>${log.id}</td>
            <td>${log.productId}</td> <!-- Bạn có thể đổi sang log.productName nếu DAO join products -->
            <td>
                <c:choose>
                    <c:when test="${log.type == 'IMPORT'}">
                        <span class="badge badge-import">Nhập</span>
                    </c:when>
                    <c:when test="${log.type == 'EXPORT'}">
                        <span class="badge badge-export">Xuất</span>
                    </c:when>
                    <c:when test="${log.type == 'ADJUST'}">
                        <span class="badge badge-adjust">Điều chỉnh</span>
                    </c:when>
                </c:choose>
            </td>
            <td>${log.quantity}</td>
            <td>${log.importPrice} ₫</td>
            <td>${log.note}</td>
            <td>
                <fmt:formatDate value="${log.createdAt}" pattern="yyyy-MM-dd HH:mm:ss"/>
            </td>
        </tr>
    </c:forEach>

</table>

</body>
</html>
