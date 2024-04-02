<%@page import="com.smhrd.model.BoardDTO"%>
<%@page import="com.smhrd.model.BoardDAO"%>
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
width:500px;
height:auto;
display: block;
font-size:5px;
}


.select2-results__option{
width:500px;
height:auto;
font-size:16px;
color:gray;
}

/* 모달창 검색 란 */
.select2-container--default .select2-selection--multiple {
    background-color: white;
    border: 1px solid #aaa;
    border-radius: 4px;
    cursor: text;
    padding-bottom: 5px;
    padding-right: 5px;
    width: 500px;
}
.select2-container--default .select2-results__option--highlighted.select2-results__option--selectable {
    background-color: #92929e45;
    color: white;
    width: 500px; 
}
.select2-container {
    box-sizing: border-box;
    display: inline-block;
    margin: 0;
    position: relative;
    vertical-align: middle;
    width: 500px;
   }
   .select2-results__options {
    list-style: none;
    margin: 0;
    padding: 0;
    width: 500px;
}
.select2-dropdown select2-dropdown--below{
width: 500px; 
}
.select2-results__option--selectable :hover{
    cursor: pointer;
  	background-color: #92929e30;
}

/* 신발 태그 */
tbody> tr > td{
 vertical-align: top; 
}

/* 신발 태그 */
tbody> tr > td >#user_id{
align: center; 
}

.select2-container--default .select2-results>.select2-results__options {
	height: 420px;
    max-height: 420px;
  z-index: 30;
  
}

/* 상하 높이 ?  위아래 설정시 */
</style>
</head>
<body>

<%UserDTO user_info = (UserDTO)session.getAttribute("user_info"); 
Double postIdx=Double.parseDouble(request.getParameter("postIdx"));

//게시글 정보 불러오기 
BoardDAO dao = new BoardDAO();
BoardDTO result=dao.showDetail(postIdx);
%>

	<!-- <form id="uploadForm" action="WriterService" method="post"
				enctype="multipart/form-data"> -->
				<form id="uploadForm" action="WriterService" method="post" enctype="multipart/form-data" 
				style="margin-left: 4px;"
				>

				<!-- 게시글 파일 선택 -->
		

		<input type="file" id="fileInput" name="filename" onchange="previewFile()">
				<!-- 게시글 파일 미리보기, 본문 작성  -->
			
					<table>
						<tr>
							<td rowspan="3" style="    width: 500px;
    height: 600px;">
    <div id="preview" style=" width:600px; height:600px; border: 1px solid #ccc; display: flex; align-items: center; justify-content: center;">
                <img src="post_img/<%=result.getPostImg()%>">
            </div>
            </td>
							<td style="width:40px; height: 60px; "><img src="img/<%=user_info.getUserProfileImg()%>" alt=""
								style="max-width: 50px; max-height: 50px; border-radius: 50%;
    border: solid 1px;" /></td>
							<td id="user_id"><%=user_info.getUserNick()%></td>
						</tr>
						<tr>
							<td colspan="2" style="width: 400px; height: 50px;"><textarea name="content" rows="10" 
									style="resize: none; width: 500px;height: 50px;"  required><%=result.getPostContent() %></textarea></td>
						</tr>
						<tr>
						
							<td colspan="2" style="width: 500px">
								<!-- 신발태그 검색 --> 
								<%
 ShoesDAO sdao = new ShoesDAO();
 ArrayList<ShoesDTO> s_list = sdao.showShoes();
 %> 
								<br> 
								<!-- <select id="shoesOptions" name="selectedShoes" multiple="multiple" data-placeholder="Search for shoes">
								</select> -->
								<select id="shoesOptions" name="selectedShoes" multiple="multiple" data-placeholder="신발을 검색하여 태그해보세요!">
								
								</select>
							</td>
						</tr>
					</table>
					<button type="submit" style="
    width: 216px;
    height: 36px;
    margin-left: 2px;
					">수정</button>
					<a href="PostDetail.jsp?postIdx=<%=postIdx%>"><button type="button" style=" 
					
    width: 216px;
    height: 36px;
					">취소</button></a>
			</form>
		
 <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-beta.1/dist/css/select2.min.css" rel="stylesheet"/>
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-beta.1/dist/js/select2.min.js"></script>
		<script>

		function previewFile() {
		    var preview = document.getElementById('preview'); // 미리보기를 표시할 div
		    var file = document.getElementById('fileInput').files[0]; // 사용자가 선택한 파일
		    var reader = new FileReader();

		    reader.onloadend = function () {
		        preview.innerHTML = '<img src="' + reader.result + '" style="max-width: 600px; max-height: 600px; width: 600px; height: 600px; z-index: 20;">'; // 미리보기 이미지 생성
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