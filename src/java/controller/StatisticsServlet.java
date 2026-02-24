package controller;

import data.dao.ReportDao;
import data.dao.StatisticsDao;
import data.impl.ReportImpl;
import data.impl.StatisticsImpl;
import model.ProfitReport;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/admin/statistics")
public class StatisticsServlet extends HttpServlet {

    private final StatisticsDao statisticsDao = new StatisticsImpl();
    private final ReportDao reportDao = new ReportImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // ===== 1. THỜI GIAN HIỆN TẠI =====
        LocalDate today = LocalDate.now();
        String day = today.toString();          // yyyy-MM-dd
        String month = today.toString().substring(0, 7); // yyyy-MM
        String year = String.valueOf(today.getYear());

        // ===== 2. DOANH THU =====
        double revDay = statisticsDao.getRevenueByDay(day);
        double revMonth = statisticsDao.getRevenueByMonth(month);
        double revYear = statisticsDao.getRevenueByYear(year);

        // ===== 3. TRẠNG THÁI ĐƠN HÀNG =====
        int processingOrders = statisticsDao.getOrdersByStatus(0);
        int packingOrders = statisticsDao.getOrdersByStatus(1);
        int shippingOrders = statisticsDao.getOrdersByStatus(2);
        int successOrders = statisticsDao.getOrdersByStatus(3);
        int canceledOrders = statisticsDao.getOrdersByStatus(4);

        // ===== 4. DOANH THU THEO THÁNG =====
        int currentYear = today.getYear();
        double[] monthlyRevenue =
                ((StatisticsImpl) statisticsDao).getMonthlyRevenue(currentYear);

        // ===== 5. PROFIT REPORT (GỘP VÀO) =====
        req.setAttribute("reports", reportDao.getProfitReport());
        
 /* ================== TỔNG LỢI NHUẬN ================== */
        double totalProfit = 0;
        List<ProfitReport> reports = reportDao.getProfitReport();

        for (ProfitReport r : reports) {
            totalProfit += r.getProfit();
        }
        req.setAttribute("totalProfit", totalProfit);
        // ===== 6. SET ATTRIBUTE CHO JSP =====
        req.setAttribute("revDay", revDay);
        req.setAttribute("revMonth", revMonth);
        req.setAttribute("revYear", revYear);

        req.setAttribute("processingOrders", processingOrders);
        req.setAttribute("packingOrders", packingOrders);
        req.setAttribute("shippingOrders", shippingOrders);
        req.setAttribute("successOrders", successOrders);
        req.setAttribute("canceledOrders", canceledOrders);

        req.setAttribute("monthlyRevenue", monthlyRevenue);

        // ===== 7. FORWARD =====
        req.getRequestDispatcher("/admin/statistics.jsp")
           .forward(req, resp);
    }
}
