package model;

public class ChatMessage {
    private int id;
    private int userId;
    private String sender;
    private String message;

    public ChatMessage(int id, int userId, String sender, String message) {
        this.id = id;
        this.userId = userId;
        this.sender = sender;
        this.message = message;
    }

    public ChatMessage(int userId, String sender, String message) {
        this.userId = userId;
        this.sender = sender;
        this.message = message;
    }

    // getter/setter đầy đủ

    public int getId() {
        return id;
    }

    public int getUserId() {
        return userId;
    }

    public String getSender() {
        return sender;
    }

    public String getMessage() {
        return message;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public void setSender(String sender) {
        this.sender = sender;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
