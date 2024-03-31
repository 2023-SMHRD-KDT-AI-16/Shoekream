<%@page import="com.smhrd.model.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="CSS/ProfileSetting.css">
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
				<li class="logo"><a>SHOEKREAM</a></li>
			</ul>
		</div>
	</header>
					
					<form id="profileForm" action="UpdateService" method="post"
				enctype="multipart/form-data">
	<div class="inputbox">
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
									oninput="pwCheck()" placeholder="한줄소개를 작성해보세요" required>
	 						<%}else{%>	
	 							<input type="text" name="post" id="post" 
									oninput="pwCheck()" value=<%=user_info.getUserInfo() %> required>
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
					<button type="submit" id="join" style="
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
		<span class="area_desc"></span> <input type="checkbox"
			name="accordion" id="answer00"> <label for="answer00"><span
			id="emo">&#128269;</span><input type="text" placeholder="검색"><em></em></label>

		<input type="checkbox" name="accordion" id="answer01"> <label
			for="answer01"><span id="emo"><a href="Main.jsp">&#127968;</a></span><a
			href="Main.jsp">홈</a><em></em></label> <input type="checkbox"
			name="accordion" id="answer02"> <label for="answer02"><span
			id="emo_post"><a id="modalOpenButton">&#9997;</a></span><a
			id="modalOpenButton"> 게시글작성 </a><em></em></label> <input type="checkbox"
			name="accordion" id="answer03"> <label for="answer03"><span
			id="emo"><a href="chat.jsp">&#128172;</a></span> <a href="chat.jsp">채팅방
				가기</a> <em></em></label> <input type="checkbox" name="accordion" id="answer04">
		<label for="answer04"> <span id="emo"><a
				href="MypageService?post_userid=<%=user_info.getUserId()%>">&#128100;</a></span>
			<a href="MypageService?post_userid=<%=user_info.getUserId()%>">프로필</a>
			<em></em></label> <input type="checkbox" name="accordion" id="answer05">
		<label for="answer05"><span id="emo">&#128276;</span>알림<em></em></label>

		<div>
			<p>여기에 내용</p>
		</div>
		<input type="checkbox" name="accordion" id="answer06"> <label
			for="answer06"><span id="emo_post2">&#9776;</span>더보기<em></em></label>

		<div>
			<p>
				<!-- 로그아웃 -->
				<button>
					<a href="LogoutService">로그아웃</a>
				</button>
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