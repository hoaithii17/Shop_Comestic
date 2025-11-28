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

    @Override
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
    public void insertCategory(String name){
        
    };
    public void deleteCategory(int id){
        
    };
    public void updateCategory(int id, String name, String newname){
        
    };
}
