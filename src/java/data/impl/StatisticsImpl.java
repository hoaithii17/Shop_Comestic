package data.impl;

import data.dao.StatisticsDao;
import data.driver.MySQLDriver;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class StatisticsImpl implements StatisticsDao {

    @Override
    public int getTotalOrders() {
        String sql = "SELECT COUNT(*) FROM orders";
        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) return rs.getInt(1);

        } catch (Exception e) { 
            e.printStackTrace(); 
        }
        return 0;
    }

    @Override
    public int getCompletedOrders() {
        // status = 3 → Đã giao hàng thành công
        String sql = "SELECT COUNT(*) FROM orders WHERE status = 3";

        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) return rs.getInt(1);

        } catch (Exception e) { 
            e.printStackTrace(); 
        }
        return 0;
    }

  @Override
public double getRevenue() {
    String sql = """
        SELECT COALESCE(SUM(od.quantity * od.price), 0)
        FROM order_details od
        JOIN orders o ON od.order_id = o.id
        WHERE o.status = 3
    """;

    try (Connection con = MySQLDriver.getConnection();
         PreparedStatement ps = con.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {

        if (rs.next()) return rs.getDouble(1);

    } catch (Exception e) {
        e.printStackTrace();
    }
    return 0;
}
 @Override
    public double getRevenueByDay(String day) {
        String sql = "SELECT SUM(od.quantity * od.price) " +
                     "FROM order_details od JOIN orders o ON od.order_id = o.id " +
                     "WHERE DATE(o.order_date) = ?";
        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, day);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getDouble(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    @Override
    public double getRevenueByMonth(String month) {
        String sql = "SELECT SUM(od.quantity * od.price) " +
                     "FROM order_details od JOIN orders o ON od.order_id = o.id " +
                     "WHERE DATE_FORMAT(o.order_date, '%Y-%m') = ?";
        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, month);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getDouble(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    @Override
    public double getRevenueByYear(String year) {
        String sql = "SELECT SUM(od.quantity * od.price) " +
                     "FROM order_details od JOIN orders o ON od.order_id = o.id " +
                     "WHERE YEAR(o.order_date) = ?";
        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, year);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getDouble(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    @Override
    public int getOrdersByStatus(int status) {
        String sql = "SELECT COUNT(*) FROM orders WHERE status=?";
        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, status);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }
    public double[] getMonthlyRevenue(int year) {
    double[] revenue = new double[12];
    String sql = "SELECT MONTH(order_date) as month, SUM(od.quantity*od.price) as total " +
                 "FROM orders o JOIN order_details od ON o.id = od.order_id " +
                 "WHERE YEAR(o.order_date) = ? " +
                 "GROUP BY MONTH(order_date)";
    try (Connection con = MySQLDriver.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {
        ps.setInt(1, year);
        ResultSet rs = ps.executeQuery();
        while(rs.next()) {
            int month = rs.getInt("month");
            double total = rs.getDouble("total");
            revenue[month - 1] = total; // month từ 1->12, mảng 0->11
        }
    } catch (Exception e) { e.printStackTrace(); }
    return revenue;
}

}
