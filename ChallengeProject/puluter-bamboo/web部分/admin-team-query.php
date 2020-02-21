<?php
include ("require.php");
if($_SESSION["userType"]!="admin"||!isset($_SESSION["userType"])) redirect("./login.html");
$wx = new WeChat("factory-1");
$pageName = "队伍信息查询";
printHeader($pageName,$_SESSION['userType'])
?>

    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">队伍信息查询</h4>
                    <h6 class="card-subtitle">队伍信息查询</h6>
                    <form action='admin-team-query.php' method='get'>
                        <div class="form-group">
                            <label for="exampleInputEmail1">请输入队伍ID</label>
                            <input type="text" class="form-control" id="exampleInputEmail1" placeholder="队伍ID" name='id'>
                        </div>
                        <button type="submit" class="btn btn-success waves-effect waves-light m-r-10">发起查询</button>
                    </form>
                    <?php
                    if(isset($_GET["id"])){
                        $id = addslashes(urldecode($_GET["id"]));
                        $res = $wx->databaseQuery("db.collection(\"team\").where({env:\"{$GLOBALS["env"]}\",_id:\"{$id}\"}).get()");
                        $res = json_decode($res["data"][0],true);
                        printTxt("名称",$res["name"]);
                        printTxt("成绩","{$res["score"][0]}胜{$res["score"][1]}负");
                        echo "<img src='{$res["imgUrl"]}' alt='{$res["name"]}' style='height: 100px;width: 100px;'/>";
                    }
                    ?>
                </div>
            </div>
        </div>
    </div>
<?php printFooter();?>