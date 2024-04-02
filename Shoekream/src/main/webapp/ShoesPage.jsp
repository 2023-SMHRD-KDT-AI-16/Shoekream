<%@page import="com.smhrd.model.ShoesDTO"%>
<%@page import="com.smhrd.model.BoardDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.smhrd.model.UserDTO"%>
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
        /* 추가한 스타일 */
        .hidden {
            display: none;
        }
        
        
        
       	/*게시글 모달*/
.modal2{
max-width:1200px !important;
height:800px;
}

<!-- css 코드라인 -->


input[id="menuicon"] {display: none;}
body{
	width: 1920px; height: 100%;
}
.container {
	display: flex;
	flex-direction: row-reverse;
	width: 1920px;
	height: 20000px;
	position:relative;
	background-color: #ffffff;

  }

/* 헤더 */
header {width: 100%;background: #ffffff;}
header > div {position: relative; width: 1920px;   margin:15 auto;}
header > div ul.navi{font-size: 0;}
header > div ul.navi > li{font-size: 50px; display: inline-block; vertical-align: middle;}
header > div ul.navi > li > a {display: block; width: auto; padding: 20px;}
header > div ul.navi > li.logp > a{padding: 20px 50px; font-size: 20px; font-weight: 900;}



h1{font-weight: normal; font-size: x-large;}
a{text-decoration: none; color: #222; }

#profile_wrap{
	margin-top: 20px;
  width: 640px;  
 height: 1000px;
 border: none;
} 

#profile_wrap .profile_box1 {
  padding: 30px; 
    font-size: x-large;
    width: 700px;
	height: 1000px;
}
#profile_wrap .profile_box1 .photo{
width: 1000px; height: 550px; background:#fff;
    border:5px solid #ebf1f7;
    border-radius:10px;
display: flex; flex-flow: row nowrap; overflow: hidden;
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

/* 사이드바 스타일 수정 */
.sidebar {
    width: 300px;
    height: 100%;
    background: #ebf1f7;
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

/* 콘텐츠 영역 스타일 */
.content {
    display: grid;
    grid-template-columns: repeat(3, 1fr); /* 3열 그리드 */
    gap: 20px; /* 각 그리드 아이템 사이의 간격 */
    padding: 20px;
}

/* 각 그리드 아이템 스타일 */
.post-item {
   
    padding: 20px;
    text-align: center;
}

/* 이미지가 있는 경우 */
.post-item img {
    max-width: 350px;
    height: 400px;
    border: solid 3px;
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
    margin-top: 10px;
     margin-right: -30px;
     margin-left: 50px;
}

/* 게시글 스타일 수정 */
.grid-container > div {
 height: 430px; /* 게시글 영역 높이 수정 */
    width: 370px; /* 게시글 영역 너비 수정 */
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

.right{
    cursor: pointer;
    background-color:#ebf1f7;
        display: flex; /* 이를 통해 내부 요소를 수평 정렬 */
    align-items: center; /* 세로 중앙 정렬 */
    justify-content: start; /* 시작 지점에서 정렬 */
    padding: 20px; /* 필요에 따라 패딩 조정 */
}


#shoekreamImg{
    width: 300px;
    height: 150px;
    margin-top: -37px;
    margin-left:-47px;
}

.post_img{
width:450px;
height:450px
}

.post_img:hover{
opacity: 0.5;
}

/* 컨테이너와 콘텐츠 배치 */
.container {
    display: flex;
    flex-direction: column; /* 세로 정렬로 변경 */
    align-items: center; /* 가운데 정렬 */
}

.container .content {
    width: calc(100% - 20px); /* 화면 전체 너비에서 여백 고려하여 콘텐츠 영역의 너비 계산 */
    height: 900%;
    margin-top: 20px; /* 적절한 간격 설정 */
    min-height: 700px;
    border-top: 5px solid #ebf1f7;
     /* 테두리 지정 border: 1px solid #835151; */
    background: #ffffff;
    align-content: start;

}



    </style>
    
    
</head>

<body>

	<%
	//세션에 저장된 로그인한 유저의 정보 불러오기 
	UserDTO user_info = (UserDTO) session.getAttribute("user_info");
	ShoesDTO shoes_info=(ShoesDTO)request.getAttribute("shoes_info");
	ArrayList<BoardDTO> p_list =(ArrayList<BoardDTO>)request.getAttribute("p_list");
	%>    
	<input type="checkbox" id="menuicon" style="display:none;" checked>
    <header>
        <div>
            <ul class="navi">
                <!-- 메뉴아이콘 -->
                <label for="menuicon" class="menubtn">
                    <span></span>
                    <span></span>
                    <span></span>
                </label>
               <li class="logo" ><a href="Main.jsp"><img id="shoekreamImg" src = "img/슈크림.jpg"></a></li>
            </ul>
        </div>
    </header>
    <div class="container">
        <div id="profile_wrap" style="width: 1400px; height: 700px; margin-bottom: 0px; margin-left: 100px;">
        
            <div class="profile_box1" style="height: auto;margin-top:20px;width: 1000px;z-index:30;">
                <div class="photo"><img src="shoe_img/<%=shoes_info.getShoe_tag() %>.png" alt="신발사진" style="width: 650px; border-radius:10px">
                
                <div class="right" style="width: 700px">
                    
                    <span>
                    
                    

                    <!-- 프로필 네임 안에 user_name? user_nickname? -->
                    <ul  style="padding-left: 0px;">
                    <h3><span><%=shoes_info.getShoe_name() %></span></h3>
                        <span>brand : <%=shoes_info.getShoe_maker() %></span><br> 
                        <span>price : <%=shoes_info.getShoe_price() %></span><br>
                    </span></ul>
                </div>
              </div>  
            </div>
        </div>
        <div class="content">
            <div class="grid-container">
                <!-- 신발 상세페이지 게시물  -->
            <%
				for (int i = 0; i < p_list.size(); i++) {
				%>
				<div class="my_post<%=i%>">
				 <div id="ex<%=i %>" class="modal2" style="display: none;">
	<iframe src="PostDetail.jsp?postIdx=<%=p_list.get(i).getPostIdx() %>" frameborder="0" style="width: 1200px; height: 800px;"></iframe>
				</div>
					<a href="javascript:show(<%=i %>)"><img class="post_img"
						src="post_img/<%=p_list.get(i).getPostImg()%>" alt="사진"></a>
				</div>
				<%
				}
				%>
            </div>
        </div>
        <!-- 여기에 script 사용해서 게시물 여부에 따라 출력할지 지정  -->
    </div>
    	
    	 <!-- 사이드바  -->
		<div class="sidebar">
			<span class="area_desc"></span> <input type="checkbox"
				name="accordion" id="answer00"> 

			<input type="checkbox" name="accordion" id="answer01"> <label
				for="answer01"><span id="emo"><a href="Main.jsp">&#127968;</a></span><a href="Main.jsp">홈</a><em></em></label> <input
				type="checkbox" name="accordion" id="answer02"> <label
				for="answer02"><span id="emo_post"> <a href="javascript:writePost()">&#9997;</a></span><a href="javascript:writePost()">게시글작성</a> <em></em></label> <input type="checkbox"
				name="accordion" id="answer03"> <label for="answer03"><span
				id="emo"><a href="chat.jsp">&#128172;</a></span>
					<a>채팅방 가기</a>
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
		
		<div id="writePost" class="modal2" style="display: none;">
	<iframe src="WritePost.jsp" frameborder="0" style="width: 1200px; height: 800px;"></iframe>
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
    		
</body>
 <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-beta.1/dist/css/select2.min.css" rel="stylesheet"/>
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-beta.1/dist/js/select2.min.js"></script>
	<script>

//------------------------------------------------------------------------
//모달 여러개...
 function show(num) {
	   console.log("선택")
     $("#ex"+num).modal({
       fadeDuration: 100,
       fadeDelay: 1,
     });
   }

 //게시글 작성 모달
 function writePost() {
	   console.log("게시글 작성")
     $("#writePost").modal({
       fadeDuration: 100,
       fadeDelay: 1,
     });
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


</html>