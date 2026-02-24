package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import data.dao.OrderDao;
import data.impl.OrderImpl;
import model.Order;
import model.User;

@WebServlet("/myorder")
public class MyOrderServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        OrderDao orderDao = new OrderImpl();
        List<Order> listOrders = orderDao.getOrdersByUserId(user.getId());

        request.setAttribute("orders", listOrders);
        request.getRequestDispatcher("/views/myorder.jsp").forward(request, response);
    }
}
