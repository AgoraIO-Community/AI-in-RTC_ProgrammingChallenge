package com.mc.worktown.config;

import com.fasterxml.jackson.annotation.JsonIgnore;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * Worktown配置信息
 *
 * @author malin
 * @version 1.0
 */
@Component
@ConfigurationProperties(prefix = "worktown")
public class WorktownProperties {

    /**
     * Socket服务地址
     */
    private String socketServer;

    /**
     * 视频服务地址
     */
    private String videoServer;

    /**
     * 默认每页记录数
     */
    private Integer defaultPageSize;

    /**
     * TOKEN超时时间
     */
    @JsonIgnore
    private Integer tokenOverTime;

    /**
     * 重新连接超时时间
     */
    private Integer reconnectOverTime;

    public String getSocketServer() {
        return socketServer;
    }

    public void setSocketServer(String socketServer) {
        this.socketServer = socketServer;
    }

    public String getVideoServer() {
        return videoServer;
    }

    public void setVideoServer(String videoServer) {
        this.videoServer = videoServer;
    }

    public Integer getDefaultPageSize() {
        return defaultPageSize;
    }

    public void setDefaultPageSize(Integer defaultPageSize) {
        this.defaultPageSize = defaultPageSize;
    }

    public Integer getTokenOverTime() {
        return tokenOverTime;
    }

    public void setTokenOverTime(Integer tokenOverTime) {
        this.tokenOverTime = tokenOverTime;
    }

    public Integer getReconnectOverTime() {
        return reconnectOverTime;
    }

    public void setReconnectOverTime(Integer reconnectOverTime) {
        this.reconnectOverTime = reconnectOverTime;
    }
}
