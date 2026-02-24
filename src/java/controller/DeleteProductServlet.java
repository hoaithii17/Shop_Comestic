package controller;

import data.impl.ProductImpl;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/deleteproduct")
public class DeleteProductServlet extends HttpServlet {
    ProductImpl dao = new ProductImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        dao.deleteProduct(id);
        resp.sendRedirect("products");
    }
}
