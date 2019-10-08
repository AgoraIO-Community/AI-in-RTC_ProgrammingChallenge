package com.mc.worktown.model;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

/**
 * 结果信息
 *
 * @author malin
 * @version 1.0
 */
@ApiModel(value = "结果信息")
public class ResultModel<T> {

    /**
     * 代码常量：正常
     */
    private final static int CODE_NORMAL = 0;

    /**
     * 代码常量：错误
     */
    private final static int CODE_ERROR = -1;

    /**
     * 代码
     */
    @ApiModelProperty(value = "代码")
    private int code;

    /**
     * 消息
     */
    @ApiModelProperty(value = "消息")
    private String message;

    /**
     * 返回内容
     */
    @ApiModelProperty(value = "返回内容")
    private T context;

    /**
     * 构造函数
     *
     * @param code 代码
     */
    private ResultModel(int code) {
        this.code = code;
    }

    /**
     * 取得正常结果信息
     *
     * @return 正常结果信息
     */
    public static ResultModel<Void> normal() {
        return normal(null);
    }

    /**
     * 取得正常结果信息
     *
     * @param context 返回内容
     * @return 正常结果信息
     */
    public static <T> ResultModel<T> normal(T context) {
        ResultModel<T> bean = new ResultModel<>(CODE_NORMAL);
        bean.context = context;

        return bean;
    }

    /**
     * 取得错误结果信息
     *
     * @param message 消息
     * @return 错误结果信息
     */
    public static ResultModel<String> error(String message) {
        return error(message, CODE_ERROR);
    }
    public static ResultModel<String> error(String message, int errCode) {
        ResultModel<String> bean = new ResultModel<>(errCode);
        bean.message = message;
        return bean;
    }

    public int getCode() {
        return code;
    }

    public String getMessage() {
        return message;
    }

    public T getContext() {
        return context;
    }
}
