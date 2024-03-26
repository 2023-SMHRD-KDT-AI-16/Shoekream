package com.smhrd.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.smhrd.model.LikeDAO;
import com.smhrd.model.LikeDTO;
import com.smhrd.model.UserDTO;

 class LIkeService extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("LikeService 도착");
		HttpSession session = request.getSession();
		UserDTO user_info = (UserDTO)session.getAttribute("user_info");
		String user_id = user_info.getUserId();
		Double post_idx=Double.parseDouble(request.getParameter("post_idx"));
		String likeyn=request.getParameter("like");
		LikeDAO dao = new LikeDAO();
		LikeDTO dto = new LikeDTO();
		dto.setUser_id(user_id);
		dto.setPost_idx(post_idx);
		
		int result=0;
		
		if(likeyn.equals("y")) {
			
			 result=dao.saveLike(dto);
			
			
		}else {
			result=dao.delLike(dto);
		}
		
		PrintWriter out;
		
		try {
			out=response.getWriter();
			out.print(result);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

}