package com.smhrd.model;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.smhrd.db.SqlSessionManager;

public class CommentDAO {
	
	SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession();

	
	//댓글 작성 메서드
	public int comment(CommentDTO dto) {
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		int result=0;
		try {
		result = sqlSession.insert("comment", dto);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
		
		return result;
	}

	
	//댓글 전체 출력 메소드
	public ArrayList<CommentDTO> showComment(Double post_idx) {
		System.out.println("showComment 도착");
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		ArrayList<CommentDTO> result = null;
		try {
			result = (ArrayList)sqlSession.selectList("showComment",post_idx);
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				sqlSession.close();
			}
		
		return result;
	}
	
	
	
}