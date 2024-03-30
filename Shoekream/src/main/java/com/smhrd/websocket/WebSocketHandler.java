package com.smhrd.websocket;

import java.util.ArrayList;
import java.util.List;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.RemoteEndpoint.Basic;
import javax.websocket.Session;
import javax.websocket.server.*;


// Web Socket용 url mapping 주소
@ServerEndpoint("/echo.do") // --> javax.websocket library 로딩함.
public class WebSocketHandler {
    private static final List<Session> sessionList = new ArrayList<Session>();

    public WebSocketHandler() {
        System.out.println("웹소켓 객체 생성");
    }

    @OnOpen
    public void onOpen(Session session) {
        try {
            System.out.println("채팅방 연결 성공: Session ID = " + session.getId());
            sessionList.add(session);
        } catch (Exception e) {
            System.out.println("OnOpen Exception: " + e.getMessage());
        }
    }

    @OnClose
    public void onClose(Session session) {
        sessionList.remove(session);
        System.out.println("Session Closed: " + session.getId());
    }

    @OnMessage
    public void onMessage(String message, Session session) {
        sendAllSessionToMessage(session, message);
    }

    private void sendAllSessionToMessage(Session self, String message) {
        sessionList.forEach(session -> {
            try {
                if (session.isOpen() && !self.getId().equals(session.getId())) {
                    session.getBasicRemote().sendText(message);
                }
            } catch (Exception e) {
                System.out.println("Send Message Exception: " + e.getMessage());
                sessionList.remove(session); // 이 부분은 신중하게 고려. ConcurrentModificationException을 피하기 위해 다른 방식을 고려할 수도 있음.
            }
        });
    }
}
