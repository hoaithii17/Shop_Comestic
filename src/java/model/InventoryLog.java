package model;

import java.sql.Timestamp;

public class InventoryLog {

    private int id;
    private int productId;
    private String type;
    private int quantity;
    private double importPrice;
    private String note;
    private Timestamp createdAt;

    public void setImportPrice(double importPrice) {
        this.importPrice = importPrice;
    }

    public double getImportPrice() {
        return importPrice;
    }

    public InventoryLog() {
    }

    public InventoryLog(int productId, String type, int quantity, String note) {
        this.productId = productId;
        this.type = type;
        this.quantity = quantity;
        this.note = note;
    }

    // ===== GETTER & SETTER =====

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}
