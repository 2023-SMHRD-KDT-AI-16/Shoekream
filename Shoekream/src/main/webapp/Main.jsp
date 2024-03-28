<%@page import="com.smhrd.model.ShoesDTO"%>
<%@page import="com.smhrd.model.ShoesDAO"%>
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
<link rel="stylesheet" href="./CSS/Main.css">
<style>
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
</style>

</head>
<body>
	<h1>SHOEKREAM</h1>

	<%
	//로그인 한 유저 정보 가져오기
	UserDTO user_info = (UserDTO) session.getAttribute("user_info");
	%>


	<!-- ------------------------------------------------------------------------- -->

	<p>로그인한 객체 정보 출력</p>
	<%=user_info.getUserNick()%>
	<%=user_info.getUserRank()%>


	<!-- 로그아웃 -->
	<button>
		<a href="LogoutService">로그아웃</a>
	</button>


	<!-- -------------------------------------------------------------- -->
	<!-- 게시글 작성 모달창 열기 -->

	<br>
	<button id="modalOpenButton">게시글 작성</button>
	<br>
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
 <!-- 신발태그 검색 -->
 <% 
 ShoesDAO sdao = new ShoesDAO();
 ArrayList<ShoesDTO> s_list = sdao.showShoes();
 %>
 
<input type="text" id="filterInput" oninput="filterShoes()">
<br>
<select id="shoesOptions">
<option value="basic">신발을 검색해주세요</option>
    <!-- 여기에 옵션들이 동적으로 추가될 것입니다. -->
</select></td>
						</tr>
					</table>
					<button type="button" id="prevButton">이전</button>
					<button type="submit">게시글 작성 완료</button>
			</form>



		</div>
		<button id="modalCloseButton">닫기</button>
	</div>
	</div>

	<!-- -------------------------------------------------------------- -->
	<!-- 게시글 출력  -->

	<%
	//게시글 정보 가져오기 
	BoardDAO dao = new BoardDAO();
	ArrayList<BoardDTO> p_list = dao.showboard();
	LikeDAO ldao= new LikeDAO();
	for (int i = 0; i < p_list.size(); i++) {
		String post_user_id = p_list.get(i).getUserId();
		UserDTO post_user = dao.postuser(post_user_id);
		
		CommentDAO cdao = new CommentDAO();
		List<CommentDTO> c_list = cdao.showComment(p_list.get(i).getPostIdx());
		
		LikeDTO ldto= new LikeDTO();
		ldto.setPost_idx(p_list.get(i).getPostIdx());
		ldto.setUser_id(user_info.getUserId());
		boolean isLike =ldao.isLike(ldto);
		
		FollowDTO fdto = new FollowDTO();
		FollowDAO fdao = new FollowDAO();
		fdto.setFollowee(post_user_id);
		fdto.setFollower(user_info.getUserId());
		boolean isfollow = fdao.isfollow(fdto);
		
		
	%>

	<table border=1>
		<tr>
			<td><img src=<%=user_info.getUserProfileImg()%> alt=""
				style="max-width: 50px; max-height: 50px;" /> 
				<%=p_list.get(i).getUserId()%>
				<input type="hidden" name="post_userid" value="<%=p_list.get(i).getUserId()%>">
				<%if(isfollow==true){ %>
				<button class="follow" id="follow_<%= i %>" onclick="togglefollowY(<%= i %>)">팔로잉</button>
				<%}else{ %>
				<button class="follow" id="follow_<%= i %>" onclick="togglefollowN(<%= i %>)">팔로우</button>
				<%} %>
			</td>

		</tr>
		<tr>
			<td><a href="PostDetail.jsp?postIdx=<%=p_list.get(i).getPostIdx()%>"><img
					alt="게시글이미지" src="post_img/<%=p_list.get(i).getPostImg()%>"></a>

			</td>
		</tr>
		<tr>
			<td>내용:<%=p_list.get(i).getPostContent()%></td>
		</tr>
		
		
		<!-- 좋아요 버튼 -->
		<tr>
		<td>
		<%if(isLike==true){ %>
	<button class="like" id="like_<%= i %>" onclick="toggleLikeY(<%= i %>)">❤️</button>
		<%}else{ %>
		<button class="like" id="like_<%= i %>" onclick="toggleLikeN(<%= i %>)">🤍</button>
		<%} %>
		
		</td>
		<td><%		//게시글 좋아요 정보 가져오기 
		int like = ldao.Like(p_list.get(i).getPostIdx());
		out.print(like); 
		

		%>
		</td>
		</tr>
		
		
		
		
		<tr>
		<!-- 댓글 출력 -->
		<%
		if(!c_list.isEmpty()){
			out.print("<td>");
		out.print("댓글 내용 : "+c_list.get(0).getCmt_content() );
		out.print("</td>");
		}
		%>
		</tr>
		
		<tr>
		<!-- 댓글 달기 -->
		<input type="hidden" name="postIdx"
			value="<%=p_list.get(i).getPostIdx()%>">
		<td><input type="text" name="comment" id="inputComment"
			class="comment"></td>
		<td><button onclick="writeComment(<%=i%>)">댓글작성</button></td>
		</tr>
		
	</table>

	<%
	}
	%>

<script src="./JS/Main.js"></script>
 <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	

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
    <div class="content" >
      <span class="area_desc"></span> 
      <!-- 위에 괄호 안이 content영역 -->
      <div id="instagram-posts">
        <!-- 여기에 포스트가 추가됩니다 -->
      </div>
    </div>
    <div class="sidebar">
      <span class="area_desc" >SIDEBAR영역</span>

        <input type="checkbox" name="accordion" id="answer00">
        <label for="answer00"> <input type="text" placeholder="검색"><em></em></label>      
        <input type="checkbox" name="accordion" id="answer01">
        <label for="answer01">홈<em></em></label>
        <div><p>여기에 내용</p></div>
        <input type="checkbox" name="accordion" id="answer02">
        <label for="answer02">게시글작성<em></em></label>
         <div><p>여기에 내용</p></div>
        <input type="checkbox" name="accordion" id="answer03">
        <label for="answer03">채팅<em></em></label>
          <div><p>여기에 내용</p></div>
        <input type="checkbox" name="accordion" id="answer04">
        <label for="answer04">알림<em></em></label>
          <div><p>여기에 내용</p></div>
          <input type="checkbox" name="accordion" id="answer05">
          <label for="answer05">프로필<em></em></label>
            <div><p>여기에 내용</p></div>
      </div>
      <div class="post">
        
      </div>
      <div id="profile_wrap">
       <div class="profile_box1">
          <div class="photo"><img src="/MAIN/img/299400862_433066862176075_265719782033185215_n.jpg" alt="기본프로필"></div>
          <div class="right">
            <h1>profile name</h1>
            <!-- 프로필 네임 안에 user_name? user_nickname? -->
            <ul>
            <h5><span>게시글 1</span>  <span>팔로워 150</span>  <span>팔로우 13</span></h5>
            <!-- 숫자사이에 넣으면 될듯?! -->
            </ul>
          </div>  
        </div>
      </div>
  </div>
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

<button>
		<a href="chat.jsp">채팅 연결하기</a>
	</button>
	<!--Start of Tawk.to Script-->
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