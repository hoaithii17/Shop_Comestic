<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page import="data.utils.API" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

<nav class="navbar navbar-expand-lg" style="background: #ffe6f2; padding: 12px; box-shadow: 0 2px 8px rgba(0,0,0,0.05);">
    <div class="container-fluid">
        <a class="navbar-brand" href="#" style="font-weight: bold; color: #d63384; font-size: 22px;">
            <img src="assets/icon/logoo.png" width="45" height="45" style="border-radius: 50%;"/>
            Beauty Shop
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarSupportedContent" style="border-color: #d63384;">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0" style="margin-left: auto;">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/home" style="color:#d63384; font-weight: 600;">Trang chủ</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/product" style="color:#d63384; font-weight: 600;">Sản phẩm</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/category" style="color:#d63384; font-weight: 600;">Danh mục</a>
                </li>

                <c:if test="${user==null}">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/login" style="color:#d63384; font-weight: 600;">Đăng nhập</a>
                    </li>
                </c:if>

                <c:if test="${user!=null}">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" style="color:#d63384; font-weight: 600;">
                            Xin chào,
                            <c:set var="s" value="${user.getName()}"></c:set>
                            <%
                                String name = (String) pageContext.getAttribute("s");
                                if(name != null) out.print(API.getName(name));
                            %>
                        </a>
                        <ul class="dropdown-menu shadow border-0" style="background: #fff0f6;">
                            <li><a class="dropdown-item py-2" href="profile" style="color:#cc2e8a;"><i class="fas fa-user-circle me-2"></i>Hồ sơ cá nhân</a></li>
                            <li><a class="dropdown-item py-2" href="${pageContext.request.contextPath}/myorder" style="color:#cc2e8a;"><i class="fas fa-box-open me-2"></i>Quản lý đơn hàng</a></li>
                            <li><hr class="dropdown-divider" style="opacity: 0.2;"></li>
                            <li><a class="dropdown-item py-2" href="./views/logout.jsp" style="color:#cc2e8a;">Đăng xuất</a></li>
                        </ul>
                    </li>
                </c:if>

                <li class="nav-item">
                    <a class="nav-link" href="cart" style="color:#d63384; font-weight: 600;">
                        <img src="assets/icon/cart.png" width="30" height="30"/>
                        <c:set var="totalQuantity" value="${0}"/>
                        <c:if test="${sessionScope.cart != null}">
                            <c:forEach var="item" items="${sessionScope.cart}">
                                <c:set var="totalQuantity" value="${totalQuantity + item.quantity}"/>
                            </c:forEach>
                        </c:if>
                        (${totalQuantity})
                    </a>
                </li>
            </ul>

            <form class="d-flex" action="${pageContext.request.contextPath}/search" method="get">
                <input class="form-control me-2" style="border-color:#d63384;" type="search" name="keyword" placeholder="Tìm sản phẩm..." />
                <button class="btn" type="submit" style="background:#d63384; color:white;">Tìm</button>
            </form>
        </div>
    </div>
</nav>

<style>
    .chat-btn {
        position: fixed; bottom: 30px; right: 30px; width: 60px; height: 60px;
        background-color: #d63384; color: white; border-radius: 50%; border: none;
        box-shadow: 0 4px 15px rgba(214, 51, 132, 0.4); font-size: 28px; z-index: 9999;
        cursor: pointer; transition: all 0.3s; display: flex; align-items: center; justify-content: center;
    }
    .chat-btn:hover { transform: scale(1.1); background-color: #c22572; }

    .chat-box {
        position: fixed; bottom: 100px; right: 30px; width: 350px; height: 450px;
        background: white; border-radius: 15px; box-shadow: 0 5px 30px rgba(0,0,0,0.15);
        z-index: 9999; display: none; flex-direction: column; overflow: hidden; border: 1px solid #ffe6f2;
    }
    .chat-header {
        background: linear-gradient(135deg, #d63384, #ff9eb5); padding: 15px; color: white;
        display: flex; align-items: center; justify-content: space-between;
    }
    .chat-body { flex: 1; padding: 15px; overflow-y: auto; background-color: #fffbfc; }

    .message { margin-bottom: 10px; max-width: 80%; padding: 10px 15px; border-radius: 20px; font-size: 14px; line-height: 1.4; word-wrap: break-word; }
    .bot-message { background-color: #f1f1f1; color: #333; align-self: flex-start; border-bottom-left-radius: 5px; }
    .user-message { background-color: #ffe6f2; color: #d63384; align-self: flex-end; border-bottom-right-radius: 5px; margin-left: auto; font-weight: 600; }

    .chat-footer { padding: 10px; border-top: 1px solid #eee; display: flex; background: white; }
    .chat-footer input { flex: 1; border: 1px solid #ddd; border-radius: 20px; padding: 8px 15px; outline: none; font-size: 14px; }
    .chat-footer input:focus { border-color: #d63384; }
    .chat-footer button { background: none; border: none; color: #d63384; font-size: 20px; margin-left: 10px; cursor: pointer; }

    .show-chat { display: flex; animation: slideUp 0.3s ease; }
    @keyframes slideUp { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }

    .typing-indicator { font-style: italic; color: #aaa; font-size: 12px; margin-bottom: 5px; display: none; padding-left: 15px;}
</style>

<button class="chat-btn" onclick="toggleChat()">
    <i class="fas fa-comment-dots"></i>
</button>

<div class="chat-box" id="chatBox">
    <div class="chat-header">
        <div class="d-flex align-items-center">
            <div class="rounded-circle bg-white p-1 me-2" style="width:30px; height:30px; display:flex; align-items:center; justify-content:center;">
                <i class="fas fa-robot text-danger"></i>
            </div>
            <div>
                <h5 class="m-0 fw-bold" style="font-size: 16px;">CSKH Beauty Shop</h5>
                <small style="font-size: 11px;">Luôn sẵn sàng hỗ trợ</small>
            </div>
        </div>
        <button onclick="toggleChat()" style="background:none; border:none; color:white; font-size:18px;">
            <i class="fas fa-times"></i>
        </button>
    </div>

    <div class="chat-body" id="chatBody">
        <c:if test="${not empty sessionScope.chatHistory}">
            <c:forEach items="${sessionScope.chatHistory}" var="msg">
                <c:choose>
                    <c:when test="${fn:contains(msg, 'Bạn:')}">
                        <div class="message user-message">
                            ${fn:substringAfter(msg, "Bạn: ")}
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="message bot-message">
                            ${fn:substringAfter(msg, "Beauty Shop: ")}
                        </div>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </c:if>

        <c:if test="${empty sessionScope.chatHistory}">
            <div class="message bot-message">
                Chào bạn! Beauty Shop có thể giúp gì cho bạn hôm nay? 💕
            </div>
        </c:if>
    </div>

    <div class="typing-indicator" id="typingIndicator">Beauty Shop đang soạn tin...</div>

    <div class="chat-footer">
        <input type="text" id="userInput" placeholder="Nhập tin nhắn..." onkeypress="handleEnter(event)">
        <button onclick="sendMessage()">
            <i class="fas fa-paper-plane"></i>
        </button>
    </div>
</div>

<script>
    // 1. Tự động cuộn xuống cuối khi load trang
    document.addEventListener("DOMContentLoaded", function() {
        var chatBody = document.getElementById("chatBody");
        if(chatBody) chatBody.scrollTop = chatBody.scrollHeight;
    });

    function toggleChat() {
        var chatBox = document.getElementById("chatBox");
        chatBox.classList.toggle("show-chat");
        if(chatBox.classList.contains("show-chat")) {
            document.getElementById("userInput").focus();
            // Cuộn xuống lần nữa khi mở chat
            var chatBody = document.getElementById("chatBody");
            chatBody.scrollTop = chatBody.scrollHeight;
        }
    }

    function handleEnter(e) {
        if (e.key === 'Enter') sendMessage();
    }

    function addMessage(text, className) {
        var chatBody = document.getElementById("chatBody");
        var div = document.createElement("div");
        div.className = "message " + className;
        div.innerHTML = text;
        chatBody.appendChild(div);
        chatBody.scrollTop = chatBody.scrollHeight;
    }

    function sendMessage() {
        var input = document.getElementById("userInput");
        var message = input.value.trim();
        if (message === "") return;

        // Hiển thị tin nhắn người dùng
        addMessage(message, "user-message");
        input.value = "";

        // Hiển thị typing...
        var typing = document.getElementById("typingIndicator");
        typing.style.display = "block";
        var chatBody = document.getElementById("chatBody");
        chatBody.scrollTop = chatBody.scrollHeight;

        // Gửi AJAX về Servlet
        var url = "${pageContext.request.contextPath}/chatbot";
        fetch(url, {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8' },
            body: 'message=' + encodeURIComponent(message)
        })
        .then(response => response.text())
        .then(data => {
            typing.style.display = "none";
            addMessage(data, "bot-message");
        })
        .catch(error => {
            console.error('Error:', error);
            typing.style.display = "none";
            addMessage("Xin lỗi, kết nối server bị lỗi.", "bot-message");
        });
    }
</script>