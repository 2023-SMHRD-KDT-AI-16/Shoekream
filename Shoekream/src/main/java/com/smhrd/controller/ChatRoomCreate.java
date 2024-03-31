package com.smhrd.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.smhrd.model.UserDAO;
import com.smhrd.model.UserDTO;


public class ChatRoomCreate extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
    	System.out.println("ChatRoomCreate 도착");
    	HttpSession session = request.getSession();
    	//로그인한 유저의 아이디
    	UserDTO currentUser= (UserDTO) session.getAttribute("user_info");
        
        //대화할 아이디
        String writerId = request.getParameter("my_id");
        System.out.println(writerId);
    	
       
        //System.out.println("[ChatRoomCreate] 서블릿 호출됨. 로그인된 사용자 ID: " + userId); // 로그 추가

        // 로그인한 유저의 닉네임과 프로필을 가져옴
       UserDAO udao = new UserDAO();
       UserDTO writer_user = udao.getUser(writerId);
      
       
       String writerProfile = writer_user.getUserProfileImg();
       String writerNick = writer_user.getUserNick();
       String contextPath = request.getContextPath();

       // redirectURL 생성 시, 모든 파라미터 값에 대해 URLEncoder.encode를 호출하여 URL 인코딩을 수행합니다.
       // 이렇게 하면, URL에 포함될 수 없는 문자들이 안전하게 인코딩되어 문제를 방지할 수 있습니다.
       String redirectURL = contextPath + "/chat-direct2.jsp?writerId=" + URLEncoder.encode(writerId, StandardCharsets.UTF_8.toString()) +
              "&writerProfile=" + URLEncoder.encode(writerProfile, StandardCharsets.UTF_8.toString()) +
              "&writerNick=" + URLEncoder.encode(writerNick, StandardCharsets.UTF_8.toString());

       // 생성된 redirectURL을 사용하여 사용자를 채팅방 페이지 chat-direct2(ORIGIN).jsp로 한 번만 리다이렉트합니다.
       response.sendRedirect(redirectURL);
    }}