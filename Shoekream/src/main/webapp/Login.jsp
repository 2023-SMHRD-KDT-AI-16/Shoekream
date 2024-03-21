<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.security.SecureRandom"%>
<%@ page import="java.math.BigInteger"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>

<head>
<title>네이버로그인</title>
</head>

<body>
	<%
	String clientId = "FAb4bunxl3DNMBTgbAkh";//애플리케이션 클라이언트 아이디값";
	String redirectURI = URLEncoder.encode("http://localhost:8081/Shoekream/callback.jsp", "UTF-8");
	SecureRandom random = new SecureRandom();
	String state = new BigInteger(130, random).toString();
	String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code" + "&client_id=" + clientId
			+ "&redirect_uri=" + redirectURI + "&state=" + state;
	session.setAttribute("state", state);
	%>
	

	<!-- 일반 로그인 -->
	<form action="LoginService" method="post">
		<input type="text" name="id" placeholder="아이디를 입력하세요">
		<br>
		<input type="password" name="pw" placeholder="비밀번호를 입력하세요">
		<br>
		<input type="submit" value="LogIn" class="button fit">
	</form>

	<!-- 네이버 로그인 버튼 -->
	<a href="<%=apiURL%>"><img height="50"
		src="http://static.nid.naver.com/oauth/small_g_in.PNG" /></a>


</body>
</html>