<?php
include("require.php");
if ($_SESSION["userType"] != "official" || !isset($_SESSION["userType"])) redirect("./login.html");
$wx = new WeChat("factory-1");
$id=urldecode($_GET['id']);
$res = $wx->databaseQuery("db.collection(\"battle\").doc(\"{$id}\").get()");
$obj = json_decode($res["data"][0],true);
$teamName = array(
    "e335bc00-db8b-49e4-b748-64959bbf6a03"=>"陈咏开队",
    "7c281641-3c8c-4bd8-8b5c-48e2c9e34c29"=>"冯梓恩队",
    "282941b0-d53c-4e54-8911-34f0b1eb5eb7"=>"陈韦蓉队",
    "378f246a-0135-433a-b78f-e91d2aeff085"=>"张志振队"
);
$arr_debaters_C = array();
$obj_debater_C = json_decode($wx->databaseQuery("db.collection(\"battle-debaters-selection\").where({battleId:\"{$id}\",teamId:\"{$obj["data"]["teamClaim"]["Id"]}\"}).get()")["data"][0],true);
for($i=0;$i<=3;$i++){
    $uid = $obj_debater_C["data"][$i];
    $obj_u = json_decode($wx->databaseQuery("db.collection(\"debater\").where({_id:\"{$uid}\"}).get()")["data"][0],true);
    $arr_debaters_C[$i] = array(
        "name"=>$obj_u["name"],
        "imgUrl"=>$obj_u["imgUrl"]
    );
}

$arr_debaters_CC = array();
$obj_debater_CC = json_decode($wx->databaseQuery("db.collection(\"battle-debaters-selection\").where({battleId:\"{$id}\",teamId:\"{$obj["data"]["teamCounterClaim"]["Id"]}\"}).get()")["data"][0],true);
for($i=0;$i<=3;$i++){
    $uid = $obj_debater_CC["data"][$i];
    $obj_u = json_decode($wx->databaseQuery("db.collection(\"debater\").where({_id:\"{$uid}\"}).get()")["data"][0],true);
    $arr_debaters_CC[$i] = array(
        "name"=>$obj_u["name"],
        "imgUrl"=>$obj_u["imgUrl"]
    );
}



$json_output = array(
    "battle"=> array(
        "rule"=>"3,,,0,;0,C1,,240,申论;1,CC2,C1,150,质询;0,CC1,,240,申论;1,C3,CC1,150,质询;0,C2,,180,申论;1,CC3,C2,150,质询;0,CC2,,180,申论;1,C1,CC2,150,质询;0,C3,,180,申论;1,CC1,C3,150,质询;0,CC3,,180,申论;1,C2,CC3,150,质询;0,C4,,120,小结;0,CC4,,120,小结;2,,,240,自由辩论;0,CC4,,210,结辩;0,C4,,210,结辩;",
        "title"=> $obj["title"]
    ),
    "team"=> array(
        array(
            "teamName"=> $teamName[$obj["data"]["teamClaim"]["Id"]],
            "debaters"=> $arr_debaters_C
        ),
        array(
            "teamName"=> $teamName[$obj["data"]["teamCounterClaim"]["Id"]],
            "debaters"=> $arr_debaters_CC
        )
    )
);

echo(json_encode($json_output));