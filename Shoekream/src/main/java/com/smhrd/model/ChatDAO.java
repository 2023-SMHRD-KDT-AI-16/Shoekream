package com.smhrd.model;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.smhrd.db.SqlSessionManager;
import java.util.HashMap;
import java.util.List;

public class ChatDAO {

    SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession();
    
	 // 최근 메세지 목록 가져오기
    public List<ChatDTO> getChatListByRecent(String fromID, String toID, int number) {
        SqlSession session = sqlSessionFactory.openSession();
        HashMap<String, Object> paramMap = new HashMap<>();
        paramMap.put("fromID", fromID);
        paramMap.put("toID", toID);
        paramMap.put("number", number);
        List<ChatDTO> chatList = session.selectList("ChatMapper.getChatListByRecent", paramMap);
        session.close();
        return chatList;
    }

    // 메세지 전송
    public int submit(String fromID, String toID, String chatContent) {
        SqlSession session = sqlSessionFactory.openSession();
        HashMap<String, Object> paramMap = new HashMap<>();
        paramMap.put("fromID", fromID);
        paramMap.put("toID", toID);
        paramMap.put("chatContent", chatContent);
        int result = session.insert("ChatMapper.submit", paramMap);
        session.commit();
        session.close();
        return result;
    }

    // 메세지 읽음 처리
    public int readChat(String fromID, String toID) {
        SqlSession session = sqlSessionFactory.openSession();
        HashMap<String, Object> paramMap = new HashMap<>();
        paramMap.put("fromID", fromID);
        paramMap.put("toID", toID);
        int result = session.update("ChatMapper.readChat", paramMap);
        session.commit();
        session.close();
        return result;
    }

    // 안 읽은 메세지 수 가져오기
    public int getAllUnreadChat(String userID) {
        SqlSession session = sqlSessionFactory.openSession();
        int count = session.selectOne("ChatMapper.getAllUnreadChat", userID);
        session.close();
        return count;
    }

    // 대화 상자 가져오기
    public List<ChatDTO> getBox(String userID) {
        SqlSession session = sqlSessionFactory.openSession();
        List<ChatDTO> chatList = session.selectList("ChatMapper.getBox", userID);
        session.close();
        return chatList;
    }

    // 특정 사용자로부터 온 안 읽은 메세지 수
    public int getUnreadChat(String fromID, String toID) {
        SqlSession session = sqlSessionFactory.openSession();
        HashMap<String, Object> paramMap = new HashMap<>();
        paramMap.put("fromID", fromID);
        paramMap.put("toID", toID);
        int count = session.selectOne("ChatMapper.getUnreadChat", paramMap);
        session.close();
        return count;
    }}
