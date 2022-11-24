<?php
include ("require.php");
if($_SESSION["userType"]!="admin"||!isset($_SESSION["userType"])) redirect("./login.html");
$wx = new WeChat("factory-1");
$pageName = "裁判一览";
printHeader($pageName,$_SESSION['userType'])
?>

    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">裁判一览</h4>
                    <h6 class="card-subtitle">这里将展示所有的裁判</h6>
                    <table id="demo-foo-accordion" class="table color-table red-table">
                        <thead>
                        <tr>
                            <th data-toggle="true"> 裁判Id </th>
                            <th> 姓名 </th>
                            <th> username </th>
                            <th> password(需要初始化！) </th>
                        </tr>
                        </thead>
                        <tbody>
                        <?php
                        $res = $wx->databaseQuery("db.collection(\"judge\").where({env:\"{$GLOBALS["env"]}\"}).limit(50).get()");
                        foreach($res["data"] as $r){
                            $r = json_decode($r,true);
                            $str = "";
                            if($r["hasInit"]=="0"){
                                $str = $r["password"];
                            }
                            echo   "<tr>
                                            <td>{$r["_id"]}</td>
                                            <td>{$r["name"]}</td>
                                            <td>{$r["username"]}</td>
                                            <td>{$str}</td>
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