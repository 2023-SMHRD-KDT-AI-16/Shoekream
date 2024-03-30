package com.smhrd.model;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.smhrd.db.SqlSessionManager;

public class UserDAO {
	
	SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession();
	SqlSession sqlSession = sqlSessionFactory.openSession(true);

	// 회원가입 메서드 생성
	public int join(UserDTO dto) {
		// 1.sqlSession 빌려오기
		SqlSession sqlSession = sqlSessionFactory.openSession(true); // -->true : 오토커밋

		// 2.sql문장 전달
		int result = sqlSession.insert("join", dto);

		// 3.결과 처리
		// 4.sqlSession 반납
		sqlSession.close();

		return result;
	}

	//로그인 메서드 생성
	public UserDTO login(UserDTO dto) {
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		
		UserDTO logindto=null;
		
		try {
			System.out.println("flag2");
			logindto=sqlSession.selectOne("login",dto);
			System.out.println("flag3");
				}catch(Exception e){
					e.printStackTrace();
				}finally {
					sqlSession.close();
				}
				return logindto;
	}

	//네이버 로그인 메서드
	public UserDTO Naverlogin(UserDTO dto) {
SqlSession sqlSession = sqlSessionFactory.openSession(true);
		
		UserDTO logindto=null;
		
		try {
			logindto=sqlSession.selectOne("naverlogin",dto);
				}catch(Exception e){
					e.printStackTrace();
				}finally {
					sqlSession.close();
				}
				return logindto;
	}

	
	//아이디 중복확인 메서드 
		public boolean checkID(String user_id) {
			SqlSession sqlSession = sqlSessionFactory.openSession(true);
			boolean result = false;
			try {
				result=sqlSession.selectOne("checkID",user_id);
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				sqlSession.close();
			}
			return result;
		}
		
		
	//아이디로 닉네임 찾기~
		public String usernick(String user_id) {
			SqlSession sqlSession = sqlSessionFactory.openSession(true);
			String result = null;
			try {
				result=sqlSession.selectOne("usernick",user_id);
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				sqlSession.close();
			}
			return result;
			
		}
		
		
	//아이디로 프로필 이미지 불러오기 
		public String profileimg(String user_id) {
			SqlSession sqlSession = sqlSessionFactory.openSession(true);
			String result = null;
			try {
				result=sqlSession.selectOne("profileimg",user_id);
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				sqlSession.close();
			}
			return result;
		}
		
		
		
	//아이디로 UserDTO 객체 불러오기
		public UserDTO getUser(String user_id) {
			SqlSession sqlSession = sqlSessionFactory.openSession(true);
			UserDTO result = null;
			try {
				result=sqlSession.selectOne("getUser",user_id);
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				sqlSession.close();
			}
			return result;	
		}
		
	
}