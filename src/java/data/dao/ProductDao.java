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
    public List<Product> findBestSeller();
    List<Product> findProductsByName(String keyword);
    public boolean deleteProduct(int id);
    void updateProduct(int id, String name, String image, double price, int category, int status);


    public void addProduct(String name, String image, double price, int quantity,
                       int status, int category) ;
public List<Product> findByCategory(Integer categoryId);
boolean decreaseQuantity(int productId, int amount);
public void updateProductQuantity(int productId, int buyQuantity) ;
public int getSoldByProductId(int productId);
}
