package controller;

import data.dao.CategoryDao;
import data.dao.ProductDao;
import data.impl.CategoryIplm;
import data.impl.ProductImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import model.Category;
import model.Product;

@WebServlet("/adminproductfind")
public class AdminProductServlet extends HttpServlet {

    // 1. Khởi tạo DAO cho cả Sản phẩm và Danh mục
    ProductDao productDao = new ProductImpl();
    CategoryDao categoryDao = new CategoryIplm();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 2. LUÔN LUÔN lấy danh sách Category để đổ vào Dropdown (Quan trọng)
        // Nếu thiếu dòng này, thanh tìm kiếm sẽ bị rỗng phần danh mục
        List<Category> categories = categoryDao.findAllCategory();
        request.setAttribute("categories", categories);

        // 3. Lấy tham số từ Form tìm kiếm
        String keyword = request.getParameter("keyword");
        String categoryIdParam = request.getParameter("categoryId");

        // Xử lý an toàn cho categoryId (tránh lỗi null hoặc không phải số)
        int categoryId = 0;
        if (categoryIdParam != null && !categoryIdParam.isEmpty()) {
            try {
                categoryId = Integer.parseInt(categoryIdParam);
            } catch (NumberFormatException e) {
                categoryId = 0;
            }
        }

        // Xử lý an toàn cho keyword
        if (keyword != null) {
            keyword = keyword.trim();
        }

        List<Product> products;

        // 4. LOGIC LỌC DỮ LIỆU (Tách biệt Tên và Danh mục)

        // TRƯỜNG HỢP 1: Có nhập từ khóa -> TÌM THEO TÊN
        if (keyword != null && !keyword.isEmpty()) {
            products = productDao.findProductsByName(keyword);
            
            // Khi tìm theo tên, ta reset category về 0 để trên giao diện hiện "Tất cả danh mục"
            categoryId = 0; 
        } 
        
        // TRƯỜNG HỢP 2: Không nhập tên, nhưng có chọn danh mục -> LỌC THEO DANH MỤC
        else if (categoryId > 0) {
            products = productDao.findByCategory(categoryId);
            
            // Reset keyword về rỗng
            keyword = "";
        } 
        
        // TRƯỜNG HỢP 3: Mặc định -> HIỆN TẤT CẢ
        else {
            products = productDao.findAllProduct();
        }

        // 5. Gửi dữ liệu sang JSP
        request.setAttribute("products", products);
        
        // Gửi lại keyword và categoryId để JSP giữ lại trạng thái (Selected/Value)
        request.setAttribute("keyword", keyword);
        request.setAttribute("categoryId", categoryId);

        // 6. Chuyển hướng đến file JSP
        // Lưu ý: Kiểm tra đường dẫn này có đúng với cấu trúc thư mục của bạn không
        request.getRequestDispatcher("/admin/products.jsp").forward(request, response);
    }
}