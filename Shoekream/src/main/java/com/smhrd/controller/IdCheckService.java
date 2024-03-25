package com.smhrd.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.smhrd.model.UserDAO;


public class IdCheckService extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		System.out.println("아이디체크 서비스 도착");
		String user_id = request.getParameter("user_id");
		
		UserDAO dao = new UserDAO();
		boolean result = dao.checkID(user_id);
		System.out.println(result);
		PrintWriter out;
		
		try {
			out=response.getWriter();
			out.print(result);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
	
	}

}
