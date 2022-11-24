package com.mc.worktown.model;

public class SocketInModel {
    private static String MESSAGE_IN = "member_in";
    private static String MESSAGE_OUT = "member_out";
    private static String MESSAGE_KICK_OUT = "kick_out";

    private String act;
    private String userCode;
    private String targetCode;
    private String tagString;

    public static SocketInModel memberIn(String code) {
        SocketInModel msg = new SocketInModel();
        msg.act = MESSAGE_IN;
        msg.userCode = code;
        return msg;
    }
    public static SocketInModel memberOut(String code) {
        SocketInModel msg = new SocketInModel();
        msg.act = MESSAGE_OUT;
        msg.userCode = code;
        return msg;
    }
    public static SocketInModel kickOut() {
        SocketInModel msg = new SocketInModel();
        msg.act = MESSAGE_KICK_OUT;
        return msg;
    }

    public String getAct() {
        return act;
    }

    public void setAct(String act) {
        this.act = act;
    }

    public String getUserCode() {
        return userCode;
    }

    public void setUserCode(String userCode) {
        this.userCode = userCode;
    }

    public String getTargetCode() {
        return targetCode;
    }

    public void setTargetCode(String targetCode) {
        this.targetCode = targetCode;
    }

    public String getTagString() {
        return tagString;
    }

    public void setTagString(String tagString) {
        this.tagString = tagString;
    }
}
