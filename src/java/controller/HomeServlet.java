/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import data.dao.Database;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import model.Category;
import model.Product;

/**
 *
 * @author DELL
 */
@WebServlet(name = "HomeServlet", urlPatterns = {"/home"})
public class HomeServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet HomeServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet HomeServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        
        // --- LOGIC MỚI: Xử lý Thêm vào giỏ hàng từ GET request (Link) ---
        String productIdParam = request.getParameter("id_product");
        String categoryIdParam = request.getParameter("id_category");
        
        if (productIdParam != null && !productIdParam.isEmpty()) {
            // Xử lý logic thêm sản phẩm vào giỏ hàng
            addProductToCart(request);
            
            // Xử lý URL sau khi Redirect
            String redirectUrl = request.getContextPath() + "/home";
            if (categoryIdParam != null && !categoryIdParam.isEmpty()) {
                 // Nếu có id_category, chuyển hướng về trang danh mục đó
                redirectUrl += "?id_category=" + categoryIdParam;
            }
            
            // Redirect để ngăn lỗi thêm sản phẩm lặp lại khi người dùng Refresh trang
            response.sendRedirect(redirectUrl);
            return; // Dừng xử lý doGet
        }
        // ------------------------------------------------------------------
        
        // --- LOGIC CŨ: Load dữ liệu và hiển thị trang ---
        List<Category> listCategory = Database.getCategoryDao().findAllCategory();
        request.setAttribute("listCategory", listCategory);

        List<Product> listProduct = Database.getProductDao().findAllProduct();
        request.setAttribute("listProduct", listProduct);
        
        // Đặt id_category lại để hiển thị filter nếu có
        if (categoryIdParam != null) {
            request.setAttribute("id_category", categoryIdParam);
        }
        
        request.setAttribute("title", "Home page");
        request.getRequestDispatcher("./views/home.jsp").include(request, response);
    }


    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Category> listcagory= Database.getCategoryDao().findAllCategory();
        request.setAttribute("listCategory", listcagory);
        List<Product> listProduct= Database.getProductDao().findAllProduct();
        request.setAttribute("listProduct", listProduct);
        String id_category=(String)request.getParameter("id_category");
        request.setAttribute("id_category", id_category);
        
        // Giữ lại logic thêm giỏ hàng ở đây nếu có form POST được sử dụng
        addProductToCart(request); 
        
        request.setAttribute("title", "Home Page");
        // Đường dẫn đã được xác nhận là "./views/home.jsp"
        request.getRequestDispatcher("./views/home.jsp").include(request, response);
    }
    
    void addProductToCart(HttpServletRequest request){
        int id_product;
        try{
            // Đảm bảo "id_product" được gửi đúng từ form/button
            id_product= Integer.parseInt(request.getParameter("id_product"));
        } catch(Exception e){
            // Nếu không thể parse, id_product = 0, và không làm gì cả
            id_product=0;
        }
        List<Product> cart= (List<Product>)request.getSession().getAttribute("cart");
        if(cart==null) cart= new ArrayList<>();
        
        if(id_product>0){
            Product product= Database.getProductDao().findProduct(id_product);
            boolean isProductInCart=false;
            for(Product pro: cart)
                if(pro.getId()==id_product){
                    // LOGIC TĂNG SỐ LƯỢNG: ĐÃ ĐÚNG
                    pro.setQuantity(pro.getQuantity()+1);
                    isProductInCart=true;
                    // Tối ưu: Dừng vòng lặp ngay khi tìm thấy và tăng số lượng
                    break;
                }
            if(!isProductInCart){
                // Thêm sản phẩm mới với quantity = 1
                // Cần đảm bảo rằng product object được lấy từ findProduct() là bản sao mới, 
                // không phải singleton, để quantity không bị chia sẻ giữa các users.
                if (product != null) {
                    product.setQuantity(1);    
                    cart.add(product);
                }
            }
        }
        // Lưu danh sách giỏ hàng đã được cập nhật trở lại Session
        request.getSession().setAttribute("cart", cart);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}