<?php
include ("require.php");
if(($_SESSION["userType"]!="official"&&$_SESSION["userType"]!="admin")||!isset($_SESSION["userType"])) redirect("./login.html");
$wx = new WeChat("factory-1");
$pageName = "分数一览";
printHeaderO($pageName,$_SESSION['userType'])
?>

    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">分数一览</h4>
                    <h6 class="card-subtitle">这里将展示所有的分数</h6>
                    <table id="demo-foo-accordion" class="table color-table purple-table">
                        <thead>
                        <tr>
                            <th> 辩题 </th>
                            <th> 时间 </th>
                            <th> 裁判 </th>
                            <th> 正方分数 </th>
                            <th> 反方分数 </th>
                            <th> 印象票 </th>
                            <th> 总结票 </th>
                        </tr>
                        </thead>
                        <tbody>
                        <?php
                        $judgeName = array(
                            "13dba11c5d3019480a0d505454b59650"=>"韩笑",
                            "9afd9b6a5d3018790a0ba15e122a0a49"=>"鲍羿岑",
                            "3e1ef27b5d351bbb0cef845371ad69a4"=>"刘振珷",
                            "282941b0-d53c-4e54-8911-34f0b1eb5eb7"=>"陈韦蓉队",
                            "378f246a-0135-433a-b78f-e91d2aeff085"=>"张志振队",
                            "f1006ad85d3016380a0abc210be70325"=>"测试"
                        );
                        $res = $wx->databaseQuery("db.collection(\"battleJudgePoints\").where({env:\"{$GLOBALS['env']}\"}).limit(50).get()");
                        foreach($res["data"] as $r){
                            $r = json_decode($r,true);
                            $bid = urlencode($r["battleId"]);
                            $C = urlencode($r["totalC"]);
                            $CC = urlencode($r["totalCC"]);
                            $j = $judgeName[$r["judgeId"]];
                            $obj = json_decode($wx->databaseQuery("db.collection(\"battle\").doc(\"{$bid}\").get()")["data"][0],true);
                            $title = $obj["title"];
                            $time = $obj["time"];
                            $express = $r["express"]=="C"?"正方":"反方";
                            $obj = $wx->databaseQuery("db.collection(\"battle-judge-point-conclude\").where({env:\"{$GLOBALS["env"]}\",battleId:\"{$bid}\",judgeId:\"{$r["judgeId"]}\"}).get()");
                            $conclude = "";
                            if($obj["pager"]["Total"]>=1){
                                $obj = json_decode($obj["data"][0],true);
                                $conclude = $obj["conclude"]=="C"?"正方":"反方";;
                            }else {
                                $conclude = "未选择";
                            }

                            echo   "<tr>
                                        <td>{$title}</td>
                                        <td>{$time}</td>
                                        <td>{$j}</td>
                                        <td>{$C}</td>
                                        <td>{$CC}</td>
                                        <td>{$express}</td>
                                        <td>{$conclude}</td>
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