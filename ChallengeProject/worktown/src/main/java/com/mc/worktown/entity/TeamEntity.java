package com.mc.worktown.entity;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.validation.constraints.NotBlank;

/**
 * 团队信息
 *
 * @author malin
 * @version 1.0
 */
@Entity
@Table(name = "team")
@ApiModel(value = "团队信息")
public class TeamEntity extends BaseEntity {

    /**
     * serialVersionUID
     */
    private final static long serialVersionUID = -1740361593280251642L;

    /**
     * 名称
     */
    @NotBlank(message = "name不能为空！")
    @Column(name = "name", nullable = false, length = 20)
    @ApiModelProperty(value = "名称")
    private String name;

    /**
     * 描述
     */
    @Column(name = "description", length = 100)
    @ApiModelProperty(value = "描述")
    private String desc;

    /**
     * 创建人编码
     */
    @Column(name = "creator", length = 64)
    @ApiModelProperty(value = "创建人编码")
    private String creator;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public String getCreator() {
        return creator;
    }

    public void setCreator(String creator) {
        this.creator = creator;
    }
}
