/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package data.impl;

import data.dao.Database;
import data.dao.ProductDao;
import data.driver.MySQLDriver;
import jakarta.servlet.http.HttpServletRequest;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import model.Product;

/**
 *
 * @author DELL
 */
public class ProductImpl implements ProductDao {
    Connection con = MySQLDriver.getConnection();
    @Override
     public List<Product> findAllProduct() {
    List<Product> listProduct = new ArrayList<>();

    String sql = """
        SELECT 
            p.*,
            COALESCE(SUM(oi.quantity), 0) AS sold
        FROM products p
        LEFT JOIN order_details oi ON p.id = oi.product_id
        LEFT JOIN orders o 
            ON oi.order_id = o.id 
            AND o.status = 'COMPLETED'
        GROUP BY 
            p.id, p.name, p.image, p.price,
            p.quantity, p.id_category, p.status
    """;

    try (PreparedStatement sttm = con.prepareStatement(sql);
         ResultSet rs = sttm.executeQuery()) {

        while (rs.next()) {
    Product p = new Product();
    p.setId(rs.getInt("id"));
    p.setName(rs.getString("name"));
    p.setPrice(rs.getDouble("price"));
    p.setQuantity(rs.getInt("quantity"));
    p.setImage(rs.getString("image"));

    // ✅ Lấy status từ DB
    p.setStatus(rs.getInt("status"));

    int sold = getSoldByProductId(p.getId());
    p.setSold(sold);

    listProduct.add(p);
}


    } catch (SQLException e) {
        e.printStackTrace();
    }

    return listProduct;
}

     @Override
public Product findProduct(int id_product) {

    String sql = "SELECT * FROM products WHERE id = ?";

    try (PreparedStatement sttm = con.prepareStatement(sql)) {

        sttm.setInt(1, id_product);

        ResultSet rs = sttm.executeQuery();

        if (rs.next()) {
            return new Product(rs);
        }

    } catch (SQLException ex) {
        Logger.getLogger(ProductImpl.class.getName()).log(Level.SEVERE, null, ex);
    }

    return null;
}

       @Override
public List<Product> findBestSeller() {
    List<Product> list = new ArrayList<>();
    String sql = "SELECT * FROM products ORDER BY quantity DESC LIMIT 6";

    try (PreparedStatement sttm = con.prepareStatement(sql);
         ResultSet rs = sttm.executeQuery()) {

        while (rs.next()) {
            list.add(new Product(rs));
        }

    } catch (SQLException e) {
        e.printStackTrace();
    }
    return list;
}
   @Override
public List<Product> findProductsByName(String keyword) {
    List<Product> list = new ArrayList<>();
    String sql = "SELECT * FROM products WHERE name LIKE ?";

    try (Connection con = MySQLDriver.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setString(1, "%" + keyword + "%");
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Product p = new Product();
            p.setId(rs.getInt("id"));
            p.setId_category(rs.getInt("id_category"));
            p.setName(rs.getString("name"));
            p.setImage(rs.getString("image"));
            p.setPrice(rs.getDouble("price"));
            p.setQuantity(rs.getInt("quantity"));
            p.setStatus(rs.getInt("status")); // ⭐ QUAN TRỌNG

            list.add(p);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    return list;
}

public boolean deleteProduct(int id) {
    String sql = "DELETE FROM products WHERE id=?";
    try (PreparedStatement ps = con.prepareStatement(sql)) {
        ps.setInt(1, id);
        return ps.executeUpdate() > 0;
    } catch (Exception e) {
        e.printStackTrace();
    }
    return false;
}
public void updateProduct(int id, String name, String image,
                          double price, int category, int status) {

    String sql = """
        UPDATE products
        SET name = ?, image = ?, price = ?, id_category = ?, status = ?
        WHERE id = ?
    """;

    try (Connection con = MySQLDriver.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setString(1, name);
        ps.setString(2, image);
        ps.setDouble(3, price);
        ps.setInt(4, category);
        ps.setInt(5, status);   // 🔥 INT – KHÔNG BOOLEAN
        ps.setInt(6, id);

        ps.executeUpdate();

    } catch (Exception e) {
        e.printStackTrace();
    }
}




void addProductToCart(HttpServletRequest request) {

    int id_product;
    try {
        id_product = Integer.parseInt(request.getParameter("id_product"));
    } catch (Exception e) {
        id_product = 0;
    }

    // Giỏ hàng: List<Product>
    List<Product> cart = (List<Product>) request.getSession().getAttribute("cart");
    if (cart == null) cart = new ArrayList<>();

    if (id_product > 0) {

        Product product = Database.getProductDao().findProduct(id_product);

        if (product != null) {
            boolean exists = false;

            // kiểm tra sản phẩm trong giỏ
            for (Product p : cart) {
                if (p.getId() == id_product) {
                    // tăng số lượng
                    p.setQuantity(p.getQuantity() + 1);
                    p.setTotalPrice(p.getPrice() * p.getQuantity());
                    exists = true;
                    break;
                }
            }

            // Nếu chưa có: thêm mới sản phẩm
            if (!exists) {
                product.setQuantity(1);
                product.setTotalPrice(product.getPrice());
                cart.add(product);
            }
        }
    }

    // cập nhật session
    request.getSession().setAttribute("cart", cart);
}



@Override
public List<Product> findByCategory(Integer categoryId) {
    List<Product> list = new ArrayList<>();
    String sql = "SELECT * FROM products WHERE id_category = ?";

    // 1. KHAI BÁO BIẾN Ở ĐÂY (Để dùng được trong cả try và finally)
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        con = MySQLDriver.getConnection();
        
        // 2. Chỉ gán giá trị (không khai báo lại kiểu dữ liệu)
        ps = con.prepareStatement(sql);
        ps.setInt(1, categoryId);

        rs = ps.executeQuery();

        while (rs.next()) {
            Product p = new Product();
            p.setId(rs.getInt("id"));
            p.setId_category(rs.getInt("id_category"));
            p.setName(rs.getString("name"));
            p.setImage(rs.getString("image"));
            p.setPrice(rs.getDouble("price"));
            p.setQuantity(rs.getInt("quantity"));
            p.setStatus(rs.getInt("status"));

            list.add(p);
        }

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // 3. Lúc này finally mới nhìn thấy biến con, ps, rs để đóng
        try {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (con != null) con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
    }

    return list;
}
@Override
public boolean decreaseQuantity(int productId, int amount) {
    String sql = "UPDATE products SET quantity = quantity - ? WHERE id = ? AND quantity >= ?";
    try {
        Connection conn = MySQLDriver.getConnection();
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, amount);
        ps.setInt(2, productId);
        ps.setInt(3, amount);

        return ps.executeUpdate() > 0;
    } catch (Exception e) {
        e.printStackTrace();
    }
    return false;
}

    @Override
    public void addProduct(String name, String image, double price, int quantity, int status, int category) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    @Override
public void updateProductQuantity(int productId, int buyQuantity) {
    String sql = "UPDATE products SET quantity = quantity - ? WHERE id = ?";

    try (Connection con = MySQLDriver.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {
        
        ps.setInt(1, buyQuantity);
        ps.setInt(2, productId);
        ps.executeUpdate();
        
    } catch (Exception e) {
        e.printStackTrace();
    }
}
@Override
public int getSoldByProductId(int productId) {

    String sql =
        "SELECT IFNULL(SUM(od.quantity), 0) " +
        "FROM order_details od " +
        "JOIN orders o ON od.order_id = o.id " +
        "WHERE od.product_id = ? AND o.status = 3";

    try (Connection con = MySQLDriver.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setInt(1, productId);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            return rs.getInt(1);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }
    return 0;
}

}