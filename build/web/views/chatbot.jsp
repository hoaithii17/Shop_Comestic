<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
    <title>Chatbot</title>

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

    <style>
        #chatbox {
            width: 400px;
            height: 400px;
            border: 1px solid #ccc;
            padding: 10px;
            overflow-y: scroll;
            margin-bottom: 10px;
        }
        .user-msg { text-align: right; color: #b4006e; margin: 5px 0; }
        .bot-msg { text-align: left; color: #333; background: #ffe6f2; padding: 6px; border-radius: 8px; margin: 5px 0; }
    </style>
</head>

<body>
    <h3>Beauty Shop Chatbot 💕</h3>

    <div id="chatbox">
        <!-- lịch sử chat sẽ load vào đây -->
    </div>

    <input type="text" id="msg" placeholder="Nhập tin nhắn..." style="width:300px;">
    <button onclick="sendMessage()">Gửi</button>

    <script>
        function sendMessage() {
            let msg = document.getElementById("msg").value;
            if (msg.trim() === "") return;

            // Append tin nhắn người dùng
            $("#chatbox").append("<div class='user-msg'>" + msg + "</div>");

            // Gửi AJAX tới Servlet
            $.post("chat", { message: msg }, function (data) {
                $("#chatbox").append("<div class='bot-msg'>" + data + "</div>");
                document.getElementById("msg").value = "";
            });
        }
    </script>

</body>
</html>
