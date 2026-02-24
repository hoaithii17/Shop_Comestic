package data.dao;

import java.util.List;

import model.Order;
import model.Product;
import model.Order;
import model.OrderItem;

public interface OrderDao {

    // Lấy danh sách đơn hàng của 1 user
    List<Order> getOrdersByUserId(int userId);

    // Tạo đơn hàng và trả về orderId
    int createOrder(int userId, String name, String email, String phone,
                     String address, double total, String note);

    // Lưu chi tiết đơn hàng
    void saveOrderDetails(int orderId, List<Product> cart);

    // Lấy 1 đơn hàng theo id và user
    Order getOrderById(int orderId, int userId);

    // Lấy danh sách sản phẩm trong đơn
   public List<Product> getOrderDetails(int orderId);


    // ADMIN — lấy tất cả đơn hàng
    List<Order> findAll();

    // ADMIN — tìm đơn theo ID
    Order findById(int id);

    // ADMIN — lấy danh sách item của 1 đơn
    List<OrderItem> findItems(int orderId);

    // ADMIN — cập nhật trạng thái đơn hàng
    boolean updateStatus(int orderId, int status);

    // ADMIN — xoá đơn hàng
    boolean deleteOrder(int orderId);
    int countNewOrders();
    public List<Order> getNewOrdersSince(int lastReadOrderId);
public void updateLastReadOrder(int orderId);
public int getLastReadOrderId();

}
