<?php
include("require.php");
if ($_SESSION["userType"] != "admin" || !isset($_SESSION["userType"])) redirect("./login.html");
$wx = new WeChat("factory-1");
$pageName = "添加比赛";
printHeader($pageName, $_SESSION['userType'])
?>
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">添加比赛</h4>
                    <h6 class="card-subtitle">在这里添加比赛</h6>
                    <form action="./action.php?m=addBattle" method="post">
                        <?php
                        printInput("title","辩题","请输入辩题");
                        printInput("loc","地址","请输入地址");
                        printInput("time","时间","请输入时间");
                        printInput("teamClaimId","正方teamId","请输入正方teamId");
                        printInput("teamCounterClaimId","反方teamId","请输入反方teamId");
                        ?>
                        <button type="submit" class="btn btn-success waves-effect waves-light m-r-10">发起添加</button>
                    </form>
                </div>
            </div>
        </div>

    </div>
<?php printFooter(); ?>