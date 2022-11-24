package com.mc.worktown.model;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import javax.validation.constraints.NotBlank;

/**
 * 登录的输入信息
 *
 * @author malin
 * @version 1.0
 */
@ApiModel("登录的输入信息")
public class LoginInModel {

    /**
     * 登录名
     */
    @NotBlank(message = "loginName不能为空！")
    @ApiModelProperty(value = "登录名")
    private String loginName;

    /**
     * 密码
     */
    @NotBlank(message = "password不能为空！")
    @ApiModelProperty(value = "密码")
    private String password;

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
}
