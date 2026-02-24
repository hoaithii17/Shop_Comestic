package controller;

import data.dao.OrderDao;
import data.impl.OrderImpl;
import model.Order;
import model.OrderItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet({"/admin/orders", "/admin/order"})
public class AdminOrderServlet extends HttpServlet {

    private final OrderDao orderDao = new OrderImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "view":
                int id = Integer.parseInt(req.getParameter("id"));
                Order order = orderDao.findById(id);
                List<OrderItem> items = orderDao.findItems(id);

                req.setAttribute("order", order);
                req.setAttribute("items", items);
                req.getRequestDispatcher("/admin/order-detail.jsp").forward(req, resp);
                break;

            case "delete":
                int idDel = Integer.parseInt(req.getParameter("id"));
                orderDao.deleteOrder(idDel);
                resp.sendRedirect(req.getContextPath() + "/admin/orders");
                break;

            default:
                List<Order> list = orderDao.findAll();
                req.setAttribute("list", list);
                req.getRequestDispatcher("/admin/orders.jsp").forward(req, resp);
        }
    }

    // update trạng thái
   @Override

protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");

    String action = request.getParameter("action");

    if ("updateStatus".equals(action)) {

        String orderIdRaw = request.getParameter("orderId");
        String statusRaw = request.getParameter("status");

        // Debug để biết có null hay không
        System.out.println("orderId = " + orderIdRaw);
        System.out.println("status = " + statusRaw);

        if (orderIdRaw == null || statusRaw == null) {
            System.out.println("⚠ LỖI: orderId hoặc status bị null");
            response.sendRedirect("orders");
            return;
        }

        int orderId = Integer.parseInt(orderIdRaw);
        int status = Integer.parseInt(statusRaw);

        orderDao.updateStatus(orderId, status);

        response.sendRedirect("orders");
        return;
    }
}

}
