package model;

import java.sql.Timestamp;

public class Order {
    private int id;
    private int userId;
    private String fullname;
    private String email;
    private String phoneNumber;
    private String address;
    private String note;
    private Timestamp orderDate; // DÙNG TIMESTAMP CHUẨN NHẤT
    private int status; 
    private double totalMoney;

    // Constructor rỗng
    public Order() {
    }

    // Constructor đầy đủ
    public Order(int id, int userId, String fullname, String email, String phoneNumber, 
                 String address, String note, Timestamp orderDate, int status, double totalMoney) {
        this.id = id;
        this.userId = userId;
        this.fullname = fullname;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.address = address;
        this.note = note;
        this.orderDate = orderDate;
        this.status = status;
        this.totalMoney = totalMoney;
    }

    // Constructor dùng khi tạo đơn mới
    public Order(int userId, String fullname, String email, String phoneNumber, 
                 String address, String note, double totalMoney) {
        this.userId = userId;
        this.fullname = fullname;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.address = address;
        this.note = note;
        this.totalMoney = totalMoney;
        
        // Set ngày hiện tại
        this.orderDate = new Timestamp(System.currentTimeMillis());
        this.status = 0; 
    }

    // GETTER & SETTER
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public Timestamp getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Timestamp orderDate) {
        this.orderDate = orderDate;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public double getTotalMoney() {
        return totalMoney;
    }

    public void setTotalMoney(double totalMoney) {
        this.totalMoney = totalMoney;
    }

    // --- HELPER ---
    public String getStatusName() {
        switch (this.status) {
            case 0: return "Đang xử lý";
            case 1: return "Đang đóng gói";
            case 2: return "Đang vận chuyển";
            case 3: return "Đã giao hàng";
            case 4: return "Đã hủy";
            default: return "Không xác định";
        }
    }

    public String getStatusClass() {
        switch (this.status) {
            case 0: return "bg-secondary";
            case 1: return "bg-info";
            case 2: return "bg-primary";
            case 3: return "bg-success";
            case 4: return "bg-danger";
            default: return "bg-dark";
        }
    }
}
