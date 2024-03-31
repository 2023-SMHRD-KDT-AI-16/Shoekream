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
	
	
	//신발 인덱스로 이름 반환하는 메서드 
	public String shoeName(String tag) {
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		String shoeName= sqlSession.selectOne("shoeName",tag);
		sqlSession.close();
		return shoeName;
	}
	
	
	//신발 인덱스로 모든 정보 불러오는 메서드 
	public ShoesDTO shoes_info(String shoe_tag) {
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		ShoesDTO shoes_info=sqlSession.selectOne("shoes_info",shoe_tag);
		sqlSession.close();
		return shoes_info;
	}
}
