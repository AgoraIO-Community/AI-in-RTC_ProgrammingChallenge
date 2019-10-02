package com.mc.worktown.util;

import com.mc.worktown.model.TencentApiModel;
import org.apache.commons.lang3.RandomStringUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.http.HttpEntity;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.security.NoSuchAlgorithmException;
import java.util.*;

import static com.mc.worktown.util.EncryptUtils.getMD5;

public class TencentApiUtil {

    public static String TENCENT_APP_ID = "**********";
    public static String TENCENT_SECRET = "**********";

    public static HttpEntity exec(TencentApiModel inModel) throws IOException, NoSuchAlgorithmException {
        CloseableHttpClient client = HttpClients.createDefault();
        HttpPost httpPost = new HttpPost(inModel.getUrl());
        List<NameValuePair> params = new ArrayList<>();
        Map<String, String> reqParas = inModel.getParas();
        if (Objects.nonNull(reqParas)) {
            reqParas.forEach((k, v) -> params.add(new BasicNameValuePair(k, v)));
        }

        params.add(new BasicNameValuePair("app_id", TENCENT_APP_ID));
        params.add(new BasicNameValuePair("time_stamp", String.valueOf(System.currentTimeMillis() / 1000)));
        params.add(new BasicNameValuePair("nonce_str", RandomStringUtils.randomAlphanumeric(17)));

        params.add(new BasicNameValuePair("sign", sign(params)));

        httpPost.setEntity(new UrlEncodedFormEntity(params));

        CloseableHttpResponse response = client.execute(httpPost);
        return response.getEntity();
    }

    public static String sign(List<NameValuePair> params) throws UnsupportedEncodingException, NoSuchAlgorithmException {

        params.sort(Comparator.comparing(NameValuePair::getName));
        StringBuilder sb = new StringBuilder();
        for (NameValuePair para : params) {
            if (sb.length() > 0) {
                sb.append("&");
            }
            sb.append(para.getName()).append("=")
                    .append(URLEncoder.encode(para.getValue(), StandardCharsets.UTF_8.toString()));
        }
        sb.append("&app_key=" + TENCENT_SECRET);

        return StringUtils.upperCase(getMD5(sb.toString()));
    }
}
