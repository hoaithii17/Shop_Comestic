package controller;

import data.dao.ProductDao;
import data.impl.ProductImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import model.Product;

@WebServlet("/admin/editProduct")
public class EditProductServlet extends HttpServlet {

    private final ProductDao productDao = new ProductImpl();

    // HIỂN THỊ FORM
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        Product product = productDao.findProduct(id);

        if (product == null) {
            response.sendRedirect(request.getContextPath() + "/adminproductfind");
            return;
        }

        request.setAttribute("product", product);
        request.getRequestDispatcher("/admin/editProduct.jsp").forward(request, response);
    }

    // XỬ LÝ CẬP NHẬT
   @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    request.setCharacterEncoding("UTF-8");

    int id = Integer.parseInt(request.getParameter("id"));
    String name = request.getParameter("name");
    String image = request.getParameter("image");
    double price = Double.parseDouble(request.getParameter("price"));
    int category = Integer.parseInt(request.getParameter("category"));
    int status = Integer.parseInt(request.getParameter("status")); // ✅ FIX

    // DEBUG (rất nên giữ lúc test)
    System.out.println("UPDATE ID = " + id);
    System.out.println("STATUS = " + status);

    productDao.updateProduct(id, name, image, price, category, status);

    response.sendRedirect(request.getContextPath() + "/adminproductfind");
}


}
