<?php
include("require.php");
if ($_SESSION["userType"] != "admin" || !isset($_SESSION["userType"])) redirect("./login.html");
$wx = new WeChat("factory-1");
$pageName = "添加裁判";
printHeader($pageName, $_SESSION['userType'])
?>
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">添加裁判</h4>
                    <h6 class="card-subtitle">在这里添加裁判</h6>
                    <form action="./action.php?m=addJudge" method="post">
                        <input type="hidden" name="hasInit" value="0"/>
                        <?php
                        printInput("name","姓名","请输入姓名");
                        printInput("username","username","请输入username");
                        printTxt("注意！","密码将自动生成，请过后进行查询");
                        ?>
                        <button type="submit" class="btn btn-success waves-effect waves-light m-r-10">发起添加</button>
                    </form>
                </div>
            </div>
        </div>

    </div>
<?php printFooter(); ?>