package com.mc.worktown;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.mc.worktown.model.SocketInModel;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Component;

import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * 管理用socket类
 *
 * @author malin
 * @version 1.0
 */
@ServerEndpoint(value = "/online")
@Component
public class OnlineServer {
    private ObjectMapper mapper =  new ObjectMapper();
    private static Map<String, Map<String, Session>> teamOnlines = new HashMap<>();
    /**
     * 连接建立成功调用的方法
     *
     * @param session socket信息
     */
    @OnOpen
    public void onOpen(Session session) throws Exception {
        System.out.println("open" + session.getQueryString());

        String userCode = getCode(session);
        String teamCode =  getTeam(session);
        String clientId = getClientId(session);

        Map<String, Session> teamMap = findTeam(teamCode);
        if (teamMap == null) {
            teamMap = new HashMap<>();
            teamOnlines.put(teamCode, teamMap);
        }

        Session userSession = findUser(teamMap, userCode);

        if (userSession != null) {
            String userClientId = getClientId((userSession));
            if (clientId.equals(userClientId)) {
                // 忽略同一客户端的重复登录
                return;
            }
            send(userSession, SocketInModel.kickOut());
            teamMap.remove(userCode);
        }

        teamMap.put(userCode, session);

        brastcast(session, SocketInModel.memberIn(userCode));
    }

    /**
     * 连接关闭调用的方法
     */
    @OnClose
    public void onClose(Session session) throws Exception {
        System.out.println("close");
        String userCode = getCode(session);
        String teamCode = getTeam(session);
        String clientId = getClientId(session);
        Map<String, Session> teamMap = findTeam(teamCode);
        Session userSession = findUser(teamMap, userCode);
        String userClientId = getClientId(userSession);
        if (!clientId.equals(userClientId)) {
            return;
        }
        brastcast(session, SocketInModel.memberOut(userCode));
        teamMap.remove(userCode);
        if (teamMap.size() == 0) {
            teamOnlines.remove(teamCode);
        }
    }

    /**
     * 收到客户端消息后调用的方法
     *
     * @param message 客户端发送过来的消息
     */
    @OnMessage
    public void onMessage(String message, Session session) throws Exception  {
        System.out.println("message: " + message);
        String userCode = getCode(session);
        SocketInModel msg = mapper.readValue(message, SocketInModel.class);
        msg.setUserCode(userCode);
        if (StringUtils.isNotBlank(msg.getTargetCode())) {
            Map<String, Session> teamMap = findTeam(session);
            Session targetSession = findUser(teamMap, msg.getTargetCode());
            send(targetSession, msg);
        } else {
            brastcast(session, msg);
        }
    }

    /**
     * 发生错误时调用
     */
    @OnError
    public void onError(Session session, Throwable error) {
        error.printStackTrace();
    }

    private Map<String, Session>  findTeam(Session session) throws Exception {
        String teamCode = getTeam(session);
        return findTeam(teamCode);
    }
    private Map<String, Session>  findTeam(String teamCode) {
        for (Map.Entry<String, Map<String, Session>> e : teamOnlines.entrySet()) {
            String key = e.getKey();
            Map<String, Session> team = e.getValue();
            if (teamCode.equals(key)) {
                return team;
            }
        }
        return null;
    }

    private  Session findUser(Map<String, Session> team, String userCode) {
        for (Map.Entry<String, Session> entry : team.entrySet()) {
            String code = entry.getKey();
            Session userSession = entry.getValue();
            if (userCode.equals(code)) {
                return userSession;
            }
        }
        return null;
    }

    private  String getCode(Session session) throws Exception {
        try {
            return session.getRequestParameterMap().get("code").get(0);
        } catch (Exception e) {
            throw new Exception("no para code");
        }
    }

    private  String getTeam(Session session) throws Exception  {
        try {
            final String team = session.getRequestParameterMap().get("team").get(0);
            return team;
        } catch (Exception e) {
            throw new Exception("no para team");
        }
    }

    private  String getClientId(Session session) throws Exception  {
        try {
            final String team = session.getRequestParameterMap().get("clientId").get(0);
            return team;
        } catch (Exception e) {
            throw new Exception("clientId");
        }
    }
//
//    private void send (Session session, SocketInModel msgModel) throws IOException {
//        send(session, msgModel);
//    }
//
//    private void send (Session session, String msg) throws IOException {
//        send(session, msg);
//    }

    private  void send  (Session session, SocketInModel msgModel) throws IOException {
        send(session, mapper.writeValueAsString(msgModel));
    }

    private  void send  (Session session, String msg) throws IOException {
        if (session.isOpen()) {
            session.getAsyncRemote().sendText(msg);
        }
    }
    private  void brastcast(Session session, SocketInModel msgModel) throws Exception {
        brastcast(session, mapper.writeValueAsString(msgModel));
    }
    private  void brastcast(Session session, String msg) throws Exception {
        String userCode = getCode(session);
        String teamCode =  getTeam(session);
        Map<String, Session> teamMap = findTeam(teamCode);

        teamMap.forEach((memeberCode, memberSession) -> {
            if (memeberCode.equals(userCode)) {
                return;
            }
            try {
                send(memberSession, msg);
            } catch (IOException e) {
                e.printStackTrace();
            }
        });
    }
}
