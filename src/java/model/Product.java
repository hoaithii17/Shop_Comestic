/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.sql.ResultSet;
import java.sql.SQLException;
/**
 *
 * @author DELL
 */
public class Product {
    int id, id_category, quantity;
    String image, name;
    double price;
    boolean status;

    // Constructor rỗng (thường dùng)
    public Product() {} 
    
    // Constructor 1 (Full)
    public Product(int id, int id_category, int quantity, String image, String name, double price, boolean status) {
        this.id = id;
        this.id_category = id_category;
        this.quantity = quantity;
        this.image = image;
        this.name = name;
        this.price = price;
        this.status = status;
    }
    
    // Constructor 2 (Từ ResultSet) - Đã thêm các trường còn thiếu
    public Product(ResultSet rs) throws SQLException {
        this.id = rs.getInt("id");
        this.id_category = rs.getInt("id_category"); // Đảm bảo lấy id_category
        this.quantity = 1; // Khởi tạo ban đầu khi lấy từ DB
        this.image = rs.getString("image");
        this.name = rs.getString("name");
        this.price = rs.getDouble("price");
        this.status = rs.getBoolean("status"); // Đảm bảo lấy status
    }

    public int getId() {
        return id;
    }

    public int getId_category() {
        return id_category;
    }

    public int getQuantity() {
        return quantity;
    }

    public String getImage() {
        return image;
    }

    public String getName() {
        return name;
    }

    public double getPrice() {
        return price;
    }

    public boolean isStatus() {
        return status;
    }
    
    // Thêm getter cho boolean theo convention (dù isStatus() đã có)
    public boolean getStatus() {
        return status;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setId_category(int id_category) {
        this.id_category = id_category;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }
    
    
}