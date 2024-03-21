<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>채팅 애플리케이션</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
</head>
<body>
    <%
        // 세션에서 userID 가져오기
        String userID = (String) session.getAttribute("userID");
        if(userID == null || userID.trim().isEmpty()) {
            // userID가 없는 경우, 로그인 페이지로 리디렉션
            response.sendRedirect("login.jsp");
            return;
        }
    %>
    <script type="text/javascript">
        // 세션에서 가져온 userID를 JavaScript 변수로 설정
        var userID = '<%= userID %>';
        console.log("현재 사용자 ID: " + userID);
        
        $(document).ready(function(){
            // 페이지가 로드될 때 실행될 기능들
            // 예: 채팅 로드, 메시지 전송 기능 등
        });

        // 추가적인 JavaScript 함수들
    </script>
    <!-- 여기에 HTML 마크업과 다른 로직을 추가하세요. -->
</body>
</html>