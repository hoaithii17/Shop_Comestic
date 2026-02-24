package data.dao;

import java.util.List;
import model.ChatMessage;

public interface ChatDao {
    void saveMessage(ChatMessage msg);
    List<ChatMessage> getChatHistory(int userId);
}
