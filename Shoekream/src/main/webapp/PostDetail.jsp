<%@page import="com.smhrd.model.UserDTO"%>
<%@page import="javax.swing.text.Document"%>
<%@page import="java.util.List"%>
<%@page import="com.smhrd.model.CommentDAO"%>
<%@page import="com.smhrd.model.CommentDTO"%>
<%@page import="com.smhrd.model.BoardDTO"%>
<%@page import="com.smhrd.model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
// 쿼리 문자열로 전달된 데이터 받기

UserDTO user_info= (UserDTO)session.getAttribute("user_info");
Double postIdx=Double.parseDouble(request.getParameter("postIdx"));
// postIdx를 사용하여 원하는 작업 수행
out.println("Post Index: " + postIdx);

BoardDAO dao = new BoardDAO();
BoardDTO result=dao.showDetail(postIdx);

if(user_info.getUserId().equals(result.getUserId())){
	out.print("<button onclick='updatePost()''>게시글수정하기</button>");	
}

CommentDAO cdao = new CommentDAO();
List<CommentDTO> c_list=cdao.showComment(postIdx);

//댓글 출력
for(int i=0;i<c_list.size();i++){
	out.print(c_list.get(i).getCmt_content());
	out.print("<br>");
}

%>

<img alt="게시글이미지" src="post_img/<%=result.getPostImg()%>">
 내용: <%=result.getPostContent() %>
 
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-beta.1/dist/css/select2.min.css" rel="stylesheet"/>
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-beta.1/dist/js/select2.min.js"></script>
 
 <script>
 function updatePost(){
	alert('updatePost 함수호출')
 }
 
 
 //-----
 	const modalCloseButton = document.getElementById('modalCloseButton');
		const modal = document.getElementById('modalContainer');
		modalCloseButton.addEventListener('click', () => {
			  modal.classList.add('hidden');
			});

		function previewFile() {
		    var preview = document.getElementById('preview'); // 미리보기를 표시할 div
		    var file = document.getElementById('fileInput').files[0]; // 사용자가 선택한 파일
		    var reader = new FileReader();

		    reader.onloadend = function () {
		        preview.innerHTML = '<img src="' + reader.result + '" style="max-width: 200px; max-height: 200px;">'; // 미리보기 이미지 생성
		    }

		    if (file) {
		        reader.readAsDataURL(file); // 파일 읽기
		    } else {
		        preview.innerHTML = "선택된 이미지 없음"; // 파일이 선택되지 않았을 때의 대체 텍스트
		    }
		}
		
		
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
			    $option.css('color', 'black');
			    return $option;
			}

			function formatSelectedShoeOption(selection) {
			    if (!selection.id) {
			        return selection.text; // Placeholder option
			    }

			    var $selection = $('<span><img src="shoe_img/' + selection.id + '.png" class="shoe-image" style="width: 70px" /> ' + selection.text + '</span>');
			    $selection.css('color', 'black');
			    return $selection;
			}
 </script>


</body>
</html>