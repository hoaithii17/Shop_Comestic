/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import data.dao.Database;
import data.utils.API;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;

/**
 *
 * @author DELL
 */
@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

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
            out.println("<title>Servlet RegisterServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RegisterServlet at " + request.getContextPath() + "</h1>");
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
       request.setAttribute("title", "Register Page");
       request.getRequestDispatcher("./views/register.jsp").include(request, response);
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
        String err_email="", err_phone="", err_repassword="";
        String name= request.getParameter("name");
        String email= request.getParameter("email");
        String phone= request.getParameter("phone");
        String password= request.getParameter("password");
        String repassword= request.getParameter("repassword");
        String Email_Regex = "^[\\w-\\+]+(\\.[\\w]+)*@[\\w-]+(\\.[\\w]+)*(\\.[a-z]{2,})$";
        String Phone_Regex="^\\d{10}$";
        boolean err=false;
        if(!email.matches(Email_Regex)){
            request.getSession().setAttribute("err_email","Eamail is incorrect!");
            err= true;
            
        }
        else{
            request.getSession().removeAttribute("err_email");
        }
        if(!phone.matches(Phone_Regex)){
            request.getSession().setAttribute("err_phone","Phone is incorrect!");
            err= true;
            
        }
        else{
            request.getSession().removeAttribute("err_phone");
        }
        if(!password.equals(repassword)){
    request.getSession().setAttribute("err_repassword","Repassword is incorrect!");
    err = true;
} else {
    request.getSession().removeAttribute("err_repassword");
}

        if(err){
            response.sendRedirect("register");
        } else{
            if(Database.getUserDao().findUser(email)!=null
                    ||Database.getUserDao().findUser(phone)!=null){
                request.getSession().setAttribute("user_exist", "User has existed ");
                response.sendRedirect("register");
            }
            else{
                Database.getUserDao().insertUser(name, email, phone, API.getMd5(password));
                User user= Database.getUserDao().findUser(email);
                request.getSession().setAttribute("user", user);
                request.getSession().removeAttribute("user_exist");
                response.sendRedirect("home");
            }
        }
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
