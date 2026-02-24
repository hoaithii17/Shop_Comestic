package controller;

import data.dao.Database;
import data.utils.API;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

@WebServlet(name = "AdminLoginServlet", urlPatterns = {"/admin/login"})
public class AdminLoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Nếu đã login admin rồi, chuyển sang trang admin
        HttpSession session = request.getSession(false);
        if (session != null) {
            User user = (User) session.getAttribute("user");
            if (user != null && "admin".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect(request.getContextPath() + "/adminproductfind");
                return;
            }
        }

        // Chưa login => hiển thị form login admin
        request.setAttribute("title", "Admin Login");
        request.getRequestDispatcher("/admin/login.jsp").forward(request, response);
    }

    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    String emailphone = request.getParameter("emailphone");
    String password = request.getParameter("password");

    User user = Database.getUserDao().findUser(emailphone, API.getMd5(password));

    if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
        request.getSession().setAttribute("error_login", "Email hoặc mật khẩu không đúng hoặc không phải admin!");
        response.sendRedirect(request.getContextPath() + "/admin/login");
    } else {
        // Lưu admin riêng vào session "admin"
        HttpSession session = request.getSession();
        session.setAttribute("admin", user);
        session.removeAttribute("error_login");

        response.sendRedirect(request.getContextPath() + "/adminproductfind");
    }
}


    @Override
    public String getServletInfo() {
        return "Servlet xử lý login cho Admin";
    }
}
