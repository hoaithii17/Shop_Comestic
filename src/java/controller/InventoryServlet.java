package controller;

import data.dao.InventoryDao;
import data.dao.ProductDao;
import data.impl.InventoryImpl;
import data.impl.ProductImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/admin/inventory")
public class InventoryServlet extends HttpServlet {

    private InventoryDao inventoryDao = new InventoryImpl();
    private ProductDao productDao = new ProductImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // 🔒 CHECK ADMIN
        HttpSession session = req.getSession();
        if (session.getAttribute("admin") == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/login");
            return;
        }

        req.setAttribute("products", productDao.findAllProduct());
        req.getRequestDispatcher("/admin/inventory.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        // 🔒 CHECK ADMIN
        HttpSession session = req.getSession();
        if (session.getAttribute("admin") == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/login");
            return;
        }

        try {
            int productId = Integer.parseInt(req.getParameter("productId"));
            String type = req.getParameter("type");
            String note = req.getParameter("note");

            switch (type) {

                case "IMPORT": {
    int quantity = Integer.parseInt(req.getParameter("quantity"));
    double importPrice = Double.parseDouble(req.getParameter("importPrice"));

    if (quantity <= 0) throw new IllegalArgumentException("Số lượng nhập không hợp lệ");
    if (importPrice <= 0) throw new IllegalArgumentException("Giá nhập không hợp lệ");

    inventoryDao.importStock(productId, quantity, importPrice, note);
    break;
}


                case "EXPORT": {
                    int quantity = Integer.parseInt(req.getParameter("quantity"));
                    if (quantity <= 0) throw new IllegalArgumentException("Số lượng xuất không hợp lệ");
                    inventoryDao.exportStock(productId, quantity, note);
                    break;
                }

                case "ADJUST": {
                    int newQuantity = Integer.parseInt(req.getParameter("newQuantity"));
                    if (newQuantity < 0) throw new IllegalArgumentException("Tồn kho không được âm");
                    inventoryDao.adjustStock(productId, newQuantity, note);
                    break;
                }
            }

            session.setAttribute("success", "Cập nhật kho thành công");

        } catch (Exception e) {
            e.printStackTrace();
            req.getSession().setAttribute("error", e.getMessage());
        }

        resp.sendRedirect(req.getContextPath() + "/admin/inventory");
    }
}
