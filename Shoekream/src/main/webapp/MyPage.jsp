<%@page import="com.smhrd.model.ShoesDTO"%>
<%@page import="com.smhrd.model.ShoesDAO"%>
<%@page import="com.smhrd.model.UserDTO"%>
<%@page import="com.smhrd.model.BoardDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<link rel="stylesheet" href="">

<style type="text/css">
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

h1 {
	font-weight: normal;
	font-size: x-large;
}

a {
	text-decoration: none;
	color: #222;
}

#profile_wrap {
	width: 360px;
}

#profile_wrap .profile_box1 {
	padding: 30px;
	/* border: 1px solid #555;  테두리 지정 */
	font-size: x-large;
}

#profile_wrap .profile_box1 .photo {
	width: 150px;
	height: 150px;
	background: lightgreen;
	border-radius: 50%;
	display: flex;
	flex-flow: row nowrap;
	overflow: hidden;
}
/* 컨텐츠영역 */
.container {
	display: flex;
	flex-direction: row-reverse;
	width: 1600px;
	position: relative;
}

.container .content {
	width: 800px;
	height: 900px;
	margin-top: 350px;
	min-height: 700px;
	border-top: 4px #222;
	background: #ffffff;
	align-content: center;
	flex: content rebv;
}


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
	margin-top: -15px;
	display: inline-block;
	background: (/MAIN/icon.png) 0 0 no-repeat;
}

input[id*="answer"]+label+div {
	max-height: 0;
	transition: all .35s;
	overflow: hidden;
	background: rgb(247, 239, 245);
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
	width: 360px;
	margin: 0 auto; /* 화면 가운데 정렬을 위한 margin 설정 */
	margin-bottom: 20px; /* 적당한 간격 설정 */
}

/* 컨테이너와 콘텐츠 배치 */
.container {
	display: flex;
	flex-direction: column; /* 세로 정렬로 변경 */
	align-items: center; /* 가운데 정렬 */
}

.container .content {
	width: calc(100% - 20px); /* 화면 전체 너비에서 여백 고려하여 콘텐츠 영역의 너비 계산 */
	height: 900px;
	margin-top: 20px; /* 적절한 간격 설정 */
	min-height: 700px;
	border-top: 2px solid #222;
	/* 테두리 지정 border: 1px solid #835151; */
	background: #ffffff;
	align-content: center;
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

/* =============================================================================================== */

/* 콘텐츠 영역 스타일 */
.content {
	display: grid;
	grid-template-columns: repeat(3, 1fr); /* 3열 그리드 */
	gap: 20px; /* 각 그리드 아이템 사이의 간격 */
	padding: 20px;
}

/* 각 그리드 아이템 스타일 */
.post-item {
	border: 1px solid #ccc;
	padding: 20px;
	text-align: center;
}

/* 이미지가 있는 경우 */
.post-item img {
	max-width: 350px;
	height: 400px;
}
/* 마이페이지 콘텐츠영역 */
/* 스타일 수정 */
.area_desc {
	display: none; /* 불필요한 요소 숨김 */
}

.grid-container {
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	gap: 20px;
	margin-top: 20px;
}

/* 게시글 스타일 수정 */
.grid-container>div {
	height: 350px; /* 게시글 영역 높이 수정 */
	width: 400px; /* 게시글 영역 너비 수정 */
	/* 게시글 배경    background-color: #555; */
	display: flex; /* 게시글 가로 배열 */
	justify-content: center;
	align-items: center;
	/* justify-content: 주축(main axis)을 따라서 요소들의 정렬 방식을 지정합니다. 주축은 Flexbox 컨테이너의 방향에 따라 다르게 결정됩니다. 주로 수평 방향으로 요소를 정렬하는 데 사용됩니다.

    center: 요소들을 컨테이너의 가운데로 정렬합니다.
    align-items: 교차축(cross axis)을 따라서 요소들의 정렬 방식을 지정합니다. 주로 수직 방향으로 요소를 정렬하는 데 사용됩니다.

    center: 요소들을 컨테이너의 가운데로 정렬합니다. */
	color: white; /* 글자 색 */
	font-size: 24px; /* 폰트 사이즈 */
	margin-left: 80px; /* 게시글 마진 왼쪽*/
	margin-top: 10px;
}
/* 게시글 사진 크기 지정 한번에 안되서 각각 지정할게요 */
.my_post1>img {
	width: 350px;
	height: 350px;
	cursor: pointer;
}

.my_post2>img {
	width: 350px;
	height: 350px;
	cursor: pointer;
}

.my_post3>img {
	width: 350px;
	height: 350px;
	cursor: pointer;
}

.my_post4>img {
	width: 350px;
	height: 350px;
	cursor: pointer;
}

.my_post5>img {
	width: 350px;
	height: 350px;
	cursor: pointer;
}

.my_post6>img {
	width: 350px;
	height: 350px;
	cursor: pointer;
}
/* 프로필 화면에 닉네임 , 게시글, 팔로우, 팔로잉, 환경설정 포인터 적용 */
.right {
	cursor: pointer;
}

<!--
기본 값 -->.grid-container {
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	gap: 20px;
	margin-top: 20px;
	height: 100vh;
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
	width: 600px;
	height: auto;
	padding: 15px;
}

#modalContainer.hidden {
	display: none;
}

.hidden {
	display: none;
}

/*게시글 모달*/
.modal2 {
	max-width: 1200px !important;
	height: 800px;
}
</style>


</head>

<body>


	<%
	//세션에 저장된 로그인한 유저의 정보 불러오기 
	UserDTO user_info = (UserDTO) session.getAttribute("user_info");

	//마이페이지 유저 정보 가져오기!
	String my_id = (String) request.getAttribute("my_id");
	String my_nick = (String) request.getAttribute("my_nick");
	ArrayList<BoardDTO> post_list = (ArrayList<BoardDTO>) request.getAttribute("post_list");
	String my_profile = (String) request.getAttribute("my_profile");

	boolean isfollow = (boolean) request.getAttribute("isfollow");
	int countfollow = (int) request.getAttribute("countfollow");
	int countfollower = (int) request.getAttribute("countfollower");
	String userInfo = (String) request.getAttribute("userInfo");
	%>
	<button>
		<a href="ChatRoomCreate?my_id=<%=my_id%>">채팅하기</a>
	</button>
	<input type="checkbox" id="menuicon">

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
	<div class="container">
		<div id="profile_wrap">
			<div class="profile_box1">
				<div class="photo">
					<img src="img/<%=my_profile%>" alt="기본프로필">
				</div>
				<div class="right">
					<h1><%=my_nick%>
						<a href="ProfileSetting.jsp"> <svg
								xmlns="http://www.w3.org/2000/svg" width="24" height="24"
								viewBox="0 0 24 24"
								style="fill: rgba(0, 0, 0, 1); margin-left: 100px;">
							<path
									d="M12 16c2.206 0 4-1.794 4-4s-1.794-4-4-4-4 1.794-4 4 1.794 4 4 4zm0-6c1.084 0 2 .916 2 2s-.916 2-2 2-2-.916-2-2 .916-2 2-2z"></path>
							<path
									d="m2.845 16.136 1 1.73c.531.917 1.809 1.261 2.73.73l.529-.306A8.1 8.1 0 0 0 9 19.402V20c0 1.103.897 2 2 2h2c1.103 0 2-.897 2-2v-.598a8.132 8.132 0 0 0 1.896-1.111l.529.306c.923.53 2.198.188 2.731-.731l.999-1.729a2.001 2.001 0 0 0-.731-2.732l-.505-.292a7.718 7.718 0 0 0 0-2.224l.505-.292a2.002 2.002 0 0 0 .731-2.732l-.999-1.729c-.531-.92-1.808-1.265-2.731-.732l-.529.306A8.1 8.1 0 0 0 15 4.598V4c0-1.103-.897-2-2-2h-2c-1.103 0-2 .897-2 2v.598a8.132 8.132 0 0 0-1.896 1.111l-.529-.306c-.924-.531-2.2-.187-2.731.732l-.999 1.729a2.001 2.001 0 0 0 .731 2.732l.505.292a7.683 7.683 0 0 0 0 2.223l-.505.292a2.003 2.003 0 0 0-.731 2.733zm3.326-2.758A5.703 5.703 0 0 1 6 12c0-.462.058-.926.17-1.378a.999.999 0 0 0-.47-1.108l-1.123-.65.998-1.729 1.145.662a.997.997 0 0 0 1.188-.142 6.071 6.071 0 0 1 2.384-1.399A1 1 0 0 0 11 5.3V4h2v1.3a1 1 0 0 0 .708.956 6.083 6.083 0 0 1 2.384 1.399.999.999 0 0 0 1.188.142l1.144-.661 1 1.729-1.124.649a1 1 0 0 0-.47 1.108c.112.452.17.916.17 1.378 0 .461-.058.925-.171 1.378a1 1 0 0 0 .471 1.108l1.123.649-.998 1.729-1.145-.661a.996.996 0 0 0-1.188.142 6.071 6.071 0 0 1-2.384 1.399A1 1 0 0 0 13 18.7l.002 1.3H11v-1.3a1 1 0 0 0-.708-.956 6.083 6.083 0 0 1-2.384-1.399.992.992 0 0 0-1.188-.141l-1.144.662-1-1.729 1.124-.651a1 1 0 0 0 .471-1.108z"></path></svg>
						</a>
					</h1>
					<!-- 프로필 네임 안에 user_name? user_nickname? -->
					<ul>
						<h5>
							<span>게시글 <%=post_list.size()%></span> <span>팔로워 <%=countfollower%></span>
							<span>팔로우 <%=countfollow%></span> <br>
							<%
							if (userInfo != null) {
							%>
							<span>소개글 <%=userInfo%></span>
							<%
							}
							%>
						</h5>
					</ul>
				</div>
			</div>
		</div>


		<div class="content">
			<div class="grid-container">
				<!-- 마이페이지 게시물  -->
				<%
				for (int i = 0; i < post_list.size(); i++) {
				%>
				<div class="my_post<%=i%>">
					<div id="ex<%=i%>" class="modal2" style="display: none;">
						<iframe
							src="PostDetail.jsp?postIdx=<%=post_list.get(i).getPostIdx()%>"
							frameborder="0" style="width: 1200px; height: 800px;"></iframe>
					</div>
					<a href="javascript:show(<%=i%>)"><img
						src="post_img/<%=post_list.get(i).getPostImg()%>" alt="사진"></a>

				</div>
				<%
				}
				%>


			</div>
		</div>
		<!-- 여기에 script 사용해서 게시물 여부에 따라 출력할지 지정  -->
	</div>



	<!-- 사이드바 -->
	<div class="sidebar">
		<span class="area_desc">SIDEBAR영역</span> <input type="checkbox"
			name="accordion" id="answer00"> <label for="answer00">
			<input type="text" placeholder="검색"><em></em>
		</label> <input type="checkbox" name="accordion" id="answer01"> <label
			for="answer01">홈<em></em></label>
		<div>
			<p>여기에 내용</p>
		</div>
		<input type="checkbox" name="accordion" id="answer02"> <label
			for="answer02" id="modalOpenButton"> 게시글작성 <em></em></label>
		<div>
			<p>여기에 내용</p>
		</div>
		<input type="checkbox" name="accordion" id="answer03"> <label
			for="answer03">채팅<em></em></label>
		<div>
			<p>여기에 내용</p>
		</div>
		<input type="checkbox" name="accordion" id="answer04"> <label
			for="answer04">알림<em></em></label>
		<div>
			<p>여기에 내용</p>
		</div>
		<input type="checkbox" name="accordion" id="answer05"> <label
			for="answer05">프로필<em></em></label>
		<div>
			<p>여기에 내용</p>
		</div>
	</div>



	<!-- 게시글 작성 모달창 -->

	<div id="modalContainer" class="hidden">
		<div id="modalContent">

			<form id="uploadForm" action="WriterService" method="post"
				enctype="multipart/form-data">

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
									style="resize: none;"></textarea></td>
						</tr>
						<tr>
							<td colspan="2">
								<%
								ShoesDAO sdao = new ShoesDAO();
								ArrayList<ShoesDTO> s_list = sdao.showShoes();
								%> <br> <!-- <select id="shoesOptions" name="selectedShoes" multiple="multiple" data-placeholder="Search for shoes">
								</select> --> <select id="shoesOptions" name="selectedShoes"
								multiple="multiple" data-placeholder="Search for shoes">
							</select>
							</td>
						</tr>
					</table>
					<button type="button" id="prevButton">이전</button>
					<button type="submit">게시글 작성 완료</button>
			</form>


		</div>
		<button id="modalCloseButton">닫기</button>
	</div>
	</div>


	<
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
	<link rel="stylesheet"
		href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
	<link
		href="https://cdn.jsdelivr.net/npm/select2@4.1.0-beta.1/dist/css/select2.min.css"
		rel="stylesheet" />
	<script
		src="https://cdn.jsdelivr.net/npm/select2@4.1.0-beta.1/dist/js/select2.min.js"></script>
	<script>
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
	
	</script>
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
        $("body select").msDropDown();
    });
	    $(document).ready(function() {
	        $('#shoesOptions').select2({
	            maximumSelectionLength: 3
	        });
	        filterShoes();
	        filterShoes();
	    });
	    
	    function filterShoes() {
	    		$.ajax({
	            url: "ShowShoes",
	            type: "get",
	            success: function(result) {
	               console.log(result)
	               var arr = result;
	              
	               $('#shoesOptions').empty();
	               arr.forEach(function(shoes) {
	                   $('#shoesOptions').append($('<option>', {
	                       value: shoes.shoe_tag, 
	                       text: shoes.shoe_name
	                   }));
	               });
	            }
	        });
	    	
	        
	    }
	    
	    filterShoes()
	
//------------------------------------------------------------------------
   //모달 여러개...
    function show(num) {
	   console.log("선택")
        $("#ex"+num).modal({
          fadeDuration: 100,
          fadeDelay: 1,
        });
      }	
//---------------------------------------------------------------
<%if (request.getAttribute("update") != null) {%>
alert("프로필을 수정했습니다")
<%}%>
	</script>


</body>

</html>