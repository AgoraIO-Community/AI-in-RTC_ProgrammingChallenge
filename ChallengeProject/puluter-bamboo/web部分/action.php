<?php
    include("require.php");
    $motion = $_GET["m"];
    $wx = new WeChat("factory-1");
    function randomKeys($length)
    {
        $pattern = '123456789abcdefghijkmnpqrstuvwxyzABCDEFGHJKLOMNPQRSTUVWXYZ';
        $key = "";
        for($i=0;$i<$length;$i++)
        {
            $key .= $pattern{mt_rand(0,35)};    //生成php随机数
        }
        return $key;
    }

    if($motion == "login"){
        $username = addslashes($_POST["username"]);
        $password = addslashes($_POST["password"]);
        $res = $wx->databaseQuery("db.collection(\"web-login\").where({env:\"{$GLOBALS["env"]}\",username:\"{$username}\",password:\"{$password}\"}).get()");
        var_dump(array($res,$password));
        var_dump($res);
        if($res["pager"]["Total"]==0) redirect("login.html?errCode=1");
        else {
            $_SESSION["username"] = $username;
            $_SESSION["userType"] = json_decode($res["data"][0],true)["userType"];
            if($_SESSION["userType"]=="admin") redirect("./admin-index.php");
            else if($_SESSION["userType"]=="official") redirect("./show-battle-list.php");
            else redirect("./user-battle-list.php");
        }
    }
    else if($motion=="addDebater"){
        $name   = $_POST["name"];
        $gender = $_POST["gender"];
        $teamID = $_POST["teamId"];
        $desc = $_POST["desc"];
        $imgUrl = $_POST["imgUrl"];
        $res = $wx->databaseAdd("db.collection(\"debater\").add({data:{env:\"{$GLOBALS["env"]}\",openId:\"\",name:\"{$name}\",gender:\"{$gender}\",teamId:\"{$teamID}\",desc:\"{$desc}\",imgUrl:\"{$imgUrl}\"}})");
        redirect("./admin-debater-query.php?id=".$res["id_list"][0]);
    }
    else if($motion=="addBattle"){
        $title   = $_POST["title"];
        $loc = $_POST["loc"];
        $time = $_POST["time"];
        $teamClaimId = $_POST["teamClaimId"];
        $teamCounterClaimId = $_POST["teamCounterClaimId"];
        $res = $wx->databaseAdd("db.collection(\"battle\").add({data:{env:\"{$GLOBALS["env"]}\",title:\"{$title}\",status:\"0\",loc:\"{$loc}\",time:\"{$time}\",data:{teamClaim:{Id:\"{$teamClaimId}\",point:\"\"},teamCounterClaim:{Id:\"{$teamCounterClaimId}\",point:\"\"}}}})");
        redirect("./admin-battle-query.php?id=".$res["id_list"][0]);
    }
    else if($motion=="addTeam"){
        $name   = $_POST["name"];
        $imgUrl = $_POST["imgUrl"];
        $res = $wx->databaseAdd("db.collection(\"team\").add({data:{env:\"{$GLOBALS["env"]}\",name:\"{$name}\",imgUrl:\"{$imgUrl}\",score:[\"0\",\"0\"]}})");
        redirect("./admin-team-query.php?id=".$res["id_list"][0]);
    }
    else if($motion=="addJudge"){
        $name     = $_POST["name"];
        $username = $_POST["username"];
        $password_random = randomKeys(10);
        $password_md5    = md5($password_random);
        $res = $wx->databaseAdd("db.collection(\"web-login\").add({data:{env:\"{$GLOBALS["env"]}\",openId:\"\",username:\"{$username}\",password:\"{$password_md5}\",userType:\"judge\"}})");
        $res = $wx->databaseAdd("db.collection(\"judge\").add({data:{env:\"{$GLOBALS["env"]}\",openId:\"\",name:\"{$name}\",username:\"{$username}\",password:\"{$password_random}\",hasInit:\"0\"}})");
        redirect("./admin-judge-query.php?id=".$res["id_list"][0]);
    }