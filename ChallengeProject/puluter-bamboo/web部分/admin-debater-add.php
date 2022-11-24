<?php
include("require.php");
if ($_SESSION["userType"] != "admin" || !isset($_SESSION["userType"])) redirect("./login.html");
$wx = new WeChat("factory-1");
$pageName = "添加辩手";
printHeader($pageName, $_SESSION['userType'])
?>
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">添加辩手</h4>
                    <h6 class="card-subtitle">在这里添加一名新辩手</h6>
                    <form action="./action.php?m=addDebater" method="post">
                        <?php
                            printInput("name","姓名","请输入姓名");
                            printInput("gender","性别","请输入性别");
                            printInput("teamId","teamID","请输入teamID");
                            printInput("desc","描述","请输入描述",1);
                            printInput("imgUrl","头像链接","请输入头像链接");
                        ?>
                        <button type="submit" class="btn btn-success waves-effect waves-light m-r-10">发起添加</button>
                    </form>
                </div>
            </div>
        </div>

    </div>
<?php printFooter(); ?>