package com.mc.worktown.exception;

import com.fasterxml.jackson.databind.ObjectMapper;
import io.swagger.annotations.ApiModelProperty;
import io.swagger.annotations.ApiParam;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.reflect.FieldUtils;
import org.apache.commons.lang3.reflect.MethodUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindException;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.client.HttpServerErrorException;
import org.springframework.web.method.annotation.MethodArgumentTypeMismatchException;

import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import java.lang.annotation.Annotation;
import java.lang.reflect.Field;
import java.util.*;
import java.util.stream.Collectors;

/**
 * 错误处理器
 *
 * @author malin
 * @version 1.0
 */
@Slf4j
@RestControllerAdvice
public class ErrorHandler {

    /**
     * 常量：输入错误消息
     */
    private final static String INPUT_ERROR_MESSAGE = "%s输入错误！";

    /**
     * 常量：共通错误消息
     */
    private final static String COMMON_ERROR_MESSAGE = "%s【%s】";

    /**
     * 常量：未知错误消息
     */
    private final static String UNKNOWN_ERROR_MESSAGE = "发生未知错误！【%s】";

    /**
     * JSON映射器
     */
    private ObjectMapper objectMapper;

    /**
     * 错误消息处理器
     */
    private ErrorMessageHandler errorMessageHandler;

    /**
     * 构造函数
     *
     * @param errorMessageHandler 错误消息处理器
     */
    public ErrorHandler(ErrorMessageHandler errorMessageHandler) {
        objectMapper = new ObjectMapper();
        this.errorMessageHandler = errorMessageHandler;
    }

    /**
     * 处理异常
     *
     * @param ex 异常
     * @return 处理结果
     */
    @ExceptionHandler(Throwable.class)
    public Object handleException(Exception ex) {
        String message;
        try {
            if (ex instanceof BindException) {
                message = getBindExceptionMessage((BindException) ex);
            } else if (ex instanceof ConstraintViolationException) {
                message = getConstraintViolationExceptionMessage((ConstraintViolationException) ex);
            } else if (ex instanceof MethodArgumentTypeMismatchException) {
                message = getMethodArgumentTypeMismatchExceptionMessage((MethodArgumentTypeMismatchException) ex);
            } else if (ex instanceof HttpServerErrorException) {
                message = getHttpServerErrorExceptionMessage((HttpServerErrorException) ex);
            } else if (ex instanceof CommonException) {
                if (ex.getCause() == null) {
                    message = ex.getMessage();
                } else {
                    message = String.format(COMMON_ERROR_MESSAGE, ex.getMessage(), ex.getCause());
                }
            } else if (ex instanceof MethodArgumentNotValidException) {
                message = getMethodArgumentNotValidExceptionMessage((MethodArgumentNotValidException) ex);
            } else {
                message = String.format(UNKNOWN_ERROR_MESSAGE, ex.toString());
            }
        } catch (Exception e) {
            message = String.format(UNKNOWN_ERROR_MESSAGE, ex.toString());
        }

        log.error(message);
        log.debug(message, ex);

        if (errorMessageHandler != null) {
            return errorMessageHandler.exec(message);
        } else {
            Map<String, Object> response = new LinkedHashMap<>();
            response.put("timestamp", new Date());
            response.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
            response.put("error", HttpStatus.INTERNAL_SERVER_ERROR.getReasonPhrase());
            response.put("message", message);

            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }

    /**
     * 取得绑定异常消息
     *
     * @param ex 绑定异常
     * @return 消息
     * @throws Exception 取得消息失败时发生
     */
    private String getBindExceptionMessage(BindException ex) throws Exception {
        return getMessageFromBindingResult(ex.getBindingResult());
    }

    /**
     * 取得方法参数类型不匹配异常消息
     *
     * @param ex 方法参数类型不匹配异常
     * @return 消息
     * @throws Exception 取得消息失败时发生
     */
    private String getMethodArgumentTypeMismatchExceptionMessage(MethodArgumentTypeMismatchException ex) throws Exception {
        return getMessageFromAnnotation(ex.getName(), ex.getParameter().getParameterAnnotations());
    }

    /**
     * 取得违背约束异常消息
     *
     * @param ex 违背约束异常
     * @return 消息
     */
    private String getConstraintViolationExceptionMessage(ConstraintViolationException ex) {
        List<String> messageList = ex.getConstraintViolations().stream()
                .map(ConstraintViolation::getMessage).collect(Collectors.toList());

        return String.join("\n", messageList);
    }

    /**
     * 取得Http服务错误异常消息
     *
     * @param ex Http服务错误异常
     * @return 消息
     * @throws Exception 取得消息失败时发生
     */
    private String getHttpServerErrorExceptionMessage(HttpServerErrorException ex) throws Exception {
        return String.valueOf(objectMapper.readValue(ex.getResponseBodyAsString(), Map.class).get("message"));
    }

    /**
     * 取得方法参数无效异常消息
     *
     * @param ex 方法参数无效异常
     * @return 消息
     * @throws Exception 取得消息失败时发生
     */
    private String getMethodArgumentNotValidExceptionMessage(MethodArgumentNotValidException ex) throws Exception {
        return getMessageFromBindingResult(ex.getBindingResult());
    }

    /**
     * 从绑定结果中取得消息
     *
     * @param bindingResult 绑定结果
     * @return 消息
     * @throws Exception 取得消息失败时发生
     */
    private String getMessageFromBindingResult(BindingResult bindingResult) throws Exception {
        List<String> messageList = new ArrayList<>();
        for (FieldError error : bindingResult.getFieldErrors()) {
            if (error.isBindingFailure()) {

                log.debug("BindException, binding failure, field=[{}]", error.getField());

                Field errorField = FieldUtils.getField(
                        Objects.requireNonNull(bindingResult.getTarget()).getClass(),
                        error.getField(), true);
                messageList.add(getMessageFromAnnotation(error.getField(), errorField.getAnnotations()));
            } else {

                log.debug("BindException, not binding failure, message=[{}]", error.getDefaultMessage());

                messageList.add(error.getDefaultMessage());
            }
        }

        return String.join("\n", messageList);
    }

    /**
     * 从注解中取得消息
     *
     * @param fieldName   字段名
     * @param annotations 注解数组
     * @return 消息
     * @throws Exception 取得消息失败时发生
     */
    private String getMessageFromAnnotation(String fieldName, Annotation[] annotations) throws Exception {
        for (Annotation annotation : annotations) {
            // 取得javax.validation注解的消息
            if (annotation.annotationType().getPackage().getName().equals("javax.validation.constraints")) {

                log.debug("Validation annotation, instance=[{}]", annotation);

                String message = MethodUtils.invokeMethod(
                        annotation, true, "message").toString();
                if (message.startsWith("{") && message.endsWith("}")) {
                    return String.format(INPUT_ERROR_MESSAGE, fieldName);
                } else {
                    return message;
                }
            }

            // 取得Swagger注解的消息
            if (annotation instanceof ApiModelProperty
                    || annotation instanceof ApiParam) {

                log.debug("Swagger annotation, instance=[{}]", annotation);

                return String.format(INPUT_ERROR_MESSAGE,
                        MethodUtils.invokeMethod(annotation, true, "value"));
            }
        }

        return String.format(INPUT_ERROR_MESSAGE, fieldName);
    }
}
