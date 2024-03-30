package com.smhrd.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.smhrd.model.ShoesDAO;
import com.smhrd.model.ShoesDTO;
import com.smhrd.model.UserDAO;
import com.smhrd.model.UserDTO;


public class SearchService extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		System.out.println("SearchService 도착");
		
				request.setCharacterEncoding("UTF-8");
				
				String inputText=request.getParameter("inputText");
				// 전체 리스트
//				 ShoesDAO sdao = new ShoesDAO();
//				 ArrayList<ShoesDTO> allShoes = sdao.showShoes();
//				
				    
				    //유저 리스트 담기
				    UserDAO udao = new UserDAO();
				    ArrayList<UserDTO> allUser = udao.allUser();
			
				   

			        Gson gson = new Gson();
			        String json = gson.toJson(allUser);
			        System.out.println(json);

				    // JSON 응답 전송
				    response.setContentType("application/json");
				    response.setCharacterEncoding("UTF-8");
				    response.getWriter().write(json);
				
		
		
		
		
		
	}

}
