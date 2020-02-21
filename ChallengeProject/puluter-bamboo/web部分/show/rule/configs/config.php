<?php

function wxConfigInitialize(){
    $GLOBALS["APP-ID"] = "wxe84c07e11394960b";
    $GLOBALS["APP-SECRET"] = "7961d1fe6e4f9804f88ab95f1fb8cbb9";
    $GLOBALS["WX-ENV"]="factory-1";
}

function developEnvConfig(){
    $GLOBALS["env"]="online";//local online undefined
}

function initializeSessions(){
    session_start();
}
developEnvConfig();
wxConfigInitialize();
initializeSessions();