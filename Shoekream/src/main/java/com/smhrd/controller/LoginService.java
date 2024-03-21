package com.smhrd.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.smhrd.model.UserDAO;
import com.smhrd.model.UserDTO;


public class LoginService extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1.인코딩
				try {
					request.setCharacterEncoding("UTF-8");
				} catch (UnsupportedEncodingException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				//2.데이터 꺼내오기
				String id =request.getParameter("id");
				String pw = request.getParameter("pw");
				System.out.println("id :" +id+" pw : "+pw);
				
				//id,pw를 넣어 회원인지 확인
				UserDTO dto = new UserDTO();
				dto.setUserId(id);
				dto.setUserPw(pw);
				
				UserDAO dao = new UserDAO();
				UserDTO result = dao.login(dto);
				
				if(result !=null) {
					//회원의 정보를 저장하여 이동할 수 있도록 수정 ! -> session 영역 
					//session 영역 불러오기 
					HttpSession session = request.getSession();//request의 session을 가져와서 session변수에 담기
					session.setAttribute("user_info",result);
					System.out.println("로그인 성공");
					System.out.println(result.getUserName());
					response.sendRedirect("Main.jsp");
					
				}
				
				
				
	}

}
