<?php
include("require.php");
if ($_SESSION["userType"] != "admin" || !isset($_SESSION["userType"])) redirect("./login.html");
$wx = new WeChat("factory-1");
$pageName = "______";
printHeader($pageName, $_SESSION['userType'])
?>
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">______</h4>
                    <h6 class="card-subtitle">______</h6>

                </div>
            </div>
        </div>

    </div>
<?php printFooter(); ?>