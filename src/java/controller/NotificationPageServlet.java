package controller;

import data.dao.OrderDao;
import data.impl.OrderImpl;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;
import model.Order;

@WebServlet("/notifications")
public class NotificationPageServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        OrderDao dao = new OrderImpl();

        int lastReadId = dao.getLastReadOrderId();
        List<Order> list = dao.getNewOrdersSince(lastReadId);

        // Đánh dấu đã đọc
        if (!list.isEmpty()) {
            dao.updateLastReadOrder(list.get(0).getId());
        }

        request.setAttribute("orders", list);

        request.getRequestDispatcher("/admin/notification.jsp")
               .forward(request, response);
    }
}
