<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="./CSS/JoinSuccess.css" />
<link rel="stylesheet" href="" />
<link rel="stylesheet" href="" />
<style>
body {
    width: 100%; /* 화면 전체 너비를 차지하도록 설정 */
    height: 100%; /* 화면 전체 높이를 차지하도록 설정 */
    margin: 0; /* 바디의 기본 마진을 제거하여 정확한 위치 조절 가능 */
    padding: 0; /* 바디의 기본 패딩을 제거하여 정확한 위치 조절 가능 */
    position: relative;
    background-image: url(img/goodwpss.jpg);
    background-size: cover; /* 배경 이미지를 컨테이너에 맞게 조절 */
    background-attachment: fixed; /* 배경 이미지를 화면에 고정 */
    display: flex;
    justify-content: center; /* 내부 요소를 가운데 정렬 */
    align-items: center; /* 내부 요소를 가운데 정렬 */
}

.MAIN-JOIN {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    gap: 50px;
    padding: 80px 80px 40px;
    position: relative;
    width: 500px;
    border-radius: 5%;
    background-color: #ffffff00;
    border: 4px solid white;
    backdrop-filter: blur(15px);
    color: white;
    height: 600px;
}
  
  .MAIN-JOIN .element {
    position: relative;
    width: 550px;
    height: 80px;
  }
  
  .MAIN-JOIN .icon-jam-icons {
    position: relative;
    width: 124px;
    height: 124px;
  }
  
  .MAIN-JOIN .section-text {
    display: flex;
    flex-direction: column;
    width: 500px;
    align-items: flex-start;
    gap: 48px;
    position: relative;
    flex: 0 0 auto;
  }
  
  .MAIN-JOIN .top {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 8px;
    position: relative;
    align-self: stretch;
    width: 100%;
    flex: 0 0 auto;
  }
  
  .MAIN-JOIN .main-headline {
    position: relative;
    align-self: stretch;
    margin-top: -1px;
    font-family: "Roboto-Bold", Helvetica;
    font-weight: 600;
    color: var(--coolgray-90);
    font-size: 30px;
    text-align: center;
    letter-spacing: 0;
    line-height: 33px;
  }
  
  .MAIN-JOIN .button {
    all: unset;
    box-sizing: border-box;
    display: flex;
    width: 500px;
    height: 50px;
    align-items: center;
    justify-content: center;
    padding: 16px;
    position: relative;
    border: 2px solid;
    border-color: rgb(121, 26, 175);
    
    background-color: rgb(145, 44, 158);
    border-radius: 20px;
  }
  .MAIN-JOIN .button{
	   	
   		cursor: pointer;
   		background-color: rgb(121, 26, 175);
  }
  
  .MAIN-JOIN .text-container {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    gap: 10px;
    padding: 0px 16px;
    position: relative;
    flex: 0 0 auto;
    margin-top: -5px;
    margin-bottom: -5px;
  }
  
  .MAIN-JOIN .button-text {
    position: relative;
    width: fit-content;
    margin-top: -1px;
    font-family: var(--button-l-font-family);
    font-weight: var(--button-l-font-weight);
    color: rgb(255 255 255);
    font-size: var(--button-l-font-size);
    letter-spacing: var(--button-l-letter-spacing);
    line-height: var(--button-l-line-height);
    white-space: nowrap;
    font-style: var(--button-l-font-style);
    border-radius: 5px;
  }
  
  .MAIN-JOIN .icon-ionicons {
    position: absolute;
    width: 40px;
    height: 40px;
    top: 23px;
    left: 27px;
  }
  /* icon / jam-icons / outline & logos / check */
.icon-ionicons{
width: 124px;
height: 124px;
flex: none;
order: 1;
flex-grow: 0;
z-index: 1;

}

/* Inside auto layout */
.close-btn {
 width: 50px;
 height: 50px;
 background-color: #ffffff;
 border: 0;
 color: black;
}

/* Close button hover effect */
.close-btn a:hover {
  cursor: pointer;

}


</style>
</head>
<body>

	<ul class="actions vertical">
		<div class="body">

		<div class="MAIN-JOIN" style="
    margin-left: 0px;
    left: auto;
		">
			<div class="element"></div>
			<img class="icon-jam-icons" src="./img/check.png" />
			<div class="section-text">
				<div class="top">
					<div class="main-headline">완료되었습니다!</div>
					<br>
					<div class="main-bodyline"><%
		String user_name = (String) request.getAttribute("user_name");
		%>
		<li><%=user_name%> 님 환영합니다</li></div>
				</div>
			</div>
			<button class="button">
				<div class="text-container">
					<div class="button-text" onclick='location.href="Login.jsp"'>로그인
						하러가기</div>
				</div>
			</button>
		</div>
		</div>
		<script>
			function closeButtonClicked() {
				// 여기에 닫기 버튼 클릭 시 실행할 동작을 추가합니다.
				console.log("닫기 버튼이 클릭되었습니다!");
				// 예시로 콘솔에 메시지를 출력하도록 했습니다.
			}
		</script>

		

	</ul>
	<script src="assets/js/jquery.min.js"></script>
	<script src="assets/js/jquery.scrolly.min.js"></script>
	<script src="assets/js/jquery.scrollex.min.js"></script>
	<script src="assets/js/skel.min.js"></script>
	<script src="assets/js/util.js"></script>
	<script src="assets/js/main.js"></script>

</body>
</html>