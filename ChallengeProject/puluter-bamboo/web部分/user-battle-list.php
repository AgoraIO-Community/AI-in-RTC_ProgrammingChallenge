<?php
include ("require.php");
if($_SESSION["userType"]!="debater"||!isset($_SESSION["userType"])) redirect("./login.html");
$wx = new WeChat("factory-1");
$pageName = "我的比赛一览";
printHeaderU($pageName,$_SESSION['userType'])
?>

    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">比赛一览</h4>
                    <h6 class="card-subtitle">这里将展示所有您出战的比赛信息</h6>
                    <table id="demo-foo-accordion" class="table color-table blue-table">
                        <thead>
                        <tr>
                            <th> 辩题 </th>
                            <th> 正方 </th>
                            <th> 反方 </th>
                            <th> 时间 </th>
                            <th> 您的分数 </th>
                            <th> 平均分数 </th>
                        </tr>
                        </thead>
                        <tbody>
                        <?php
                        $teamName = array(
                            "e335bc00-db8b-49e4-b748-64959bbf6a03"=>"陈咏开队",
                            "7c281641-3c8c-4bd8-8b5c-48e2c9e34c29"=>"冯梓恩队",
                            "282941b0-d53c-4e54-8911-34f0b1eb5eb7"=>"陈韦蓉队",
                            "378f246a-0135-433a-b78f-e91d2aeff085"=>"张志振队"
                        );
                        $res1 = $wx->databaseQuery("db.collection(\"debater\").limit(50).where({env:\"{$GLOBALS["env"]}\",name:\"{$_SESSION["username"]}\"}).get()");//TODO：重名？
                        $obj = json_decode($res1["data"][0],true);
                        $did = $obj["_id"];
                        $teamId = $obj["teamId"];
                        $res = $wx->databaseQuery("db.collection(\"data-analysis\").limit(50).where({env:\"{$GLOBALS["env"]}\",debaterId:\"{$did}\"}).get()");
                        foreach($res["data"] as $re){
                            $re = json_decode($re,true);
                            $res3 = $wx->databaseQuery("db.collection(\"battle\").doc(\"{$re["battleId"]}\").get()");
                            $r = json_decode($res3["data"][0],true);
                            $r1 = urlencode($r["data"]["teamClaim"]["Id"]);
                            $r2 = urlencode($r["data"]["teamCounterClaim"]["Id"]);
                            $ui = urlencode($r["_id"]);
                            echo   "<tr>
                                        <div style='display:none;'>{$r["_id"]}</div>
                                        <td>{$r["title"]}</td>
                                        <td>{$teamName[$r["data"]["teamClaim"]["Id"]]}</td>
                                        <td>{$teamName[$r["data"]["teamCounterClaim"]["Id"]]}</td>
                                        <td>{$r["time"]}</td>
                                        <td>{$re["myPoints"]}</td>
                                        <td>{$re["avgPoints"]}</td>
                                    </tr>";
                        }
                        ?>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
<?php printFooter();?>