package com.mc.worktown.controller;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.mc.worktown.model.ResultModel;
import com.mc.worktown.util.TencentApiUtil;
import com.mc.worktown.model.TencentApiModel;
import com.mc.worktown.service.LoginService;
import io.swagger.annotations.Api;
import org.apache.commons.lang3.StringUtils;
import org.apache.http.HttpEntity;
import org.apache.http.util.EntityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.util.*;

@RestController
@RequestMapping("/proxy")
@Api(tags = "代理接口")
public class ProxyController extends BaseController {
    /**
     * 登录Service
     */
    @Autowired
    private LoginService loginService;

    /**
     * 跳转到腾讯api
     * @param inModel
     * @return
     * @throws IOException
     * @throws NoSuchAlgorithmException
     */
    @PostMapping("/tencent")
    public ResultModel<String> apiTencent(@RequestBody TencentApiModel inModel) throws IOException, NoSuchAlgorithmException {
        final HttpEntity entity = TencentApiUtil.exec(inModel);
        return ResultModel.normal(EntityUtils.toString(entity));
    }

    /**
     * 通过人脸图片登录
     * @param inModel
     * @return
     * @throws IOException
     * @throws NoSuchAlgorithmException
     */
    @PostMapping("/login")
    public ResultModel<String> loginByTencentFace(@RequestBody TencentApiModel inModel) throws IOException, NoSuchAlgorithmException {
        inModel.setUrl("https://api.ai.qq.com/fcgi-bin/face/face_faceidentify");
        final HttpEntity entity = TencentApiUtil.exec(inModel);
        String result = EntityUtils.toString(entity);
        ObjectMapper mapper = new ObjectMapper();
        JsonNode jsonNode = mapper.readTree(result);
        String ret = jsonNode.findValue("ret").asText();
        if (!"0".equals(ret)) {
            return ResultModel.error("登录失败", 1); // 图片中不含人脸
        }
        if (null == jsonNode.findValue("person_id")) {
            return ResultModel.error("登录失败",2); // 人脸库中不存在
        } else {
            int confidence = jsonNode.findValue("confidence").asInt();
            if (confidence < 90) {
                return ResultModel.error("登录失败",2); // 人脸库中不存在
            }
        }
        if (null == jsonNode.findValue("person_id")) {
            return ResultModel.error("登录失败",2); // 人脸库中不存在
        }
        String code = jsonNode.findValue("person_id").asText();
        if (StringUtils.isNotBlank(code)) {
            try {
                return ResultModel.normal(loginService.login(code));
            } catch (Exception e) {
                TencentApiModel tModel = new TencentApiModel();
                tModel.setUrl("https://api.ai.qq.com/fcgi-bin/face/face_delperson");
                Map<String, String> paras = new HashMap<>();
                paras.put("person_id", code);
                tModel.setParas(paras);
                TencentApiUtil.exec(tModel);

                return ResultModel.error("登录失败",3); // 编码不在注册列表中
            }
        } else {
            return ResultModel.error("登录失败",2); // 人脸库中不存在
        }
    }
}
