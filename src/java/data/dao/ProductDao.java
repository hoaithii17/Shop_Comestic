/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package data.dao;

import java.util.List;
import model.Product;

/**
 *
 * @author DELL
 */
public interface ProductDao {
    public List<Product> findAllProduct();
    public Product findProduct(int id_product);
}
