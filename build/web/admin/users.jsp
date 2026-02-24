<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:import url="/inc/admin_navbar.jsp" />

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>

<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h3 style="color:#d63384;">👥 Quản lý Người dùng</h3>
        <a href="${pageContext.request.contextPath}/admin/user?action=create" class="btn btn-outline-danger">+ Thêm người dùng</a>
    </div>

    <table class="table table-hover bg-white">
        <thead class="table-light">
            <tr>
                <th>ID</th>
                <th>Họ & Tên</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Role</th>
                <th style="width:170px">Hành động</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="u" items="${list}">
                <tr>
                    <td>${u.id}</td>
                    <td>${u.name}</td>
                    <td>${u.email}</td>
                    <td>${u.phone}</td>
                    <td>
                        <c:choose>
                            <c:when test="${u.role == 'admin'}">Admin</c:when>
                            <c:otherwise>User</c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <a class="btn btn-sm btn-primary" href="${pageContext.request.contextPath}/admin/user?action=edit&id=${u.id}">Sửa</a>
                        <a class="btn btn-sm btn-danger" 
                           href="${pageContext.request.contextPath}/admin/user?action=delete&id=${u.id}"
                           onclick="return confirm('Bạn có chắc muốn xóa người dùng này?');">Xóa</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
