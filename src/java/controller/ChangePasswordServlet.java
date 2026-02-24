package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import data.dao.UserDao;
import data.impl.UserImpl;
import data.utils.API;         // <-- dùng MD5 ở đây
import model.User;

@WebServlet("/change-password")
public class ChangePasswordServlet extends HttpServlet {

    private UserDao userDao = new UserImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        request.getRequestDispatcher("./views/change-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        String oldPass = request.getParameter("oldPassword");
        String newPass = request.getParameter("newPassword");
        String confirmPass = request.getParameter("confirmPassword");

        String msg = "";
        String msgType = "";

        try {
            // Lấy user từ database (luôn lấy từ DB để đảm bảo dữ liệu mới nhất)
            User dbUser = userDao.getUserById(user.getId());

            if (dbUser == null) {
                msg = "Không tìm thấy tài khoản!";
                msgType = "danger";
            } else {

                // Chuyển mật khẩu cũ nhập vào sang MD5
                String oldPassHash = API.getMd5(oldPass);

                // 1. Kiểm tra mật khẩu cũ
                if (!dbUser.getPassword().equalsIgnoreCase(oldPassHash)) {
                    msg = "Mật khẩu cũ không đúng!";
                    msgType = "danger";
                }
                // 2. Kiểm tra xác nhận mật khẩu mới
                else if (!newPass.equals(confirmPass)) {
                    msg = "Xác nhận mật khẩu mới không khớp!";
                    msgType = "danger";
                }
                // 3. Cập nhật mật khẩu
                else {
                    String newPassHash = API.getMd5(newPass);

                    boolean updated = userDao.updatePassword(user.getId(), newPassHash);

                    if (updated) {
                        // Cập nhật lại vào session
                        user.setPassword(newPassHash);
                        session.setAttribute("user", user);

                        msg = "Đổi mật khẩu thành công!";
                        msgType = "success";
                    } else {
                        msg = "Đổi mật khẩu thất bại!";
                        msgType = "danger";
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            msg = "Lỗi hệ thống!";
            msgType = "danger";
        }

        request.setAttribute("msg", msg);
        request.setAttribute("msgType", msgType);
        request.getRequestDispatcher("/views/change-password.jsp").forward(request, response);
    }
}
