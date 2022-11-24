<?php
include ("require.php");
if($_SESSION["userType"]!="admin"||!isset($_SESSION["userType"])) redirect("./login.html");
$wx = new WeChat("factory-1");
$pageName = "比赛信息查询";
printHeader($pageName,$_SESSION['userType'])
?>

    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">比赛信息查询</h4>
                    <h6 class="card-subtitle">比赛信息查询</h6>
                    <form action='admin-battle-query.php' method='get'>
                        <div class="form-group">
                            <label for="exampleInputEmail1">请输入比赛ID</label>
                            <input type="text" class="form-control" id="exampleInputEmail1" placeholder="比赛ID" name='id'>
                        </div>
                        <button type="submit" class="btn btn-success waves-effect waves-light m-r-10">发起查询</button>
                    </form>
                    <?php
                    if(isset($_GET["id"])){
                        $id = addslashes(urldecode($_GET["id"]));
                        $res = $wx->databaseQuery("db.collection(\"battle\").where({env:\"{$GLOBALS["env"]}\",_id:\"{$id}\"}).get()");
                        $res = json_decode($res["data"][0],true);
                        printTxt("辩题",$res["title"]);
                        printTxt("地点",$res["loc"]);
                        printTxt("时间",$res["time"]);
                        printTxt("正方队伍Id",$res["data"]["teamClaim"]["Id"]);
                        printTxt("正方队伍得票",$res["data"]["teamClaim"]["point"]);
                        printTxt("反方队伍Id",$res["data"]["teamCounterClaim"]["Id"]);
                        printTxt("反方队伍得票",$res["data"]["teamCounterClaim"]["point"]);
                    }
                    ?>
                </div>
            </div>
        </div>
    </div>
<?php printFooter();?>