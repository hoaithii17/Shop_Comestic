package data.impl;

import data.dao.UserDao;
import data.driver.MySQLDriver;
import model.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserImpl implements UserDao {

    @Override
    public User findUser(String emailphone, String password) {
        String sql = emailphone.contains("@")
                ? "SELECT * FROM users WHERE email = ? AND password = ?"
                : "SELECT * FROM users WHERE phone = ? AND password = ?";

        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, emailphone);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return new User(rs);
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return null;
    }

    @Override
    public User findUser(String emailphone) {
        String sql = emailphone.contains("@")
                ? "SELECT * FROM users WHERE email = ?"
                : "SELECT * FROM users WHERE phone = ?";

        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, emailphone);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return new User(rs);
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return null;
    }

    // insert bằng các tham số (form đăng ký)
    @Override
    public void insertUser(String name, String email, String phone, String password) {
        String sql = "INSERT INTO users(name, email, phone, password, role) VALUES(?,?,?,?,?)";

        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, phone);
            ps.setString(4, password);
            ps.setString(5, "user"); // mặc định role = "user"

            ps.executeUpdate();

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    // insert bằng object (admin)
    @Override
    public void insertUser(User user) {
        String sql = "INSERT INTO users(name, email, phone, password, role) VALUES(?,?,?,?,?)";

        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPhone());
            ps.setString(4, user.getPassword());
            ps.setString(5, user.getRole());

            ps.executeUpdate();

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    // update profile (trả về true nếu thành công)
    @Override
    public boolean updateUser(User user) {
        String sql = "UPDATE users SET name = ?, email = ?, phone = ?, password = ?, role = ? WHERE id = ?";

        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPhone());
            ps.setString(4, user.getPassword());
            ps.setString(5, user.getRole());
            ps.setInt(6, user.getId());

            return ps.executeUpdate() > 0;

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }

    @Override
    public User getUserById(int id) {
        String sql = "SELECT * FROM users WHERE id = ?";

        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return new User(rs);
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean updatePassword(int id, String newPassword) {
        String sql = "UPDATE users SET password = ? WHERE id = ?";

        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, newPassword);
            ps.setInt(2, id);

            return ps.executeUpdate() > 0;

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }

    @Override
    public List<User> findAllUsers() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM users ORDER BY id DESC";

        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                // phù hợp constructor bạn có: User(int id, String name, String email, String phone, String password, String role)
                list.add(new User(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getString("password"),
                        rs.getString("role")
                ));
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    @Override
    public void deleteUser(int id) {
        String sql = "DELETE FROM users WHERE id = ?";

        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    @Override
    public User findById(int id) {
        // delegate to getUserById (giữ để tương thích tên cũ)
        return getUserById(id);
    }
}
