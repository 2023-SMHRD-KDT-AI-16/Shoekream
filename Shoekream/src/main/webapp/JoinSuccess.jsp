<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <link rel="stylesheet" href="./CSS/JoinSuccess.css" />
    <link rel="stylesheet" href="Success.css" />
    <link rel="stylesheet" href="style.css" />
    <style>
      /* Close button hover effect */
      .close-btn:hover {
        cursor: pointer;
      }
      
      /* MAIN-JOIN 스타일 수정 */
      .MAIN-JOIN {
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 50px;
        padding: 80px 80px 40px;
        background-color: #ffffff;
      }

      .MAIN-JOIN .element {
        width: 550px;
        height: 80px;
      }

      .MAIN-JOIN .icon-jam-icons {
        width: 124px;
        height: 124px;
      }

      .MAIN-JOIN .section-text {
        display: flex;
        flex-direction: column;
        width: 1280px;
        align-items: center;
        gap: 48px;
      }

      .MAIN-JOIN .top {
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 8px;
        width: 100%;
      }

      .MAIN-JOIN .main-headline {
        margin-top: -1px;
        font-family: "Roboto-Bold", Helvetica;
        font-weight: 700;
        color: var(--coolgray-90);
        font-size: 30px;
        text-align: center;
        letter-spacing: 0;
        line-height: 33px;
      }

      .MAIN-JOIN .button {
        display: flex;
        width: 491px;
        height: 42px;
        align-items: center;
        justify-content: center;
        padding: 16px;
        border: 2px solid;
        border-color: var(--primary-60);
		
      }

      .MAIN-JOIN .text-container {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 10px;
        padding: 0px 16px;
        margin-top: -5px;
        margin-bottom: -5px;
      }

      .MAIN-JOIN .button-text {
        width: fit-content;
        margin-top: -1px;
        font-family: var(--button-l-font-family);
        font-weight: var(--button-l-font-weight);
        color: var(--primary-60);
        font-size: var(--button-l-font-size);
        letter-spacing: var(--button-l-letter-spacing);
        line-height: var(--button-l-line-height);
        white-space: nowrap;
        font-style: var(--button-l-font-style);
      }

      .MAIN-JOIN .icon-ionicons {
        width: 40px;
        height: 40px;
        top: 23px;
        left: 27px;
        position: absolute;
      }
    </style>
</head>
<body>

	<ul class="actions vertical">
		    <button aria-label="close" class="close-btn x" onclick="closeButtonClicked()">✖️</button>
    <div class="MAIN-JOIN">
      <div class="element"></div>
      <img class="icon-jam-icons" src="./img/check.png" />
      <div class="section-text">
        <div class="top">
          <div class="main-headline">완료되었습니다!</div>
        </div>
      </div>
      <button class="button">
        <div class="text-container">
          <div class="button-text" onclick='location.href="Login.jsp"'>로그인 하러가기</div>
        </div>
      </button>
    </div>

    <script>
      function closeButtonClicked() {
        // 여기에 닫기 버튼 클릭 시 실행할 동작을 추가합니다.
        console.log("닫기 버튼이 클릭되었습니다!");
        // 예시로 콘솔에 메시지를 출력하도록 했습니다.
      }
    </script>
		
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