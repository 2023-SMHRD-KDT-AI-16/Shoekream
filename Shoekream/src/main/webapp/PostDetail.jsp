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


Double postIdx=Double.parseDouble(request.getParameter("postIdx"));
// postIdx를 사용하여 원하는 작업 수행
out.println("Post Index: " + postIdx);

BoardDAO dao = new BoardDAO();
BoardDTO result=dao.showDetail(postIdx);
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
 
 


</body>
</html>