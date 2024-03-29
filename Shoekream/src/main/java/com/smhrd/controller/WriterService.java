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
import com.smhrd.model.BoardDAO;
import com.smhrd.model.BoardDTO;
import com.smhrd.model.UserDTO;


public class WriterService extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		System.out.println("게시글 작성 서비스 도착");
		
		//게시글 작성 속성 가져오기 
		request.setCharacterEncoding("UTF-8");
		
		//신발정보 불러오기
		//String[] selectedShoes = request.get("selectedShoes");

		
//		//파일 업로드를 위한 multi 불러오기 
		String path ="C:\\Users\\User\\git\\Shoekream\\Shoekream\\src\\main\\webapp\\post_img";
		int maxSize = 1024*1024*7;
		String encoding = "UTF-8";
		DefaultFileRenamePolicy rename= new DefaultFileRenamePolicy();
		
		MultipartRequest multi = new MultipartRequest(request,path,maxSize,encoding,rename);
		String filename= URLEncoder.encode(multi.getFilesystemName("filename"),"UTF-8");
		String content = multi.getParameter("content");
		System.out.println(content+":"+filename);
//		
//		//-----------------------------------------------------------
//		HttpSession session = request.getSession();
//		UserDTO user_info = (UserDTO) session.getAttribute("user_info");
//		BoardDAO dao = new BoardDAO();
//		BoardDTO dto = new BoardDTO();
//		dto.setPostContent(content);
//		dto.setPostImg(filename);
//		dto.setUserId(user_info.getUserId());
//		int result = dao.upload(dto);
//		
//		if(result>0) {
//			System.out.println("게시글 등록 성공!");
//		}else {
//			System.out.println("등록 실패");
//		}
//		
//		response.sendRedirect("Main.jsp");
//	
	}

}
