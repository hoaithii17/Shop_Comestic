<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- products -->
<c:if test="${id_category == null}">
    <c:forEach items="${listCategory}" var="c">
        <section>
            <div class="container my-5">
                <header class="mb-4">
                    <h3>${c.getName()}</h3>
                </header>
                <div class="row">
                    <c:forEach items="${listProduct}" var="p">
                        <c:if test="${c.getId() == p.getId_category() && p.isStatus() == true}">
                            <div class="col-lg-3 col-md-6 d-flex">
                                <div class="card w-100 my-2 shadow-2-strong">
                                    <img src="assets/images/${p.getImage()}" class="card-img-top" style="aspect-ratio: 1/1" />
                                    <div class="card-body d-flex flex-column">
                                        <h5 class="card-type">${p.getName()}</h5>
                                        <p class="card-text">${p.getPrice()} VN?</p>
                                        <div class="card-footer d-flex align-items-end pt-3 px-0 pb-0 mt-auto">

                                            <c:choose>
                                                <c:when test="${user == null}">
                                                    <a href="login" class="btn btn-primary shadow-0 me-1">Add to cart</a>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="home?id_product=${p.getId()}" class="btn btn-primary shadow-0 me-1">Add to cart</a>
                                                </c:otherwise>
                                            </c:choose>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </div>
        </section>
    </c:forEach>
</c:if>

<c:if test="${id_category != null}">
    <c:forEach items="${listCategory}" var="c">
        <section>
            <div class="container my-5">
                <header class="mb-4">
                    <h3>${c.getName()}</h3>
                </header>
                <div class="row">
                    <c:forEach items="${listProduct}" var="p">
                        <c:if test="${c.getId() == p.getId_category() && p.isStatus() == true}">
                            <div class="col-lg-3 col-md-6 d-flex">
                                <div class="card w-100 my-2 shadow-2-strong">
                                    <img src="assets/images/${p.getImage()}" class="card-img-top" style="aspect-ratio: 1/1" />
                                    <div class="card-body d-flex flex-column">
                                        <h5 class="card-type">${p.getName()}</h5>
                                        <p class="card-text">${p.getPrice()} VN?</p>
                                        <div class="card-footer d-flex align-items-end pt-3 px-0 pb-0 mt-auto">

                                            <c:choose>
                                                <c:when test="${user == null}">
                                                    <a href="login" class="btn btn-primary shadow-0 me-1">Add to cart</a>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="home?id_product=${p.getId()}&id_category=${c.getId()}"
                                                       class="btn btn-primary shadow-0 me-1">Add to cart</a>
                                                </c:otherwise>
                                            </c:choose>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </div>
        </section>
    </c:forEach>
</c:if>
