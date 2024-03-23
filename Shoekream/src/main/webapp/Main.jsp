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
<title>Insert title here</title>
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
	Main화면입니다

	<%
UserDTO user_info = (UserDTO) session.getAttribute("user_info");
// 프로필사진 출력(프로필 사진 없을시 기본이미지 출력)
//if (user_info.getUserProfileImg() == null) {
//	user_info.setUserProfileImg("img/profile.png");
//}
%>

	<p>로그인한 객체 정보 출력</p>
	<%=user_info.getUserNick()%>
	<%=user_info.getUserRank()%>


	<!-- 로그아웃 -->
	<button><a href="LogoutService">로그아웃</a></button>


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
	BoardDAO dao = new BoardDAO();
	ArrayList<BoardDTO> p_list = dao.showboard();
	for (int i = 0; i < p_list.size(); i++) {
		String post_user_id = p_list.get(i).getUserId();
		UserDTO post_user = dao.postuser(post_user_id);
		
	%>
	
	<table>
		<tr>
			<td>아이디:<%=p_list.get(i).getUserId()%></td>
			<td>내용:<%=p_list.get(i).getPostContent()%></td>
			<td>프로필: <%=post_user.getUserProfileImg()%></td>
		</tr>
	</table>


	<%
	}
	%>





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
	</script>






</body>
</html>