<%@page contentType="text/html; charset=UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Font Awesome Free -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

<section class="py-5" style="background-color: #ffe6f2;">
  <div class="container text-center">
    <h2 class="fw-bold mb-3">Danh mục sản phẩm</h2>
    <p class="mb-5">Chọn loại sản phẩm bạn muốn xem</p>

    <div class="row g-4 justify-content-center">
      <c:forEach items="${listCategory}" var="c">
        <div class="col-lg-3 col-md-4 col-sm-6">
          <a href="${pageContext.request.contextPath}/product?id_category=${c.getId()}" class="text-decoration-none">
            <div class="category-card p-4 rounded shadow-sm bg-white h-100 d-flex flex-column align-items-center justify-content-center">
              <div class="category-icon mb-3" style="font-size:3rem; color:#d63384;">
                <c:choose>
                  <c:when test="${c.getName() == 'Skincare'}"><i class="fas fa-tint"></i></c:when>
                  <c:when test="${c.getName() == 'Makeup'}"><i class="fas fa-eye-dropper"></i></c:when>
                  <c:when test="${c.getName() == 'Haircare'}"><i class="fas fa-spa"></i></c:when>
                  <c:when test="${c.getName() == 'Bodycare'}"><i class="fas fa-hand-sparkles"></i></c:when>
                  <c:otherwise><i class="fas fa-shopping-bag"></i></c:otherwise>
                </c:choose>
              </div>
              <h5 class="mb-0 text-dark">${c.getName()}</h5>
            </div>
          </a>
        </div>
      </c:forEach>
    </div>
  </div>
</section>

<style>
.category-card {
  transition: transform 0.3s, box-shadow 0.3s;
  cursor: pointer;
}
.category-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 8px 20px rgba(0,0,0,0.2);
}
.category-icon {
  font-size: 3rem;
}
@media (max-width: 768px) {
  .category-icon {
    font-size: 2.5rem;
  }
}
</style>
