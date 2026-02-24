package model;

import java.sql.ResultSet;
import java.sql.SQLException;

public class OrderItem {

    private int id;
    private int orderId;
    private int productId;
    private String productName; // Join lấy tên sản phẩm
    private double price;
    private int quantity;
    private double totalPrice;

    public OrderItem() {
    }

    // Constructor đọc từ ResultSet (để dùng trong new OrderItem(rs))
    public OrderItem(ResultSet rs) throws SQLException {
        this.id = rs.getInt("id");
        this.orderId = rs.getInt("order_id");
        this.productId = rs.getInt("product_id");

        // Các cột tùy bảng
        try { this.productName = rs.getString("product_name"); } catch (Exception e) {}
        try { this.price = rs.getDouble("price"); } catch (Exception e) {}
        try { this.quantity = rs.getInt("quantity"); } catch (Exception e) {}
        this.totalPrice = this.price * this.quantity;
    }

    // Getter & Setter
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public double getTotalPrice() { return totalPrice; }
    public void setTotalPrice(double totalPrice) { this.totalPrice = totalPrice; }
}
