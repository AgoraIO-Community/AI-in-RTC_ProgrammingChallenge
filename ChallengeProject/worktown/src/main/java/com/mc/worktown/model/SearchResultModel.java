package com.mc.worktown.model;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import java.util.List;

/**
 * 查询结果信息
 *
 * @author malin
 * @version 1.0
 */
@ApiModel("查询结果信息")
public class SearchResultModel<T> extends BaseModel {

    /**
     * 当前页索引
     */
    @ApiModelProperty(value = "当前页索引")
    private Integer index;

    /**
     * 每页记录数
     */
    @ApiModelProperty(value = "每页记录数")
    private Integer size;

    /**
     * 记录总数
     */
    @ApiModelProperty(value = "记录总数")
    private Integer total;

    /**
     * 当前页内容
     */
    @ApiModelProperty(value = "当前页内容")
    private List<T> items;

    public Integer getIndex() {
        return index;
    }

    public void setIndex(Integer index) {
        this.index = index;
    }

    public Integer getSize() {
        return size;
    }

    public void setSize(Integer size) {
        this.size = size;
    }

    public Integer getTotal() {
        return total;
    }

    public void setTotal(Integer total) {
        this.total = total;
    }

    public List<T> getItems() {
        return items;
    }

    public void setItems(List<T> items) {
        this.items = items;
    }
}
