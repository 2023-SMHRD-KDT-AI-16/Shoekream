<%@page import="com.smhrd.model.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
a{
	text-decoration: none !important;
	color: black;
	z-index:30;
}
input[id="menuicon"] {display: none;}
body{
	width: 1920px; height: 100%;
}
.container {
	display: flex;
	flex-direction: row-reverse;
	width: 1920px;
	height: 1080px;
	position:relative;
	background-image: url('./goodwpss.jpg'); /* 원하는 배경 이미지로 변경 */
	background-size: cover; /* 배경 이미지를 컨테이너에 맞게 확대/축소 */
	background-position: center; /* 배경 이미지 위치를 가운데 정렬 */
	background-attachment: fixed; /* 배경 이미지를 고정시킴 */
  }
  .profile_box1, .inputbox {
    height: 40px; /* 예시로 100px로 설정합니다. 필요에 따라 조절하세요. */
}



/* 헤더 */
header {width: 100%;background: #ffffff;}
header > div {position: relative; width: 1920px;   margin:15 auto;}
header > div ul.navi{font-size: 0;}
header > div ul.navi > li{font-size: 50px; display: inline-block; vertical-align: middle;}
header > div ul.navi > li > a {display: block; width: auto; }
header > div ul.navi > li.logp > a{padding: 20px 50px; font-size: 20px; font-weight: 900;}




/* 프로필 박스 안에 있는 요소들을 가운데 정렬 */
.profile_box1 {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    text-align: center; /* 요소들의 텍스트를 중앙 정렬 */
}

/* 프로필 박스 사진 요소 스타일 수정 */
#profile_wrap .profile_box1 .photo {
    width: 300px;
    height: 300px;
    background: rgb(200, 154, 226);
    display: flex;
    justify-content: center;
    align-items: center;
    border-radius: 50%;
    border: 2px solid;
}

/* 프로필 박스 사진 요소 이미지 스타일 수정 */
#profile_wrap .profile_box1 .photo img {
    width: 100%;
    height: auto;
    border-radius: 50%;
}


/* 각영역의 라벨(중앙정렬) 사이드바*/
.area_desc {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	font-size: 20px;
}

/* 메뉴버튼 */
.menubtn {
	display: block;
	width: 50px;
	height: 50px;
	position: fixed;
	top: 50px;
	right: 16%;
	transform: translateY(-50%);
	cursor: pointer;
	z-index: 100;
}

.menubtn span {
	display: block;
	position: absolute;
	width: 80%;
	height: 5px;
	border-radius: 30px;
	background: #222;
	transition: all .35s;
}

.menubtn span:nth-child(1) {
	top: 20%;
	left: 50%;
	transform: translateX(-50%);
}

.menubtn span:nth-child(2) {
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
}

.menubtn span:nth-child(3) {
	bottom: 20%;
	left: 50%;
	transform: translatex(-50%);
}



/* 체크 변화값 */
input[id=menuicon]:checked ~ header .menubtn {
	z-index: 2;
}

input[id=menuicon]:checked ~ header .menubtn span:nth-child(1) {
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%) rotate(135deg);
}

input[id=menuicon]:checked ~ header .menubtn span:nth-child(2) {
	left: 50%;
	transform: translate(-50%, -50%) scale(2);
	opacity: 0;
}

input[id=menuicon]:checked ~ header .menubtn span:nth-child(3) {
	bottom: 50%;
	left: 50%;
	transform: translate(-50%, -50%) rotate(-135deg);
}

input[id=menuicon]:checked ~ .container .sidebar {
	right: 0;
}
/* 메뉴 버튼 기능구현 */
input[id*="answer"] {
	display: none;
}

input[id*="answer"]+label {
	display: block;
	padding: 20px;
	border: 1px solid #292626;
	border-bottom: 0;
	color: #312c2c;
	font-weight: 900;
	background: rgb(247, 239, 245);
	cursor: pointer;
	position: relative;
}

input[id*="answer"]+label em {
	position: absolute;
	top: 50%;
	right: 10px;
	width: 30px;
	height: 30px;
	-top: -15px;
	display: inline-block;
	background: url(/MAIN/icon.png) 0 0 no-repeat;
}

input[id*="answer"]+label+div {
	max-height: 0;
	transition: all .35s;
	overflow: hidden;
	background: #edf8ff;
	font-size: 11px;
}

input[id*="answer"]+label+div p {
	display: inline-block;
	padding: 20px;
}

input[id*="answer"]:checked+label+div {
	max-height: 100px;
}

input[id*="answer"]:checked+label  em {
	background-position: -30px;
}

/* 팔로우 버튼 */
follow_0 {
	height: 20px;
}
/*이모티콘 마진 적용*/
#emo {
	margin-right: 10px;
}

#emo_post {
	margin-right: 5px;
}
/* 이모티콘의 크기 조절 */
.sidebar label span {
	font-size: 24px; /* 이모티콘의 크기를 24px로 설정 */
}

.sidebar label {
	display: block;
	padding: 10px;
	transition: background-color 0.3s ease; /* 배경색 변경 애니메이션 */
}

.sidebar label:hover {
	background-color: pink; /* 마우스 호버 시 배경색 변경 */
	margin: 1px;
	transition: .35s;
}

#emo_post2 {
	margin-left: 5px;
	margin-right: 15px;
}


/* 프로필 웹 스타일 수정 */
 #profile_wrap {
    width: 1000px;
    margin-bottom: 20px;
    border: 1px solid rgb(0, 0, 0);
    margin-right: 500px;
    margin-top: 20px
}
/* 사이드바 스타일 수정 */
.sidebar {
    width: 300px;
    height: 100%;
    background: #ffffff;
    border: 1px solid #eee;
    z-index: 30;
    transition: .35s;
    position: fixed;
    top: 0;
    right: 0; /* 이 부분을 수정하여 사이드바를 오른쪽으로 이동 */
}
/* 메뉴 아이콘 체크 시 사이드바를 오른쪽으로 나타나게 함 */
#menuicon:checked ~ .sidebar {
    right: 0;
}

/* 메뉴 아이콘 체크하지 않은 경우 사이드바를 화면 밖으로 숨김 */
#menuicon:not(:checked) ~ .sidebar {
    right: -300px;
}

section {
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
    width: 100%;
    background: url('./goodwpss.jpg') no-repeat;
    background-position: center;
    background-size: cover;
}

.form-box{
    position: relative;
    width: 600px;
    height: 800px;
    background: transparent;
 
    border-radius: 20px;
    backdrop-filter: blur(15px);
    display: flex;
    justify-content: center;
    align-items: center;

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
    top: 0px;
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


.register{
    font-size: .9em;
    color: #fff;
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
   #checkbutton {
        background-color: black; /* 배경을 투명하게 설정 */
        border: none; /* 테두리 제거 */
    }

    #checkbutton:hover {
        color: blue; /* 호버 시 텍스트 색상 변경 */
    }
#join {
   
    border: none; /* 테두리 제거 */
    width: 212px;
    height: 32px;
    margin-top: 10px;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s ease; /* 배경색 변화에 대한 부드러운 전환 설정 */
}
#join:hover {
    background-color: rgb(180, 180, 180); /* 호버 시 배경색 변경 */
}

#btn1:hover{
	 background-color: rgb(180, 180, 180); /* 호버 시 배경색 변경 */
}

</style>
<style type="text/css">
/* 추가한 스타일 */
.hidden {
	display: none;
}
</style>
</head>
<body>
	<%
	//세션에 저장된 로그인한 유저의 정보 불러오기 
	UserDTO user_info = (UserDTO) session.getAttribute("user_info");
	%>
	<input type="checkbox" id="menuicon">
	<header>
		<div>
			<ul class="navi">
				<!-- 메뉴아이콘 -->
				<label for="menuicon" class="menubtn"> <span></span> <span></span>
					<span></span>
				</label>
				<li class="logo"><a href="Main.jsp"><img id="shoekreamImg" src = "img/슈크림.jpg" style="    width: 360px; 
    margin-left: 40px;
				"></a></li>
			</ul>
		</div>
	</header>
					
					<form id="profileForm" action="UpdateService" method="post"
				enctype="multipart/form-data">
	
		<div class="container">
			<div id="profile_wrap" style="width: 1000px; height: auto;">
				<div class="profile_box1" style="width: 1000px; height: auto; margin-top: 20px;">
					<div class="photo"
						style="width: 300px; height: 300px; border-radius: 50%; border: 2px soild">
						<img src="img/<%=user_info.getUserProfileImg() %>" alt="프로필사진"
							style="width: 300px; height: 300px; border-radius: 50%;">

					</div>
					
					<button id="btn1"  style="
  border: none; /* 테두리 제거 */
    width: 212px;
    height: 32px;
    margin-top: 10px;
    border-radius: 5px;
        cursor: pointer;
          transition: background-color 0.3s ease; /* 배경색 변화에 대한 부드러운 전환 설정 */
					">사진추가</button>
					<div class="right">
					
							<div class="inputbox">

								<input type="text" name="user_nick" value=<%=user_info.getUserName() %>
									required ><label for="">변경할 닉네임*</label>
							
						</div>
							<div class="inputbox">
	
	 						<%if(user_info.getUserInfo()==null){%>
	 								<input type="text" name="post" id="post" 
									 placeholder="한줄소개를 작성해보세요" required>
	 						<%}else{%>	
	 							<input type="text" name="post" id="post" 
									 value=<%=user_info.getUserInfo() %> required>
							<%}%>
							
								<label for="">소개글*</label>
							</div>
				
					<form>
					<div class="inputbox">
						
						<input type="password" name="user_pw" id="user_pw"
							oninput="pwCheck()" placeholder="영어,숫자 조합으로 8~16자" required>
						<label for="">비밀번호*</label>
					</div>
					<div class="inputbox">


						<input type="password" name="user_pw_check" id="user_pw_check"
							oninput="pwCheck()" placeholder="동일하게 입력해주세요" required> <label
							for="">비밀번호 재확인*</label> <span id="pwConfirm"></span>

					</div>
					<div class="inputbox">

						<input type="" name="user_email"
							value=<%=user_info.getUserEmail() %> required> <label
							for="">이메일*</label>
					</div>

					<div class="inputbox">

						<input type="text" name="user_phone"
							value=<%=user_info.getUserPhone() %> required> <label for="">휴대폰번호*</label>
					</div>
					<div class="inputbox">

						<input type="text" name="user_name" value=<%=user_info.getUserName() %> required>
						<label for="">이름*</label>
					</div>
					<input type="file" id="profileImageUpload" name="profileImage" style="display: none;" accept="image/*" />
					<button type="submit" onclick="success()" id="join" style="
   border: none; /* 테두리 제거 */
    width: 212px;
    height: 32px;
    margin-top: 10px;
    border-radius: 5px;
        cursor: pointer;
					">프로필 수정하기</button>
					</form>
				</div>
				
			</div>	
				<br>

				<!-- 프로필 네임 안에 user_name? user_nickname? -->

			</div>
		</div>
	</div>


	
		<div class="sidebar">
			<span class="area_desc"></span> 
		
			
			<input type="checkbox" name="accordion" id="answer01"> <label
				for="answer01"><span id="emo"><a href="Main.jsp">&#127968;</a></span><a href="Main.jsp">홈</a><em></em></label> <input
				type="checkbox" name="accordion" id="answer02"> <label
				for="answer02"><span id="emo_post"> <a href="javascript:writePost()">&#9997;</a></span><a href="javascript:writePost()">게시글작성</a> <em></em></label> <input type="checkbox"
				name="accordion" id="answer03"> <label for="answer03"><span
				id="emo"><a href="chat.jsp">&#128172;</a></span>
					<a href="chat.jsp">채팅방 가기</a>
				 <em></em></label> 
				<input type="checkbox" name="accordion" id="answer04">
			<label for="answer04">
			<span id="emo"><a href="MypageService?post_userid=<%=user_info.getUserId()%>">&#128100;</a></span>
			<a href="MypageService?post_userid=<%=user_info.getUserId()%>">프로필</a>
			<em></em></label>
																
			<input type="checkbox" name="accordion" id="answer06"> <label
				for="answer06"><span id="emo_post2">&#9776;</span>더보기<em></em></label>
	
			<div>
				<p>
						<a href="LogoutService">로그아웃</a>
				</p>
			</div>
		</div>
</body>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>	
//모든 메뉴 아이템 요소를 가져옵니다.
const menuItems = document.querySelectorAll('.sidebar input[type="checkbox"]');

// 각 메뉴 아이템에 클릭 이벤트를 추가합니다.
menuItems.forEach(item => {
    item.addEventListener('click', function() {
        // 클릭된 요소의 형제 요소에 대한 클래스를 제거합니다.
        const siblings = getSiblings(this.parentElement);
        siblings.forEach(sibling => {
            sibling.classList.remove('active');
        });
        // 클릭된 요소에 active 클래스를 추가합니다.
        this.parentElement.classList.add('active');
    });
});

// 요소의 형제 요소를 가져오는 함수
function getSiblings(element) {
    const siblings = [];
    let sibling = element.parentNode.firstChild;
    while (sibling) {
        if (sibling.nodeType === 1 && sibling !== element) {
            siblings.push(sibling);
        }
        sibling = sibling.nextSibling;
    }
    return siblings;
}

//----------------------------------------------------------------
//비밀번호 재확인
     function pwCheck(){
         if($('#user_pw').val()==$('#user_pw_check').val()){
            $('#pwConfirm').text("비밀번호가 일치합니다").css('color','green')
         }else{
            $('#pwConfirm').text('비밀번호가 일치하지 않습니다.').css('color','red')         
         }
      }

//---------------------------------------------------------------------------
//프로필 이미지 사진 변경, 미리보기
// 버튼 클릭 이벤트 리스너 추가
document.getElementById('btn1').addEventListener('click', function() {
    document.getElementById('profileImageUpload').click(); // 숨겨진 input 클릭 트리거
});

// 파일 선택 시 미리보기 기능
document.getElementById('profileImageUpload').addEventListener('change', function(event) {
    var reader = new FileReader(); // 파일을 읽기 위한 FileReader 객체 생성
    reader.onload = function(e) {
        // FileReader가 파일을 읽었을 때 실행될 콜백
        var previewImage = document.querySelector('.photo img'); // 미리보기 이미지 태그 선택
        previewImage.src = e.target.result; // 이미지 태그의 src 속성을 읽은 파일의 내용으로 설정
    };
    reader.readAsDataURL(event.target.files[0]); // 선택한 파일을 Data URL 형태로 읽음
});

function success(){
	alert("프로필이 수정되었습니다")
}

</script>
<script type="text/javascript">
var Tawk_API=Tawk_API||{}, Tawk_LoadStart=new Date();
(function(){
var s1=document.createElement("script"),s0=document.getElementsByTagName("script")[0];
s1.async=true;
s1.src='https://embed.tawk.to/660219b7a0c6737bd1249071/1hps38u1h';
s1.charset='UTF-8';
s1.setAttribute('crossorigin','*');
s0.parentNode.insertBefore(s1,s0);
})();

</script>


</body>
</html>