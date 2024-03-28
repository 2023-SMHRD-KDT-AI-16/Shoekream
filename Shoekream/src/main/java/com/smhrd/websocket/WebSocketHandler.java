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

	// 채팅방에 입장한 사람들의 session 정보를 저장하는 객체 --> 계속 공유해야 함(메모리에서 사라지면 안됨)
	private static final List<Session> sessionList = new ArrayList<Session>();

	// 채팅방을 만들어야 한다면, 채팅방을 모아놓는 공간
	// String : 채팅방을 구분하는 이름 / List<Session> : 해당 채팅방에 있는 사용자들 정보
	// private static final Map<String, List<Session>> room = new HashMap<String,List<Session>>();

	// 객체 생성 여부 확인을 위해 생성자에서 출력해서 확인
	public WebSocketHandler() {
		System.out.println("웹소켓 객체 생성");
	}

	// HttpSession과는 아예 별개로 소켓 Session!
	@OnOpen // (1) 열어주기
	public void onOpen(Session session) {
		// Session -> 입장한 사용자 정보 수집
		// session.getId() -> 사용자 고유의 아이디값 확인 가능
		// session.getBasicRemote() -> 메시지를 되돌려줄 주소 정보를 가져오는 방법
		try {
			// socket을 사용하는 사용자의 message를 보내줄 주소 정보를 담아서
			final Basic basic = session.getBasicRemote();
			
			// 해당 주소로 데이터 보내주기
			//session.getBasicRemote().sendText("{\"content\":\"채팅방 연결 성공~\"}");
			System.out.println("채팅방 연결 성공");
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.getMessage());
		}
		sessionList.add(session); //사용자 정보 추가
	}

	@OnClose // (2) 닫아주기
	public void onClose(Session session) {
		sessionList.remove(session); // 사용자가 접속할때마다 추가되는 형식으로 소켓이 닫히면 삭제해줘야함.
	}

	@OnMessage // (3) 메세지 수신 하는 방법
	public void onMessage(String message, Session session) {
		// 문자열 데이터만 받아올 수 있음 -> Gson을 이용하여 받아온 채팅을 JAVA객체로 변환가능!!!
		// Gson gson = new Gson();
		// Chat chatting = gson.fromJson(message, Chat.class); // 만약 사용자 닉네임이랑 같이 출력을 해줘야한다면 이렇게 보내주는게 맞겠죠?
		sendAllSessionToMessage(session, message);
		// 수신한 메세지를 보내주는 메소드(아래에 새로 만들어놨죠?) session --> 사용자 정보 / message --> 메세지
	}

	private void sendAllSessionToMessage(Session self, String message) {
		try {
			for (Session session : WebSocketHandler.sessionList) { // 해당 서버안에 들어와있는 사용자 정보를 전체 확인
				if (!self.getId().equals(session.getId())) { // 만약에 보낸이가 아닌 다른 사람이라면
					session.getBasicRemote().sendText(message); // 메세지를 전송하겠다.
				}
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}

}
