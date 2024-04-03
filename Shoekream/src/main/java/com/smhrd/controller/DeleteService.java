package com.smhrd.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.smhrd.model.BoardDAO;
import com.smhrd.model.CommentDAO;
import com.smhrd.model.LikeDAO;


public class DeleteService extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	System.out.println("게시글 삭제 서비스 도착");
request.setCharacterEncoding("UTF-8");
		
Double postIdx=Double.parseDouble(request.getParameter("postIdx"));
			System.out.println("삭제할 인덱스: "+postIdx);	
		BoardDAO dao = new BoardDAO();
		CommentDAO cdao = new CommentDAO();
		LikeDAO ldao = new LikeDAO();
		int result1=cdao.delpost_comment(postIdx);
		int result2=ldao.delpost_like(postIdx);
		
		int result3=dao.delpost(postIdx);
	System.out.println("delete");
		if(result3>0) {
			System.out.println("게시글 삭제 성공");
		}else {
			System.out.println("게시글 삭제 실패");
		}
		
		
	PrintWriter out;
		
		try {
			out=response.getWriter();
			out.print(result3);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		
	}

}
