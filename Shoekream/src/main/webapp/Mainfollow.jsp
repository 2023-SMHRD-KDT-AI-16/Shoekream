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
.menubtn {
    position: absolute; /* 고정 위치에서 상대 위치로 변경 */
    top: 20px; /* 원하는 위치로 조정 */
    right: 20px; /* 사이드바 내부에서의 위치 조정 */
    z-index: 100; /* 필요에 따라 조정 */
}

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
/*사이드바*/
.menubtn {
    position: absolute; /* 고정 위치에서 상대 위치로 변경 */
    top: 20px; /* 원하는 위치로 조정 */
    right: 20px; /* 사이드바 내부에서의 위치 조정 */
    z-index: 100; /* 필요에 따라 조정 */
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
	color: black;
	
}

/*팔로우 팔로워 폰트 수정*/
.my {font-weight:revert-layer;
	font-size: x-large;
	color: black;
	margin:10px;
	 display: flex;
    justify-content: center; 
}

}
h5 {span { font-weight:revert-layer;
	font-size: x-large;
	margin: auto;
	color: black;
}

}
a {
	text-decoration: none;
	color: #222;
}

#profile_wrap {
	width: 360px;
	margin-left: 40px;
	    display: fixed;
    justify-content: center; /* 수평 가운데 정렬 */
    flex-direction: column; /* 자식 요소를 세로로 정렬 */
    margin-top: 20px; /* 위쪽 여백 */
    margin-bottom: 20px; /* 아래쪽 여백 */
}

#profile_wrap .profile_box1 {
    padding: 60px;
    border-radius: 5%;
    backdrop-filter: blur(15px);
    margin-top: 130px;
   
}

#profile_wrap .profile_box1 .photo {
	width: 150px;
	height: 150px;
	
	border-radius: 50%;
	display: flex;
	flex-flow: row nowrap;
	overflow: hidden;
	margin-left: 10px;
}
#profile{
	width:150px;
	height:150px;
	
}
#profile_wrap .profile_box1 .photo img {
	border: solid 2px #a0b3ce;
	border-radius: 50%;
		 display: flex;
  justify-content: center;
}

#profile_wrap .profile_box1 .right {
	margin-left: 20px;
}

#profile_wrap .profile_box1 .right h1 {
	text-align: center;
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

/* 컨텐츠영역 */
.container {
	display: flex;
	flex-direction: row-reverse;
	width: 1920px;
	height: auto;
	position: relative;
<<<<<<< HEAD
	
=======

	background-size: cover; /* 배경 이미지를 컨테이너에 맞게 조절 */
	background-attachment: fixed; /* 배경 이미지를 화면에 고정 */
>>>>>>> branch 'main' of https://github.com/2023-SMHRD-KDT-AI-16/Shoekream.git
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
		background: #ebf1f7;

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
	border: 1px solid #ffffff;
	border-bottom: 0;
	color: #222;
	font-weight: 900;
	background: #ebf1f7;
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
	background: #2787f5;
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
	margin-top:80px;
	padding: 10px;
	border-bottom:2px solid #a0b3ce;
	width:600px;
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
	border: 1px solid gray; /*이미지 테두리 지정 */
}


.post-content img {
	width: 100%;
	height: auto;
	margin-bottom: 10px;
	
}

.post-footer {
	margin-top: 10px;
	border: 15;
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
	border:2px solid white;
	box-shadow: 1px 2px 5px #a0b3ce;
}

.head {
	cursor: pointer;
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
	margin-right: 5px;
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
	background-color: #2787f5; /* 마우스 호버 시 배경색 변경 */
	margin: 1px;
	transition: .35s;
}

#emo_post2 {
	margin-left: 5px;
	margin-right: 15px;
}

/*신발 검색 옵션*/

#shoesOptions{
width:800px;
height:auto;
display: block;
font-size:5px;
}


.select2-results__option{
width:800px;
height:auto;
font-size:16px;
color:gray;
}


/* 신발 이미지 */
img {
	cursor: pointer;
	wedth:70px;
	height:70px;

}

/*게시글 모달*/
.modal2{
max-width:1200px !important;
height:800px;
}

/*전체 검색*/
#Search{
width:600px;
height:auto;
display: block;
font-size:4px;
color: black;
}

#modalContainer {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5); /* 배경을 반투명한 검은색으로 설정 */
    z-index: 999; /* 다른 요소들보다 위에 나타나도록 설정 */
    display: flex;
    justify-content: center;
    align-items: center;
}

#modalContent {
    background-color: #fff; /* 모달 내용의 배경색을 흰색으로 설정 */
    padding: 20px;
    border-radius: 10px;
}

#modalCloseButton {
    position: absolute;
    top: 10px;
    right: 10px;
    background-color: transparent;
    border: none;
    cursor: pointer;
}


.likes{
font-size:30px
}

#shoekreamImg{
    width: 300px;
    height: 150px;
    margin-top: -10px;
    margin-left:20px;
}

#profile_wrap .profile_box1 .right h1 {
    margin-bottom: 10px; /* 이름과 다음 항목 사이의 간격 */
}


</style>

</head>
<body>
	<%
	if(request.getParameter("post_result")!=null){
	if(request.getParameter("post_result").equals("1")){
		PrintWriter out2 = response.getWriter();
		String script = "<script>alert('게시글이 등록되었습니다');</script>";
		out.println(script);
	}	
	}
	
	//세션에 저장된 로그인한 유저의 정보 불러오기 
	UserDTO user_info = (UserDTO) session.getAttribute("user_info");
	%>


	<!-- 왼쪽 상단 메뉴 아이콘 -->
	<input type="checkbox" id="menuicon" checked>
	
	
	<header>
		<div>
			<ul class="navi">

				<!-- 메뉴아이콘 -->
				<label for="menuicon" class="menubtn"> <span></span> <span></span>
					<span></span>
				</label>
				<li class="logo" style="position: fixed"><a href="Main.jsp"><img id="shoekreamImg" src = "img/슈크림.jpg"></a></li>
				<!-- 슈크림 메인 로고  -->
				
			</ul>			
		</div>
	</header>
	

	<!-- ----------------------------------- -->	
	
	<div class="container">
		<div class="content" style="height: auto; margin-left: 320px; margin-top:70px">
		<select id="Search" name="selectedSearch" multiple="multiple" data-placeholder="&#128269; 닉네임 또는 신발 이름을 검색하세요"> </select>
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
				name="accordion" id="answer00"> 

			<input type="checkbox" name="accordion" id="answer01"> <label
				for="answer01"><span id="emo"><a href="Main.jsp">&#127968;</a></span><a href="Main.jsp">홈</a><em></em></label> <input
				type="checkbox" name="accordion" id="answer02"> <label
				for="answer02"><span id="emo_post"> <a href="javascript:writePost()">&#9997;</a></span><a href="javascript:writePost()">게시글작성</a> <em></em></label> <input type="checkbox"
				name="accordion" id="answer03"> <label for="answer03"><span
				id="emo"><a href="Mainfollow.jsp">🙂</a></span>
					<a href="Mainfollow.jsp">팔로우 </a>
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

		<div id="profile_wrap">
		<a href="MypageService?post_userid=<%=user_info.getUserId()%>">
			<div class="profile_box1">
				<div class="photo">
					<img id="profile" src="img/<%=user_info.getUserProfileImg()%>" alt="프로필이미지" style="width:150px;height:150px">
				</div>
				<br>
				<div class="right">
					<h1><%=user_info.getUserNick()%></h1>
					<!-- 프로필 네임 안에 user_name? user_nickname? -->
					<ul class="my_info">
						<p>
							<span class="my">게시글 <%=countPost%></span> </span>
						</p>
						<p>
							<span ><span class="my">팔로워 <%=countfollower%></span> 
						</p>
						<p>
							<span class="my">팔로우 <%=countfollow%></span>
						</p>
						<!-- 숫자사이에  넣으면 될듯?! -->
					</ul>
				</div>
			</div>
		</div>
		</a>
	</div>






	<!-- -------------------------------------------------------------- -->
	<!-- 게시글 작성 모달창 열기 -->




 <div id="writePost" class="modal2" style="display: none;">
	<iframe src="WritePost.jsp" frameborder="0" style="width: 1200px; height: 800px;"></iframe>
	</div>

 <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
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
            data: { "post_idx": post_userid, "follow": "y" },
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
            data: { "post_idx": post_userid, "follow": "n" },
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
            data: { "post_idx": post_userid, "follow": "n" },
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
            data: { "post_idx": post_userid, "follow": "y" },
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
function toggleLikeN(index,post_idx) {
    var likeButton = document.getElementById('like_' + index);
    likeButton.classList.toggle('active');
    
    var likeCountElement =document.getElementsByClassName('likes')[index]
    var likeCount = parseInt(likeCountElement.textContent);

    
    if (likeButton.classList.contains('active')) {
        // 좋아요를 눌렀을 때
        likeCount += 1;
        likeButton.src='img/빨간색하트.png';
        $.ajax({
            url: "LikeService",
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
        likeButton.src='img/흰색하트.png';
        $.ajax({
            url: "LikeService",
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
function toggleLikeY(index,post_idx) {
    var likeButton = document.getElementById('like_' + index);
    likeButton.classList.toggle('active');
    
    var likeCountElement =document.getElementsByClassName('likes')[index]
    var likeCount = parseInt(likeCountElement.textContent);
    
    if (likeButton.classList.contains('active')) {
         // 좋아요 취소 했을 때
        likeCount -= 1;
        likeButton.src='img/흰색하트.png';
        $.ajax({
            url: "LikeService",
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
        likeButton.src='img/빨간색하트.png';
        $.ajax({
            url: "LikeService",
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

function writeComment(i,postIdx){
	var inputComment = $('[name="comment"]').eq(i).val();
	var comment = document.getElementsByClassName('comment')[i]
	var userNick = "<%=user_info.getUserNick()%>"
	  if(inputComment.trim() !== '') {
	        $.ajax({
	            url: 'WriteCommentService',
	            data: {"postIdx": postIdx, "inputComment": inputComment},
	            type: 'get',
	            success: function(result){
	                console.log("댓글 저장 성공");
	                // 댓글 저장 후 입력 필드 초기화
	                 $('[name="comment"]').eq(i).val('');
	                alert("댓글이 입력되었습니다");
	                comment.innerText = userNick + ": " + inputComment;
	            },
	            error: function(){
	                console.log("댓글 저장 실패");
	            }
	        });
	    } else {
	        alert("댓글을 입력해주세요.");
	    }
	
}


//-----------------------------------------------------------------------------
//게시글 작성 모달
    function writePost() {
	   console.log("게시글 작성")
        $("#writePost").modal({
          fadeDuration: 100,
          fadeDelay: 1,
        });
      }

//--------------------------------------------------------
//포스트(게시글 무한스크롤)
var currentUserId = '<%=user_info.getUserId()%>';
    let page = 0;
	var loading = 'false';
	
    function loadMorePosts() {
		
      const container = document.getElementById("instagram-posts");

      $.ajax({
					url:'getPostService',
					data:{"index":page},
					type:'get',
					success: function(result){
						
						if(result==="오류"){
							loading = 'err'
							alert("마지막 게시글입니다")
						}else{
							
					var post_result =JSON.parse(result)		
				

// 팔로우 버튼 HTML 생성 로직
var followButtonHTML = '';
if(post_result.post_user_id !== currentUserId) {
    var isfollow = post_result.isfollow ? "팔로잉" : "팔로우";
    var togglefollow = post_result.isfollow ? `togglefollowY(${page}, '${post_result.post_idx}')` : `togglefollowN(${page}, '${post_result.post_idx}')`;
    followButtonHTML = `<button id="follow_${page}" onclick="${togglefollow}" style="">${isfollow}</button>`;
} else {
    // 현재 사용자가 게시물 작성자와 같은 경우, 팔로우 버튼을 숨김
    followButtonHTML = `<button id="follow_${page}" style="display: none;">${isfollow}</button>`;
}
					
					//좋아요 여부에 따라 좋아요 버튼 바꾸기
					console.log("좋아요"+post_result.isLike)
					var isLike = post_result.isLike
					var toggleLike = null
					if(post_result.isLike==true){
						isLike="빨간색하트"
						toggleLike=`toggleLikeY(${page}, '${post_result.post_idx}')`
					}else{
						isLike="흰색하트"
						toggleLike=`toggleLikeN(${page}, '${post_result.post_idx}')`
					}
					 if(isfollow==="팔로잉"){
					const postData= `
						<div class="instagram-post">
						  <div class="post-header">
						    <a href="MypageService?post_userid=${post_result.post_user_id}"><img src="img/${post_result.post_profileimg}" alt="프로필 사진"></a>
						    <div class="profile-info">
						      <h2 class="head">${post_result.post_nick} 
						      ${followButtonHTML} 
						      </h2>
						      <p style="margin-left: 400px;">${post_result.posted_at}</p>
						    </div>
						    <div></div>
						  </div>
						  <div class="post-content">
						  <a href="javascript:show(${page})">
						    <img src="post_img/${post_result.post_img}" alt="게시물 이미지" style="box-shadow: 1px 2px 5px #a0b3ce; margin-top:10px;border-radius:5px;height:500px;">
						    </a>
						   
						  
						  <table style="box-shadow: 1px 2px 5px #a0b3ce; border-radius:10px;width: 580px;">
						  
						    ${post_result.shoe_tag1 ? `<tr class="tag"><td style="width:80px"><a href="ShoespageService?shoeId=${post_result.shoe_tag1}"><img id="Shoetag" style="vertical-align: middle;border-radius:3px" src="shoe_img/${post_result.shoe_tag1}.png"/></td><td> <span style="vertical-align: middle;font-size:20px">${post_result.tag1_name}</span></a></td></tr>` : ''}
						    ${post_result.shoe_tag2 ? `<tr class="tag"><td style="width:80px"><a href="ShoespageService?shoeId=${post_result.shoe_tag2}"><img id="Shoetag" style="vertical-align: middle;border-radius:3px" src="shoe_img/${post_result.shoe_tag2}.png"/></td><td> <span style="vertical-align: middle;font-size:20px">${post_result.tag2_name}</span></a></td></tr>` : ''}
						    ${post_result.shoe_tag3 ? `<tr class="tag"><td style="width:80px"><a href="ShoespageService?shoeId=${post_result.shoe_tag3}"><img id="Shoetag" style="vertical-align: middle;border-radius:3px" src="shoe_img/${post_result.shoe_tag3}.png"/></td><td> <span style="vertical-align: middle;font-size:20px">${post_result.tag3_name}</span></a></td></tr>` : ''}
						  
						</table>
						</div>
						  
						<br>
						<p style="font-size:20px"><a href="MypageService?post_userid=${post_result.post_user_id}"><b>${post_result.post_nick}</b></a> : ${post_result.post_content}</p>
						  
					        <div class="post-footer">
						    <div class="emoji-icons" >
						      <box-icon name='heart' class="h" style="margin-left:10px">
						      <span class="likes" style="vertical-align: middle;">${post_result.countlike}</span>
						      <img src='img/${isLike}.png' id="like_${page}" onclick="${toggleLike}" class="heart_comment" style="height:60px;weight:50px;padding:10px;vertical-align: middle;">
						      </box-icon>
						      <a href="javascript:show(${page})">
						      <img src='img/말풍선.png' class="heart_comment" style="height:60px;weight:50px;padding:10px;vertical-align: middle;">
						      </a>
						    </div>
						    <style>
						    /* SVG 이미지에 호버 효과 적용 */
						    .heart_comment:hover {
						        opacity: 0.5; /* 호버 시 투명도 변경 */
						   
						    }
							
						</style>

					       <span></span>
						  	<span class="comment"></span> 
						  	<br>
						    <input type="text" placeholder="댓글을 입력해주세요" id="postchat" name="comment" style="width:500px">
						    <button onclick="writeComment(${page},${post_result.post_idx})">댓글저장</button>  
						      <div id="ex${page}" class="modal2" style="display: none;">
						   <iframe src="PostDetail.jsp?postIdx=${post_result.post_idx}" frameborder="0" style="width: 1200px; height: 800px;"></iframe>

						    </div>
      `;

      
					 // 새로운 포스트를 추가합니다.
      container.innerHTML += postData+'<br>';
      //console.log(postData)	

      
      
      page++;
      loading = 'false'}
					 else{
    	  container.innerHTML += ` <div  style="height:500px;margin-left:200px"><div><br><br><br><br><br><br><br><br><h3>팔로우를 추가해주세요!<h3>`;
      }
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
  if($(window).scrollTop()+300>=$(document).height() - $(window).height())
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
   //모달 여러개...
    function show(num) {
	   console.log("선택")
        $("#ex"+num).modal({
          fadeDuration: 100,
          fadeDelay: 1,
        });
      }
 //-----------------------------------------------------------------------------
 //전체 검색

$(document).ready(function() {
    // Select2 초기화
    $('#Search').select2({
        maximumSelectionLength: 1,
        templateResult: formatSearch, // Customizes option rendering
        templateSelection: formatSelectedSearch // Customizes selected option rendering
    });

    // Select2 항목 선택 이벤트 핸들러 추가
    $('#Search').on('select2:select', function (e) {
        var data = e.params.data;

        // 선택된 항목의 그룹을 확인
        var group = $(data.element).closest('optgroup').attr('label');

        // 선택된 항목에 따라 서블릿 URL 구성
        var servletURL = '';
        if(group === 'Shoes') {
           servletURL = 'ShoespageService?shoeId=' + data.id;
        } else if(group === 'Users') {
          servletURL = 'MypageService?post_userid=' + data.id;
        }

        // 서블릿 URL이 설정되었으면, 해당 URL로 페이지 이동
        if(servletURL !== '') {
            window.location.href = servletURL;
        }
    });

    filterSearch();
});

function filterSearch() {
    // 첫 번째 데이터 소스: 신발 정보
    var shoesPromise = $.ajax({
        url: "ShowShoes",
        type: "get"
    });

    // 두 번째 데이터 소스: 사용자 정보
    var usersPromise = $.ajax({
        url: "SearchService",
        type: "get"
    });

    // 두 요청이 모두 완료되면 실행
    Promise.all([shoesPromise, usersPromise]).then(function(results) {
        // results[0]은 ShowShoes의 결과, results[1]은 SearchService의 결과
        var shoesArr = results[0];
        var usersArr = results[1];

        $('#Search').empty(); // 한 번만 비우고
        
        // 신발 정보 그룹 생성
        var shoesGroup = $('<optgroup label="Shoes"></optgroup>');
        shoesArr.forEach(function(shoe) {
            shoesGroup.append($('<option>', {
                value: shoe.shoe_tag, 
                text: shoe.shoe_name,
                title:shoe.shoe_tag,
            }));
        });
        $('#Search').append(shoesGroup);

        // 사용자 정보 그룹 생성
        var usersGroup = $('<optgroup label="Users"></optgroup>');
        usersArr.forEach(function(user) {
            usersGroup.append($('<option >', {
                value: user.user_id, 
                text: user.user_nick,
                title: user.user_profile_img,
              
            }));
        });
        $('#Search').append(usersGroup);

        // Select2 업데이트
        $('#Search').val(null).trigger('change');
    }).catch(function(error) {
        // 오류 처리
        console.error('Error:', error);
    });
}

function formatSearch(item) {
	var group = $(item.element).closest('optgroup').attr('label');
	console.log("라벨"+group)
   if(group==='Shoes'){
	   var $option = $('<span><img src="shoe_img/' + item.title +'.png" class="user-image" style="width: 70px;border-radius:50%" /> ' + item.text + '</span>');
   }else{
  var $option = $('<span><img src="img/' + item.title + '" class="shoe-image" style="width: 60px;border-radius:50%" /> ' + item.text + '</span>'); }
    
	if(!item.title){
		 $option = $('<span>' + item.text + '</span>');
	}
	
	 $option.css('color', 'black'); // 글자색을 검정색으로 설정
    return $option;
}

function formatSelectedSearch(selection) {
	var group = $(selection.element).closest('optgroup').attr('label');
	console.log("라벨"+group)
   if(group==='Shoes'){
	   var $option = $('<span><img src="shoe_img/' + selection.title +'.png" class="shoe-image" style="width: 70px" /> ' + selection.text + '</span>');
   }else{
  var $option = $('<span><img src="img/' + selection.title + '" class="user-image" style="width: 60px" /> ' + selection.text + '</span>'); }
    
	$option.css({
	    'color': 'black', // 글자색을 검정색으로 설정
	    'font-size': '13px' // 글자 크기를 16px로 설정
	});
	 return $option;
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
<script>
document.getElementById('heart').addEventListener('click', function() {
    this.style.fill = 'red';
});
</script>
	<!--End of Tawk.to Script-->


</body>
</html>ta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>