<?php

class WeChat
{
    private $access_token="";
    private $env="";
    function getToken(){
        $env = $GLOBALS["enV"];
        if($env == "undefined") {
            $url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid={$GLOBALS["APP-ID"]}&secret={$GLOBALS["APP-SECRET"]}";
            $data = json_decode(H_get($url), true);
            var_dump($data["access_token"]);
            return $data["access_token"];
        }
        else if($env == "local"){
            return "23_9z9aTCi-kVv9RnTSGjR7dD3edrDS7uQxH-4g75aD7RUl6suz88n4LAs0Y_4q8FYFNBAIwwNydmw_lZMKZn59LiIaWWPgN9C7JgCl3hC6CQWycLbzXZk2g12KiRrVdP12XteYKupdR_KBIBBzOSRbAEAGKJ";
        }
        else {
            return H_get("https://puluter.cn/server/???");
        }
    }

    function __construct($env){
        $this->access_token = $this->getToken();
        $this->env = $env;
//        var_dump($this->access_token);
    }

    /**
     * @param $name
     * @param $data
     * @return object
     * @example {
                    "errcode": 0,
                    "errmsg": "ok",
                    "resp_data": "{\"event\":{\"userInfo\":{\"appId\":\"SAMPLE_APPID\"}},\"appid\":\"SAMPLE_APPID\"}"
                }
     */
    public function invokeCloudFunction($name, $data){
        $env = $this->env;
        $res = H_post(" https://api.weixin.qq.com/tcb/invokecloudfunction?access_token={$this->access_token}&env={$env}&name={$name}",$data);
        $res = json_decode($res,true);
        return $res;
    }

    /**
     * @param int $limit
     * @param int $offset
     * @author puluter
     * @return mixed
     */

    public function databaseBackup(){
        $env = $this->env;
        $data = array(
            "env" => $env,
            "file_path"=>"test_export1",
            "file_type"=>1,
            "query"=>"db.collection(\'debater-tmp-img\').get()"
        );
        $res = H_post("https://api.weixin.qq.com/tcb/databasemigrateexport?access_token={$this->access_token}",$data);
        $res = json_decode($res,true);
        return $res;
    }

    public function databaseBackupGetUrl($id){
        $env = $this->env;
        $data = array(
            "env" => $env,
            "job_id"=>$id,
        );
        $res = H_post("https://api.weixin.qq.com/tcb/databasemigratequeryinfo?access_token={$this->access_token}",$data);
        $res = json_decode($res,true);
        return $res;
    }

    /**
     * @param $query("db.collection(\"table\").add({data:...})") string
     * @return array(id1,id2,...)
     */
    public function databaseAdd($query){
        $env = $this->env;
        $data = array(
            "env" => $env,
            "query" => $query
        );
        $res = H_post("https://api.weixin.qq.com/tcb/databaseadd?access_token={$this->access_token}",$data);
        $res = json_decode($res,true);
        return $res;
    }

    /**
     * @param $query("db.collection(\"table\").where({done:true}).limit(10).skip(1).get()") string
     * @return object(res["data"]=>string(json_decode),string,string)
     */
    public function databaseQuery($query){
        $env = $this->env;
        $data = array(
            "env" => $env,
            "query" => $query
        );
        $res = H_post("https://api.weixin.qq.com/tcb/databasequery?access_token={$this->access_token}",$data);
        $res = json_decode($res,true);
        return $res;
    }

    /**
     * @param $query("db.collection(\"geo\").where({done:true}).count()") string
     * @return object(res["count"]=>number)
     */
    public function databaseCount($query){
        $env = $this->env;
        $data = array(
            "env" => $env,
            "query" => $query
        );
        $res = H_post("https://api.weixin.qq.com/tcb/databasecount?access_token={$this->access_token}",$data);
        $res = json_decode($res,true);
        return $res;
    }

    /**
     * @param $query("db.collection(\"geo\").doc(\"56abd6d5-9daf-4fc7-af05-eca13933f1aa\").update({data:{age: 10}})") string
     * @return object
     * @example return {
                    "errcode": 0,
                    "errmsg": "ok",
                    "matched": 0,
                    "modified": 0,
                    "id": "be62d9c4-43ec-4dc6-8ca1-30b206eeed24"
                }
     */
    public function databaseUpdate($query){
        $env = $this->env;
        $data = array(
            "env" => $env,
            "query" => $query
        );
        $res = H_post("https://api.weixin.qq.com/tcb/databaseupdate?access_token={$this->access_token}",$data);
        $res = json_decode($res,true);
        return $res;
    }

    /**
     * @param $query(""db.collection(\"geo\").where({done:false}).remove()"") string
     * @return object(res["count"]=>number)
     * @example return {
                        "errcode": 0,
                        "errmsg": "ok",
                        "deleted": 1
                        }
     */
    public function databaseDelete($query){
        $env = $this->env;
        $data = array(
            "env" => $env,
            "query" => $query
        );
        $res = H_post("https://api.weixin.qq.com/tcb/databasedelete?access_token={$this->access_token}",$data);
        $res = json_decode($res,true);
        return $res;
    }

    public function sendTemplateMsg($to, $tid, $data, $e_w=""){
        $env = $this->env;
        $data = array(
            "touser" => $to,
            "template_id" => $tid,
            "data" => $data,
            "emphasis_keyword" => $e_w
        );
        $res = H_post("https://api.weixin.qq.com/cgi-bin/message/wxopen/template/send?access_token={$this->access_token}",$data);
        $res = json_decode($res,true);
        return $res;
    }
    public function getWXAcodeUnlimit($page=""){
        $data = array(
            "line_color" => ['r'=>'0','g'=>'0','b'=>'0'],
            "path" => $page
        );var_dump(json_encode($data));
        $res = H_post("https://api.weixin.qq.com/wxa/getwxacode?access_token={$this->access_token}",json_encode($data));
        $res = json_decode($res,true);
        return $res;
    }


    public function getwxaqrcode($path)

    {
        $url = 'https://api.weixin.qq.com/wxa/getwxacode?access_token='.$this->access_token;
        $data='{"path":"'.$path.'"}';
        $return = request_post($url,$data);
//将生成的小程序码存入相应文件夹下
        file_put_contents('./uploads/img/'.time().'.jpg',$return);
        $lu = '/uploads/img/'.time().'.jpg';
        var_dump($return);
    }

}