package com.mc.worktown.util;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.mc.worktown.bean.CurrentUserInfo;
import com.mc.worktown.config.WorktownProperties;
import com.mc.worktown.entity.MemberEntity;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.JwtBuilder;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;

import javax.annotation.PostConstruct;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.http.HttpServletRequest;
import java.util.Base64;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * 授权认证工具
 *
 * @author malin
 * @version 1.0
 */
public class AuthorizationUtil {

    /**
     * 钥匙
     */
    public final static String SECRET_KEY = "sunway20050708";

    /**
     * 用户信息键
     */
    public final static String USER_CLAIM_KEY = "userInfo";

    /**
     * REQUEST属性KEY：用户信息
     */
    private final static String REQUEST_ATTRIBUTE_KEY_USER_INFO = "userInfo";

    /**
     * REQUEST属性KEY：用户验证结果
     */
    private final static String REQUEST_ATTRIBUTE_KEY_USER_VERIFY_RESULT = "userVerifyResult";

    /**
     * JSON映射器
     */
    private ObjectMapper objectMapper;

    /**
     * RTS配置信息
     */
    @Autowired
    private WorktownProperties worktownProperties;

    /**
     * 用户工具
     */
    @Autowired
    private UserUtil userUtil;

    /**
     * HTTP请求
     */
    @Autowired
    private HttpServletRequest httpServletRequest;

    /**
     * 不需要认证的URL集合
     */
    private Set<String> notVerifyUrlSet;

    /**
     * TOKEN过期时间
     */
    private long timeout;

    /**
     * 构造函数
     */
    public AuthorizationUtil() {
        objectMapper = new ObjectMapper();
        objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
        notVerifyUrlSet = new HashSet<>();
        notVerifyUrlSet.add("/login");
        notVerifyUrlSet.add("/member/reg");
        notVerifyUrlSet.add("/proxy/login");
        notVerifyUrlSet.add("/error");
    }

    /**
     * 初始化方法
     */
    @PostConstruct
    public void init() {
        timeout = worktownProperties.getTokenOverTime() * 60 * 1000L;
    }

    /**
     * 发行TOKEN信息
     *
     * @param userInfo 用户信息
     * @return TOKEN信息
     */
    public String issueToken(MemberEntity userInfo) {
        SignatureAlgorithm signatureAlgorithm = SignatureAlgorithm.HS256;
        Date expireDate = new Date(System.currentTimeMillis() + timeout);
        JwtBuilder builder = Jwts.builder()
                .claim(USER_CLAIM_KEY, userInfo)
                .setExpiration(expireDate)
                .signWith(signatureAlgorithm, generateKey());

        return builder.compact();
    }

    /**
     * 验证
     *
     * @param token TOKEN信息
     * @return 验证结果（true：通过、false：未通过）
     */
    public boolean verify(String token) {
        try {
            // 解析TOKEN
            Claims claims = Jwts.parser()
                    .setSigningKey(generateKey())
                    .parseClaimsJws(token)
                    .getBody();

            // 取得用户信息并保存
            String json = objectMapper.writeValueAsString(claims.get(USER_CLAIM_KEY));
            MemberEntity user = objectMapper.readValue(json, MemberEntity.class);
            httpServletRequest.setAttribute(REQUEST_ATTRIBUTE_KEY_USER_INFO, user);

            // 取得当前用户信息并保存
            CurrentUserInfo currentUserInfo = new CurrentUserInfo();
            currentUserInfo.setCode(user.getCode());
            currentUserInfo.setLoginName(user.getLoginName());
            currentUserInfo.setName(user.getName());
            currentUserInfo.setTeamCode(user.getTeamCode());
            currentUserInfo.setOrderIndex(user.getOrderIndex());
            userUtil.set(currentUserInfo);

            // 保存验证结果
            httpServletRequest.setAttribute(REQUEST_ATTRIBUTE_KEY_USER_VERIFY_RESULT, true);
        } catch (Exception e) {
            httpServletRequest.setAttribute(REQUEST_ATTRIBUTE_KEY_USER_VERIFY_RESULT, false);
            return false;
        }

        return true;
    }

    /**
     * 是否需要验证
     *
     * @return 是否需要验证（true：需要、false：不需要）
     */
    public boolean isNeedVerify() {
        if (notVerifyUrlSet.contains(httpServletRequest.getRequestURI())) {
            return false;
        }

        if (StringUtils.containsIgnoreCase(httpServletRequest.getRequestURI(), "swagger")) {
            return false;
        }

        return true;
    }

    /**
     * 是否验证通过
     *
     * @return 验证结果（true：通过、false：未通过）
     */
    public boolean isVerified() {
        Boolean result = (Boolean) httpServletRequest.getAttribute(REQUEST_ATTRIBUTE_KEY_USER_VERIFY_RESULT);
        return result != null ? result : false;
    }

    /**
     * 取得用户信息
     *
     * @return 用户信息
     */
    public MemberEntity getUserInfo() {
        return (MemberEntity) httpServletRequest.getAttribute(REQUEST_ATTRIBUTE_KEY_USER_INFO);
    }

    /**
     * 生成钥匙
     *
     * @return 钥匙
     */
    private SecretKey generateKey() {
        return new SecretKeySpec(Base64.getDecoder().decode(SECRET_KEY), SignatureAlgorithm.HS256.getJcaName());
    }
}
