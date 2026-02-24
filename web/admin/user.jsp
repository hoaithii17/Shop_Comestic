<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:import url="/inc/admin_navbar.jsp" />

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>

<div class="container mt-4">
    <div class="card">
        <div class="card-header" style="background:#fff0f6; color:#d63384;">
            <h5 class="mb-0">
                <c:choose>
                    <c:when test="${user != null}">✏️ Sửa người dùng</c:when>
                    <c:otherwise>➕ Thêm người dùng</c:otherwise>
                </c:choose>
            </h5>
        </div>
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/admin/user" method="post">
                <input type="hidden" name="id" value="${user != null ? user.id : ''}"/>

                <div class="mb-3">
                    <label class="form-label">Họ & Tên</label>
                    <input name="name" class="form-control" required value="${user != null ? user.name : ''}">
                </div>

                <div class="mb-3">
                    <label class="form-label">Email</label>
                    <input name="email" type="email" class="form-control" required value="${user != null ? user.email : ''}">
                </div>

                <div class="mb-3">
                    <label class="form-label">Phone</label>
                    <input name="phone" class="form-control" value="${user != null ? user.phone : ''}">
                </div>

                <div class="mb-3">
                    <label class="form-label">Mật khẩu</label>
                    <input name="password" type="password" class="form-control" ${user == null ? 'required' : ''}>
                    <small class="text-muted">Để trống nếu không muốn đổi mật khẩu khi sửa.</small>
                </div>

                <div class="mb-3">
                    <label class="form-label">Role</label>
                    <select name="role" class="form-select">
                        <option value="user" ${user != null && user.role=='user' ? 'selected' : ''}>User</option>
                        <option value="admin" ${user != null && user.role=='admin' ? 'selected' : ''}>Admin</option>
                    </select>
                </div>

                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-danger">Lưu</button>
                    <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-secondary">Hủy</a>
                </div>
            </form>
        </div>
    </div>
</div>
