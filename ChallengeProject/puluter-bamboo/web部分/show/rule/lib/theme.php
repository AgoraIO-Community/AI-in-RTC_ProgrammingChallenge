<?php

function printFooter(){
    echo "</div>
<footer class=\"footer\"> © 2019 于卓浩 鲁ICP备19033198号-1 </footer>
</div>
</div><script src=\"../assets/plugins/jquery/jquery.min.js\"></script>
<script src=\"https://cdn.bootcss.com/popper.js/1.15.0/esm/popper-utils.js\"></script>
<script src=\"../assets/plugins/bootstrap/js/bootstrap.min.js\"></script>
<script src=\"js/jquery.slimscroll.js\"></script>
<script src=\"js/waves.js\"></script>
<script src=\"js/sidebarmenu.js\"></script>
<script src=\"../assets/plugins/sticky-kit-master/dist/sticky-kit.min.js\"></script>
<script src=\"../assets/plugins/sparkline/jquery.sparkline.min.js\"></script>
<script src=\"js/custom.min.js\"></script>
<script src=\"../assets/plugins/bootstrap-select/bootstrap-select.min.js\" type=\"text/javascript\"></script>
<script src=\"../assets/plugins/nestable/jquery.nestable.js\"></script>
</body></html>";
}

function printHeader($pageName,$userType){
    $str = "";
    if($userType=="admin") $str = "管理员";
    else if($userType=="teacher") $str="带队者";
    echo ";
    if($userType=="admin"){
        echo "<aside class=\"left-sidebar\">
        <div class=\"scroll-sidebar\">
            <div class=\"user-profile\" style=\"background: url(../assets/images/background/user-info.jpg) no-repeat;\">
                <div class=\"profile-img\"> <img src=\"../assets/images/users/1.jpg\" alt=\"user\" /> </div>
                <div class=\"profile-text\"> <a href=\"#\" data-toggle=\"dropdown\" role=\"button\" aria-haspopup=\"true\" aria-expanded=\"true\">{$_SESSION['username']}</a>
                </div>
            </div>
            <!-- End User profile text-->
            <!-- Sidebar navigation-->
            <nav class=\"sidebar-nav\">
                <ul id=\"sidebarnav\">
                    <!-- <li class=\"nav-small-cap\">PERSONAL</li>-->
                    <li>
                        <a class=\"has-arrow \" href=\"#\" aria-expanded=\"false\"><i class=\"mdi mdi-map-marker\"></i><span class=\"hide-menu\">比赛管理</span></a>
                        <ul aria-expanded=\"false\" class=\"collapse\">
                            <li><a href=\"./admin-battle-list.php\">比赛一览</a></li>
                            <li><a href=\"./admin-battle-add.php\">添加比赛</a></li>
                            <li><a href=\"./admin-battle-del.php\">删除比赛</a></li>
                            <li><a href=\"./admin-battle-query.php\">比赛信息查询</a></li>
                        </ul>
                    </li>                    
                    <li>
                        <a class=\"has-arrow \" href=\"#\" aria-expanded=\"false\"><i class=\"mdi mdi-map-marker\"></i><span class=\"hide-menu\">队伍管理</span></a>
                        <ul aria-expanded=\"false\" class=\"collapse\">
                            <li><a href=\"./admin-team-list.php\">队伍一览</a></li>
                            <li><a href=\"./admin-team-add.php\">添加队伍</a></li>
                            <li><a href=\"./admin-team-del.php\">删除队伍</a></li>
                            <li><a href=\"./admin-team-query.php\">队伍信息查询</a></li>
                        </ul>
                    </li>                    
                    <li>
                        <a class=\"has-arrow \" href=\"#\" aria-expanded=\"false\"><i class=\"mdi mdi-map-marker\"></i><span class=\"hide-menu\">辩手管理</span></a>
                        <ul aria-expanded=\"false\" class=\"collapse\">
                            <li><a href=\"./admin-debater-list.php\">辩手一览</a></li>
                            <li><a href=\"./admin-debater-add.php\">添加辩手</a></li>
                            <li><a href=\"./admin-debater-del.php\">删除辩手</a></li>
                            <li><a href=\"./admin-debater-query.php\">辩手信息查询</a></li>
                        </ul>
                    </li>                    
                    <li>
                        <a class=\"has-arrow \" href=\"#\" aria-expanded=\"false\"><i class=\"mdi mdi-map-marker\"></i><span class=\"hide-menu\">裁判管理</span></a>
                        <ul aria-expanded=\"false\" class=\"collapse\">
                            <li><a href=\"./admin-judge-list.php\">裁判一览</a></li>
                            <li><a href=\"./admin-judge-add.php\">添加裁判</a></li>
                            <li><a href=\"./admin-judge-del.php\">删除裁判</a></li>
                            <li><a href=\"./admin-judge-query.php\">裁判信息查询</a></li>
                            <li><a href=\"./admin-judge-points.php\">裁判打分查询</a></li>
                        </ul>
                    </li>
                </ul>
            </nav>
            <!-- End Sidebar navigation -->
        </div>
        <!-- End Sidebar scroll-->
        
    </aside>";
    }
    echo "<div class=\"page-wrapper\">
        <div class=\"container-fluid\">   
            <div class=\"row page-titles\">
                <div class=\"col-md-5 col-8 align-self-center\">
                    <h3 class=\"text-themecolor m-b-0 m-t-0\">{$str}后台</h3>
                    <ol class=\"breadcrumb\">
                        <li class=\"breadcrumb-item\"><a href=\"javascript:void(0)\">主页</a></li>
                        <li class=\"breadcrumb-item active\">{$pageName}</li>
                    </ol>
                </div>
            </div>";
}

function printTxt($title,$txt,$isArray=0,$array=Array()){
    if($isArray==0){
        echo "<label for=\"name\">{$title}</label>
<p>{$txt}</p>";
    }
    else {
        foreach($array as $a){
            echo "<label for=\"name\">{$a[0]}</label>
<p>{$a[1]}</p>";
        }
    }
}

function printInput($name,$title,$placeholder="",$isLong=0,$description=""){
    if($placeholder!=""){
        if($isLong==0){
            echo "<div class=\"form-group\">
                  <label for=\"name\">{$title}</label>
                  <p>{$description}</p>
                  <input type=\"text\" name=\"{$name}\" class=\"form-control\" id=\"name\" placeholder=\"{$placeholder}\">
                  </div>";
        }
        else{
            echo "<div class=\"form-group\">
                  <label for=\"name\">{$title}</label>
                  <p>{$description}</p>
                  <textarea name='{$name}' cols='30' rows='10' class='form-control' placeholder='{$placeholder}'></textarea>
                  </div>";
        }
    }
    else {
        if($isLong==0){
            echo "<div class=\"form-group\">
                  <label for=\"name\">{$title}</label>
                  <p>{$description}</p>
                  <input type=\"text\" name=\"{$name}\" class=\"form-control\" id=\"name\" placeholder=\"请输入{$title}\">
                  </div>";
        }
        else {
            echo "<div class=\"form-group\">
                  <label for=\"name\">{$title}</label>
                  <p>{$description}</p>
                  <textarea name='{$name}' cols='30' rows='10' class='form-control'></textarea>
                  </div>";
        }
        //
    }
}

function printHeaderO($pageName,$userType){
    $str = "";
    if($userType=="admin") $str = "管理员";
    else if($userType=="official") $str="工作人员";
    echo "<!DOCTYPE html>
<head>
    <meta charset=\"utf-8\">
    <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">
    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">
    <meta name=\"description\" content=\"\">
    <meta name=\"author\" content=\"\">
    <link rel=\"icon\" type=\"image/png\" sizes=\"16x16\" href=\"../logo1.png\">
    <title>{$pageName} | 竹</title>
    <link href=\"../assets/plugins/bootstrap/css/bootstrap.min.css\" rel=\"stylesheet\">
    <link href=\"../assets/plugins/footable/css/footable.bootstrap.min.css\" rel=\"stylesheet\">
    <link href=\"../assets/plugins/bootstrap-select/bootstrap-select.min.css\" rel=\"stylesheet\" />
    <link href=\"css/style.css\" rel=\"stylesheet\">
    <link href=\"../assets/plugins/nestable/nestable.css\" rel=\"stylesheet\" type=\"text/css\" />
    <link href=\"css/colors/purple.css\" id=\"theme\" rel=\"stylesheet\">
    <!--[if lt IE 9]>
    <script src=\"https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js\"></script>
    <script src=\"https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js\"></script>
    <![endif]-->
</head><body class=\"fix-header fix-sidebar card-no-border\">
<div class=\"preloader\">
    <svg class=\"circular\" viewBox=\"25 25 50 50\">
        <circle class=\"path\" cx=\"50\" cy=\"50\" r=\"20\" fill=\"none\" stroke-width=\"2\" stroke-miterlimit=\"10\" /> </svg>
</div>
<div id=\"main-wrapper\">
    <header class=\"topbar\">
        <nav class=\"navbar top-navbar navbar-expand-md navbar-light\">
            <div class=\"navbar-header\">
                <a class=\"navbar-brand\" href=\"index.html\">
                    <b>
                        <!--You can put here icon as well // <i class=\"wi wi-sunset\"></i> //-->
                        <!-- Dark Logo icon -->
                        <img src=\"../assets/images/logo-icon.png\" alt=\"homepage\" class=\"dark-logo\" />
                        <img src=\"../assets/images/logo-light-icon.png\" alt=\"homepage\" class=\"light-logo\" />
                    </b>
                    <span>
                         <img src=\"../assets/images/logo-text.png\" alt=\"homepage\" class=\"dark-logo\" />
                         <img src=\"../assets/images/logo-light-text.png\" class=\"light-logo\" alt=\"homepage\" /></span> </a>
            </div>
            <div class=\"navbar-collapse\">
                <ul class=\"navbar-nav mr-auto mt-md-0\">
                    <li class=\"nav-item\"> <a class=\"nav-link nav-toggler hidden-md-up text-muted waves-effect waves-dark\" href=\"javascript:void(0)\"><i class=\"mdi mdi-menu\"></i></a> </li>
                    <li class=\"nav-item\"> <a class=\"nav-link sidebartoggler hidden-sm-down text-muted waves-effect waves-dark\" href=\"javascript:void(0)\"><i class=\"ti-menu\"></i></a> </li>
                </ul>
            </div>
        </nav>
    </header>";
    if($userType=="admin"){
        echo "<aside class=\"left-sidebar\">
        <div class=\"scroll-sidebar\">
            <div class=\"user-profile\" style=\"background: url(../assets/images/background/user-info.jpg) no-repeat;\">
                <div class=\"profile-img\"> <img src=\"../assets/images/users/1.jpg\" alt=\"user\" /> </div>
                <div class=\"profile-text\"> <a href=\"#\" data-toggle=\"dropdown\" role=\"button\" aria-haspopup=\"true\" aria-expanded=\"true\">{$_SESSION['username']}</a>
                </div>
            </div>
            <!-- End User profile text-->
            <!-- Sidebar navigation-->
            <nav class=\"sidebar-nav\">
                <ul id=\"sidebarnav\">
                    <!-- <li class=\"nav-small-cap\">PERSONAL</li>-->
                    <li>
                        <a class=\"has-arrow \" href=\"#\" aria-expanded=\"false\"><i class=\"mdi mdi-map-marker\"></i><span class=\"hide-menu\">比赛管理</span></a>
                        <ul aria-expanded=\"false\" class=\"collapse\">
                            <li><a href=\"./admin-battle-list.php\">比赛一览</a></li>
                            <li><a href=\"./admin-battle-add.php\">添加比赛</a></li>
                            <li><a href=\"./admin-battle-del.php\">删除比赛</a></li>
                            <li><a href=\"./admin-battle-query.php\">比赛信息查询</a></li>
                        </ul>
                    </li>                    
                    <li>
                        <a class=\"has-arrow \" href=\"#\" aria-expanded=\"false\"><i class=\"mdi mdi-map-marker\"></i><span class=\"hide-menu\">队伍管理</span></a>
                        <ul aria-expanded=\"false\" class=\"collapse\">
                            <li><a href=\"./admin-team-list.php\">队伍一览</a></li>
                            <li><a href=\"./admin-team-add.php\">添加队伍</a></li>
                            <li><a href=\"./admin-team-del.php\">删除队伍</a></li>
                            <li><a href=\"./admin-team-query.php\">队伍信息查询</a></li>
                        </ul>
                    </li>                    
                    <li>
                        <a class=\"has-arrow \" href=\"#\" aria-expanded=\"false\"><i class=\"mdi mdi-map-marker\"></i><span class=\"hide-menu\">辩手管理</span></a>
                        <ul aria-expanded=\"false\" class=\"collapse\">
                            <li><a href=\"./admin-debater-list.php\">辩手一览</a></li>
                            <li><a href=\"./admin-debater-add.php\">添加辩手</a></li>
                            <li><a href=\"./admin-debater-del.php\">删除辩手</a></li>
                            <li><a href=\"./admin-debater-query.php\">辩手信息查询</a></li>
                        </ul>
                    </li>                    
                    <li>
                        <a class=\"has-arrow \" href=\"#\" aria-expanded=\"false\"><i class=\"mdi mdi-map-marker\"></i><span class=\"hide-menu\">裁判管理</span></a>
                        <ul aria-expanded=\"false\" class=\"collapse\">
                            <li><a href=\"./admin-judge-list.php\">裁判一览</a></li>
                            <li><a href=\"./admin-judge-add.php\">添加裁判</a></li>
                            <li><a href=\"./admin-judge-del.php\">删除裁判</a></li>
                            <li><a href=\"./admin-judge-query.php\">裁判信息查询</a></li>
                            <li><a href=\"./admin-judge-points.php\">裁判打分查询</a></li>
                        </ul>
                    </li>
                </ul>
            </nav>
            <!-- End Sidebar navigation -->
        </div>
        <!-- End Sidebar scroll-->
        
    </aside>";
    }
    else if($userType=="official") {
        echo "<aside class=\"left-sidebar\">
        <div class=\"scroll-sidebar\">
            <div class=\"user-profile\" style=\"background: url(../assets/images/background/user-info.jpg) no-repeat;\">
                <div class=\"profile-img\"> <img src=\"../assets/images/users/1.jpg\" alt=\"user\" /> </div>
                <div class=\"profile-text\"> <a href=\"#\" data-toggle=\"dropdown\" role=\"button\" aria-haspopup=\"true\" aria-expanded=\"true\">{$_SESSION['username']}</a>
                </div>
            </div>
            <!-- End User profile text-->
            <!-- Sidebar navigation-->
            <nav class=\"sidebar-nav\">
                <ul id=\"sidebarnav\">
                    <!-- <li class=\"nav-small-cap\">PERSONAL</li>-->
                    <li>
                        <a class=\"has-arrow \" href=\"#\" aria-expanded=\"false\"><i class=\"mdi mdi-map-marker\"></i><span class=\"hide-menu\">比赛管理</span></a>
                        <ul aria-expanded=\"false\" class=\"collapse\">
                            <li><a href=\"./show-battle-list.php\">比赛一览</a></li>
                        </ul>
                    </li>
                </ul>
            </nav>
            <!-- End Sidebar navigation -->
        </div>
        <!-- End Sidebar scroll-->
        
    </aside>";
    }
    echo "<div class=\"page-wrapper\">
        <div class=\"container-fluid\">   
            <div class=\"row page-titles\">
                <div class=\"col-md-5 col-8 align-self-center\">
                    <h3 class=\"text-themecolor m-b-0 m-t-0\">{$str}后台</h3>
                    <ol class=\"breadcrumb\">
                        <li class=\"breadcrumb-item\"><a href=\"javascript:void(0)\">主页</a></li>
                        <li class=\"breadcrumb-item active\">{$pageName}</li>
                    </ol>
                </div>
            </div>";
}