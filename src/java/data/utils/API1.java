package data.utils;

import model.Category;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class API1 {

    // Thay đổi thông tin DB cho phù hợp
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/shopping";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASS = "";

    // Phương thức lấy tất cả category
    public static List<Category> getAllCategory() {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT id, name FROM categories"; // giả sử bảng tên 'category'

        try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASS);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                list.add(new Category(id, name));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }
}
