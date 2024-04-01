<%@page import="com.smhrd.model.FollowDAO"%>
<%@page import="com.smhrd.model.FollowDTO"%>
<%@page import="com.smhrd.model.LikeDTO"%>
<%@page import="com.smhrd.model.LikeDAO"%>
<%@page import="com.smhrd.model.ShoesDAO"%>
<%@page import="com.smhrd.model.UserDAO"%>
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
<style>
.content-container {
  display: flex;
  align-items: flex-start; /* 세로선을 상단에 정렬 */
  margin-top:10px;
}

#left_zone {
    width: 630px;
    margint: 20px;
}

#post_user_img{
width: 70px;
height: 70px;
margin-right: 10px;
border:black 1px solid;
border-radius: 50px;
}

#post_img{
width:500px;
height:500px;
margin-left:50px;
}

.user-profile {
  display: flex;
  align-items: center; /* 세로축 중앙 정렬 */
 /*  justify-content: center; 가로축 중앙 정렬 */
  text-align: center; /* 텍스트 중앙 정렬 */
}

.vertical-line {
  border-left: 2px solid black; /* 왼쪽 테두리를 세로선으로 사용 */
  height: 700px; /* 세로선의 높이 */
  margin-top: 20px;
}

.shoe-table {
	margin-top:20px;
  margin-left: 20px; /* 세로선과의 간격 */
  border-collapse: collapse; /* 테이블 경계 스타일 */
  width:480px;
  background-color: whitesmoke;
  border-radius:10px
}

.shoe-table th, .shoe-table td {
  padding: 8px; /* 셀 안쪽 여백 */
  text-align: left; /* 텍스트 정렬 */
}

.tagimg{
width: 60px;
height: 60px;
}


.comment-table {

  margin-left: 20px; /* 세로선과의 간격 */
  border-collapse: collapse; /* 테이블 경계 스타일 */
  width:450px;
    background-color: whitesmoke;
  border-radius:10px
}

.comment-table th, .comment-table td {
  padding: 8px; /* 셀 안쪽 여백 */
  text-align: left; /* 텍스트 정렬 */
}

.comment_user_img{
width: 40px;
height: 40px;
margin-right: 10px;
border:black 1px solid;
border-radius: 50px;
}

#inputcomment{
width:375px;
margin:20px;



.comment-table {
  width: 100%; /* 테이블 너비를 컨테이너에 맞춤 */
}
</style>
</head>
<body>

<%
// 쿼리 문자열로 전달된 데이터 받기

UserDTO user_info= (UserDTO)session.getAttribute("user_info");
Double postIdx=Double.parseDouble(request.getParameter("postIdx"));

//게시글 정보 불러오기 
BoardDAO dao = new BoardDAO();
BoardDTO result=dao.showDetail(postIdx);

//게시글 작성한 사용자 정보 불러오기 
UserDAO udao = new UserDAO();
UserDTO post_user= udao.getUser(result.getUserId());


//게시글에 태그된 신발 정보 불러오기 (이름)
	ShoesDAO sdao = new ShoesDAO();
			String tag1_name=null;
			String tag2_name=null;
			String tag3_name=null;
			if(result.getShoeTag1()!=null) {
				tag1_name = sdao.shoeName(result.getShoeTag1());
				System.out.println("tag1: "+tag1_name);
			}
			
			if(result.getShoeTag2()!=null) {
				tag2_name = sdao.shoeName(result.getShoeTag2());
				System.out.println("tag2: "+tag2_name);
			}
		
			if(result.getShoeTag3()!=null) {
				tag3_name = sdao.shoeName(result.getShoeTag3());
				System.out.println("tag3: "+tag3_name);
			}
			
// 좋아요 정보 가져오기
			LikeDAO ldao = new LikeDAO();
			LikeDTO ldto = new LikeDTO();
			ldto.setPost_idx(postIdx);
			ldto.setUser_id(user_info.getUserId());
			boolean isLike = ldao.isLike(ldto);//좋아요 여부
			int like = ldao.Like( postIdx);//좋아요 개수

	//팔로우 여부 가져오기
          FollowDTO fdto = new FollowDTO();
          FollowDAO fdao = new FollowDAO();
          fdto.setFollowee(result.getUserId());
          fdto.setFollower(user_info.getUserId());
          boolean isfollow = fdao.isfollow(fdto);//팔로우 여부 

          
//게시글 댓글 
CommentDAO cdao = new CommentDAO();
List<CommentDTO> c_list=cdao.showComment(postIdx);


%>


<div class="content-container">
<div id="left_zone">

<div class="user-profile">
  <a href="MypageService?post_userid=<%=post_user.getUserId()%>" class="modal-external-link"><img id="post_user_img" alt="작성자 프로필 이미지" src="img/<%=post_user.getUserProfileImg()%>"></a>
<h2><%=post_user.getUserNick() %></h2>
<span style="width: 30px;"></span>
<% 
if(user_info.getUserId().equals(result.getUserId())){%>
<a href="UpdatePost.jsp?postIdx=<%=postIdx %>"><button>게시글 수정</button></a>

<span style="width: 10px;"></span>
<a class="isdel" href="Main.jsp"><button onclick='deletePost()'>게시글 삭제</button></a>	
	

<span style="width: 100px;"></span>
<p style="margin-top:70px">작성일자:<%=result.getPostedAt()%></p>
<%}else{%>
<%if(isfollow==true){ %>
<button class="follow" onclick="togglefollowY(<%=postIdx%>)">팔로잉</button>
<%}else{ %>
<button  class="follow" onclick="togglefollowN(<%=postIdx%>)">팔로우</button><%} %>
<span style="width: 150px;"></span>
<p style="margin-top:70px">작성일자:<%=result.getPostedAt()%></p>
<%} %>

</div>

<div style="justify-content:left;">
<img id="post_img" alt="게시글이미지" src="post_img/<%=result.getPostImg()%>" >
</div>

<span class="likes" style="vertical-align: middle;"><%=like %></span>
<%if(isLike==true){%>
<img src='img/빨간색하트.png' id="like" onclick="toggleLikeY(<%=postIdx %>)" class="heart_comment" style="height:60px;weight:50px;padding:10px;vertical-align: middle;">
<%}else{ %>
<img src='img/흰색하트.png' id="like" onclick="toggleLikeN(<%=postIdx %>)" class="heart_comment" style="height:60px;weight:50px;padding:10px;vertical-align: middle;">
<%} %>
<p><%=result.getPostContent() %></p>
</div>

  <div class="vertical-line"></div>
<div id="rightzone"> 


<%if(tag1_name!=null) {%> 
<h3 style="margin-left:230px">신발</h3>
  <table class="shoe-table">
        <tr>
            <td class="shoe_img">
            <a class="modal-shoe-link" href="ShoespageService?shoeId=<%=result.getShoeTag2()%>">
            <img class="tagimg" src="shoe_img/<%=result.getShoeTag1()%>.png"></a>
            </td>
            <td><%=tag1_name %></td>
        </tr>
        <%if(tag2_name!=null) {%>
        <tr>
            <td class="shoe_img"><a class="modal-shoe-link" href="ShoespageService?shoeId=<%=result.getShoeTag2()%>"><img  class="tagimg" src="shoe_img/<%=result.getShoeTag2()%>.png"></a>
            </td>
            <td><%=tag2_name %></td>
        </tr>
        <%if(tag3_name!=null){ %>
        <tr>
            <td class="shoe_img"><a class="modal-shoe-link" href="ShoespageService?shoeId=<%=result.getShoeTag3()%>"><img  class="tagimg" src="shoe_img/<%=result.getShoeTag2()%>.png"></a>
            </td>
            <td><%=tag3_name %></td>
        </tr>
        <%} }%>
  </table> 
   <hr>
  <%} %>
  
  <%String comment_h="610";
  	if(tag3_name!=null){
  		comment_h="290";
  	}else if(tag2_name!=null){
  		comment_h="370";
  	}else if(tag1_name!=null){
  		comment_h="450";
  	}
  %>

  <h3 style="margin-left:230px">댓글</h3>
<div id="comment-table-container" style=" height:<%=comment_h%>px; overflow-y:auto">
  <table class="comment-table">
    <% if(c_list != null && !c_list.isEmpty()) { // 댓글 리스트가 null이 아니고, 비어있지 않은 경우
         for(int i = 0; i < c_list.size(); i++) {
           UserDTO comment_user = udao.getUser(c_list.get(i).getUser_id()); %>
           <tr>
             <td style="width:30px"><img class="comment_user_img" src="img/<%= comment_user.getUserProfileImg() %>"></td>
             <td style="width:300px"><b><%= comment_user.getUserNick() %></b> :<%= c_list.get(i).getCmt_content() %></td>
             <td><p style="font-size:9px;font-color:gray"><%= c_list.get(i).getCreated_at() %></p></td>
           </tr>
         <% }
       } else { // 댓글 리스트가 null이거나 비어있는 경우 %>
         <tr>
           <td colspan="4">작성된 댓글이 없습니다.</td>
         </tr>
    <% } %>
  </table>
</div>

  <form action=#>
  <input type="text" name="postIdx" style="height:20px;display:none" value="<%=postIdx%>">
  <input id="inputcomment" type="text" name="comment" style="height:20px"> <button type="submit" onclick="writeComment()">댓글작성</button>
  </form>
 </div> 

 </div>
 
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
			
			$(document).ready(function() {
			    $('.modal-external-link').on('click', function(e) {
			        e.preventDefault(); // 기본 이벤트 차단
			        var targetUrl = $(this).attr('href'); // 이동할 URL 가져오기

			        // 최상위 창의 URL을 변경하여 부모 페이지 이동 시도
			        window.top.location.href = targetUrl;
			    });
			});
			
			$(document).ready(function() {
			    $('.modal-shoe-link').on('click', function(e) {
			        e.preventDefault(); // 기본 이벤트 차단
			        var targetUrl = $(this).attr('href'); // 이동할 URL 가져오기

			        // 최상위 창의 URL을 변경하여 부모 페이지 이동 시도
			        window.top.location.href = targetUrl;
			    });
			});
			
			$(document).ready(function() {
			    // .comment-table-container의 높이를 가져옵니다.
			    var containerHeight = $('.comment-table-container').height();
			    
			    // .comment-table-container의 스크롤 위치를 높이와 동일하게 설정하여
			    // 스크롤바를 맨 아래로 이동시킵니다.
			    $('.comment-table-container').scrollTop(containerHeight);
			});
			
			
			function writeComment() {
			    var inputComment = $('[name="comment"]').val(); // 댓글 입력 필드의 값을 가져옵니다.
			    var postIdx = $('[name="postIdx"]').val();
			    console.log(<%=postIdx%>)
			    if (inputComment.trim() !== '') {
			        $.ajax({
			            url: 'WriteCommentService',
			            data: {
			                "postIdx": postIdx,
			                "inputComment": inputComment
			            },
			            type: 'get',
			            success: function () {
			                console.log("댓글 저장 성공");
			                $('[name="comment"]').val(''); // 댓글 저장 후 입력 필드 초기화
			                

			                var tr = document.createElement("tr");

			                // 이미지 셀
			                var imgtd = document.createElement("td");
			                var img = document.createElement("img");
			                img.src = "img/<%=user_info.getUserProfileImg()%>";
			                img.style.width="30px"
			                img.className = "comment_user_img"; // 클래스 추가
			                imgtd.appendChild(img);

			                // 내용 셀
			                var contenttd = document.createElement("td");
			                contenttd.style.width="300px"
			                contenttd.innerHTML = "<b><%=user_info.getUserNick()%></b> : " + inputComment; // innerHTML을 사용
							
			                
			                // 날짜 셀
			                var datetd = document.createElement("td");
			                var dateP = document.createElement("p");
			                dateP.style.fontSize = "9px";
			                dateP.style.color = "gray"; // 'font-color'가 아니라 'color' 사용
			                dateP.innerText = new Date().toISOString().slice(0, 10); // 현재 날짜를 YYYY-MM-DD 형식으로 표시
			                datetd.appendChild(dateP);

			                // 행에 셀 추가
			                tr.appendChild(imgtd);
			                tr.appendChild(contenttd);
			                tr.appendChild(datetd);

			                // 댓글 테이블에 행 추가
			                document.querySelector(".comment-table").appendChild(tr); // getElementByClassName는 없습니다. querySelector 사용
			                alert("댓글이 저장되었습니다")
			            },
			            error: function () {
			                console.log("댓글 저장 실패");
			            }
			        });
			    } else {
			        alert("댓글을 입력해주세요.");
			    }
			}
			//좋아요 누른 게시글일때
			function toggleLikeN(post_idx) {
			    var likeButton = document.getElementById('like');
			    likeButton.classList.toggle('active');
			    
			    var likeCountElement = document.querySelector('.likes');
			    var likeCount = parseInt(likeCountElement.textContent);
			    
			    if (likeButton.classList.contains('active')) {
			        // 좋아요를 눌렀을 때
			        likeCount += 1;
			        likeButton.src='img/빨간색하트.png';
			        $.ajax({
			            url: "LikeService",
			            data: { "post_idx": post_idx, "like": "y" },
			            type: 'get',
			            success: function (result) {
			                console.log("좋아요 DB저장완료")
			            },
			            error: function () {
			                console.log("통신 실패")
			            }
			        });
			    } else {
			        // 좋아요 취소 했을 때
			        likeCount -= 1;
			        likeButton.src='img/흰색하트.png';
			        $.ajax({
			            url: "LikeService",
			            data: { "post_idx": post_idx, "like": "n" },
			            type: 'get',
			            success: function (result) {
			                console.log("좋아요 삭제 완료")
			            },
			            error: function () {
			                console.log("통신 실패")
			            }
			        });
			    }

			    likeCountElement.textContent = likeCount;
			}
			//좋아요 안누른 게시글 일때
			function toggleLikeY(post_idx) {
			    var likeButton = document.getElementById('like');
			    likeButton.classList.toggle('active');
			    
			    var likeCountElement = document.querySelector('.likes');
			    var likeCount = parseInt(likeCountElement.textContent);
			    if (likeButton.classList.contains('active')) {
			         // 좋아요 취소 했을 때
			        likeCount -= 1;
			        likeButton.src='img/흰색하트.png';
			        $.ajax({
			            url: "LikeService",
			            data: { "post_idx": post_idx, "like": "n" },
			            type: 'get',
			            success: function (result) {
			                console.log("좋아요 삭제 완료")
			            },
			            error: function () {
			                console.log("통신 실패")
			            }
			        });
			    } else {
			    	 // 좋아요를 눌렀을 때
			        likeCount += 1;
			        likeButton.src='img/빨간색하트.png';
			        $.ajax({
			            url: "LikeService",
			            data: { "post_idx": post_idx, "like": "y" },
			            type: 'get',
			            success: function (result) {
			                console.log("좋아요 DB저장완료")
			            },
			            error: function () {
			                console.log("통신 실패")
			            }
			        });
			    }

			    likeCountElement.textContent = likeCount;
			}	
			
			function togglefollowN(post_user_id) {
			    console.log("togglefollowN");
			    var followButton = document.querySelector('.follow');
			    followButton.classList.toggle('active');
			    var post_userid = post_user_id;
			    console.log("togglefollowN , post_userid:" + post_userid);
			    if (followButton.classList.contains('active')) {
			        followButton.textContent = '팔로잉';
			        
			        $.ajax({
			            url: "FollowService",
			            data: { "post_userid": post_userid, "follow": "y" },
			            type: 'get',
			            success: function (result) {
			                console.log("팔로우 DB저장완료");
			            },
			            error: function () {
			                console.log("통신 실패");
			            }
			        });
			        
			    } else {
			        followButton.textContent = '팔로우';
			        $.ajax({
			            url: "FollowService",
			            data: { "post_userid": post_userid, "follow": "n" },
			            type: 'get',
			            success: function (result) {
			                console.log("팔로우 DB삭제완료");
			            },
			            error: function () {
			                console.log("통신 실패");
			            }
			        });
			    }
			}

			function togglefollowY(post_user_id) {
			    console.log("togglefollowY");
			    var followButton = document.querySelector('.follow');
			    followButton.classList.toggle('active');
			    var post_userid = post_user_id;
			    console.log("post_userid: " + post_userid);

			    if (followButton.classList.contains('active')) {
			        followButton.textContent = '팔로우';
			        $.ajax({
			            url: "FollowService",
			            data: { "post_userid": post_userid, "follow": "n" },
			            type: 'get',
			            success: function (result) {
			                console.log("팔로우 DB삭제완료");
			            },
			            error: function () {
			                console.log("통신 실패");
			            }
			        });
			    } else {
			        followButton.textContent = '팔로잉';
			        $.ajax({
			            url: "FollowService",
			            data: { "post_userid": post_userid, "follow": "y" },
			            type: 'get',
			            success: function (result) {
			                console.log("팔로우 DB저장완료");
			            },
			            error: function () {
			                console.log("통신 실패");
			            }
			        });
			    }
			}
			
			$(document).ready(function() {
			   $('.isdel').on('click', function(e) {
				  
					var del =confirm('게시글을 삭제하시겠습니까?')
					if(del){
					 var postIdx = $('[name="postIdx"]').val();	
					$.ajax({
						url: "DeleteService",
			            data: {"postIdx":postIdx},
			            type: 'get',
			            success: function (result) {
			                console.log("삭제 완료");
			            },
			            error: function () {
			                console.log("삭제 실패");
			            }
						})
						alert("게시글이 삭제됐습니다.")
			        e.preventDefault(); // 기본 이벤트 차단
			        var targetUrl = $(this).attr('href'); // 이동할 URL 가져오기

			        // 최상위 창의 URL을 변경하여 부모 페이지 이동 시도
			        window.top.location.href = targetUrl;}
			    });
			});
			
 </script>
 
 
 
 


</body>
</html>