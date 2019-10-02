package com.mc.worktown.bean;

/**
 * 当前用户信息
 *
 * @author malin
 * @version 1.0
 */
public class CurrentUserInfo {

    /**
     * 编码
     */
    private String code;

    /**
     * 登录名
     */
    private String loginName;

    /**
     * 显示名
     */
    private String name;

    /**
     * 团队编码
     */
    private String teamCode;

    /**
     * 团队中的位置
     */
    private Integer orderIndex;

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getLoginName() {
        return loginName;
    }

    public void setLoginName(String loginName) {
        this.loginName = loginName;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getTeamCode() {
        return teamCode;
    }

    public void setTeamCode(String teamCode) {
        this.teamCode = teamCode;
    }

    public Integer getOrderIndex() {
        return orderIndex;
    }

    public void setOrderIndex(Integer orderIndex) {
        this.orderIndex = orderIndex;
    }
}
