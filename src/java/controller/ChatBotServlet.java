package controller;

import data.impl.ChatImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import model.ChatMessage;
import model.User;
import service.ChatBotService;

@WebServlet("/chatbot")
public class ChatBotServlet extends HttpServlet {

    ChatImpl chatDao = new ChatImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Cấu hình tiếng Việt
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/plain; charset=UTF-8");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // 2. Kiểm tra đăng nhập
        if (user == null) {
            response.getWriter().write("Bạn cần đăng nhập để dùng chatbot 💕");
            return;
        }

        // 3. Lấy lịch sử từ Session
        List<ChatMessage> history = (List<ChatMessage>) session.getAttribute("chatHistory");

        // 4. Nếu Session chưa có (mới đăng nhập lại), tải từ Database lên
        if (history == null) {
            history = chatDao.getChatHistory(user.getId());
            session.setAttribute("chatHistory", history);
        }

        // 5. Xử lý tin nhắn mới
        String userMsgText = request.getParameter("message");
        
        if (userMsgText != null && !userMsgText.trim().isEmpty()) {
            // -- Xử lý tin nhắn của User --
            ChatMessage userMsg = new ChatMessage(user.getId(), "user", userMsgText);
            chatDao.saveMessage(userMsg); // Lưu vào DB
            history.add(userMsg);         // Thêm vào Session

            // -- Xử lý tin nhắn của Bot --
            String botReplyText = ChatBotService.reply(userMsgText);
            ChatMessage botMsg = new ChatMessage(user.getId(), "bot", botReplyText);
            chatDao.saveMessage(botMsg);  // Lưu vào DB
            history.add(botMsg);          // Thêm vào Session

            // Cập nhật lại session
            session.setAttribute("chatHistory", history);

            // Trả về câu trả lời cho AJAX
            response.getWriter().write(botReplyText);
        }
    }
}