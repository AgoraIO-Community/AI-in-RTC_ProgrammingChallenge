package com.mc.worktown.util;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.mc.worktown.bean.CurrentUserInfo;
import com.mc.worktown.exception.CommonException;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.http.HttpServletRequest;
import java.net.URLDecoder;

/**
 * 用户工具
 *
 * @author malin
 * @version 1.0
 */
public class UserUtil {

    /**
     * REQUEST-HEADER-KEY：当前用户
     */
    public final static String REQUEST_HEADER_KEY_CURRENT_USER = "rts-current-user";

    /**
     * REQUEST属性KEY：当前用户
     */
    private final static String REQUEST_ATTRIBUTE_KEY_CURRENT_USER = "rtsCurrentUser";

    /**
     * HTTP请求
     */
    @Autowired
    private HttpServletRequest httpServletRequest;

    /**
     * 对象映射器
     */
    protected ObjectMapper objectMapper;

    /**
     * 构造函数
     */
    public UserUtil() {
        objectMapper = new ObjectMapper();
    }

    /**
     * 设置当前用户
     *
     * @param currentUserInfo 当前用户信息
     */
    public void set(CurrentUserInfo currentUserInfo) {
        httpServletRequest.setAttribute(REQUEST_ATTRIBUTE_KEY_CURRENT_USER, currentUserInfo);
    }

    /**
     * 取得当前用户
     *
     * @return 当前用户信息
     */
    public CurrentUserInfo get() {
        // 从请求属性信息中取得当前用户信息
        CurrentUserInfo currentUserInfo =
                (CurrentUserInfo) httpServletRequest.getAttribute(REQUEST_ATTRIBUTE_KEY_CURRENT_USER);
        if (currentUserInfo != null) {
            return currentUserInfo;
        }

        // 从请求头部信息中取得当前用户信息
        String userInfoHeader = httpServletRequest.getHeader(REQUEST_HEADER_KEY_CURRENT_USER);
        if (StringUtils.isNotBlank(userInfoHeader)) {
            try {
                currentUserInfo = objectMapper.readValue(
                        URLDecoder.decode(userInfoHeader, "UTF-8"), CurrentUserInfo.class);
            } catch (Exception e) {
                throw new CommonException("无法取得当前用户信息！", e);
            }

            // 保存当前用户信息
            set(currentUserInfo);
        }

        return currentUserInfo;
    }
}
