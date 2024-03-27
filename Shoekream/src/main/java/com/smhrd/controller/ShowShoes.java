package com.smhrd.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.smhrd.model.ShoesDAO;
import com.smhrd.model.ShoesDTO;

public class ShowShoes extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	//System.out.println("showShoes 도착");
		
		request.setCharacterEncoding("UTF-8");
		
		String inputText=request.getParameter("inputText");
		// 전체 리스트
		 ShoesDAO sdao = new ShoesDAO();
		 ArrayList<ShoesDTO> allShoes = sdao.showShoes();
		 
		// 필터링된 결과를 담을 리스트 생성
		    ArrayList<ShoesDTO> filteredShoes = new ArrayList<>();

		 // 검색어가 있을 경우 필터링 작업 수행
		    if (inputText != null && !inputText.isEmpty()) {
		        for (ShoesDTO shoes : allShoes) {
		            // 예시: ShoesDTO에서 검색어에 해당하는 필드를 찾아서 일치하는 경우에만 결과 리스트에 추가
		            if (shoes.getShoe_name().contains(inputText)) {
		                filteredShoes.add(shoes);
		            }
		        }
		    } else {
		        // 검색어가 없는 경우 전체 리스트를 반환
		        filteredShoes = allShoes;
		    }    
		    
		 // Gson 라이브러리를 사용하여 JSON 형식으로 변환합니다.
		    Gson gson = new Gson();
		    String json = gson.toJson(filteredShoes);

		    // JSON 응답 전송
		    response.setContentType("application/json");
		    response.setCharacterEncoding("UTF-8");
		    response.getWriter().write(json);
		
	}

}