package model;

import java.sql.ResultSet;
import java.sql.SQLException;

public class Product {
    int id, id_category, quantity;
    String image, name;
    double price;
    int status;
private int cartQuantity;

private double totalPrice;

    public int getCartQuantity() {
        return cartQuantity;
    }

    public void setCartQuantity(int cartQuantity) {
        this.cartQuantity = cartQuantity;
    }
    public double getTotalPrice() { return totalPrice; }
public void setTotalPrice(double totalPrice) { this.totalPrice = totalPrice; }
    public Product() {}

    public Product(int id, int id_category, int quantity, String image, String name, double price, int status) {
        this.id = id;
        this.id_category = id_category;
        this.quantity = quantity;
        this.image = image;
        this.name = name;
        this.price = price;
        this.status = status;
    }

    // Constructor từ ResultSet (CHUẨN)
    public Product(ResultSet rs) throws SQLException {
        this.id = rs.getInt("id");
        this.id_category = rs.getInt("id_category");
        this.quantity = rs.getInt("quantity");   // ✔ LẤY ĐÚNG TỒN KHO TRONG DB
        this.image = rs.getString("image");
        this.name = rs.getString("name");
        this.price = rs.getDouble("price");
        this.status = rs.getInt("status");
    }

    // GETTER
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

    public int isStatus() {
        return status;
    }

    public int getStatus() {
        return status;
    }

    // SETTER
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

    public void setStatus(int status) {
        this.status = status;
    }
    private int sold;

public int getSold() {
    return sold;
}

public void setSold(int sold) {
    this.sold = sold;
}

}
