/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package data.impl;

import data.dao.ProductDao;
import data.driver.MySQLDriver;
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
        String sql = "SELECT * FROM products";

        try (
             PreparedStatement sttm = con.prepareStatement(sql);
             ResultSet rs = sttm.executeQuery()) {

            while (rs.next()) {
                int id = rs.getInt("id");
                int id_category = rs.getInt("id_category");
                int quantity = rs.getInt("quantity");
                String image = rs.getString("image");
                String name = rs.getString("name");
                double price = rs.getDouble("price");
                boolean status = rs.getBoolean("status");
                listProduct.add(new Product(id, id_category, quantity, image, name, price, status));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return listProduct;
    }
     @Override
       public Product findProduct(int id_product){
      
       String sql= "select * from products where id="+id_product;
       PreparedStatement sttm;
        try {
            sttm = con.prepareStatement(sql);
            ResultSet rs= sttm.executeQuery();
       if(rs.next()) return new Product(rs);
       
        } catch (SQLException ex) {
            Logger.getLogger(ProductImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
       return null;}}
       
       
       
