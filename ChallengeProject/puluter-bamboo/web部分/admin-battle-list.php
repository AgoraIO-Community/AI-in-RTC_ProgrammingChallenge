<?php
include ("require.php");
if($_SESSION["userType"]!="admin"||!isset($_SESSION["userType"])) redirect("./login.html");
$wx = new WeChat("factory-1");
$pageName = "比赛一览";
printHeader($pageName,$_SESSION['userType'])
?>

    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">比赛一览</h4>
                    <h6 class="card-subtitle">这里将展示所有的比赛</h6>
                    <table id="demo-foo-accordion" class="table color-table red-table">
                        <thead>
                        <tr>
                            <th data-toggle="true"> 比赛Id </th>
                            <th> 辩题 </th>
                            <th> 正方 </th>
                            <th> 反方 </th>
                            <th> 地点 </th>
                            <th> 时间 </th>
                            <th> 进行数据分析 </th>
                        </tr>
                        </thead>
                        <tbody>
                        <?php
                        $res = $wx->databaseQuery("db.collection(\"battle\").where({env:\"{$GLOBALS['env']}\"}).limit(50).get()");
                        foreach($res["data"] as $r){
                            $r = json_decode($r,true);
                            $r1 = urlencode($r["data"]["teamClaim"]["Id"]);
                            $r2 = urlencode($r["data"]["teamCounterClaim"]["Id"]);
                            echo   "<tr>
                                            <td>{$r["_id"]}</td>
                                            <td>{$r["title"]}</td>
                                            <td><a href='admin-team-query.php?id={$r1}'>{$r["data"]["teamClaim"]["Id"]} ({$r["data"]["teamClaim"]["point"]})</a></td>
                                            <td><a href='admin-team-query.php?id={$r2}'>{$r["data"]["teamCounterClaim"]["Id"]} ({$r["data"]["teamCounterClaim"]["point"]})</a></td>
                                            <td>{$r["loc"]}</td>
                                            <td>{$r["time"]}</td>
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