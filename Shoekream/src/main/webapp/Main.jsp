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

	<p>로그인한 객체 정보 출력</p>
	<%=user_info.getUserNick()%>
	<%=user_info.getUserRank()%>


	<!-- 로그아웃 -->
	<button><a href="LogoutService">로그아웃</a></button>


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
	BoardDAO dao = new BoardDAO();
	ArrayList<BoardDTO> p_list = dao.showboard();
	for (int i = 0; i < p_list.size(); i++) {
		String post_user_id = p_list.get(i).getUserId();
		UserDTO post_user = dao.postuser(post_user_id);	
	%>
	
	<table>
		<tr>
			<td><img src=<%=user_info.getUserProfileImg()%> alt=""
								style="max-width: 50px; max-height: 50px;" />
			<%=p_list.get(i).getUserId()%>
			</td>
			
		</tr>
		<tr>
			<td>
			<a href="PostDetail.jsp?postIdx=<%=p_list.get(i).getPostIdx()%>" ><img alt="게시글이미지" src="post_img/<%=p_list.get(i).getPostImg()%>"></a>
		
			</td>
		</tr>
		<tr>	
			<td>내용:<%=p_list.get(i).getPostContent()%></td>
		</tr>
		<tr>
		<td></td></tr>
		<!-- 댓글 달기 -->
	
		<input type="hidden" name="postIdx" value="<%=p_list.get(i).getPostIdx()%>">
		<td><input type ="text" name ="comment" id="inputComment" class="comment"> </td>
		<td><button onclick="writeComment(<%=i%>)"> 댓글작성</button></td>
	
	</table>

	<%}%>



<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script type ="text/javascript">


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
</script>




	<script>
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
	

	</script>






</body>
</html>