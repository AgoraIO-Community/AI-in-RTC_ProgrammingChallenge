package com.mc.worktown.controller;

import com.mc.worktown.entity.MemberEntity;
import com.mc.worktown.entity.TeamEntity;
import com.mc.worktown.model.ResultModel;
import com.mc.worktown.model.SearchMemberModel;
import com.mc.worktown.service.MemberService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.constraints.NotNull;
import java.util.List;

@RequestMapping("/team")
@Api(tags = "团队操作接口")
@Validated
@RestController
public class TeamController extends BaseEntityController<TeamEntity> {

    @Autowired
    MemberService memberService;
    @DeleteMapping("/{code}")
    public ResultModel dissolve(
            @ApiParam(value = "团队编码", required = true)  @PathVariable @NotNull(message = "编码不能为空！") String code) {
        SearchMemberModel condition = new SearchMemberModel();
        condition.setTeamCode(code);
        List<MemberEntity> members = memberService.search(condition);
        for (MemberEntity mem :
                members) {
            mem.setTeamCode(null);
            memberService.modify(mem);
        }

        TeamEntity team = service.getByCode(code);
        service.delete(team.getId());
        return ResultModel.normal(team);
    }
}
