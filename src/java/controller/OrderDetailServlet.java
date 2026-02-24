package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

import data.dao.OrderDao;
import data.impl.OrderImpl;
import model.Order;
import model.Product;
import model.User;

@WebServlet("/order-detail")
public class OrderDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // Chưa đăng nhập → về login
        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        try {
            String orderIdParam = request.getParameter("id");
            if (orderIdParam == null) {
                response.sendRedirect("myorder");
                return;
            }

            int orderId = Integer.parseInt(orderIdParam);

            OrderDao orderDao = new OrderImpl();

            // Lấy đơn hàng → chỉ đơn của chính user
            Order order = orderDao.getOrderById(orderId, user.getId());
            if (order == null) {
                response.sendRedirect("myorder");
                return;
            }

            // Lấy danh sách Product trong order (đã gồm name, price, quantity)
            List<Product> items = orderDao.getOrderDetails(orderId);

            // Gửi qua JSP
            request.setAttribute("order", order);
            request.setAttribute("items", items);

            request.getRequestDispatcher("/views/order-detail.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.getRequestDispatcher("./views/error.jsp").forward(request, response);
        }
    }
}
