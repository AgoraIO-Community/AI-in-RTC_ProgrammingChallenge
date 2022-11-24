<?php
include ("require.php");
if($_SESSION["userType"]!="admin"||!isset($_SESSION["userType"])) redirect("./login.html");
$wx = new WeChat("factory-1");
$pageName = "队伍一览";
printHeader($pageName,$_SESSION['userType'])
?>

    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">队伍一览</h4>
                    <h6 class="card-subtitle">这里将展示所有的队伍</h6>
                    <table id="demo-foo-accordion" class="table color-table red-table">
                        <thead>
                        <tr>
                            <th data-toggle="true"> 队伍Id </th>
                            <th> 名称 </th>
                            <th> 目前成绩 </th>
                            <th> LOGO </th>
                        </tr>
                        </thead>
                        <tbody>
                        <?php
                            $res = $wx->databaseQuery("db.collection(\"team\").where({env:\"{$GLOBALS['env']}\"}).limit(50).get()");
                            foreach($res["data"] as $r){
                                $r = json_decode($r,true);
                                echo   "<tr>
                                            <td>{$r["_id"]}</td>
                                            <td>{$r["name"]}</td>
                                            <td>{$r["score"][0]}胜{$r["score"][1]}负</td>
                                            <td><img src='{$r["imgUrl"]}' style='height:40px;width:40px;'/> </td>
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