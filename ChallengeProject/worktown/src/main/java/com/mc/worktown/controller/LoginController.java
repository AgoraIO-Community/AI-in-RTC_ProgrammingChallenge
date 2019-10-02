package com.mc.worktown.controller;

import com.mc.worktown.model.LoginInModel;
import com.mc.worktown.model.ResultModel;
import com.mc.worktown.config.WorktownProperties;
import com.mc.worktown.entity.MemberEntity;
import com.mc.worktown.service.LoginService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

/**
 * 登录Controller
 *
 * @author malin
 * @version 1.0
 */
@Validated
@RestController
@RequestMapping("/login")
@Api(tags = "登录操作接口")
public class LoginController extends BaseController {

    /**
     * 登录Service
     */
    @Autowired
    private LoginService loginService;

    /**
     * 登录
     *
     * @param info 登录的输入信息
     * @return 结果信息
     */
    @PostMapping("")
    @ApiOperation(value = "登录")
    public ResultModel<String> login(
            @ApiParam(value = "登录信息") @RequestBody @Validated LoginInModel info) {
        return ResultModel.normal(loginService.login(info));
    }

    /**
     * 取得用户信息
     *
     * @return 结果信息
     */
    @GetMapping("/currentUser")
    @ApiOperation(value = "取得用户信息")
    public ResultModel<MemberEntity> getUserInfo() {
        return ResultModel.normal(loginService.getUserInfo());
    }

    /**
     * 取得配置信息
     *
     * @return 结果信息
     */
    @GetMapping("/config")
    @ApiOperation(value = "取得配置信息")
    public ResultModel<WorktownProperties> getConfigInfo() {
        return ResultModel.normal(loginService.getConfigInfo());
    }

    /**
     * 取得TOKEN
     *
     * @return TOKEN
     */
    @GetMapping("/token")
    @ApiOperation(value = "取得TOKEN")
    public ResultModel<String> getToken() {
        return ResultModel.normal(loginService.getToken());
    }
}
