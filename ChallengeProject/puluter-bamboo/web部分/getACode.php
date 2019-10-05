<?php
    include("require.php");
    $wx = new WeChat("build1");

    var_dump($wx->getwxaqrcode("pages/schedule/schedule?env=champion2019&cName=第一届国际华语辩论冠军赛",""));