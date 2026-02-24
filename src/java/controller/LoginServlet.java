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

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Nếu đã đăng nhập rồi, redirect theo role
        HttpSession session = request.getSession(false);
        if (session != null) {
            User sessionUser = (User) session.getAttribute("user");
            if (sessionUser != null) {
                if ("admin".equalsIgnoreCase(sessionUser.getRole())) {
                    // Chặn admin từ form user
                    session.setAttribute("error_login", "Admin không được đăng nhập từ đây!");
                    response.sendRedirect(request.getContextPath() + "/admin/login"); // form admin login
                    return;
                } else {
                    response.sendRedirect(request.getContextPath() + "/home"); // user bình thường
                    return;
                }
            }
        }

        // Chưa đăng nhập => hiển thị trang login user
        request.setAttribute("title", "Login Page");
        request.getRequestDispatcher("/views/login.jsp").forward(request, response);
    }

    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    String emailphone = request.getParameter("emailphone");
    String password = request.getParameter("password");

    User user = Database.getUserDao().findUser(emailphone, API.getMd5(password));

    if (user == null) {
        request.getSession().setAttribute("error_login", "Email hoặc mật khẩu không chính xác!");
        response.sendRedirect(request.getContextPath() + "/login");
    } else {
        // Chặn admin đăng nhập từ form user
        if ("admin".equalsIgnoreCase(user.getRole())) {
            request.getSession().setAttribute("error_login", "Admin không được đăng nhập từ đây!");
            response.sendRedirect(request.getContextPath() + "/admin/login");
        } else {
            // Lưu user bình thường vào session "user"
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.removeAttribute("error_login");

            response.sendRedirect(request.getContextPath() + "/home");
        }
    }
}


    @Override
    public String getServletInfo() {
        return "Login Servlet cho user bình thường, chặn admin đăng nhập từ đây";
    }
}
