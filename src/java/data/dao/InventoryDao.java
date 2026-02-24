/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package data.dao;

import java.util.List;
import model.InventoryLog;

public interface InventoryDao {

    // Nhập kho (có giá nhập)
    void importStock(int productId, int quantity, double importPrice, String note);

    // Xuất kho (bán hàng, hỏng, trả NCC...)
    void exportStock(int productId, int quantity, String note);

    // Điều chỉnh tồn kho (kiểm kê)
    void adjustStock(int productId, int newQuantity, String note);

    // Lịch sử nhập / xuất kho
    List<InventoryLog> getInventoryLogs();

    // Giá vốn trung bình
    double getAverageCost(int productId);
}
