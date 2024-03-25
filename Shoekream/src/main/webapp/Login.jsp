<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.security.SecureRandom"%>
<%@ page import="java.math.BigInteger"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/Login.css">
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
	
 <section>
        <div class="form-box">
            <div class="form-value">
                <form action="">
                    <h2>SHOEKREAM</h2>
                    <div class="inputbox" >
                       
                        <input type="id" required >
                        <label for="">아이디</label>
                    </div>
                    <div class="inputbox">
                  
                        <input type="password" required>
                        <label for="">비밀번호</label>
                    </div>
                    <span class="error" >
                        
                    </span>
                    <div class="forget">
                        <label for=""><input type="checkbox" >아이디 기억하기    <a href="#">비밀번호 찾기</a></label>
                    </div>
                    <button>로그인</button> 
                </form>
                     <br>
                     <div class="naver" >
                        <form action="https://nid.naver.com/nidlogin.login?mode=form&url=https://www.naver.com/">
                     <button >NAVER 로그인</button>
                    </form>
                    </div>
                     <div class="join_pass">
                    <br>
                    <label for="">아이디가 없으신가요?    <a href="/MAIN/Login.html">  회원가입 하러가기</a></label>
                </div>
            </div>
        </div>
    </section>
  <!-- <script>
   const er = document.querySelector(".error");
   er.innerHTML="아이디 및 비밀번호를 잘못 입력하셨습니다."
  </script> -->
	<!-- 일반 로그인 -->
	<form action="LoginService" method="post">
		<input type="text" name="id" placeholder="아이디를 입력하세요">
		<br>
		<input type="password" name="pw" placeholder="비밀번호를 입력하세요">
		<br>
		<input type="submit" value="LogIn" class="button fit">
	</form>

	<!-- 네이버 로그인 버튼 -->
	<a href="<%=apiURL%>"><img height="30"
		src="http://static.nid.naver.com/oauth/small_g_in.PNG" /></a>
	<br>
	<!-- 회원가입 버튼 -->
	<button><a href="Join.jsp">회원가입</a></button>

</body>
</html>