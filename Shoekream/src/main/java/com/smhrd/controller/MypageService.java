package com.smhrd.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.smhrd.model.BoardDAO;
import com.smhrd.model.BoardDTO;
import com.smhrd.model.FollowDAO;
import com.smhrd.model.FollowDTO;
import com.smhrd.model.UserDAO;
import com.smhrd.model.UserDTO;

public class MypageService extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		System.out.println("MypageService 도착");
		
		request.setCharacterEncoding("UTF-8");
		
		//마이페이지의 유저 아이디
		String my_userid = request.getParameter("post_userid");
		System.out.println(my_userid);
		//로그인한 유저 정보
		HttpSession session = request.getSession();
		UserDTO user_info = (UserDTO) session.getAttribute("user_info");
		String user_id = user_info.getUserId();
		
		UserDAO udao = new UserDAO();
		BoardDAO dao = new BoardDAO();
	
		//마이페이지 유저의 게시글 정보 불러오기
		ArrayList<BoardDTO> p_list = dao.id_post(my_userid);
		
		//마이페이지 유저 정보 불러오기
		UserDTO my_user_info = udao.getUser(my_userid);
		
		//팔로우 여부
		FollowDTO fdto = new FollowDTO();
        FollowDAO fdao = new FollowDAO();
        fdto.setFollowee(my_userid);
        fdto.setFollower(user_info.getUserId());
        boolean isfollow = fdao.isfollow(fdto);
        
        //팔로우/팔로워 수
        int countfollow =fdao.countfollow(my_userid);
        int countfollower =fdao.countfollower(my_userid);
        
		
		request.setAttribute("my_id", my_userid);
		request.setAttribute("post_list", p_list);
		request.setAttribute("my_nick", my_user_info.getUserNick());
		request.setAttribute("my_profile", my_user_info.getUserProfileImg());
        request.setAttribute("isfollow", isfollow);
        request.setAttribute("countfollow",countfollow );
        request.setAttribute("countfollower",countfollower );
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("MyPage.jsp");
        dispatcher.forward(request, response);
        
	}

}
