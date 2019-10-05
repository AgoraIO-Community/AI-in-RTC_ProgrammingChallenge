<?php
include("require.php");
if(($_SESSION["userType"]!="official"&&$_SESSION["userType"]!="admin")||!isset($_SESSION["userType"])) redirect("./login.html");
$wx = new WeChat("factory-1");
$pageName = "______";
printHeader($pageName, $_SESSION['userType']);
?>
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">生成中~</h4>
                    <h6 class="card-subtitle">______</h6>
                    <?php
                        function dg($num){
                            return floor($num*100)/100;
                        }

                        $bid = $_GET["id"];
                        $ext = $wx->databaseQuery("db.collection(\"data-analysis\").where({env:\"{$GLOBALS["env"]}\",battleId: \"{$bid}\"}).get()")["pager"]["Total"];
                        $pointBL = $wx->databaseQuery("db.collection(\"battleJudgePoints\").where({env:\"{$GLOBALS["env"]}\",battleId: \"{$bid}\"}).get()");
                        if($pointBL["pager"]["Total"]==0) exit;
                        if($ext==0) {
                            $pointBL = $pointBL["data"];
                            $debatersL = $wx->databaseQuery("db.collection(\"battle-debaters-selection\").where({env:\"{$GLOBALS["env"]}\",battleId: \"{$bid}\"}).get()")["data"];
                            $battleL = json_decode($wx->databaseQuery("db.collection(\"battle\").doc( \"{$bid}\").get()")["data"][0],true);
                            $teamC = ($battleL["data"]["teamClaim"]["Id"]==json_decode($debatersL[0],true)["teamId"])?json_decode($debatersL[0],true):json_decode($debatersL[1],true);
                            $teamCC = ($battleL["data"]["teamClaim"]["Id"]==json_decode($debatersL[0],true)["teamId"])?json_decode($debatersL[1],true):json_decode($debatersL[0],true);
                            foreach($pointBL as $pb) {
                                $pb = json_decode($pb,true);
                                $p = $pb["debaters"];
                                $avgPoints = array(
                                    dg(($p[1][0]+$p[2][0]+$p[3][0]+$p[5][0]+$p[6][0]+$p[7][0])/6),dg(($p[1][1]+$p[2][1]+$p[3][1]+$p[5][1]+$p[6][1]+$p[7][1])/6),dg(($p[1][2]+$p[2][2]+$p[3][2]+$p[5][2]+$p[6][2]+$p[7][2])/6),dg(($p[1][3]+$p[2][3]+$p[3][3]+$p[5][3]+$p[6][3]+$p[7][3]+$p[8][1]+$p[4][1])/8));//申论 质询 答辩 自由辩
                                $p1 = dg(($p[4][0]+$p[8][0])/2);
                                $p2 = dg(($p[4][2]+$p[8][2])/2);
                                for($j=0;$j<3;$j++) {
                                    $wx->databaseAdd("db.collection(\"data-analysis\").add({data:{env:\"{$GLOBALS["env"]}\",battleId:\"{$bid}\",debaterId:\"{$teamC["data"][$j]}\",myPoints:\"申论：{$p[$j+1][0]} ，质询：{$p[$j+1][1]} ，答辩：{$p[$j+1][2]} ，自由辩：{$p[$j+1][3]} 。\",avgPoints:\"[{$avgPoints[0]},{$avgPoints[1]},{$avgPoints[2]},{$avgPoints[3]}]\",teamId:\"{$teamC["teamId"]}\"}})");
                                }
                                $wx->databaseAdd("db.collection(\"data-analysis\").add({data:{env:\"{$GLOBALS["env"]}\",battleId:\"{$bid}\",debaterId:\"{$teamC["data"][3]}\",myPoints:\"小结：{$p[4][0]} ，自由辩：{$p[4][1]} ，结辩：{$p[4][2]}。\",avgPoints:\"[{$p1},{$avgPoints[3]},{$p2}]\",teamId:\"{$teamC["teamId"]}\"}})");

                                for($j=4;$j<7;$j++) {
                                    $wx->databaseAdd("db.collection(\"data-analysis\").add({data:{env:\"{$GLOBALS["env"]}\",battleId:\"{$bid}\",debaterId:\"{$teamCC["data"][$j-4]}\",myPoints:\"申论：{$p[$j+1][0]} ，质询：{$p[$j+1][1]} ，答辩：{$p[$j+1][2]} ，自由辩：{$p[$j+1][3]} 。\",avgPoints:\"[{$avgPoints[0]},{$avgPoints[1]},{$avgPoints[2]},{$avgPoints[3]}]\",teamId:\"{$teamCC["teamId"]}\"}})");
                                }
                                $wx->databaseAdd("db.collection(\"data-analysis\").add({data:{env:\"{$GLOBALS["env"]}\",battleId:\"{$bid}\",debaterId:\"{$teamCC["data"][3]}\",myPoints:\"小结：{$p[8][0]} ，自由辩：{$p[8][1]} ，结辩：{$p[8][2]}。\",avgPoints:\"[{$p1},{$avgPoints[3]},{$p2}]\",teamId:\"{$teamCC["teamId"]}\"}})");
                            }
                        }
                        else {
                            echo "已经生成过了！";
                        }
                    ?>
                </div>
            </div>
        </div>

    </div>
<?php printFooter(); ?>