<?php
/**
 * @param $durl
 * @return bool|string
 */
function H_get($durl){
        $headers = array(
            "token:1111111111111",
            "over_time:22222222222",
        );
        $curl = curl_init();
        curl_setopt($curl, CURLOPT_URL, $durl);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, true) ;
        curl_setopt($curl, CURLOPT_BINARYTRANSFER, true) ;
        // 添加头信息
        curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);
        curl_setopt($curl, CURLINFO_HEADER_OUT, true);
        curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, FALSE);
        curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, FALSE);
        $data = curl_exec($curl);
        curl_close($curl);
        return $data;
    }

    /**
     * @param $durl
     * @param $post_data
     * @return bool|string
     */
    function H_post($durl, $post_data){
        $headers = array(
            "token:1111111111111",
            "over_time:22222222222",
        );
        $curl = curl_init();
        curl_setopt($curl, CURLOPT_URL, $durl);
        curl_setopt($curl, CURLOPT_HEADER, false);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($curl, CURLOPT_POST, true);
        curl_setopt($curl, CURLOPT_POSTFIELDS, json_encode($post_data));
        curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);
        curl_setopt($curl, CURLINFO_HEADER_OUT, true);
        curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, FALSE);
        curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, FALSE);
        $data = curl_exec($curl);
        curl_close($curl);
        return $data;
    }