package com.smhrd.model;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.smhrd.db.SqlSessionManager;

public class BoardDAO {
	SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession();
	
	//게시글을 업로드하는 메서드
	public int upload(BoardDTO dto) {
		System.out.println("upload 도착");
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		int result= sqlSession.insert("upload",dto);
		sqlSession.close();
		return result;
	}
	
	//신발 태그 1개 업로드 
	public int uploadTag1(BoardDTO dto) {
		System.out.println("upload 도착");
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		int result= sqlSession.insert("uploadTag1",dto);
		sqlSession.close();
		return result;
	}
	
	//신발 태그 2개 업로드 
	public int uploadTag2(BoardDTO dto) {
		System.out.println("upload 도착");
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		int result= sqlSession.insert("uploadTag2",dto);
		sqlSession.close();
		return result;
	}
	
	
	//신발 태그 3개 업로드 
	public int uploadTag3(BoardDTO dto) {
		System.out.println("upload 도착");
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		int result= sqlSession.insert("uploadTag3",dto);
		sqlSession.close();
		return result;
	}
	
	
	
	//게시글을 수정하는 메서드
	public int update(BoardDTO dto) {
		System.out.println("update 도착");
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		int result= sqlSession.update("update",dto);
		sqlSession.close();
		return result;
	}
	
	//신발 태그 1개 수정 
	public int updateTag1(BoardDTO dto) {
		System.out.println("update 도착");
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		int result= sqlSession.update("updateTag1",dto);
		sqlSession.close();
		return result;
	}
	
	//신발 태그 2개 수정
	public int updateTag2(BoardDTO dto) {
		System.out.println("update 도착");
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		int result= sqlSession.update("updateTag2",dto);
		sqlSession.close();
		return result;
	}
	
	
	//신발 태그 3개 수정
	public int updateTag3(BoardDTO dto) {
		System.out.println("update 도착");
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		int result= sqlSession.update("updateTag3",dto);
		sqlSession.close();
		return result;
	}
	
	
	//전체 게시글을 불러오는 메서드
	public ArrayList<BoardDTO> showboard(){
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		ArrayList<BoardDTO> b_list= (ArrayList) sqlSession.selectList("showboard");
		sqlSession.close();
		return b_list;
	}
	
	//게시글을 작성한 user 정보 불러오는 메서드
	public UserDTO postuser(String post_user_id) {
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		UserDTO result = sqlSession.selectOne("postuser", post_user_id);
		sqlSession.close();
		return result;
	}

	//게시글 상세정보를 불러오는 메서드 
	public BoardDTO showDetail(Double postIdx) {
		System.out.println("showDetial 도착");
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		BoardDTO result = sqlSession.selectOne("showDetail", postIdx);
		sqlSession.close();
		return result;
	}
	
	//유저별 게시글 개수 
	public int countPost(String user_id) {
		System.out.println("user_id:"+user_id);
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		int result = sqlSession.selectOne("countPost",user_id);
		sqlSession.close();
		System.out.println(result);
		return result;
	}
	
	
	//유저별 게시글 정보 
	public ArrayList<BoardDTO> id_post(String post_userid) {
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		ArrayList<BoardDTO> p_list= (ArrayList) sqlSession.selectList("id_post",post_userid);
		sqlSession.close();
		return p_list;
	}

	//신발이 태그된 게시글 정보 
	public ArrayList<BoardDTO> shoesPost(String shoe_tag) {
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		ArrayList<BoardDTO> p_list= (ArrayList) sqlSession.selectList("shoesPost",shoe_tag);
		sqlSession.close();
		return p_list;
	}

	//게시글 삭제 메서드
	public int delpost(Double post_idx) {
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		int result = sqlSession.delete("delpost",post_idx);
		sqlSession.close();
		System.out.println(result);
		return result;
	}
	

}
