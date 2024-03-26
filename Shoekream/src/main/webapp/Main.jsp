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
							<td colspan="2"><input type="text"></td>
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


</body>
</html>