package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User admin = null;

        if (session != null) {
            admin = (User) session.getAttribute("admin"); // session riêng cho admin
        }

        if (admin == null) {
            // Chưa đăng nhập hoặc không phải admin -> redirect login
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        // Nếu là admin, chuyển tới trang home admin
        request.getRequestDispatcher("/admin/admin.jsp").forward(request, response);
    }
}
