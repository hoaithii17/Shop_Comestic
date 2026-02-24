package controller;

import data.dao.CategoryDao;
import data.impl.CategoryIplm;
import model.Category;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

// URL Mapping chuẩn: /admin/categories
@WebServlet("/admin/categories")
public class AdminCategoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String action = req.getParameter("action");
        CategoryDao dao = new CategoryIplm();

        // --- XÓA ---
        if ("delete".equals(action)) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                dao.deleteCategory(id);
            } catch (Exception e) {
                e.printStackTrace();
            }
            // SỬA: Thêm "s" vào cuối đường dẫn
            resp.sendRedirect(req.getContextPath() + "/admin/categories");
            return;
        }

        // --- DANH SÁCH ---
        List<Category> list = dao.findAllCategory();
        req.setAttribute("categories", list);
        
        // Đường dẫn file JSP (Kiểm tra xem file JSP bạn lưu tên là gì: category.jsp hay categories.jsp?)
        // Giả sử bạn lưu là /views/admin/category.jsp
        req.getRequestDispatcher("/admin/categories.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String action = req.getParameter("action");
        CategoryDao dao = new CategoryIplm();

        // --- THÊM ---
        if ("add".equals(action)) {
            String name = req.getParameter("name");
            dao.insertCategory(name);
            // SỬA: Thêm "s"
            resp.sendRedirect(req.getContextPath() + "/admin/categories");
            return;
        }

        // --- SỬA ---
        if ("update".equals(action)) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                String name = req.getParameter("name");
                
                // Lưu ý: Hàm update trong DAO của bạn phải khớp tham số này
                dao.updateCategory(id, name);
                
            } catch (Exception e) {
                e.printStackTrace();
            }
            // SỬA: Thêm "s"
            resp.sendRedirect(req.getContextPath() + "/admin/categories");
        }
    }
}