<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<section class="h-100 h-custom" style="background-color: #eee;">
  <div class="container py-5 h-100">
    <div class="row d-flex justify-content-center align-items-start h-100">

      <div class="col-lg-7">
        <h5 class="mb-3">
          <a href="home" class="text-body">
            <i class="fas fa-long-arrow-alt-left me-2"></i>Continue shopping
          </a>

          &nbsp;&nbsp;|&nbsp;&nbsp;

          <a href="cart?clear=OK" class="text-body">
            <i class="fas fa-trash-alt me-2"></i>Empty cart
          </a>
        </h5>

        <hr>

        <div class="d-flex justify-content-between align-items-center mb-4">
          <div>
            <p class="mb-1">Shopping cart</p>
            <p class="mb-0">You have ${cart.size()} items in your cart</p>
          </div>
          <div>
            <p class="mb-0">
              <span class="text-muted">Sort by:</span>
              <a href="#" class="text-body">price <i class="fas fa-angle-down mt-1"></i></a>
            </p>
          </div>
        </div>

        <c:set var="total" value="0"/>

        <c:forEach items="${cart}" var="product">
          <div class="card mb-3">
            <div class="card-body">
              <div class="d-flex justify-content-between">
                
                <!-- LEFT block -->
                <div class="d-flex flex-row align-items-center">
                  <div>
                    <img src="./assets/images/${product.image}"
                         class="img-fluid rounded-3" style="width: 65px;">
                  </div>
                  <div class="ms-3">
                    <h5>${product.name}</h5>
                  </div>
                </div>

                <!-- RIGHT block -->
                <div class="d-flex flex-row align-items-center" style="gap: 20px;">

                  <!-- QUANTITY -->
                  <form action="cart" method="post" style="display:flex; gap:6px;">
    <input type="hidden" name="id_product" value="${product.id}">
    <input type="number" name="quantity" value="${product.quantity}" min="1" style="width:60px;">

    <button type="submit" name="action" value="update">
        <img src="./assets/icon/update.png" width="18" height="18">
    </button>

    <button type="submit" name="action" value="delete">
        <img src="./assets/icon/delete.png" width="18" height="18">
    </button>
</form>

                  <!-- PRICE -->
                  <div style="width: 80px; text-align:right;">
                    <h5 class="mb-0">${product.price}</h5>
                  </div>
                </div>

              </div>
            </div>
          </div>

          <c:set var="total" value="${total + product.quantity * product.price}"/>
        </c:forEach>

      </div>


      <!-- RIGHT COLUMN = PAYMENT -->
      <div class="col-lg-5">
        <div class="card bg-primary text-white rounded-3">
          <div class="card-body">

            <div class="d-flex justify-content-between align-items-center mb-4">
              <h5 class="mb-0">Card details</h5>
              <img src="https://mdbcdn.b-cdn.net/img/Photos/Avatars/avatar-6.webp"
                   class="img-fluid rounded-3" style="width: 45px;" alt="Avatar">
            </div>

            <p class="small mb-2">Card type</p>
            <img src="./assets/icon/mastercard.png" width="40" class="me-2"/>
            <img src="./assets/icon/vietcombank.png" width="40" class="me-2"/>
            <img src="./assets/icon/vietinbank.png" width="40" class="me-2"/>
            <img src="./assets/icon/donga.png" width="40"/>

            <hr class="my-4">

            <div class="d-flex justify-content-between">
              <p class="mb-2">Subtotal</p>
              <p class="mb-2">$${total}</p>
            </div>

            <div class="d-flex justify-content-between">
              <p class="mb-2">Shipping</p>
              <p class="mb-2">$${total * 0.1}</p>
            </div>

            <div class="d-flex justify-content-between mb-4">
              <p class="mb-2">Total(Incl. taxes)</p>
              <p class="mb-2">$${total * 1.1}</p>
            </div>

            <button type="button" class="btn btn-info btn-block btn-lg">
              <div class="d-flex justify-content-between">
                <span>$${total * 1.1}</span>
                <span>Checkout <i class="fas fa-long-arrow-alt-right ms-2"></i></span>
              </div>
            </button>

          </div>
        </div>
      </div>

    </div>
  </div>
</section>
