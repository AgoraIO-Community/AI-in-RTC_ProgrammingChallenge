package com.mc.worktown.entity;

import com.mc.worktown.annotation.Unique;
import io.swagger.annotations.ApiModelProperty;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import java.io.Serializable;
import java.util.UUID;

/**
 * 基础实体信息
 *
 * @author malin
 * @version 1.0
 */
@MappedSuperclass
public abstract class BaseEntity implements Serializable {

    /**
     * ID
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    @ApiModelProperty(value = "ID")
    private Long id;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    /**
     * 编码
     */
    @Unique(name = "编码")
    @NotBlank(message = "code不能为空！")
    @Column(name = "code", nullable = false, length = 64)
    @ApiModelProperty(value = "编码")
    private String code = UUID.randomUUID().toString().split("-")[0];

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }
}
