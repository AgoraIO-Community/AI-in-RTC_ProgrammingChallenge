package com.mc.worktown.exception;

/**
 * 共通异常
 *
 * @author malin
 * @version 1.0
 */
public class CommonException extends RuntimeException {

    /**
     * 构造函数
     *
     * @param message 消息
     */
    public CommonException(String message) {
        super(message);
    }

    /**
     * 构造函数
     *
     * @param message 消息
     * @param cause   原因
     */
    public CommonException(String message, Throwable cause) {
        super(message, cause);
    }
}
