package data.dao;

public interface StatisticsDao {
    int getTotalOrders();
    int getCompletedOrders();
    double getRevenue();
    double getRevenueByDay(String day);
    double getRevenueByMonth(String month);
    double getRevenueByYear(String year);
    int getOrdersByStatus(int status);
    public double[] getMonthlyRevenue(int year);
}
