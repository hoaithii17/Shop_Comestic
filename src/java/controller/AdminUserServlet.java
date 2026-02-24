package controller;

import data.dao.UserDao;
import data.impl.UserImpl;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet({"/admin/users", "/admin/user"})
public class AdminUserServlet extends HttpServlet {

    private final UserDao userDao = new UserImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null || action.isEmpty()) action = "list";

        switch (action) {
            case "create":
                // show create form
                req.setAttribute("user", null);
                req.getRequestDispatcher("/admin/user.jsp").forward(req, resp);
                break;

            case "edit":
                int idEdit = Integer.parseInt(req.getParameter("id"));
                User uEdit = userDao.findById(idEdit);
                req.setAttribute("user", uEdit);
                req.getRequestDispatcher("/admin/user.jsp").forward(req, resp);
                break;

            case "delete":
                int idDel = Integer.parseInt(req.getParameter("id"));
                userDao.deleteUser(idDel);
                resp.sendRedirect(req.getContextPath() + "/admin/users");
                break;

            case "list":
            default:
                List<User> list = userDao.findAllUsers();
                req.setAttribute("list", list);
                req.getRequestDispatcher("/admin/users.jsp").forward(req, resp);
                break;
        }
    }

    // handle create / update form submit (POST)
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // ensure UTF-8 for form
        req.setCharacterEncoding("UTF-8");

        String idStr = req.getParameter("id"); // will be null for create
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String password = req.getParameter("password");
        String role = req.getParameter("role");
        if (role == null || role.isEmpty()) role = "user";

        if (idStr == null || idStr.isEmpty()) {
            // create
            User u = new User(0, name, email, phone, password, role);
            userDao.insertUser(u);
        } else {
            // update
            int id = Integer.parseInt(idStr);
            User u = new User(id, name, email, phone, password, role);
            userDao.updateUser(u);
        }

        resp.sendRedirect(req.getContextPath() + "/admin/users");
    }
}
