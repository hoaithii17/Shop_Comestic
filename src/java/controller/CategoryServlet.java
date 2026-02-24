package controller;

import model.Category;  // class Category của bạn
import data.utils.API1;       // giả sử API.getAllCategory() trả về List<Category>
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/category")
public class CategoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy tất cả category từ database hoặc API
        List<Category> listCategory = API1.getAllCategory();

        // Gửi listCategory sang category.jsp
        request.setAttribute("listCategory", listCategory);

        // Chuyển hướng tới category.jsp
        request.getRequestDispatcher("/views/category.jsp").forward(request, response);
    }
}
