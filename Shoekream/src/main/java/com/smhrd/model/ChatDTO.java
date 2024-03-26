package com.smhrd.model;

import java.sql.Timestamp; // Timestamp 타입을 사용하기 위한 import

public class ChatDTO {
    
    private int chatID; // chatID는 숫자 타입으로 변경
    private int roomIdx; // 채팅방 인덱스 추가
    private String fromID;
    private String toID;
    private String chatContent;
    private Timestamp chatTime; // java.sql.Timestamp 타입으로 변경

    // Getters and Setters
    public int getChatID() {
        return chatID;
    }

    public void setChatID(int chatID) {
        this.chatID = chatID;
    }
    public int getRoomIdx() { // roomIdx getter
        return roomIdx;
    }

    public void setRoomIdx(int roomIdx) { // roomIdx setter
        this.roomIdx = roomIdx;
    }

    public String getFromID() {
        return fromID;
    }

    public void setFromID(String fromID) {
        this.fromID = fromID;
    }

    public String getToID() {
        return toID;
    }

    public void setToID(String toID) {
        this.toID = toID;
    }

    public String getChatContent() {
        return chatContent;
    }

    public void setChatContent(String chatContent) {
        this.chatContent = chatContent;
    }

    public Timestamp getChatTime() {
        return chatTime;
    }

    public void setChatTime(Timestamp chatTime) {
        this.chatTime = chatTime;
    }
}