/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package data.dao;

import java.util.List;
import model.Category;

/**
 *
 * @author DELL
 */
public interface CategoryDao {
    public List<Category> findAllCategory();
    public void insertCategory(String name);
    public void deleteCategory(int id);
    public void updateCategory(int id, String name, String newname);
    
    
}
