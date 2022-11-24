<?php
    include ("require.php");
    if($_SESSION["userType"]!="admin"||!isset($_SESSION["userType"])) redirect("./login.html");
    $wx = new WeChat("factory-1");
    $pageName = "管理员主页";
    function getDebaterCount(){
        global $wx;
        $res = $wx->databaseCount("db.collection(\"debater\").where({env:\"{$GLOBALS['env']}\"}).count()");
        return $res["count"];
    }
    function getTeamCount(){
        global $wx;
        $res = $wx->databaseCount("db.collection(\"team\").where({env:\"{$GLOBALS['env']}\"}).count()");
        return $res["count"];
    }
    function getBattleCount(){
        global $wx;
        $res = $wx->databaseCount("db.collection(\"battle\").where({env:\"{$GLOBALS['env']}\"}).count()");
        return $res["count"];
    }
    printHeader($pageName,$_SESSION['userType']);
?>
    <div class="row">
        <div class="col-12">
            <div class="row">
                <!-- Column -->
                <div class="col-lg-3 col-md-6">
                    <a href="./admin-debater-list.php">
                        <div class="card">
                            <div class="card-body">
                                <div class="d-flex flex-row">
                                    <div class="round align-self-center round-info"><i class="ti-user"></i></div>
                                    <div class="m-l-10 align-self-center">
                                        <h3 class="m-b-0"><?php echo getDebaterCount();?></h3>
                                        <h5 class="text-muted m-b-0">辩手总数</h5></div>
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
                <!-- Column -->
                <!-- Column -->
                <div class="col-lg-3 col-md-6">
                    <div class="card">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-12">
                                    <h3>40%</h3>
                                    <h6 class="card-subtitle">辩手报到率</h6></div>
                                <div class="col-12">
                                    <div class="progress">
                                        <div class="progress-bar bg-info" role="progressbar" style="width: 40%; height: 6px;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Column -->
                <!-- Column -->
                <div class="col-lg-3 col-md-6">
                    <div class="card">
                        <div class="card-body">
                            <div class="d-flex flex-row">
                                <div class="round align-self-center round-success"><i class="ti-save-alt"></i></div>
                                <div class="m-l-10 align-self-center">
                                    <h3 class="m-b-0"><?php echo getTeamCount();?></h3>
                                    <h5 class="text-muted m-b-0">队伍总数</h5></div>
                            </div>
                        </div>
                    </div>
                </div><div class="col-lg-3 col-md-6">
                    <div class="card">
                        <div class="card-body">
                            <div class="d-flex flex-row">
                                <div class="round align-self-center round-danger"><i class="ti-calendar"></i></div>
                                <div class="m-l-10 align-self-center">
                                    <h3 class="m-b-0"><?php echo getBattleCount();?></h3>
                                    <h5 class="text-muted m-b-0">比赛总数</h5></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

<?php printFooter();?>