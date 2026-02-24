/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package data.impl;


import data.dao.InventoryDao;
import data.driver.MySQLDriver;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.InventoryLog;


/**
 *
 * @author DELL
 */
public class InventoryImpl implements InventoryDao {

 
public void importStock(int productId, int quantity, double importPrice, String note) {

    String updateProduct =
        "UPDATE products SET quantity = quantity + ? WHERE id = ?";

    String logSql =
        "INSERT INTO inventory_log(product_id, type, quantity, import_price, note) " +
        "VALUES (?, 'IMPORT', ?, ?, ?)";

    try (Connection con = MySQLDriver.getConnection()) {
        con.setAutoCommit(false);

        PreparedStatement ps1 = con.prepareStatement(updateProduct);
        ps1.setInt(1, quantity);
        ps1.setInt(2, productId);
        ps1.executeUpdate();

        PreparedStatement ps2 = con.prepareStatement(logSql);
        ps2.setInt(1, productId);
        ps2.setInt(2, quantity);
        ps2.setDouble(3, importPrice);
        ps2.setString(4, note);
        ps2.executeUpdate();

        con.commit();
    } catch (Exception e) {
        e.printStackTrace();
    }
}


    @Override
    public void exportStock(int productId, int quantity, String note) {
        String updateProduct =
            "UPDATE products SET quantity = quantity - ? WHERE id = ? AND quantity >= ?";
        String logSql =
            "INSERT INTO inventory_log(product_id, type, quantity, note) VALUES (?, 'EXPORT', ?, ?)";

        try (Connection con = MySQLDriver.getConnection()) {
            con.setAutoCommit(false);

            PreparedStatement ps1 = con.prepareStatement(updateProduct);
            ps1.setInt(1, quantity);
            ps1.setInt(2, productId);
            ps1.setInt(3, quantity);

            if (ps1.executeUpdate() == 0) {
                throw new RuntimeException("Không đủ hàng trong kho");
            }

            PreparedStatement ps2 = con.prepareStatement(logSql);
            ps2.setInt(1, productId);
            ps2.setInt(2, quantity);
            ps2.setString(3, note);
            ps2.executeUpdate();

            con.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void adjustStock(int productId, int newQuantity, String note) {
        String getQty = "SELECT quantity FROM products WHERE id = ?";
        String updateProduct = "UPDATE products SET quantity = ? WHERE id = ?";
        String logSql = "INSERT INTO inventory_log(product_id, type, quantity, note) VALUES (?, 'ADJUST', ?, ?)";

        try (Connection con = MySQLDriver.getConnection()) {
            con.setAutoCommit(false);

            PreparedStatement psGet = con.prepareStatement(getQty);
            psGet.setInt(1, productId);
            ResultSet rs = psGet.executeQuery();
            if (!rs.next()) throw new RuntimeException("Không tìm thấy sản phẩm");

            int oldQty = rs.getInt("quantity");
            int diff = newQuantity - oldQty;

            PreparedStatement psUpdate = con.prepareStatement(updateProduct);
            psUpdate.setInt(1, newQuantity);
            psUpdate.setInt(2, productId);
            psUpdate.executeUpdate();

            PreparedStatement psLog = con.prepareStatement(logSql);
            psLog.setInt(1, productId);
            psLog.setInt(2, diff);
            psLog.setString(3, note);
            psLog.executeUpdate();

            con.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
     // 📜 Lịch sử kho
    @Override
    public List<InventoryLog> getInventoryLogs() {
        List<InventoryLog> list = new ArrayList<>();
        String sql = "SELECT * FROM inventory_log ORDER BY created_at DESC";

        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                InventoryLog log = new InventoryLog();
                log.setId(rs.getInt("id"));
                log.setProductId(rs.getInt("product_id"));
                log.setType(rs.getString("type"));
                log.setQuantity(rs.getInt("quantity"));
                log.setImportPrice(rs.getDouble("import_price"));
                log.setNote(rs.getString("note"));
                log.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(log);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 💰 Giá vốn trung bình
    @Override
    public double getAverageCost(int productId) {
        String sql =
            "SELECT SUM(import_price * quantity) / SUM(quantity) "
          + "FROM inventory_log WHERE product_id=? AND type='IMPORT'";

        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    
}