package com.smhrd.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.smhrd.model.CommentDAO;
import com.smhrd.model.CommentDTO;
import com.smhrd.model.UserDTO;
 class WriteCommentDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
System.out.println("댓글작성 서비스 도착");
		
		//요청값에서 댓글 데이터 꺼내오기
		request.setCharacterEncoding("UTF-8");
		
		String comment=request.getParameter("inputComment");
		String postIdx=request.getParameter("postIdx");
		Double postIdx2= Double.parseDouble(postIdx);
		//dto,dao 생성
		
		System.out.println("인덱스번호"+postIdx2);
		System.out.println("댓글내용"+comment);
		
		CommentDTO dto = new CommentDTO();
		CommentDAO dao = new CommentDAO();
		dto.setCmt_content(comment);
		dto.setPost_idxf(postIdx2);
		
		HttpSession session = request.getSession();
		UserDTO user_info = (UserDTO)session.getAttribute("user_info");
		dto.setUser_id(user_info.getUserId());
		int result = dao.comment(dto);
		if(result>0) {
			System.out.println("댓글 저장 성공");
		}else {
			System.out.println("댓글 저장 실패");
		}
		
		response.sendRedirect("PostDetail?postIdx="+postIdx2);
		
		
		
	}

}
