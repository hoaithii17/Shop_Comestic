package data.impl;

import data.dao.OrderDao;
import data.driver.MySQLDriver;
import model.Order;
import model.OrderItem;
import model.Product;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;


public class OrderImpl implements OrderDao {

    @Override
    public List<Order> getOrdersByUserId(int userId) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE user_id = ? ORDER BY order_date DESC";

        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Order o = new Order(
                        rs.getInt("id"),
                        rs.getInt("user_id"),
                        rs.getString("fullname"),
                        rs.getString("email"),
                        rs.getString("phone_number"),
                        rs.getString("address"),
                        rs.getString("note"),
                        rs.getTimestamp("order_date"),
                        rs.getInt("status"),
                        rs.getDouble("total_money")
                );
                list.add(o);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }


    @Override
    public int createOrder(int userId, String name, String email, String phone, String address, double total, String note) {
        int orderId = 0;

        String sql = "INSERT INTO orders (user_id, fullname, email, phone_number, address, total_money, note, order_date, status) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, NOW(), 0)";

        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, userId);
            ps.setString(2, name);
            ps.setString(3, email);
            ps.setString(4, phone);
            ps.setString(5, address);
            ps.setDouble(6, total);
            ps.setString(7, note);

            if (ps.executeUpdate() > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) orderId = rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return orderId;
    }


   @Override
public void saveOrderDetails(int orderId, List<Product> cart) {

    String sqlDetail = "INSERT INTO order_details (order_id, product_id, price, quantity, total_price) "
                     + "VALUES (?, ?, ?, ?, ?)";

    String sqlUpdateQty = "UPDATE products SET quantity = quantity - ? WHERE id = ?";

    try (Connection con = MySQLDriver.getConnection()) {

        // Lưu chi tiết đơn hàng
        PreparedStatement ps = con.prepareStatement(sqlDetail);
        PreparedStatement psUpdate = con.prepareStatement(sqlUpdateQty);

        for (Product p : cart) {

            // 1. Lưu chi tiết
            ps.setInt(1, orderId);
            ps.setInt(2, p.getId());
            ps.setDouble(3, p.getPrice());
            ps.setInt(4, p.getQuantity());
            ps.setDouble(5, p.getPrice() * p.getQuantity());
            ps.addBatch();

            
        }

        ps.executeBatch();
        psUpdate.executeBatch();

    } catch (Exception e) {
        e.printStackTrace();
    }
}



    @Override
    public Order getOrderById(int orderId, int userId) {

        String sql = "SELECT * FROM orders WHERE id = ? AND user_id = ?";

        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            ps.setInt(2, userId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return new Order(
                        rs.getInt("id"),
                        rs.getInt("user_id"),
                        rs.getString("fullname"),
                        rs.getString("email"),
                        rs.getString("phone_number"),
                        rs.getString("address"),
                        rs.getString("note"),
                        rs.getTimestamp("order_date"),
                        rs.getInt("status"),
                        rs.getDouble("total_money")
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

@Override
public List<Product> getOrderDetails(int orderId) {
    List<Product> list = new ArrayList<>();

    String sql = "SELECT p.id, p.name, p.price, p.image, od.quantity " +
                 "FROM order_details od " +
                 "JOIN products p ON od.product_id = p.id " +
                 "WHERE od.order_id = ?";

    try (Connection con = MySQLDriver.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setInt(1, orderId);

        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Product p = new Product();
            p.setId(rs.getInt("id"));
            p.setName(rs.getString("name"));
            p.setPrice(rs.getDouble("price"));
            p.setImage(rs.getString("image"));

            // quantity trong order_details → quantity đặt hàng
            int qty = rs.getInt("quantity");
            p.setQuantity(qty);

            // tự tính totalPrice trong Product
            p.setTotalPrice(p.getPrice() * qty);

            list.add(p);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return list;
}




    @Override
    public List<Order> findAll() {
        List<Order> list = new ArrayList<>();

        String sql = "SELECT * FROM orders ORDER BY id DESC";

        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(new Order(
                        rs.getInt("id"),
                        rs.getInt("user_id"),
                        rs.getString("fullname"),
                        rs.getString("email"),
                        rs.getString("phone_number"),
                        rs.getString("address"),
                        rs.getString("note"),
                        rs.getTimestamp("order_date"),
                        rs.getInt("status"),
                        rs.getDouble("total_money")
                ));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }


    @Override
    public Order findById(int id) {
        String sql = "SELECT * FROM orders WHERE id=?";

        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return new Order(
                        rs.getInt("id"),
                        rs.getInt("user_id"),
                        rs.getString("fullname"),
                        rs.getString("email"),
                        rs.getString("phone_number"),
                        rs.getString("address"),
                        rs.getString("note"),
                        rs.getTimestamp("order_date"),
                        rs.getInt("status"),
                        rs.getDouble("total_money")
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }


    
    @Override
    public List<OrderItem> findItems(int orderId) {

        List<OrderItem> list = new ArrayList<>();

        String sql = "SELECT * FROM order_details WHERE order_id=?";

        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, orderId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(new OrderItem(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }


    @Override
    public boolean updateStatus(int orderId, int status) {
        String sql = "UPDATE orders SET status=? WHERE id=?";

        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, status);
            ps.setInt(2, orderId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    @Override
    public boolean deleteOrder(int orderId) {

        try (Connection con = MySQLDriver.getConnection()) {

            PreparedStatement ps1 = con.prepareStatement("DELETE FROM order_details WHERE order_id=?");
            ps1.setInt(1, orderId);
            ps1.executeUpdate();

            PreparedStatement ps2 = con.prepareStatement("DELETE FROM orders WHERE id=?");
            ps2.setInt(1, orderId);

            return ps2.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
    @Override
    public int countNewOrders() {
        String sql = "SELECT COUNT(*) FROM orders WHERE status = 0";
        try {Connection con = MySQLDriver.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
     @Override
    public List<Order> getNewOrdersSince(int lastReadOrderId) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE id > ? ORDER BY id DESC";

        try (Connection con = MySQLDriver.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, lastReadOrderId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Order o = new Order();
                o.setId(rs.getInt("id"));
                o.setUserId(rs.getInt("userId"));
                o.setFullname(rs.getString("fullname"));
                o.setEmail(rs.getString("email"));
                o.setPhoneNumber(rs.getString("phoneNumber"));
                o.setAddress(rs.getString("address"));
                o.setNote(rs.getString("note"));
               o.setOrderDate(rs.getTimestamp("orderDate"));

                o.setStatus(rs.getInt("status"));
                list.add(o);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    @Override
    public void updateLastReadOrder(int orderId) {
        String sql = "UPDATE admin_notify SET last_read_order_id = ? WHERE id = 1";

        try (Connection con = MySQLDriver.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public int getLastReadOrderId() {
        String sql = "SELECT last_read_order_id FROM admin_notify WHERE id = 1";

        try (Connection con = MySQLDriver.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("last_read_order_id");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0; // mặc định
    }
}
