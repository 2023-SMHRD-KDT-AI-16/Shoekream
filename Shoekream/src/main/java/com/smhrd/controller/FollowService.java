package com.smhrd.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.smhrd.model.FollowDAO;
import com.smhrd.model.FollowDTO;
import com.smhrd.model.UserDTO;


public class FollowService extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("FollowService 도착");
		HttpSession session = request.getSession();
		UserDTO user_info = (UserDTO)session.getAttribute("user_info");
		String follower = user_info.getUserId();
		String followee= request.getParameter("post_userid");
		String followyn = request.getParameter("follow");
		
		FollowDAO dao = new FollowDAO();
		FollowDTO dto = new FollowDTO();
		dto.setFollower(follower);
		dto.setFollowee(followee);
		boolean isfollow=dao.isfollow(dto);
int result=0;
		
		if(followyn.equals("y")&&!isfollow) {
			
			 result=dao.savefollow(dto);
			
			
		}else {
			result=dao.delfollow(dto);
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
