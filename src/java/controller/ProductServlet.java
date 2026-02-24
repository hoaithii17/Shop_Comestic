package controller;

import data.dao.Database;
import data.dao.ProductDao;
import data.impl.ProductImpl;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;

import model.Category;
import model.Product;

@WebServlet("/product")
public class ProductServlet extends HttpServlet {

    ProductDao productDao = new ProductImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idProductParam = request.getParameter("id_product");

        /* ===================================================
           1. NẾU ĐANG THÊM GIỎ HÀNG
        =================================================== */
        if (idProductParam != null) {

            // Kiểm tra đăng nhập
            Object user = request.getSession().getAttribute("user");
            if (user == null) {
                response.sendRedirect("login");
                return;
            }

            // Thêm giỏ hàng
            addProductToCart(request);

            // Lấy lại id_category nếu đang đứng trong category
            String idCate = request.getParameter("id_category");

            // Load danh mục
            List<Category> listCategory = Database.getCategoryDao().findAllCategory();
            request.setAttribute("listCategory", listCategory);

            // Load sản phẩm theo category hoặc tất cả
            List<Product> listProduct;

            if (idCate != null && !idCate.isEmpty()) {
                int cateId = Integer.parseInt(idCate);

                listProduct = productDao.findAllProduct()
                        .stream()
                        .filter(p -> p.getId_category() == cateId)
                        .collect(Collectors.toList());
            } else {
                listProduct = productDao.findAllProduct();
            }

            request.setAttribute("listProduct", listProduct);
            request.setAttribute("title", "Product page");

            // ⚠ Dùng forward để giữ param id_category
            request.getRequestDispatcher("/views/product.jsp").forward(request, response);
            return;
        }

        /* ===================================================
           2. HIỂN THỊ SẢN PHẨM HOẶC LỌC THEO DANH MỤC
        =================================================== */
        String idCate = request.getParameter("id_category");

        List<Product> allProducts = productDao.findAllProduct();
        List<Product> list = allProducts;

        // Nếu có lọc category
        if (idCate != null && !idCate.isEmpty()) {
            int cateId = Integer.parseInt(idCate);

            list = allProducts.stream()
                    .filter(p -> p.getId_category() == cateId)
                    .collect(Collectors.toList());
        }

        request.setAttribute("listProduct", list);

        // Luôn gửi danh mục cho sidebar/menu
        List<Category> listCategory = Database.getCategoryDao().findAllCategory();
        request.setAttribute("listCategory", listCategory);

        request.setAttribute("title", "Product page");

        request.getRequestDispatcher("/views/product.jsp").forward(request, response);
    }

    /* ===================================================
       HÀM THÊM GIỎ HÀNG
    =================================================== */
  void addProductToCart(HttpServletRequest request) {

    int id_product;
    try {
        id_product = Integer.parseInt(request.getParameter("id_product"));
    } catch (Exception e) {
        id_product = 0;
    }

    HttpSession session = request.getSession();

    // Giỏ hàng
    List<Product> cart = (List<Product>) session.getAttribute("cart");
    if (cart == null) cart = new ArrayList<>();

    if (id_product > 0) {

        Product product = Database.getProductDao().findProduct(id_product);

        if (product != null) {

            // ⭐ 1) Kiểm tra hết hàng
            if (product.getQuantity() <= 0) {
                session.setAttribute("error", "Sản phẩm '" + product.getName() + "' đã hết hàng!");
                return;
            }

            boolean exists = false;

            // ⭐ 2) Kiểm tra sản phẩm đã có trong giỏ
            for (Product p : cart) {
                if (p.getId() == id_product) {

                    // Nếu tăng thêm 1 vượt quá kho → CẤM
                    if (p.getQuantity() + 1 > product.getQuantity()) {
                        session.setAttribute("error", "Sản phẩm '" + p.getName() + 
                            "' chỉ còn " + product.getQuantity() + " sản phẩm!");
                        return;
                    }

                    // Nếu hợp lệ → tăng
                    p.setQuantity(p.getQuantity() + 1);
                    p.setTotalPrice(p.getPrice() * p.getQuantity());

                    exists = true;
                    break;
                }
            }

            // ⭐ 3) Nếu sản phẩm chưa có trong giỏ → thêm mới
            if (!exists) {
                // Nếu kho đang = 0 → không cho thêm
                if (product.getQuantity() <= 0) {
                    session.setAttribute("error", "Sản phẩm '" + product.getName() + "' đã hết hàng!");
                    return;
                }

                product.setQuantity(1);
                product.setTotalPrice(product.getPrice());
                cart.add(product);
            }
        }
    }

    // Cập nhật lại session
    session.setAttribute("cart", cart);
}
}