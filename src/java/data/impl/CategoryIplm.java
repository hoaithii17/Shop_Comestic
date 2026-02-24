package data.impl;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import data.dao.CategoryDao;
import data.driver.MySQLDriver;
import java.util.ArrayList;
import java.util.List;
import model.Category;

/**
 *
 * @author DELL
 */
public class CategoryIplm implements CategoryDao {

    public List<Category> findAllCategory() {
        List<Category> listCategory = new ArrayList<>();
        String sql = "SELECT * FROM categories";

        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement sttm = con.prepareStatement(sql);
             ResultSet rs = sttm.executeQuery()) {

            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                listCategory.add(new Category(id, name));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return listCategory;
    }
     @Override
    public void insertCategory(String name) {
        String sql = "INSERT INTO categories(name) VALUES (?)";

        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, name);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void updateCategory(int id, String name) {
        String sql = "UPDATE categories SET name=? WHERE id=?";

        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, name);
            ps.setInt(2, id);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteCategory(int id) {
        String sql = "DELETE FROM categories WHERE id=?";

        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
