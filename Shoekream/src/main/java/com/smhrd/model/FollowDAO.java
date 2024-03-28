package com.smhrd.model;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.smhrd.db.SqlSessionManager;

public class FollowDAO {
	SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession();
	
	//팔로우 여부 메서드
	public boolean isfollow(FollowDTO dto) {
		System.out.println("팔로우 여부 메서드");
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		boolean result= sqlSession.selectOne("isFollow",dto);
		System.out.println(result);
		sqlSession.close();
		return result;
	}
	
	//팔로우 저장 메서드
	public int savefollow(FollowDTO dto) {
		System.out.println("팔로우 저장");
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		int result= sqlSession.insert("savefollow",dto);
		System.out.println(result);
		sqlSession.close();
		return result;
	}
	
	//팔로우 삭제 메서드(언팔로우)
	public int delfollow(FollowDTO dto) {
		System.out.println("팔로우 삭제");
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		int result= sqlSession.delete("delfollow",dto);
		sqlSession.close();
		return result;
	}
	
	//팔로우 수 구하는 메서드 
	public int countfollow(String user_id) {
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		int result = sqlSession.selectOne("countfollow",user_id);
		sqlSession.close();
		System.out.println("팔로우 수 :"+result);
		return result;
	}
	
	//팔로워 수 구하는 메서드
	public int countfollower(String user_id) {
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		int result = sqlSession.selectOne("countfollower",user_id);
		sqlSession.close();
		System.out.println("팔로워 수 :"+result);
		return result;
	}
	
	
}
