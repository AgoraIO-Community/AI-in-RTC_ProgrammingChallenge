package com.mc.worktown.exception;

import java.util.function.Function;

/**
 * 消息处理器
 *
 * @author malin
 * @version 1.0
 */
public class ErrorMessageHandler {

    /**
     * 处理方法
     */
    private Function<String, Object> function;

    /**
     * 构造函数
     *
     * @param function 处理方法
     */
    public ErrorMessageHandler(Function<String, Object> function) {
        this.function = function;
    }

    /**
     * 执行方法
     *
     * @param message 消息
     * @return 执行结果
     */
    public Object exec(String message) {
        return function.apply(message);
    }
}
