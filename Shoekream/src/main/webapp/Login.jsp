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
						<label for=""><input type="checkbox">아이디 기억하기 <a
							href="#">비밀번호 찾기</a></label>
					</div>
					<button type="submit" id="login"
						style="width: 303.63636px; height: 43.636359999999996px; 
						border: 2px solid rgba(255,255,255,0.5);
						border-radius: 8px; background-color:#ffffff00; color:white;
						font-size: medium;
						">로그인</button>
				</form>
				<br>
<div class="naver">ㅋ
    <a href="<%=apiURL%>">
        <img height="40" width="300"
            src="https://go.at.or.kr/images/naver.png" />
    </a>
</div>
				<div class="join_pass">
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


	<script>
    let page = 1;

    function loadMorePosts() {
      const container = document.getElementById("instagram-posts");

      
      // 여기서는 간단한 예시로서 더미 데이터를 사용합니다.
      const dummyData = `
        <div class="instagram-post">
          <div class="post-header">
            <img src="/MAIN/img/299400862_433066862176075_265719782033185215_n.jpg" alt="프로필 사진">
            <div class="profile-info">
              <h2 class="head" >프로필 이름 <button>팔로우</button> <span class="icon">❤️</span> <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"   viewBox="0 0 24 24" style="fill: rgba(0, 0, 0, 1); margin-left: 450px; transform: ;msFilter:;"><path d="M12 10c-1.1 0-2 .9-2 2s.9 2 2 2 2-.9 2-2-.9-2-2-2zm6 0c-1.1 0-2 .9-2 2s.9 2 2 2 2-.9 2-2-.9-2-2-2zM6 10c-1.1 0-2 .9-2 2s.9 2 2 2 2-.9 2-2-.9-2-2-2z"></path></svg></h2>
              <p>게시물 날짜 및 시간</p>
            </div>
            <div></div>
          </div>
          <div class="post-content">
            <img src="/MAIN/img/KakaoTalk_20240319_123914465.jpg" alt="게시물 이미지">
          </div>
          <div class="post-footer">
            <div class="emoji-icons">
              <box-icon name='heart' class="h"><svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" viewBox="0 0 24 24" style="fill: rgba(0, 0, 0, 1);transform: ;msFilter:;"><path d="M12 4.595a5.904 5.904 0 0 0-3.996-1.558 5.942 5.942 0 0 0-4.213 1.758c-2.353 2.363-2.352 6.059.002 8.412l7.332 7.332c.17.299.498.492.875.492a.99.99 0 0 0 .792-.409l7.415-7.415c2.354-2.354 2.354-6.049-.002-8.416a5.938 5.938 0 0 0-4.209-1.754A5.906 5.906 0 0 0 12 4.595zm6.791 1.61c1.563 1.571 1.564 4.025.002 5.588L12 18.586l-6.793-6.793c-1.562-1.563-1.561-4.017-.002-5.584.76-.756 1.754-1.172 2.799-1.172s2.035.416 2.789 1.17l.5.5a.999.999 0 0 0 1.414 0l.5-.5c1.512-1.509 4.074-1.505 5.584-.002z"></path></svg></box-icon>
              <svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" viewBox="0 0 24 24" style="fill: rgba(0, 0, 0, 1);transform: ;msFilter:;"><path d="M12 2C6.486 2 2 5.589 2 10c0 2.908 1.898 5.516 5 6.934V22l5.34-4.005C17.697 17.852 22 14.32 22 10c0-4.411-4.486-8-10-8zm0 14h-.333L9 18v-2.417l-.641-.247C5.67 14.301 4 12.256 4 10c0-3.309 3.589-6 8-6s8 2.691 8 6-3.589 6-8 6z"></path></svg>
            </div>
          
            <span class="likes">좋아요 수</span>
            <span class="comments">댓글 수</span><br>
            <p>게시물 텍스트 내용</p>
            <input type="text" placeholder="댓글달기...">
            <button>전송</button>  
          </div>
        </div>
      `;

      // 새로운 포스트를 추가합니다.
      container.innerHTML += dummyData;

      page++;
    }

    // 스크롤 이벤트를 감지하여 무한 스크롤 함수를 호출
    window.addEventListener("scroll", () => {
      const { scrollTop, scrollHeight, clientHeight } = document.documentElement;
      
      if (scrollTop + clientHeight >= scrollHeight - 5) {
        // 페이지 하단에 도달했을 때 새로운 포스트를 로드
        loadMorePosts();
      }
    });

    // 페이지 로드 시 초기 포스트들을 로드
    loadMorePosts();
  </script>

</body>
</html>