package data.dao;

import data.impl.CategoryIplm;
import data.impl.ProductImpl;
import data.impl.UserImpl;

/**
 *
 * @author DELL
 */
public class Database {
    // DAO cho bảng Category
    private static final CategoryIplm categoryDao = new CategoryIplm();

    public static CategoryIplm getCategoryDao() {
        return categoryDao;
    }

    // DAO cho bảng Product
    private static final ProductImpl productDao = new ProductImpl();

    public static ProductImpl getProductDao() {
        return productDao;
    }
    public static UserDao getUserDao(){
        return new UserImpl();
    }
}
