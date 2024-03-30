<%@page import="java.io.PrintWriter"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.smhrd.model.ShoesDAO"%>
<%@page import="com.smhrd.model.ShoesDTO"%>
<%@page import="com.smhrd.model.FollowDAO"%>
<%@page import="com.smhrd.model.FollowDTO"%>
<%@page import="com.smhrd.model.LikeDTO"%>
<%@page import="com.smhrd.model.LikeDAO"%>
<%@page import="com.smhrd.model.CommentDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.smhrd.model.CommentDAO"%>
<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@page import="com.smhrd.model.BoardDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.smhrd.model.BoardDAO"%>
<%@page import="com.smhrd.model.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SHOEKREAM</title>
<style>
input[id="menuicon"] {
	display: none;
}

body {
	width: 1920px;
	height: 100%;
}

/* 헤더 */
header {
	width: 100%;
	background: #ffffff;
}

header>div {
	position: relative;
	width: 1920px;
	margin: 15 auto;
}

header>div ul.navi {
	font-size: 0;
}

header>div ul.navi>li {
	font-size: 50px;
	display: inline-block;
	vertical-align: middle;
}

header>div ul.navi>li>a {
	display: block;
	width: auto;
	padding: 20px;
}

header>div ul.navi>li.logp>a {
	padding: 20px 50px;
	font-size: 20px;
	font-weight: 900;
}

/* 왼쪽 프로필 */
* {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
}

h1 {span { font-weight:revert-layer;
	font-size: x-large;
}

}
h1 {
	color: white;
	margin-left: 45px;
}
/*팔로우 팔로워 폰트 수정*/
span {span { font-weight:revert-layer;
	font-size: x-large;
	margin-left: 10px;
	color: white;
}

}
h5 {span { font-weight:revert-layer;
	font-size: x-large;
	margin: auto;
	color: white;
}

}
a {
	text-decoration: none;
	color: #222;
}

#profile_wrap {
	width: 360px;
	margin-left: 40px;
}

#profile_wrap .profile_box1 {
	padding: 30px;
	border: solid 2px;
	border-color: white;
	border-radius: 5%;
	backdrop-filter: blur(15px);
}

#profile_wrap .profile_box1 .photo {
	width: 150px;
	height: 150px;
	background: white;
	border-radius: 50%;
	display: flex;
	flex-flow: row nowrap;
	overflow: hidden;
	margin-left: 20px;
}

#profile_wrap .profile_box1 .photo img {
	border: solid 3px;
	border-radius: 50%;
}

#profile_wrap .profile_box1 .right {
	
}

#profile_wrap .profile_box1 .right h1 {
	
}

#profile_wrap .profile_box1 .right p {
	
}

#profile_wrap .profile_box1 #open_close {
	
}

#profile_wrap .profile_box2 {
	
}

#profile_wrap .profile_box2 a {
	
}

#postchat {
	border-left-width: 0px;
	border-right-width: 0px;
	border-top-width: 0px;
	border-bottom-width: 0px;
}

/* 각영역의 라벨(중앙정렬) */
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

/* 컨텐츠영역 */
.container {
	display: flex;
	flex-direction: row-reverse;
	width: 1920px;
	height: auto;
	position: relative;
	background-image: url(img/goodwpss.jpg);
	background-size: cover; /* 배경 이미지를 컨테이너에 맞게 조절 */
	background-attachment: fixed; /* 배경 이미지를 화면에 고정 */
}

.container .content {
	width: 800px;
	height: 100px;
	margin: 0 auto;
	min-height: 700px;
	background: #ffffff;
	align-content: center;
}

.container .sidebar {
	position: fixed;
	top: 0;
	right: -300px;
	width: 300px;
	height: 100%;
	/*	background: #ffffff;
	border: 1px solid #eee; */
	z-index: 30;
	transition: .35s;
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
	margin-top: -15px;
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

.instargram-post>div {
	padding-bottom: 30px;
}

.instagram-post {
	margin-bottom: 20px;
	padding: 10px;
}

.post-header {
	display: flex;
	align-items: center;
}

.post-header img {
	width: 50px;
	height: 50px;
	border-radius: 50%;
	margin-right: 10px;
	border: 2px solid black; /*이미지 테두리 지정 */
}

.post-content img {
	width: 100%;
	height: auto;
	margin-bottom: 10px;
}

.post-footer {
	margin-top: 10px;
	border: 15;
	border-bottom: solid 1px;
}

.post-content>img {
	width: 776px;
	height: 800px;
	align-content: center;
	border: solid 1px;
	border-color: #000;
}

.emoji-icons {
	cursor: pointer;
}

.menubtn {
	/* position: fixed; 
	margin-bottom: 800px; */
	
}

.profile_box1 {
	position: fixed;
}

.head {
	cursor: pointer;
}

#modalOpenButton, #modalCloseButton {
	cursor: pointer;
}

#modalContainer {
	width: 100%;
	height: 100%;
	position: fixed;
	top: 0;
	left: 0;
	display: flex;
	justify-content: center;
	align-items: center;
	background: rgba(0, 0, 0, 0.5);
}

#modalContent {
	position: absolute;
	background-color: #ffffff;
	width: 1200px;
	height: 800px;
	padding: 15px;
}

#modalContainer.hidden {
	display: none;
}

.hidden {
	display: none;
}

/*댓글 밑 line*/
element.style {
	padding-bottom: 40px;
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


#shoesOptions{
width:300px;
height:auto;
display: block;
font-size:5px;
}


.select2-results__option{
width:300px;
height:auto;
font-size:16px;
color:gray;
}



</style>

</head>
<body>
	<%
	if(request.getParameter("post_result")!=null){
	if(request.getParameter("post_result").equals("success")){
		PrintWriter out2 = response.getWriter();
		String script = "<script>alert('게시글이 등록되었습니다');</script>";
		out.println(script);
	}	
	}
	
	//세션에 저장된 로그인한 유저의 정보 불러오기 
	UserDTO user_info = (UserDTO) session.getAttribute("user_info");
	%>


	<!-- 왼쪽 상단 메뉴 아이콘 -->
	<input type="checkbox" id="menuicon">

	<header>
		<div>
			<ul class="navi">

				<!-- 메뉴아이콘 -->
				<label for="menuicon" class="menubtn"> <span></span> <span></span>
					<span></span>
				</label>
				<li class="logo"><a>SHOEKREAM</a></li>
				<!-- 슈크림 메인 로고  -->
			</ul>

		</div>
	</header>

	<!-- ----------------------------------------------------------------------- -->

	<div class="container">
		<div class="content" style="height: auto; margin-right: 520px">
			<span class="area_desc"></span>
			<!-- 위에 괄호 안이 content영역 -->
			<div id="instagram-posts">
				<!-- 여기에 포스트가 추가됩니다 -->
			</div>
		</div>


		<!-- ------------------------------------------------------------------------- -->
		<!-- 사이드바  -->

		<div class="sidebar">
			<span class="area_desc"></span> <input type="checkbox"
				name="accordion" id="answer00"> <label for="answer00"><span
				id="emo">&#128269;</span><input type="text" placeholder="검색"><em></em></label>

			<input type="checkbox" name="accordion" id="answer01"> <label
				for="answer01"><span id="emo"><a href="Main.jsp">&#127968;</a></span><a href="Main.jsp">홈</a><em></em></label> <input
				type="checkbox" name="accordion" id="answer02"> <label
				for="answer02"><span id="emo_post"><a
				id="modalOpenButton">&#9997;</a></span><a
				id="modalOpenButton"> 게시글작성 </a><em></em></label> <input type="checkbox"
				name="accordion" id="answer03"> <label for="answer03"><span
				id="emo"><a href="chat.jsp">&#128172;</a></span>
					<a href="chat.jsp">채팅방 가기</a>
				 <em></em></label> 
				<input type="checkbox" name="accordion" id="answer04">
			<label for="answer04">
			<span id="emo"><a href="MypageService?post_userid=<%=user_info.getUserId()%>">&#128100;</a></span>
			<a href="MypageService?post_userid=<%=user_info.getUserId()%>">프로필</a>
			<em></em></label>
																
			<input type="checkbox" name="accordion" id="answer05"> <label
				for="answer05"><span id="emo">&#128276;</span>알림<em></em></label>

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
</script>
		<!-- 이건 뭘까 -->
		<div class="post"></div>

		<!-- ----------------------------------------------------------------------------------------- -->
		<!-- 프로필 영역 -->
		<%
		//게시글 개수 가져오기
		BoardDAO dao = new BoardDAO();
		int countPost = dao.countPost(user_info.getUserId());

		//팔로워 팔로우 수 가져오기
		FollowDAO fdao = new FollowDAO();
		int countfollow = fdao.countfollow(user_info.getUserId());
		int countfollower = fdao.countfollower(user_info.getUserId());
		%>
<a href="MypageService?post_userid=<%=user_info.getUserId()%>">
		<div id="profile_wrap">
			<div class="profile_box1">
				<div class="photo">
					<img src="img/<%=user_info.getUserProfileImg()%>" alt="프로필이미지">
				</div>
				<div class="right">
					<h1><%=user_info.getUserNick()%></h1>
					<!-- 프로필 네임 안에 user_name? user_nickname? -->
					<ul>
						<h5>
							<span>게시글 <%=countPost%></span> </span>
						</h5>
						<h5>
							<span><span>팔로워 <%=countfollower%></span> <span>팔로우
									<%=countfollow%></span>
						</h5>
						<!-- 숫자사이에  넣으면 될듯?! -->
					</ul>
				</div>
			</div>
		</div>
	</div>
</a>





	<!-- -------------------------------------------------------------- -->
	<!-- 게시글 작성 모달창 열기 -->




	<div id="modalContainer" class="hidden">
		<div id="modalContent">

			<!-- <form id="uploadForm" action="WriterService" method="post"
				enctype="multipart/form-data"> -->
				<form id="uploadForm" action="WriterService" method="post" enctype="multipart/form-data"
				>

				<!-- 게시글 파일 선택 -->
				<div id="fileSelectionScreen">
					<input type="file" id="fileInput" name="filename">
					<button type="button" id="nextButton">다음</button>
				</div>

				<!-- 게시글 파일 미리보기, 본문 작성  -->
				<div id="photoPreviewScreen" style="display: none;">
					<table>
						<tr>
							<td rowspan="3"><div id="preview"></div></td>
							<td><img src=<%=user_info.getUserProfileImg()%> alt=""
								style="max-width: 50px; max-height: 50px;" /></td>
							<td><%=user_info.getUserNick()%></td>
						</tr>
						<tr>
							<td colspan="2"><textarea name="content" rows="10"
									style="resize: none;" required></textarea></td>
						</tr>
						<tr>
							<td colspan="2">
								<!-- 신발태그 검색 --> 
								<%
 ShoesDAO sdao = new ShoesDAO();
 ArrayList<ShoesDTO> s_list = sdao.showShoes();
 %> 
								<br> 
								<!-- <select id="shoesOptions" name="selectedShoes" multiple="multiple" data-placeholder="Search for shoes">
								</select> -->
								<select id="shoesOptions" name="selectedShoes" multiple="multiple" data-placeholder="Search for shoes">
								</select>
							</td>
						</tr>
					</table>
					<button type="button" id="prevButton">이전</button>
					<button type="submit">게시글 작성 완료2</button>
			</form>


		</div>
		<button id="modalCloseButton">닫기</button>
	</div>
	</div>


<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-beta.1/dist/css/select2.min.css" rel="stylesheet"/>
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-beta.1/dist/js/select2.min.js"></script>
<script>
    $(document).ready(function() {
        $("body select").msDropDown();
    });
</script>
	<script>

function togglefollowN(page,post_user_id) {
	console.log("togglefollowN")
    var followButton = document.getElementById('follow_' + page);
    followButton.classList.toggle('active');
    var post_userid = post_user_id;
    console.log("togglefollowN , post_userid:"+post_userid)
    if (followButton.classList.contains('active')) {
        followButton.textContent = '팔로잉';
        
        $.ajax({
            url: "FollowService",
            data: { "post_userid": post_userid, "follow": "y" },
            type: 'get',
            success: function (result) {
                console.log("팔로우 DB저장완료");
            },
            error: function () {
                console.log("통신 실패");
            }
        });
        
    } else {
        followButton.textContent = '팔로우';
        $.ajax({
            url: "FollowService",
            data: { "post_userid": post_userid, "follow": "n" },
            type: 'get',
            success: function (result) {
                console.log("팔로우 DB삭제완료");
            },
            error: function () {
                console.log("통신 실패");
            }
        });
    }
}

function togglefollowY(page,post_user_id) {
	console.log("togglefollowY")
	  var followButton = document.getElementById('follow_' + page);
	 followButton.classList.toggle('active');
	    var post_userid = post_user_id;
	    console.log("togglefollowN , post_userid:"+post_userid)
    
    if (followButton.classList.contains('active')) {
		followButton.textContent = '팔로우';
        $.ajax({
            url: "FollowService",
            data: { "post_userid": post_userid, "follow": "n" },
            type: 'get',
            success: function (result) {
                console.log("팔로우 DB삭제완료");
            },
            error: function () {
                console.log("통신 실패");
            }
        });
    } else {
        
        followButton.textContent = '팔로잉';
        
        $.ajax({
            url: "FollowService",
            data: { "post_userid": post_userid, "follow": "y" },
            type: 'get',
            success: function (result) {
                console.log("팔로우 DB저장완료");
            },
            error: function () {
                console.log("통신 실패");
            }
        });
        
    }
}

//------------------------------------------------------------
//좋아요 누른 게시글일때
function toggleLikeN(index) {
    var likeButton = document.getElementById('like_' + index);
    likeButton.classList.toggle('active');
    
    var likeCountElement = likeButton.parentElement.nextElementSibling;
    var likeCount = parseInt(likeCountElement.textContent);
    var post_idx = $('[name="postIdx"]').eq(index).val();
    
    if (likeButton.classList.contains('active')) {
        // 좋아요를 눌렀을 때
        likeCount += 1;
        likeButton.textContent='❤️';
        $.ajax({
            url: "LIkeService",
            data: { "post_idx": post_idx, "like": "y" },
            type: 'get',
            success: function (result) {
                console.log("좋아요 DB저장완료")
            },
            error: function () {
                console.log("통신 실패")
            }
        });
    } else {
        // 좋아요 취소 했을 때
        likeCount -= 1;
        likeButton.textContent='🤍';
        $.ajax({
            url: "LIkeService",
            data: { "post_idx": post_idx, "like": "n" },
            type: 'get',
            success: function (result) {
                console.log("좋아요 삭제 완료")
            },
            error: function () {
                console.log("통신 실패")
            }
        });
    }

    likeCountElement.textContent = likeCount;
}
//좋아요 안누른 게시글 일때
function toggleLikeY(index) {
    var likeButton = document.getElementById('like_' + index);
    likeButton.classList.toggle('active');
    
    var likeCountElement = likeButton.parentElement.nextElementSibling;
    var likeCount = parseInt(likeCountElement.textContent);
    var post_idx = $('[name="postIdx"]').eq(index).val();
    
    if (likeButton.classList.contains('active')) {
         // 좋아요 취소 했을 때
        likeCount -= 1;
        likeButton.textContent='🤍';
        $.ajax({
            url: "LIkeService",
            data: { "post_idx": post_idx, "like": "n" },
            type: 'get',
            success: function (result) {
                console.log("좋아요 삭제 완료")
            },
            error: function () {
                console.log("통신 실패")
            }
        });
    } else {
    	 // 좋아요를 눌렀을 때
        likeCount += 1;
        likeButton.textContent='❤️';
        $.ajax({
            url: "LIkeService",
            data: { "post_idx": post_idx, "like": "y" },
            type: 'get',
            success: function (result) {
                console.log("좋아요 DB저장완료")
            },
            error: function () {
                console.log("통신 실패")
            }
        });
    }

    likeCountElement.textContent = likeCount;
}

//----------------------------------------------------------------
//댓글 달기

function writeComment(i){
	var inputComment = $('[name="comment"]').eq(i).val();
	var postIdx = $('[name="postIdx"]').eq(i).val();
	
	$.ajax({
		//1.어디로 요청할 것인지
		url:'WriteCommentService',
		//2.요청할 데이터 {key:value} --> request객체에 담김
		data:{"postIdx": postIdx, "inputComment": inputComment},
		//3.요청방식
		type:'get',
		//요청에 성공했을때 무엇을 할 것인지
		success: function(result){
			console.log("통신 성공")
				
			
		},
		//요청에 실패했을때
		error:function(){
		console.log("통신 실패")
		}
		
		
	});
	
}


//-----------------------------------------------------------------------------
//게시글 작성 모달창, 게시글 출력
	const modalOpenButton = document.getElementById('modalOpenButton');
	const modalCloseButton = document.getElementById('modalCloseButton');
	const modal = document.getElementById('modalContainer');
	const fileInput = document.getElementById('fileInput');
	const nextButton = document.getElementById('nextButton');
	const prevButton = document.getElementById('prevButton');
	const preview = document.getElementById('preview');
	const fileSelectionScreen = document.getElementById('fileSelectionScreen');
	const photoPreviewScreen = document.getElementById('photoPreviewScreen');

	modalOpenButton.addEventListener('click', () => {
	  modal.classList.remove('hidden');
	  fileSelectionScreen.style.display = 'block'; // Show file selection screen
	  photoPreviewScreen.style.display = 'none'; // Hide photo preview screen
	});

	modalCloseButton.addEventListener('click', () => {
	  modal.classList.add('hidden');
	});

	nextButton.addEventListener('click', () => {
	  // Check if a file is selected
	  if (fileInput.files.length > 0) {
	    // Display the selected image
	    const file = fileInput.files[0];
	    const reader = new FileReader();
	    reader.onload = function(event) {
	      const img = document.createElement('img');
	      img.src = event.target.result;
	      img.style.maxWidth = '100%'; // Adjust as needed
	      preview.innerHTML = ''; // Clear previous preview
	      preview.appendChild(img);
	    };
	    reader.readAsDataURL(file);
	    fileSelectionScreen.style.display = 'none'; // Hide file selection screen
	    photoPreviewScreen.style.display = 'block'; // Show photo preview screen
	  } else {
	    alert('파일을 선택하세요.');
	  }
	});
	
	prevButton.addEventListener('click', () => {
	  // Show file selection screen and hide photo preview screen
	  fileSelectionScreen.style.display = 'block';
	  photoPreviewScreen.style.display = 'none';
	});
	
//----------------------------------------------------------
//신발 정보 검색
$(document).ready(function() {
    $('#shoesOptions').select2({
        maximumSelectionLength: 3,
        templateResult: formatShoeOption, // Call the formatShoeOption function to customize option rendering
        templateSelection: formatSelectedShoeOption // Call the formatSelectedShoeOption function to customize selected option rendering
    });
    
    // Call filterShoes function initially
    filterShoes();
});

function filterShoes() {
    $.ajax({
        url: "ShowShoes",
        type: "get",
        success: function(result) {
            console.log(result);
            var arr = result;

            $('#shoesOptions').empty();
            arr.forEach(function(shoes) {
                $('#shoesOptions').append($('<option>', {
                    value: shoes.shoe_tag, 
                    text: shoes.shoe_name,
                    title: shoes.shoe_img
                }));
            });
            
            // Refresh Select2 to reflect the updated options
            $('#shoesOptions').trigger('change');
        }
    });
}

function formatShoeOption(shoe) {
    if (!shoe.id) {
        return shoe.text; // Option without an image (placeholder)
    }

    var $option = $('<span><img src="shoe_img/' + shoe.id + '.png" class="shoe-image" style="width: 70px" /> ' + shoe.text + '</span>');
  
    return $option;
}

function formatSelectedShoeOption(selection) {
    if (!selection.id) {
        return selection.text; // Placeholder option
    }

    var $selection = $('<span><img src="shoe_img/' + selection.id + '.png" class="shoe-image" style="width: 70px" /> ' + selection.text + '</span>');
    return $selection;
}
//--------------------------------------------------------
//포스트(게시글 무한스크롤)
    let page = 0;
	var loading = 'false';
	console.log("Test2")
    function loadMorePosts() {
		console.log("Test2")
      const container = document.getElementById("instagram-posts");

      $.ajax({
					url:'getPostService',
					data:{"index":page},
					type:'get',
					success: function(result){
						console.log(result)
						if(result==="오류"){
							loading = 'err'
							alert("마지막 게시글입니다")
						}else{
							
					var post_result =JSON.parse(result)		
					console.log("result"+result)
					
					//follow여부에 따라 follow버튼 바꾸기
					var isfollow = post_result.isfollow
					var togglefollow = null
					console.log(isfollow)
					if(!isfollow){
						isfollow="팔로우"
						console.log(post_result.post_user_id)
							togglefollow = `togglefollowN(${page}, '${post_result.post_user_id}')`;
					}else{
						isfollow="팔로잉"
						togglefollow=`togglefollowY(${page},'${post_result.post_user_id}')`
					}
					
					 
					const postData= `
						<div class="instagram-post">
						  <div class="post-header">
						    <a href="MypageService?post_userid=${post_result.post_user_id}"><img src="img/${post_result.post_profileimg}" alt="프로필 사진"></a>
						    <div class="profile-info">
						      <h2 class="head">${post_result.post_nick} 
						        <button id="follow_${page}" onclick="${togglefollow}">${isfollow}</button> 
						        <span class="icon">❤️</span> 
						        <svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" viewBox="0 0 24 24" style="fill: rgba(0, 0, 0, 1); margin-left: 500px; transform: ;msFilter:;">
						          <path d="M12 10c-1.1 0-2 .9-2 2s.9 2 2 2 2-.9 2-2-.9-2-2-2zm6 0c-1.1 0-2 .9-2 2s.9 2 2 2 2-.9 2-2-.9-2-2-2zM6 10c-1.1 0-2 .9-2 2s.9 2 2 2 2-.9 2-2-.9-2-2-2z"></path>
						        </svg>
						      </h2>
						      <p>${post_result.posted_at}</p>
						    </div>
						    <div></div>
						  </div>
						  <div class="post-content">
						    <img src="post_img/${post_result.post_img}" alt="게시물 이미지">
						  </div>
						  ${post_result.shoe_tag1 ? `<img src="shoe_img/${post_result.shoe_tag1}.png"/> <p>${post_result.tag1_name}</p>` : ''}
					        ${post_result.shoe_tag2 ? `<img src="shoe_img/${post_result.shoe_tag2}.png"/> <p>${post_result.tag2_name}</p>` : ''}
					        ${post_result.shoe_tag3 ? `<img src="shoe_img/${post_result.shoe_tag3}.png"/> <p>${post_result.tag3_name}</p>` : ''}
						  <div class="post-footer">
						    <div class="emoji-icons">
						      <box-icon name='heart' class="h">
						        <svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" viewBox="0 0 24 24" style="fill: rgba(0, 0, 0, 1);transform: ;msFilter:;">
						          <path d="M12 4.595a5.904 5.904 0 0 0-3.996-1.558 5.942 5.942 0 0 0-4.213 1.758c-2.353 2.363-2.352 6.059.002 8.412l7.332 7.332c.17.299.498.492.875.492a.99.99 0 0 0 .792-.409l7.415-7.415c2.354-2.354 2.354-6.049-.002-8.416a5.938 5.938 0 0 0-4.209-1.754A5.906 5.906 0 0 0 12 4.595zm6.791 1.61c1.563 1.571 1.564 4.025.002 5.588L12 18.586l-6.793-6.793c-1.562-1.563-1.561-4.017-.002-5.584.76-.756 1.754-1.172 2.799-1.172s2.035.416 2.789 1.17l.5.5a.999.999 0 0 0 1.414 0l.5-.5c1.512-1.509 4.074-1.505 5.584-.002z"></path>
						        </svg>
						      </box-icon>
						      <svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" viewBox="0 0 24 24" style="fill: rgba(0, 0, 0, 3);transform: ;msFilter:;">
						        <path d="M12 2C6.486 2 2 5.589 2 10c0 2.908 1.898 5.516 5 6.934V22l5.34-4.005C17.697 17.852 22 14.32 22 10c0-4.411-4.486-8-10-8zm0 14h-.333L9 18v-2.417l-.641-.247C5.67 14.301 4 12.256 4 10c0-3.309 3.589-6 8-6s8 2.691 8 6-3.589 6-8 6z"></path>
						      </svg>
						    </div>
						    
						    <span class="likes">${post_result.countlike}</span>
						    <br>
						    ${post_result.cmtcontent?`<span class="comments">${post_result.cmtcontent}</span>`:''}
						    <br>
						    <p>게시글내용${post_result.post_content}</p>
						    <input type="text" placeholder="댓글달기..." id="postchat">
						    <button id="openModal">전송</button>  
						    
						    <h1 class="postDetailbtn">멀티 모달창</h1>
						    <div class="postDetailmodal">
						    <div class="postDetailmodal-content">
					        <span class="postDetailmoalclose">&times;</span>                         
					        <p>${page} 번째 Modal</p>
					      </div>
					    </div>
						  </div>
						</div>
      `;
	 			
      
					 // 새로운 포스트를 추가합니다.
      container.innerHTML += postData+'<br>';
      //console.log(postData)	

      page++;
      loading = 'false'
      ;}
					},
					//요청에 실패했을때
					error:function(){
						alert("통신 실패");
					}

				});
      

	
    }

    // 스크롤 이벤트를 감지하여 무한 스크롤 함수를 호출
$(window).scroll(function(){
  if($(window).scrollTop()+200>=$(document).height() - $(window).height())
   {
      if(loading==='false')    //실행 가능 상태라면?
        {
           loading = true; //실행 불가능 상태로 변경
            loadMorePosts(); 
        }
        else if(loading==='true')           //실행 불가능 상태라면?
        {
            console.log('다음페이지를 로딩중입니다.');  
        }
    }
});

    // 페이지 로드 시 초기 포스트들을 로드
    loadMorePosts();

    
 //------------------------------------------------------------------------

    
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

	<!--End of Tawk.to Script-->


</body>
</html>