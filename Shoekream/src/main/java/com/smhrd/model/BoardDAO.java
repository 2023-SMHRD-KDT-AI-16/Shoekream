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
	

}
