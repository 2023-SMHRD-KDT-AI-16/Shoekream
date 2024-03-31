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
    <link rel="stylesheet" href="CSS/ShoesPage.css">
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
	ShoesDTO shoes_info=(ShoesDTO)request.getAttribute("shoes_info");
	ArrayList<BoardDTO> p_list =(ArrayList<BoardDTO>)request.getAttribute("p_list");
	%>    
	<input type="checkbox" id="menuicon">
    <header>
        <div>
            <ul class="navi">
                <!-- 메뉴아이콘 -->
                <label for="menuicon" class="menubtn">
                    <span></span>
                    <span></span>
                    <span></span>
                </label>
                <li class="logo"><a>SHOEKREAM</a> </li>
            </ul>
        </div>
    </header>
    <div class="container">
        <div id="profile_wrap">
            <div class="profile_box1">
                <div class="photo"><img src="shoe_img/<%=shoes_info.getShoe_tag() %>.png" alt="신발사진" style="width: 650px;">
                </div>
                <div class="right">
                    <h1>shoesname</h1>
                    <p><%=shoes_info.getShoe_name() %></p>
                    <br>

                    <!-- 프로필 네임 안에 user_name? user_nickname? -->
                    <ul>
                        <h5><span>brand <%=shoes_info.getShoe_maker() %></span><br> 
                        <span>price <%=shoes_info.getShoe_price() %></span><br> </h5> 
                    </ul>
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
					<a href="#"><img
						src="post_img/<%=p_list.get(i).getPostImg()%>" alt="사진"></a>
				</div>
				<%
				}
				%>
            </div>
        </div>
        <!-- 여기에 script 사용해서 게시물 여부에 따라 출력할지 지정  -->
    </div>
    
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
			<span id="emo"><a href="MypageService?post_userid=<%= user_info.getUserId()%>">&#128100;</a></span>
			<a href="MypageService?post_userid=<%= user_info.getUserId()%>">프로필</a>
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
</body>
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