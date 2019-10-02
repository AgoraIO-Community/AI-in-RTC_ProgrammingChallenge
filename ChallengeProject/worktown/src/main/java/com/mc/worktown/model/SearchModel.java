package com.mc.worktown.model;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import javax.validation.constraints.Min;
import java.util.Objects;

/**
 * 查询信息
 *
 * @author malin
 * @version 1.0
 */
@ApiModel("查询信息")
public class SearchModel extends BaseModel {

    /**
     * 排序字段
     */
    @ApiModelProperty(value = "排序字段")
    private String sort;

    /**
     * 是否正序
     */
    @ApiModelProperty(value = "是否正序")
    private boolean asc = true;

    /**
     * 当前页索引
     */
    @Min(value = 0, message = "当前页索引输入错误！")
    @ApiModelProperty(value = "当前页索引（默认为0、第一页）")
    private Integer pageIndex = 0;

    /**
     * 每页记录数
     */
    @Min(value = 0, message = "每页记录数输入错误！")
    @ApiModelProperty(value = "每页记录数（默认为0、不分页）")
    private Integer pageSize = 0;

    public String getSort() {
        return sort;
    }

    public void setSort(String sort) {
        this.sort = sort;
    }

    public boolean isAsc() {
        return asc;
    }

    public void setAsc(boolean asc) {
        this.asc = asc;
    }

    public Integer getPageIndex() {
        return pageIndex;
    }

    public void setPageIndex(Integer pageIndex) {
        this.pageIndex = Objects.isNull(pageIndex) ? 0 : pageIndex < 0 ? 0 : pageIndex;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = Objects.isNull(pageSize) ? 0 : pageSize < 0 ? 0 : pageSize;
    }
}
