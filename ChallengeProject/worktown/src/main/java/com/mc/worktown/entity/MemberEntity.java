package com.mc.worktown.entity;

import com.mc.worktown.annotation.Unique;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.validation.constraints.NotBlank;

/**
 * 用户信息
 *
 * @author malin
 * @version 1.0
 */
@Entity
@Table(name = "member")
@ApiModel(value = "用户信息")
public class MemberEntity extends BaseEntity {

    /**
     * serialVersionUID
     */
    private final static long serialVersionUID = -6168171687410896338L;

    /**
     * 登录名
     */
    @Unique(name = "登录名")
    @NotBlank(message = "loginName不能为空！")
    @Column(name = "login_name", nullable = false, length = 20)
    @ApiModelProperty(value = "登录名")
    private String loginName;

    /**
     * 密码
     */
    @NotBlank(message = "password不能为空！")
    @Column(name = "password", nullable = false, length = 20)
    @ApiModelProperty(value = "密码")
    private String password;

    /**
     * 显示名
     */
    @NotBlank(message = "name不能为空！")
    @Column(name = "name", nullable = false, length = 20)
    @ApiModelProperty(value = "显示名")
    private String name;

    /**
     * 团队编码
     */
    @Column(name = "team_code", length = 64)
    @ApiModelProperty(value = "团队编码")
    private String teamCode;

    /**
     * 团队中的位置
     */
    @Column(name = "order_index")
    @ApiModelProperty(value = "团队中的位置")
    private Integer orderIndex;


    public String getLoginName() {
        return loginName;
    }

    public void setLoginName(String loginName) {
        this.loginName = loginName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
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
