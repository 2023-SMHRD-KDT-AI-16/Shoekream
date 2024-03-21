
package com.smhrd.model;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.smhrd.db.SqlSessionManager;

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
    }
    public String getTen(String fromID, String toID) {
        List<ChatDTO> chatList = getChatListByRecent(fromID, toID, 10); // 최근 10개 메시지 조회
        try {
            ObjectMapper mapper = new ObjectMapper();
            return mapper.writeValueAsString(chatList); // List를 JSON 문자열로 변환
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    // 특정 ID 이후 메시지 가져오기 (예시 구현)
    public String getID(String fromID, String toID, String chatID) {
        // ID에 해당하는 메시지 조회 로직 구현 필요
        // 이 예제에서는 해당 기능을 직접적으로 지원하는 MyBatis 쿼리가 필요하며, ChatMapper.xml에 쿼리를 추가해야 합니다.
        // 예시 코드에서는 실제 조회 로직 대신 임시 문자열을 반환
        return "[]"; // 임시로 빈 JSON 객체를 문자열로 반환
    }
}
