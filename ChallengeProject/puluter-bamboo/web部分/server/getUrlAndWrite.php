<?php
include("../require.php");
$wx = new WeChat("factory-1");
//$res = $wx->databaseQuery("db.collection(\"debater-tmp-img\").limit(50).get()");
//foreach($res["data"] as $r) {
//    $r = json_decode($r,true);//
//    $res2 = $wx->databaseUpdate("db.collection(\"debater-tmp-img\").doc(\"{$r["_id"]}\").update({data:{imgUrl:\"\"}})");
//}
$res = $wx->batchDownloadFile(array(array("fileid"=>"cloud://factory-1.6275-factory-1/img-debater/0695b7c8-ff93-4a1b-9844-07bc25c07dbd.jpg","max_age"=>86400)));
var_dump($res);