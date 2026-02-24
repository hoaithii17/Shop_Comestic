package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import model.User;
import data.dao.UserDao;
import data.impl.UserImpl;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    private UserDao userDao = new UserImpl(); // DAO để thao tác DB

    // Hiển thị trang hồ sơ
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login"); // Chưa đăng nhập -> về login
            return;
        }

        request.setAttribute("user", user); // gửi user sang JSP
        request.getRequestDispatcher("/views/profile.jsp").forward(request, response);
    }

    // Xử lý cập nhật thông tin khi bấm "Lưu thay đổi"
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        // Lấy thông tin từ form
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password"); // optional

        // Cập nhật thông tin user
        user.setName(fullname);
        user.setEmail(email);
        user.setPhone(phone);
        if (password != null && !password.isEmpty()) {
            user.setPassword(password); // chỉ cập nhật nếu user nhập password mới
        }

        // Gọi DAO để update DB
        boolean updateSuccess = userDao.updateUser(user);

        if (updateSuccess) {
            session.setAttribute("user", user); // cập nhật session
            request.setAttribute("message", "Cập nhật thành công!");
        } else {
            request.setAttribute("error", "Cập nhật thất bại. Vui lòng thử lại.");
        }

        request.setAttribute("user", user);
        request.getRequestDispatcher("/views/profile.jsp").forward(request, response);
    }
}
