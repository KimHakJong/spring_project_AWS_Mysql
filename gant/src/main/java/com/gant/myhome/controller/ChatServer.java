package com.gant.myhome.controller;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.springframework.stereotype.Controller;

@Controller
@ServerEndpoint("/ChatServer")
public class ChatServer extends HttpServlet {
	private static final List<Session> sessionList=new ArrayList<Session>();
	private static HashMap<String,String> idstorage = new HashMap<String,String>();
	private static final long serialVersionUID = 1L;
    private static String receiveSession ="";
    
	//@OnOpen은 클라이언트 ㅡ> 서버로 접속할 때의 처리입니다.
	@OnOpen
	public void onOpen(Session session) {
		// 콘솔에 접속 로그를 출력
		System.out.println("새로운 클라이언트:"+session.getId());
		receiveSession=session.getId(); //새로들어온 클라이언트의 세션ID값 저장
		/*
		try {
	    	//자신과 연결된 session을 통해 문자열을 보냅니다.(즉, 자기 자신에게만 메시지 전달됩니다.)
	        session.getBasicRemote().sendText("연결되었습니다");
	    }catch (Exception e) {
	        System.out.println(e.getMessage());
	    }
	    */
	    sessionList.add(session);
	}

	@OnMessage
	public void onMessage(String message, Session session){
		System.out.println("receive:"+message);
		boolean welcome = false;
		if(message.indexOf("[|]") == -1) {
			int index = message.indexOf("님"); //이름
			if(index!= -1) {
				welcome = true;
				idstorage.put(receiveSession, message.substring(0,index-1));
				System.out.println(message.substring(0,index-1));
				Collection<String> names = idstorage.values(); //HasMap의 value들 [A,B,C]로 저장
				message += names;
				System.out.println(message);
			}
		}
		try {
			synchronized (sessionList) {
				for(Session s : sessionList) {
					if(welcome==false) {
						if(!s.equals(session)) { //자기한테 안보냄
							s.getBasicRemote().sendText(message);
						}
					}else { //채팅방들어왔을 때 메시지보내는 경우
						s.getBasicRemote().sendText(message);
					}
				}
			}
	    }catch (Exception e) {
	        System.out.println(e.getMessage());
	    }
	}


	//@OnClose는 접속이 끊겼을때 처리입니다.
	@OnClose
	public void onClose(Session session) {
		System.out.println("연결 종료된 클라이언트:"+session.getId());
		String closename = idstorage.get(session.getId()); //닫는 session의 이름
		idstorage.remove(session.getId());
		sessionList.remove(session); //닫는 session은 제거
		
		Collection<String> names = idstorage.values(); //HasMap의 value들 [A,B,C]로 저장
		try {
			synchronized (sessionList) {
				for(Session s : sessionList) {
						s.getBasicRemote().sendText(closename + " 님이 채팅방을 나갔습니다."+names);
						System.out.println(idstorage.get(session.getId())+" 님이 채팅방을 나갔습니다."+names);
				}
			}
	    }catch (Exception e) {
	        System.out.println(e.getMessage());
	    }
	}
	
	@OnError
	public void handleError(Throwable t) {
		 // 콘솔에 에러를 표시한다.
		 t.printStackTrace();
	}
}
