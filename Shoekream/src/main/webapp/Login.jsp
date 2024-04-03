<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.security.SecureRandom"%>
<%@ page import="java.math.BigInteger"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="">
<title>Document</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Poppins:wght@500&display=swap');
*{
    margin: 0;
    padding: 0;
    font-family: 'poppins',sans-serif;
}

section {
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
    width: 100%;
    background: url('') no-repeat;
    background-position: center;
    background-size: cover;
        background-color: #ebf1f7;
}

.form-box{
  position: relative;
    width: 500px;
    height: auto;
    /* background: #ebf1f7; */
    border: 2px solid rgb(0, 0, 0);
    border-radius: 20px;
    backdrop-filter: blur(15px);
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 60px 0;
    box-sizing: border-box;
    background-color: white;

}
h2{
    font-size: 2em;
    color: rgb(0, 0, 0);
    text-align: center;
}
.inputbox{
    position: relative;
    margin: 30px 0;
    width: 310px;
    border-bottom: 2px solid rgb(0, 0, 0);
}
.inputbox label{
    position: absolute;
    top: 10px;
    left: 5px;
    transform: translateY(-50%);
    color: rgb(0, 0, 0);
    font-size: 1em;
    pointer-events: none;
    transition: .5s;
}
input:focus ~ label,
input:valid ~ label{
top: -5px;
}
.inputbox input {
    width: 100%;
    height: 50px;
    background: transparent;
    border: none;
    outline: none;
    font-size: 1em;
    padding:0 35px 0 5px;
    color: rgb(0, 0, 0);
}
.inputbox ion-icon{
    position: absolute;
    right: 8px;
    color: rgb(0, 0, 0);
    font-size: 1.2em;
    top: 20px;
}
.forget{
    margin: -15px 0 15px ;
    font-size: .9em;
    color: rgb(0, 0, 0);
    display: flex;
    justify-content: space-between;  
}

.forget label input{
    margin-right: 5px;
    
    
}
.forget label a{
    color: #ff007f;
    text-decoration: none;
}
.forget label a:hover{
    text-decoration: underline;
}
#login{
    width: 225px;
    height: 60px;
    border-radius: 20px;
    background:  black;;
    border:none;
    outline: darkslateblue;
    
    cursor: pointer;
    font-size: 1em;
    font-weight: 600;
 
}

.register{
    font-size: .9em;
    color: rgb(0, 0, 0);
    text-align: center;
    margin: 25px 0 10px;
}
.register p a{
    text-decoration: none;
    color: rgb(0, 0, 0);
    font-weight: 600;
}
.register p a:hover{
    text-decoration: underline;
}

.form-box{
    color: rgb(0, 0, 0);
    text-align: center;
     
}
.naver img {  
        transition: background-color 0.3s; /* 호버 효과를 위한 전환 효과 설정 */
    }
/* .error{
    display: block;
    height: 50px;
    color: red;
    text-align: left;
} */
 
      .naver img:hover {
        background-color: rgba(0, 0, 0, 0.1); /* 호버 시 배경색 변경 */
    	 margin: 2px;
        transition: .35s;
    }
    
    
    .join_pass a {
        color: #ff007f; /* 링크 텍스트 색상 변경 */
    }    
    

</style>
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
					<h2>  <img src="./img/슈크림.jpg" alt="SHOEKREAM 로고" style="width: 200px; height: 100px;"></h2>
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
						style="width: 225px; height:60px; 
						border-radius: 5px; background-color:#ffffff; color: rgb(0, 0, 0);;
						font-size: medium;
						    border: solid 2px #80808038;
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