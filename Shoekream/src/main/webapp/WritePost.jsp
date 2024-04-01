<%@page import="com.smhrd.model.UserDTO"%>
<%@page import="com.smhrd.model.ShoesDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.smhrd.model.ShoesDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
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
</style>
</head>
<body>

<%UserDTO user_info = (UserDTO)session.getAttribute("user_info"); %>

	<!-- <form id="uploadForm" action="WriterService" method="post"
				enctype="multipart/form-data"> -->
				<form id="uploadForm" action="WriterService" method="post" enctype="multipart/form-data"
				>

				<!-- 게시글 파일 선택 -->
		

		<input type="file" id="fileInput" name="filename" onchange="previewFile()">
				<!-- 게시글 파일 미리보기, 본문 작성  -->
			
					<table>
						<tr>
							<td rowspan="3"><div id="preview" style="min-width: 200px; min-height: 200px; border: 1px solid #ccc; display: flex; align-items: center; justify-content: center;">
                <span>이미지 미리보기</span>
            </div>
            </td>
							<td style="width:40px;"><img src="img/<%=user_info.getUserProfileImg()%>" alt=""
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
					<button type="submit">게시글 작성 완료2</button>
			</form>
		<button id="modalCloseButton">닫기</button>
 <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-beta.1/dist/css/select2.min.css" rel="stylesheet"/>
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-beta.1/dist/js/select2.min.js"></script>
		<script>
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