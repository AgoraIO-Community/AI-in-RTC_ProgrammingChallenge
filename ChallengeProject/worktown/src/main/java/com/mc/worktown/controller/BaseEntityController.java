package com.mc.worktown.controller;

import com.mc.worktown.entity.BaseEntity;
import com.mc.worktown.model.ResultModel;
import com.mc.worktown.service.BaseRepositoryService;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.constraints.NotNull;

public abstract class BaseEntityController<T extends BaseEntity>  extends BaseController {
    @Autowired
    BaseRepositoryService<T> service;

    /**
     * 添加实体
     *
     * @param info 实体对象
     * @return 实体对象
     */
    @PostMapping
    @ApiOperation(value = "添加记录")
    public ResultModel<T> add(
            @ApiParam(value = "实体对象") @RequestBody @Validated T info) {
        return ResultModel.normal(service.add(info));
    }

    /**
     * 修改实体
     *
     * @param id   实体对象ID
     * @param info 实体对象
     * @return 实体对象
     */
    @PutMapping("/{id}")
    @ApiOperation(value = "修改实体对象")
    public ResultModel<T> modify(
            @ApiParam(value = "实体对象ID", required = true) @PathVariable @NotNull(message = "id不能为空！") Long id,
            @ApiParam(value = "实体对象") @RequestBody @Validated T info) {
        info.setId(id);
        return ResultModel.normal(service.modify(info));
    }
//
//    /**
//     * 根据ID获取实体对象
//     *
//     * @param id 实体对象ID
//     * @return 实体对象
//     */
//    @GetMapping("/{id}")
//    @ApiOperation(value = "根据ID获取实体对象")
//    public T getById(
//            @ApiParam(value = "实体对象ID", required = true) @PathVariable @NotNull(message = "id不能为空！") Long id) {
//        return service.getById(id);
//    }

    /**
     * 根据编码获取实体对象
     *
     * @param code 实体对象编码
     * @return 实体对象
     */
    @GetMapping("/{code}")
    @ApiOperation(value = "根据编码获取实体对象")
    public ResultModel<T> getByCode(
            @ApiParam(value = "实体对象编码", required = true) @PathVariable @NotNull(message = "编码不能为空！") String code) {
        return ResultModel.normal(service.getByCode(code));
    }
}
