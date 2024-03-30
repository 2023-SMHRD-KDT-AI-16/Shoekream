<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@page import="com.smhrd.model.UserDTO"%>
<%@page import="com.smhrd.model.UserDAO"%>
<%@page import="com.smhrd.model.ShoesDAO"%>
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

String idx=request.getParameter("postIdx");
Double postIdx=Double.parseDouble(idx);
// postIdx를 사용하여 원하는 작업 수행
out.println("Post Index: " + postIdx);

BoardDAO dao = new BoardDAO();
BoardDTO result=dao.showDetail(postIdx);
CommentDAO cdao = new CommentDAO();
List<CommentDTO> c_list=cdao.showComment(postIdx);

ShoesDAO sdao = new ShoesDAO();
if(result.getShoeTag1()!=null){
	String tag1=sdao.shoeName(result.getShoeTag1());
	out.print("태그1:"+tag1);
}
if(result.getShoeTag2()!=null){
	String tag2=sdao.shoeName(result.getShoeTag2());
	out.print("태그2:"+tag2);
}
if(result.getShoeTag3()!=null){
	String tag3=sdao.shoeName(result.getShoeTag3());
	out.print("태그3:"+tag3);
}

//댓글 출력
for(int i=0;i<c_list.size();i++){
	out.print(c_list.get(i).getCmt_content());
	out.print("<br>");
}

//유저 정보 불러오기
UserDAO udao= new UserDAO();
UserDTO post_user_info= udao.getUser(result.getUserId());
out.print("아이디"+post_user_info.getUserId());
%>

<img alt="게시글이미지" src="post_img/<%=result.getPostImg()%>">
 내용: <%=result.getPostContent() %>
 
 
 <input type="text" placeholder="댓글달기..." id="postchat" name="comment">
<button onclick="writeComment(<%=postIdx%>)">댓글저장</button>  

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>

function writeComment(postIdx){
	var inputComment = $('[name="comment"]').val();
	  if(inputComment.trim() !== '') {
	        $.ajax({
	            url: 'WriteCommentService',
	            data: {"postIdx": postIdx, "inputComment": inputComment},
	            type: 'get',
	            success: function(result){
	                console.log("댓글 저장 성공");
	                // 댓글 저장 후 입력 필드 초기화
	                $('[name="comment"]').val('');
	            },
	            error: function(){
	                console.log("댓글 저장 실패");
	            }
	        });
	    } else {
	        alert("댓글을 입력해주세요.");
	    }
	
}

</script>

</body>
</html>