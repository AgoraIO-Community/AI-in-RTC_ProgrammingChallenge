package com.mc.worktown.model;

import java.io.Serializable;
import java.util.Map;

public class TencentApiModel implements Serializable {

    String url;

    Map<String, String> paras;

    /**
     * Gets the value of url.
     *
     * @return the value of url
     */
    public String getUrl() {
        return url;
    }

    /**
     * Sets the url.
     *
     * <p>You can use getUrl() to get the value of url</p>
     *
     * @param url url
     */
    public void setUrl(String url) {
        this.url = url;
    }

    /**
     * Gets the value of reqParas.
     *
     * @return the value of reqParas
     */
    public Map<String, String> getParas() {
        return paras;
    }

    /**
     * Sets the paras.
     *
     * <p>You can use getReqParas() to get the value of reqParas</p>
     *
     * @param paras reqParas
     */
    public void setParas(Map<String, String> paras) {
        this.paras = paras;
    }
}
