package data.impl;

import data.dao.ReportDao;
import data.driver.MySQLDriver;
import model.ProfitReport;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ReportImpl implements ReportDao {

    @Override
    public List<ProfitReport> getProfitReport() {

        List<ProfitReport> list = new ArrayList<>();

       String sql = """
    SELECT 
        p.id,
        p.name,
    
        SUM(od.quantity) AS sold,
        SUM(od.quantity * od.price) AS revenue,
    
        ROUND(IFNULL(inv.avg_cost, 0), 0) AS avg_cost,
    
        ROUND(
            SUM(od.quantity * od.price) 
            - (SUM(od.quantity) * IFNULL(inv.avg_cost, 0)),
            0
        ) AS profit
    
    FROM order_details od
    JOIN orders o ON od.order_id = o.id
    JOIN products p ON od.product_id = p.id
    
    LEFT JOIN (
        SELECT 
            product_id,
            SUM(import_price * quantity) / SUM(quantity) AS avg_cost
        FROM inventory_log
        WHERE type = 'IMPORT'
        GROUP BY product_id
    ) inv ON inv.product_id = p.id
    
    WHERE o.status = 3
    GROUP BY p.id, p.name, inv.avg_cost
""";


        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                
                ProfitReport r = new ProfitReport();
r.setProductId(rs.getInt("id"));              // ❗ THIẾU
    r.setProductName(rs.getString("name"));
                int sold = rs.getInt("sold");
double revenue = rs.getDouble("revenue");
double avgCost = rs.getDouble("avg_cost");

double cost = sold * avgCost;
double profit = revenue - cost;

r.setSold(sold);
r.setRevenue(revenue);
r.setAvgCost(avgCost);
r.setCost(cost);
r.setProfit(profit);


                list.add(r);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
