<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<ul class="actions vertical">
		<li><h1>환영합니다!</h1></li>
		<li>회원가입을 축하합니다.</li>
		<!-- Q2. 회원가입 한 회원정보 중 email을 출력하시오.(request영역 활용) -->
		<!-- smart@smhrd.or.kr -> 실제 회원가입 한 회원의 email로 출력 -->
		<%
		String user_name = (String) request.getAttribute("user_name");
		%>
		<li><%=user_name %> 님 환영합니다</li>
		<li><button onclick='location.href="Login.jsp"'>로그인하러가기</button></li>
	</ul>
	<script src="assets/js/jquery.min.js"></script>
			<script src="assets/js/jquery.scrolly.min.js"></script>
			<script src="assets/js/jquery.scrollex.min.js"></script>
			<script src="assets/js/skel.min.js"></script>
			<script src="assets/js/util.js"></script>
			<script src="assets/js/main.js"></script>
	
</body>
</html>