package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

import data.dao.OrderDao;
import data.impl.OrderImpl;
import data.dao.ProductDao;
import data.impl.ProductImpl;
import model.Product;
import model.User;

@WebServlet("/order")
public class OrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // Nếu chưa đăng nhập → chuyển login
        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        try {
            // Lấy thông tin khách hàng
            String name = request.getParameter("customerName");
            String phone = request.getParameter("customerPhone");
            String email = request.getParameter("customerEmail");
            String address = request.getParameter("customerAddress");
            String note = request.getParameter("orderNote");

            // Lấy giỏ hàng
            List<Product> cart = (List<Product>) session.getAttribute("cart");
            if (cart == null || cart.isEmpty()) {
                response.sendRedirect("home");
                return;
            }

            ProductDao productDao = new ProductImpl();

            // ⭐ KIỂM TRA SỐ LƯỢNG CÓ VƯỢT QUÁ KHO KHÔNG
            for (Product p : cart) {
                Product realProduct = productDao.findProduct(p.getId());

                // Nếu sản phẩm hết hàng
                if (realProduct.getQuantity() <= 0) {
                    session.setAttribute("error", "Sản phẩm '" + p.getName() + "' đã hết hàng!");
                    response.sendRedirect("cart.jsp");
                    return;
                }

                // Nếu vượt quá số lượng còn lại
                if (p.getQuantity() > realProduct.getQuantity()) {
                    session.setAttribute("error", "Sản phẩm '" + p.getName() 
                        + "' chỉ còn " + realProduct.getQuantity() + " sản phẩm!");
                    response.sendRedirect("cart.jsp");
                    return;
                }
            }

            // ⭐ TÍNH TỔNG TIỀN
            double totalAmount = 0;
            for (Product p : cart) {
                totalAmount += p.getPrice() * p.getQuantity() * 1000;
            }
            double shippingFee = totalAmount * 0.1;
            double finalTotal = totalAmount + shippingFee;

            // ⭐ Lưu đơn hàng
            OrderDao orderDao = new OrderImpl();
            int orderId = orderDao.createOrder(user.getId(), name, phone, email, address, finalTotal, note);

            // ⭐ Lưu chi tiết đơn hàng
            orderDao.saveOrderDetails(orderId, cart);

            // ⭐ TRỪ SỐ LƯỢNG TRONG KHO
            for (Product p : cart) {
                boolean ok = productDao.decreaseQuantity(
    p.getId(),
    p.getQuantity()
);

if (!ok) {
    throw new Exception("Không đủ hàng");
}

            }

            // ⭐ Xóa giỏ hàng
            session.removeAttribute("cart");

            // ⭐ Chuyển đến trang cảm ơn
            request.setAttribute("orderId", orderId);
            request.getRequestDispatcher("/views/order.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
