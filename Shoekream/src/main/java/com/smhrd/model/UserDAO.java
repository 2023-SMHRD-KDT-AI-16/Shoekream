package com.smhrd.model;


import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.smhrd.db.SqlSessionManager;

public class UserDAO {

    SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession();
    
    public int login(String userID, String userPassword) {
        try (SqlSession session = sqlSessionFactory.openSession()) {
            String dbPassword = session.selectOne("user.UserMapper.login", userID);
            if (dbPassword != null) {
                return dbPassword.equals(userPassword) ? 1 : 2;
            }
            return 0;
        }
    }
    
    public int registerCheck(String userID) {
        try (SqlSession session = sqlSessionFactory.openSession()) {
            Integer count = session.selectOne("user.UserMapper.registerCheck", userID);
            return (count != null && count > 0) || userID.equals("") ? 0 : 1;
        }
    }
    
    public int register(UserDTO user) {
        try (SqlSession session = sqlSessionFactory.openSession(true)) {
            return session.insert("user.UserMapper.register", user);
        }
    }
    
    public UserDTO getUser(String userID) {
        try (SqlSession session = sqlSessionFactory.openSession()) {
            return session.selectOne("user.UserMapper.getUser", userID);
        }
    }
    
    public int update(UserDTO user) {
        try (SqlSession session = sqlSessionFactory.openSession(true)) {
            return session.update("user.UserMapper.update", user);
        }
    }
    
    public int profile(String userID, String userProfile) {
        Map<String, Object> params = new HashMap<>();
        params.put("userID", userID);
        params.put("userProfile", userProfile);
        try (SqlSession session = sqlSessionFactory.openSession(true)) {
            return session.update("user.UserMapper.profile", params);
        }
    }
    
    public String getProfile(String userID) {
        try (SqlSession session = sqlSessionFactory.openSession()) {
            return session.selectOne("user.UserMapper.getProfile", userID);
        }
    }
}