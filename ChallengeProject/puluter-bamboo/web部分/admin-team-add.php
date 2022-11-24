<?php
include("require.php");
if ($_SESSION["userType"] != "admin" || !isset($_SESSION["userType"])) redirect("./login.html");
$wx = new WeChat("factory-1");
$pageName = "添加队伍";
printHeader($pageName, $_SESSION['userType'])
?>
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">添加队伍</h4>
                    <h6 class="card-subtitle">在这里添加队伍</h6>
                    <form action="./action.php?m=addTeam" method="post">
                        <?php
                        printInput("name","队名","请输入队名");
                        printInput("imgUrl","logo链接","请输入logo链接");
                        ?>
                        <button type="submit" class="btn btn-success waves-effect waves-light m-r-10">发起添加</button>
                    </form>
                </div>
            </div>
        </div>

    </div>
<?php printFooter(); ?>