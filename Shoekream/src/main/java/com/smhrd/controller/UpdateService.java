package com.smhrd.controller;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.smhrd.model.UserDAO;
import com.smhrd.model.UserDTO;


public class UpdateService extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("프로필 업데이트서비스 도착");
		HttpSession session = request.getSession();
		UserDTO user_info = (UserDTO)session.getAttribute("user_info");
		
		String path ="C:\\Users\\User\\git\\Shoekream\\Shoekream\\src\\main\\webapp\\img";
		int maxSize = 1024*1024*7;
		String encoding = "UTF-8";
		DefaultFileRenamePolicy rename= new DefaultFileRenamePolicy();
		
		MultipartRequest multi = new MultipartRequest(request,path,maxSize,encoding,rename);
		String profileImage= URLEncoder.encode(multi.getFilesystemName("profileImage"),"UTF-8");
		String user_nick = multi.getParameter("user_nick");
		String user_pw = multi.getParameter("user_pw");
		String user_email = multi.getParameter("user_email");
		String post = multi.getParameter("post");
		String user_name = multi.getParameter("user_name");
		String user_phone = multi.getParameter("user_phone");
		
		
		UserDAO udao = new UserDAO();
		UserDTO dto = new UserDTO(user_info.getUserId(), user_pw, user_name, user_phone, user_email, user_nick);
		dto.setUserInfo(post);
		dto.setUserProfileImg(profileImage);
		int result=udao.updateuser(dto);
		if(result>0) {
			System.out.println("회원정보 수정 성공");
		}else {
			System.out.println("회원정보 수정 실패");
		}
		
		response.sendRedirect("MyPage.jsp");
		
		
	}

}
