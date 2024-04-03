package com.smhrd.model;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.smhrd.db.SqlSessionManager;

public class LikeDAO {
	SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession();
	
	//게시글당 좋아요 수 구하는 메서드 
	public int Like(Double postIdx){
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		int result = sqlSession.selectOne("Like",postIdx);
			sqlSession.close();

		return result;
	}

	
	//좋아요 저장하는 메서드
	public int saveLike(LikeDTO dto) {
		System.out.println("좋아요 저장");
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		int result= sqlSession.insert("saveLike",dto);
		System.out.println(result);
		sqlSession.close();
		return result;
	}


	//좋아요 삭제 메서드 
	public int delLike(LikeDTO dto) {
		System.out.println("좋아요 삭제");
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		int result= sqlSession.delete("delLike",dto);
		sqlSession.close();
		return result;
	}

	//좋아요 여부 메서드
	public boolean isLike(LikeDTO dto) {
		System.out.println("좋아요 여부 메서드");
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		boolean result= sqlSession.selectOne("isLike",dto);
		sqlSession.close();
		return result;
	}
	
	
	public int delpost_like(Double post_idx) {
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		int result=0;
		result = sqlSession.insert("delpost_like", post_idx);
		sqlSession.close();
		return result;
	}
	
}
