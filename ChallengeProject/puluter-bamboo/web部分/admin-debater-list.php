<?php
include ("require.php");
if($_SESSION["userType"]!="admin"||!isset($_SESSION["userType"])) redirect("./login.html");
$wx = new WeChat("factory-1");
$pageName = "辩手一览";
printHeader($pageName,$_SESSION['userType'])
?>

    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">辩手一览</h4>
                    <h6 class="card-subtitle">这里将展示所有的辩手</h6>
                    <table id="demo-foo-accordion" class="table color-table red-table">
                        <thead>
                        <tr>
                            <th data-toggle="true"> 辩手Id </th>
                            <th> 头像 </th>
                            <th> 名称 </th>
                            <th> 性别 </th>
                            <th> 描述 </th>
                            <th> 队伍Id </th>
                        </tr>
                        </thead>
                        <tbody>
                        <?php
                        $res = $wx->databaseQuery("db.collection(\"debater\").where({env:\"{$GLOBALS['env']}\"}).limit(50).get()");
                        foreach($res["data"] as $r){
                            $r = json_decode($r,true);
                            echo   "<tr>
                                            <td>{$r["_id"]}</td>
                                            <td><img src='{$r["imgUrl"]}' style='height:40px;width:40px;' alt='{$r["name"]}'/> </td>
                                            <td>{$r["name"]}</td>
                                            <td>{$r["gender"]}</td>
                                            <td>{$r["desc"]}</td>
                                            <td><a href='admin-team-query.php?id={$r["teamId"]}'>{$r["teamId"]}</a></td>
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