<?php

    function getToken(){
        $env = $GLOBALS["env"];
        if($env == "undefined") {
            $url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid={$GLOBALS["APP-ID"]}&secret={$GLOBALS["APP-SECRET"]}";
            $data = json_decode(H_get($url), true);
            return $data["access_token"];
        }
        else if($env == "local"){
            return "23_1M497g8-ykF90pgOFV0DYVxt1VU4Uq8ION5tx-JXTd168YxyVmCP8Ltgb-OaFTBjG9OqrOnLKzCbOm98gGaDBivr8M_y5yMjeuXFsfW-xUG1KvdSq-fEW1FY3Rz20KVkChBnSmFhlF6GRf9DIUXbAGAYKN";
        }
    }

