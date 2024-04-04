<%@page import="com.smhrd.model.ShoesDTO"%>
<%@page import="com.smhrd.model.ShoesDAO"%>
<%@page import="com.smhrd.model.UserDTO"%>
<%@page import="com.smhrd.model.BoardDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<link rel="stylesheet" href="CSS/MyPage.css">
<style>
.grid-container {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 20px;
    margin-top: 10px;
     margin-right: -30px;
     margin-left: 30px;
}

</style>
<style type="text/css">


.hidden {
      display: none;
    }



/*게시글 모달*/
.modal2{
max-width:1200px !important;
height:800px;
}

.my_img{
width:450px;
height:450px
}

#shoekreamImg{
    width: 300px;
    height: 150px;
    margin-top: -30px;
    margin-left:0px;
}

.sidebar { position:fixed; top: 0; right: -300px; width: 300px; height: 100%; background:#ebf1f7; border:1px solid #eee;z-index: 30; transition: .35s;}

.user_post{
margin:10px
}

#my_profile_img{
heigth:300px;
width:300px;
}

 .my_img:hover {
 opacity: 0.5; /* 호버 시 투명도 변경 */
  }
</style>


</head>

<body>
   
   
   <%
   //세션에 저장된 로그인한 유저의 정보 불러오기 
   UserDTO user_info = (UserDTO) session.getAttribute("user_info");

   //마이페이지 유저 정보 가져오기!
   String my_id = (String) request.getAttribute("my_id");
   String my_nick = (String) request.getAttribute("my_nick");
   ArrayList<BoardDTO> post_list = (ArrayList<BoardDTO>) request.getAttribute("post_list");
   String my_profile = (String) request.getAttribute("my_profile");

   boolean isfollow = (boolean) request.getAttribute("isfollow");
   int countfollow = (int) request.getAttribute("countfollow");
   int countfollower = (int) request.getAttribute("countfollower");
   String userInfo= (String) request.getAttribute("userInfo");
   %>
  
    
   <input type="checkbox" id="menuicon" checked>
   <header>
      <div>
         <ul class="navi">
            <!-- 메뉴아이콘 -->
            <label for="menuicon" class="menubtn" > <span></span> <span></span>
               <span></span>
            </label>
            <li class="logo" ><a href="Main.jsp"><img id="shoekreamImg" src = "img/슈크림.jpg"></a></li>
         </ul>
      </div>
   </header>
   <div class="container">
      <div id="profile_wrap">
         <div class="profile_box1" style="width:660px; ">
            <div class="photo">
               <img id="my_profile_img" src="img/<%=my_profile%>" alt="기본프로필"> 
            </div>
            <br>
            <div class="right">
               <h1><%=my_nick%>
               
               
               <%if(my_id.equals(user_info.getUserId())){ %>
               <a href="ProfileSetting.jsp">
               <svg xmlns="http://www.w3.org/2000/svg"
                     width="24" height="24" viewBox="0 0 24 24"
                     style="fill: rgba(0, 0, 0, 1); margin-left: 150px;">
                     <path
                        d="M12 16c2.206 0 4-1.794 4-4s-1.794-4-4-4-4 1.794-4 4 1.794 4 4 4zm0-6c1.084 0 2 .916 2 2s-.916 2-2 2-2-.916-2-2 .916-2 2-2z"></path>
                     <path
                        d="m2.845 16.136 1 1.73c.531.917 1.809 1.261 2.73.73l.529-.306A8.1 8.1 0 0 0 9 19.402V20c0 1.103.897 2 2 2h2c1.103 0 2-.897 2-2v-.598a8.132 8.132 0 0 0 1.896-1.111l.529.306c.923.53 2.198.188 2.731-.731l.999-1.729a2.001 2.001 0 0 0-.731-2.732l-.505-.292a7.718 7.718 0 0 0 0-2.224l.505-.292a2.002 2.002 0 0 0 .731-2.732l-.999-1.729c-.531-.92-1.808-1.265-2.731-.732l-.529.306A8.1 8.1 0 0 0 15 4.598V4c0-1.103-.897-2-2-2h-2c-1.103 0-2 .897-2 2v.598a8.132 8.132 0 0 0-1.896 1.111l-.529-.306c-.924-.531-2.2-.187-2.731.732l-.999 1.729a2.001 2.001 0 0 0 .731 2.732l.505.292a7.683 7.683 0 0 0 0 2.223l-.505.292a2.003 2.003 0 0 0-.731 2.733zm3.326-2.758A5.703 5.703 0 0 1 6 12c0-.462.058-.926.17-1.378a.999.999 0 0 0-.47-1.108l-1.123-.65.998-1.729 1.145.662a.997.997 0 0 0 1.188-.142 6.071 6.071 0 0 1 2.384-1.399A1 1 0 0 0 11 5.3V4h2v1.3a1 1 0 0 0 .708.956 6.083 6.083 0 0 1 2.384 1.399.999.999 0 0 0 1.188.142l1.144-.661 1 1.729-1.124.649a1 1 0 0 0-.47 1.108c.112.452.17.916.17 1.378 0 .461-.058.925-.171 1.378a1 1 0 0 0 .471 1.108l1.123.649-.998 1.729-1.145-.661a.996.996 0 0 0-1.188.142 6.071 6.071 0 0 1-2.384 1.399A1 1 0 0 0 13 18.7l.002 1.3H11v-1.3a1 1 0 0 0-.708-.956 6.083 6.083 0 0 1-2.384-1.399.992.992 0 0 0-1.188-.141l-1.144.662-1-1.729 1.124-.651a1 1 0 0 0 .471-1.108z"></path></svg>
               </a>
              
              <%}else{%>   
              <button  style="margin-left: 150px;"><a href="ChatRoomCreate?my_id=<%=my_id%>">채팅하기</a></button>
              <%} %></h1>
               <!-- 프로필 네임 안에 user_name? user_nickname? -->
               <ulclass="user_post">
          
                 <h5>
                     <span style="margin-right:10px">게시글<%=post_list.size()%>  </span> <span style="margin-right:10px">팔로워 <%=countfollower%></span>
                     <span >팔로우 <%=countfollow%></span>
                     <br></h5>
                    
                     <% if(userInfo!=null){%>
                     <br>
                     <span><p style="color:#555 ; font-size:18px">소개글 : <%=userInfo %></p></span>
                     <%} %>
                 
               </ul>
            </div>
         </div>
      </div>
      
      
      <div class="content">
         <div class="grid-container">
            <!-- 마이페이지 게시물  -->
            <%
            for (int i = 0; i < post_list.size(); i++) {
            %>
            <div class="my_post<%=i%>">
              <div id="ex<%=i %>" class="modal2" style="display: none;">
   <iframe src="PostDetail.jsp?postIdx=<%=post_list.get(i).getPostIdx() %>" frameborder="0" style="width: 1200px; height: 800px;"></iframe>
            </div>
               <a  href="javascript:show(<%=i %>)"><img class="my_img"
                  src="post_img/<%=post_list.get(i).getPostImg()%>" alt="사진"></a>
            
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
				id="emo"><a href="Mainfollow.jsp">🙂</a></span>
					<a href="Mainfollow.jsp">팔로우 </a>
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
   
< <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-beta.1/dist/css/select2.min.css" rel="stylesheet"/>
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-beta.1/dist/js/select2.min.js"></script>
<script>
 
   //----------------------------------------------------------
   //신발 정보 검색
   
     $(document).ready(function() {
        $("body select").msDropDown();
    });
       $(document).ready(function() {
           $('#shoesOptions').select2({
               maximumSelectionLength: 3
           });
           filterShoes();
           filterShoes();
       });
       
       function filterShoes() {
             $.ajax({
               url: "ShowShoes",
               type: "get",
               success: function(result) {
                  console.log(result)
                  var arr = result;
                 
                  $('#shoesOptions').empty();
                  arr.forEach(function(shoes) {
                      $('#shoesOptions').append($('<option>', {
                          value: shoes.shoe_tag, 
                          text: shoes.shoe_name
                      }));
                  });
               }
           });
          
           
       }
       
       filterShoes()
   
//------------------------------------------------------------------------
   //모달 여러개...
    function show(num) {
      console.log("선택")
        $("#ex"+num).modal({
          fadeDuration: 100,
          fadeDelay: 1,
        });
      }   
       
     //-----------------------------------------------------------------------------
     //게시글 작성 모달
         function writePost() {
     	   console.log("게시글 작성")
             $("#writePost").modal({
               fadeDuration: 100,
               fadeDelay: 1,
             });
           }

//---------------------------------------------------------------
<%if(request.getAttribute("update")!=null){%>
alert("프로필을 수정했습니다")
<%}%>
   </script>
   

</body>

</html>