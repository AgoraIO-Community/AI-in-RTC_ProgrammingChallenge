package com.mc.worktown.controller;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.mc.worktown.entity.MemberEntity;
import com.mc.worktown.model.*;
import com.mc.worktown.service.MemberService;
import com.mc.worktown.util.TencentApiUtil;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.apache.commons.lang3.StringUtils;
import org.apache.http.HttpEntity;
import org.apache.http.util.EntityUtils;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

@RequestMapping("/member")
@Api(tags = "用户操作接口")
@Validated
@RestController
public class MemberController extends BaseEntityController<MemberEntity> {
    /**
     * 查询用户
     *
     * @param condition 查询条件
     * @return 用户列表
     */
    @GetMapping
    @ApiOperation(value = "查询用户")
    public ResultModel search(
            @ApiParam(value = "查询条件", required = false)  @Validated SearchMemberModel condition) {
        SearchResultModel<MemberEntity> result = new SearchResultModel<>();

        result.setItems(((MemberService)service).search(condition));
        return ResultModel.normal(result);
    }

    @PostMapping("/reg")
    public ResultModel register(
            @ApiParam(value = "显示名", required = true)  @Validated @RequestBody RegMemberModel member) throws Exception {
        if (((MemberService)service).getOneByLoginName(member.getLoginName()) != null) {
            return ResultModel.error("登录名已经存在，请换一个重新注册试试！");
        }
        MemberEntity entity = new MemberEntity();

        if (StringUtils.isNotBlank(member.getImgData())) {
            TencentApiModel inModel = new TencentApiModel();
            inModel.setUrl("https://api.ai.qq.com/fcgi-bin/face/face_newperson");
            Map<String, String> paras = new HashMap<>();
            paras.put("person_id", entity.getCode());
            paras.put("person_name", URLEncoder.encode(member.getName(), "UTF-8").toUpperCase());
            paras.put("group_ids", member.getGroup());
            paras.put("image", member.getImgData());
            inModel.setParas(paras);
            final HttpEntity httpEntity = TencentApiUtil.exec(inModel);
            ObjectMapper mapper = new ObjectMapper();
            String rstString = EntityUtils.toString(httpEntity);
            JsonNode jsonNode = mapper.readTree(rstString);
            try {
                String ret = jsonNode.findValue("ret").asText();
                if (!"0".equals(ret)) {
                    throw new Exception("人脸添加失败，请重试");
                }
            } catch (Exception e) {
                throw new Exception("人脸添加失败，请重试");
            }
        }

        entity.setName(member.getName());
        entity.setLoginName(member.getLoginName());
        entity.setPassword(member.getPassword());
        entity = service.add(entity);
        entity.setPassword("*");

        return ResultModel.normal(entity);
    }
}
