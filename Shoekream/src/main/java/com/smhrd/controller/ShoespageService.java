package com.smhrd.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.smhrd.model.BoardDAO;
import com.smhrd.model.BoardDTO;
import com.smhrd.model.ShoesDAO;
import com.smhrd.model.ShoesDTO;

public class ShoespageService extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		
		System.out.println("신발페이지 서비스 도착");
		
		request.setCharacterEncoding("UTF-8");
		//신발 태그 id 가져오기 
		String shoe_tag = request.getParameter("shoeId");
		System.out.println(shoe_tag);
		
		//신발 정보 불러오기 
		ShoesDAO sdao = new ShoesDAO();
		ShoesDTO shoes_info = sdao.shoes_info(shoe_tag);
		System.out.println(shoes_info.getShoe_name());
		
		BoardDAO bdao = new BoardDAO();
		ArrayList<BoardDTO> p_list = bdao.shoesPost(shoe_tag);
		
		request.setAttribute("shoes_info",shoes_info);
		request.setAttribute("p_list", p_list);
		RequestDispatcher dispatcher = request.getRequestDispatcher("ShoesPage.jsp");
		dispatcher.forward(request, response);
		
		
		
		
	}

}
