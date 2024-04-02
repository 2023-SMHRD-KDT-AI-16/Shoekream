<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.security.SecureRandom"%>
<%@ page import="java.math.BigInteger"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="./CSS/Login.css">
<title>Document</title>
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

	<section>
		<div class="form-box">
			<div class="form-value">
				<form action="LoginService">
					<h2>SHOEKREAM</h2>
					<div class="inputbox">

						<input type="text" name="id" required> <label for="">아이디</label>
					</div>
					<div class="inputbox">

						<input type="password" name="pw" required> <label for="">비밀번호</label>
					</div>
					<span class="error"> </span>
					<div class="forget">
					<!--  
						<label for=""><input type="checkbox">아이디 기억하기 <a
							href="#">비밀번호 찾기</a></label>-->
			 	</div>
					<button type="submit" id="login"
						style="width: 303.63636px; height: 43.636359999999996px; 
						border: 2px solid rgba(255,255,255,0.5);
						border-radius: 8px; background-color:#ffffff00; color:white;
						font-size: medium;
						">로그인</button>
				</form>
				<br>
<div class="naver">
    <a href="<%=apiURL%>">
        <img style="height:60px" src="img/btnW_완성형.png" />
    </a>
</div>
				<div class="join_pass"></div>
					<br> <label for="" >아이디가 없으신가요? <a href="Join.jsp">
							회원가입 하러가기</a></label>
				</div>
			</div>
		</div>
	</section>


	<!-- 로그인 실패시 오류 메세지 출력 -->
	<%
	String errorMessage = (String) request.getAttribute("errorMessage");
	if (errorMessage != null) {
	%>
	<script>alert('<%=errorMessage%>');</script>
	<%
	}
	%>




</body>
</html>