<?php

function wxConfigInitialize(){
    $GLOBALS["APP-ID"] = "nonono";
    $GLOBALS["APP-SECRET"] = "nonono";
    $GLOBALS["WX-ENV"]="factory-1";
    $GLOBALS["env"]="champion2019";
}

function developEnvConfig(){
    $GLOBALS["enV"]="online";//local online undefined
}

function initializeSessions(){
    session_start();
}
developEnvConfig();
wxConfigInitialize();
initializeSessions();