package com.smhrd.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.smhrd.model.BoardDAO;


public class DeleteService extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	System.out.println("게시글 삭제 서비스 도착");
request.setCharacterEncoding("UTF-8");
		
		Double postIdx=Double.parseDouble(request.getParameter("postIdx"));
				
		BoardDAO dao = new BoardDAO();
		int result=dao.delpost(postIdx);
		
		if(result>0) {
			System.out.println("게시글 삭제 성공");
		}else {
			System.out.println("게시글 삭제 실패");
		}
		
		
		
		
		
		
	}

}
