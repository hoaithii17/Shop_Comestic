/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.List;
import model.Product;

/**
 *
 * @author DELL
 */
public class CartServlet extends HttpServlet {

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
            out.println("<title>Servlet CartServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CartServlet at " + request.getContextPath() + "</h1>");
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
        if(request.getParameter("clear")!=null)request.getSession().setAttribute("cart", new ArrayList<>());
        request.setAttribute("title", "Cart Detail");
       request.getRequestDispatcher("./views/cart.jsp").include(request, response);
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        updateDelete(request, response);
    }
    void updateDelete(HttpServletRequest request, HttpServletResponse response) throws IOException{
        String action= request.getParameter("action");
        int id_product= Integer.parseInt(request.getParameter("id_product"));
        switch(action){
        case "update":
        doUpdate(request, id_product);break;
        case "delete":
        doDelete(request, id_product);break;
        
    }
        response.sendRedirect("cart");
    }
   void doDelete(HttpServletRequest request, int id_product) {
    // Lấy giỏ hàng từ session
    List<Product> cart = (List<Product>) request.getSession().getAttribute("cart");

    // Lấy số lượng mới từ form
   
    // Cập nhật số lượng cho sản phẩm trong giỏ
    for (Product pro : cart) {
        if (pro.getId() == id_product) {
            cart.remove(pro);
            break;
        }
    }

    // Lưu lại giỏ hàng vào session
    request.getSession().setAttribute("cart", cart);}
     void doUpdate(HttpServletRequest request, int id_product) {
    // Lấy giỏ hàng từ session
    List<Product> cart = (List<Product>) request.getSession().getAttribute("cart");

    // Lấy số lượng mới từ form
    int quantity = Integer.parseInt(request.getParameter("quantity"));

    // Cập nhật số lượng cho sản phẩm trong giỏ
    for (Product pro : cart) {
        if (pro.getId() == id_product && quantity > 0) {
            pro.setQuantity(quantity);
            break;
        }
    }

    // Lưu lại giỏ hàng vào session
    request.getSession().setAttribute("cart", cart);
}

            

}
