package com.smhrd.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.smhrd.model.UserDAO;
import com.smhrd.model.UserDTO;


public class NaverService extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("네이버 서비스 도착");
		
		request.setCharacterEncoding("UTF-8");
		
		//2.요청값에서 필요한 데이터 꺼내오기
		
		String user_name = (String)request.getAttribute("user_name");
		String user_nick = (String)request.getAttribute("user_nick");
		String user_email = (String)request.getAttribute("user_email");
		String user_id = (String)request.getAttribute("user_id");
		String user_pw = (String)request.getAttribute("user_pw");
		String user_phone = (String)request.getAttribute("user_phone");
		
		UserDTO dto = new UserDTO(user_id,user_id,user_name,user_phone,user_email,user_nick);
		UserDAO dao = new UserDAO();
		UserDTO result = dao.Naverlogin(dto);
		
		if(result !=null) {
			//회원의 정보를 저장하여 이동할 수 있도록 수정 ! -> session 영역 
			//session 영역 불러오기 
			HttpSession session = request.getSession();//request의 session을 가져와서 session변수에 담기
			session.setAttribute("user_info",result);
			System.out.println("로그인 성공");
			System.out.println(result.getUserName());
			response.sendRedirect("Main.jsp");
			
		}else {
			int result2 = dao.join(dto);
			if(result2 >0) {
				System.out.println("회원가입 성공");
				request.setAttribute("user_name", user_name);
				RequestDispatcher rd=request.getRequestDispatcher("JoinSuccess.jsp");
				rd.forward(request, response);
				
			}
			
		}
		
		
	}

}

