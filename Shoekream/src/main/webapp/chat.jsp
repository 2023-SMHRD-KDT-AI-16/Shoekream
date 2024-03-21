<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>채팅 애플리케이션</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script type="text/javascript">
        // userID를 가져오기 위한 스크립틀릿
        var userID = '<%= (String) session.getAttribute("userID") %>';
        
        $(document).ready(function() {
            // 페이지 로드 시에 채팅 내용을 로드하는 함수 호출
            loadChatBox();

            // 여기에 메시지 전송에 관한 스크립트 추가
            // ...
        });

        function loadChatBox() {
            // 채팅 상자 내용 로드하기
            $.ajax({
                type: "POST",
                url: "ChatBoxServlet",
                data: {
                    userID: userID
                },
                dataType: "text",
                success: function(response) {
                    // 채팅 상자에 메시지들을 로드
                    $("#chatBox").html(response);
                }
            });
        }

        // 채팅 전송 함수 (가정)
        function sendChat() {
            var message = $("#chatMessage").val();
            // 메시지 전송 AJAX 구현
            // ...
        }
    </script>
</head>
<body>
    <div class="container">
        <!-- 로그인된 유저의 채팅 상자 -->
        <div id="chatBox" class="chat-box">
            <!-- 채팅 내용이 여기에 동적으로 로드됩니다. -->
        </div>
        <!-- 메시지 입력 필드 -->
        <input type="text" id="chatMessage" />
        <!-- 메시지 전송 버튼 -->
        <button onclick="sendChat()">메시지 전송</button>
    </div>
</body>
</html>