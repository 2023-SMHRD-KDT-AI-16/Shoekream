package com.smhrd.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.smhrd.model.UserDAO;
import com.smhrd.model.UserDTO;

public class JoinService extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//회원가입을 위한 서비스
				//1.요청값 인코딩하여 받아오기
				request.setCharacterEncoding("UTF-8");
				
				//2.요청값에서 필요한 데이터 꺼내오기
				String user_name = request.getParameter("user_name");
				String user_nick = request.getParameter("user_nick");
				String user_email = request.getParameter("user_email");
				String user_id = request.getParameter("user_id");
				String user_pw = request.getParameter("user_pw");
				String user_phone = request.getParameter("user_phone");
				
				//3.처리해야 하는 로직 구현
				UserDTO dto = new UserDTO(user_id,user_pw,user_name,user_phone,user_email,user_nick);
				
				UserDAO dao = new UserDAO();
				
				//4.결과 처리 
				int result = dao.join(dto);
				if(result >0) {
					System.out.println("회원가입 성공");
					request.setAttribute("user_name", user_name);
					RequestDispatcher rd=request.getRequestDispatcher("JoinSuccess.jsp");
					rd.forward(request, response);
					
				}
		
		
		
	}

}
