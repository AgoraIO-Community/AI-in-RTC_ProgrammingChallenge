package com.mc.worktown.interceptor;

import com.mc.worktown.util.AuthorizationUtil;
import org.apache.http.HttpHeaders;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Component
public class AuthorizationInterceptor implements HandlerInterceptor {

    @Autowired
    private AuthorizationUtil authorizationUtil;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        System.out.println("==============");

        if (!authorizationUtil.isNeedVerify()) {
            return true;
        }

        String tokenContext = request.getHeader(HttpHeaders.AUTHORIZATION);
        if (tokenContext == null) {
            handleUnauthorized(response);
            return false;
        }

        // 解析TOKEN
        String[] token = tokenContext.split(" ");
        if (token.length != 2) {
            handleUnauthorized(response);
            return false;
        }

        // 验证TOKEN
        if (!authorizationUtil.verify(token[1])) {
            handleUnauthorized(response);
            return false;
        }

        return true;
    }

    private void handleUnauthorized(HttpServletResponse response) {
        response.setStatus(HttpStatus.UNAUTHORIZED.value());
        response.setContentType("text/html;charset=UTF-8");
        try {
            response.getWriter().println("用户验证失败！");
        } catch (IOException e) {
        }
    }
}
