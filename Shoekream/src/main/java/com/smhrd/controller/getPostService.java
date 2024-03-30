package com.smhrd.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.smhrd.model.BoardDAO;
import com.smhrd.model.BoardDTO;
import com.smhrd.model.CommentDAO;
import com.smhrd.model.CommentDTO;
import com.smhrd.model.FollowDAO;
import com.smhrd.model.FollowDTO;
import com.smhrd.model.LikeDAO;
import com.smhrd.model.LikeDTO;
import com.smhrd.model.ShoesDAO;
import com.smhrd.model.UserDAO;
import com.smhrd.model.UserDTO;


public class getPostService extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.setCharacterEncoding("UTF-8");
		// 인덱스 번호 받아오기
	
		System.out.println("getPost");
		HttpSession session = request.getSession();


		String indexStr = request.getParameter("index");
		int index = Integer.parseInt(indexStr);

		
		UserDTO user_info = (UserDTO) session.getAttribute("user_info");

		BoardDAO dao = new BoardDAO();
		UserDAO udao = new UserDAO();
		ArrayList<BoardDTO> p_list = dao.showboard();
		// indexStr이 null이 아니고 숫자 형태인지 확인
		if (indexStr != null && index < p_list.size()) {
			// 문자열을 정수로 변환

			// 게시글 리스트에서 해당 인덱스의 게시글 내용을 가져옴
			System.out.println(index+"++");
			BoardDTO post_info = p_list.get(index);
			String post_nick=udao.usernick(post_info.getUserId());
			String post_profileimg = udao.profileimg(post_info.getUserId());
			
			//신발 이름 
			ShoesDAO sdao = new ShoesDAO();
			//String tag1_name = sdao.shoeName(post_info.getShoeTag1());
			//String tag2_name = sdao.shoeName(post_info.getShoeTag2());
			//String tag3_name = sdao.shoeName(post_info.getShoeTag3());
			//System.out.println("tag:"+tag1_name+tag2_name+tag3_name);
	
			// Gson 객체 생성
			Gson gson = new Gson();

			// 새로운 JSON 객체 생성
			JsonObject jsonObject = new JsonObject();

			// BoardDTO 객체의 속성을 JSON 객체에 추가
			jsonObject.addProperty("post_idx", post_info.getPostIdx());
			jsonObject.addProperty("post_content", post_info.getPostContent());
			jsonObject.addProperty("post_img", post_info.getPostImg());
			jsonObject.addProperty("posted_at", post_info.getPostedAt().toString());
			jsonObject.addProperty("post_user_id", post_info.getUserId());
			jsonObject.addProperty("post_nick", post_nick);
			jsonObject.addProperty("post_profileimg", post_profileimg);
			
			jsonObject.addProperty("shoe_tag1", post_info.getShoeTag1());
			//jsonObject.addProperty("tag1_name", tag1_name);			
			jsonObject.addProperty("shoe_tag2", post_info.getShoeTag2());
			//jsonObject.addProperty("tag2_name", tag2_name);
			jsonObject.addProperty("shoe_tag3", post_info.getShoeTag3());
			//jsonObject.addProperty("tag3_name", tag3_name);

			
			// 좋아요 정보 가져오기
			LikeDAO ldao = new LikeDAO();
			LikeDTO ldto = new LikeDTO();
			ldto.setPost_idx(p_list.get(index).getPostIdx());
			ldto.setUser_id(user_info.getUserId());
			boolean isLike = ldao.isLike(ldto);
			int like = ldao.Like(p_list.get(index).getPostIdx());
			
			jsonObject.addProperty("isLike",isLike);
			jsonObject.addProperty("countlike",like);
			
			
			//게시글별 최근 댓글 가져오기
			CommentDAO cdao = new CommentDAO();
            List<CommentDTO> c_list = cdao.showComment(p_list.get(index).getPostIdx());
        	if(!c_list.isEmpty()){
        		String cmtcontent=c_list.get(0).getCmt_content();
        		String cmtuserid=c_list.get(0).getUser_id();
        		String cmtusernick = udao.usernick(cmtuserid);
        		String cmtat=c_list.get(0).getCreated_at().toString();
        		
        		jsonObject.addProperty("cmtcontent",cmtcontent);
        		jsonObject.addProperty("cmtusernick",cmtusernick);
        		jsonObject.addProperty("cmtat",cmtat);
        		
        	}
			
        	//팔로우 여부 가져오기
            FollowDTO fdto = new FollowDTO();
            FollowDAO fdao = new FollowDAO();
            fdto.setFollowee(p_list.get(index).getUserId());
            fdto.setFollower(user_info.getUserId());
            boolean isfollow = fdao.isfollow(fdto);
            jsonObject.addProperty("isfollow",isfollow);

			// JSON 객체를 문자열로 변환
			String jsonData = gson.toJson(jsonObject);

			// 응답의 인코딩 설정
			response.setCharacterEncoding("UTF-8");

			// JSON 형식으로 응답
			PrintWriter out = response.getWriter();
			out.print(jsonData);
			out.flush();
		}else {
			String err ="오류";
			PrintWriter out = response.getWriter();
			out.print(err);
			
		}

		
		
		
	}

}
