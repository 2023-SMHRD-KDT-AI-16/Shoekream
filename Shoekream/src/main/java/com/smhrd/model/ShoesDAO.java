package com.smhrd.model;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.smhrd.db.SqlSessionManager;

public class ShoesDAO {
	SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession();
	
	//신발 정보 모두 불러오는 메서드 
	public  ArrayList<ShoesDTO> showShoes() {
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		ArrayList<ShoesDTO> s_list= (ArrayList) sqlSession.selectList("showShoes");
		sqlSession.close();
		return s_list;
	}
	
	
	
}
