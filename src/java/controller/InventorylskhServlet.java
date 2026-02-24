/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import data.dao.InventoryDao;
import data.impl.InventoryImpl;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.InventoryLog;

/**
 *
 * @author DELL
 */
@WebServlet(name = "InventorylskhServlet", urlPatterns = {"/lskh"})
public class InventorylskhServlet extends HttpServlet {

     InventoryDao inventoryDao = new InventoryImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1️⃣ Lấy toàn bộ lịch sử kho từ database
        List<InventoryLog> logs = inventoryDao.getInventoryLogs();

        // 2️⃣ Đẩy dữ liệu sang JSP
        request.setAttribute("logs", logs);

        // 3️⃣ Chuyển đến JSP hiển thị
        request.getRequestDispatcher("/admin/inventory_logs.jsp").forward(request, response);}
}
