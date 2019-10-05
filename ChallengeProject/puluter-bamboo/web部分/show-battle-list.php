<?php
include ("require.php");
if(($_SESSION["userType"]!="official"&&$_SESSION["userType"]!="admin")||!isset($_SESSION["userType"])) redirect("./login.html");
$wx = new WeChat("factory-1");
$pageName = "比赛一览";
printHeaderO($pageName,$_SESSION['userType'])
?>

    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">比赛一览</h4>
                    <h6 class="card-subtitle">这里将展示所有的比赛</h6>
                    <table id="demo-foo-accordion" class="table color-table purple-table">
                        <thead>
                        <tr>
                            <th> 辩题 </th>
                            <th> 正方 </th>
                            <th> 反方 </th>
                            <th> 时间 </th>
                            <th> 演示 </th>
                            <th> 进行成绩分析 </th>
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
                        $res = $wx->databaseQuery("db.collection(\"battle\").where({env:\"{$GLOBALS['env']}\"}).limit(50).get()");
                        foreach($res["data"] as $r){
                            $r = json_decode($r,true);
                            $r1 = urlencode($r["data"]["teamClaim"]["Id"]);
                            $r2 = urlencode($r["data"]["teamCounterClaim"]["Id"]);
                            $ui = urlencode($r["_id"]);
                            echo   "<tr>
                                        <div style='display:none;'>{$r["_id"]}</div>
                                        <td>{$r["title"]}</td>
                                        <td>{$teamName[$r["data"]["teamClaim"]["Id"]]}</td>
                                        <td>{$teamName[$r["data"]["teamCounterClaim"]["Id"]]}</td>
                                        <td>{$r["time"]}</td>
                                        <td><a href='./show/index.php?id={$ui}'><button type=\"submit\" class=\"btn btn-primary waves-effect waves-light m-r-10\">开始演示</button></a></td>
                                        <td><a href='./do-data-analy.php?id={$r["_id"]}'><button type=\"submit\" class=\"btn btn-danger waves-effect waves-light m-r-10\">进行成绩分析</button></a></td>
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