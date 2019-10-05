let rules = [],statusNowLocal=0,BigTimerId=-1, timerType=0, bigTimerTime=0,freeTimerTime = [0,0];
let CheckTimeId = -1,CTimerId=-1,CCTimerId=-1,timerStatus=[0,0],hasBeeped = 0,hasBeeped1=0,hasBeeped2=0;
//timerType: 0-大计时器 1-自由辩计时器
//timerStatus: 0-主计时器是否在运行 1-(-1:尚未开始计时 0:正方在计时 1:反方在计时 2:暂停了计时)
const posList = ["","正方一辩","正方二辩","正方三辩","正方四辩","反方一辩","反方二辩","反方三辩","反方四辩",];

function right(mainStr,lngLen){
    if(mainStr.length-lngLen>=0&&mainStr.length>=0&&mainStr.length-lngLen<=mainStr.length){
        return mainStr.substring(mainStr.length-lngLen,mainStr.length)}
    else{return null}
}
function changeStatusHTML(str) {
    $("#status").html(str);
}
function checkTimer() {
    let min = Math.floor(bigTimerTime/60);
    let sec = bigTimerTime - min*60;
    if ( min < 10 ) min = "0" + min;
    if ( sec < 10 ) sec = "0" + sec;
    let str = min+" : "+sec;
    $("#mainTimer").html(str);
    if(bigTimerTime<=30&&rules[statusNowLocal][0]!=="3") $("#mainTimer").attr("class","bigTime danger-time-big");
    else $("#mainTimer").attr("class","bigTime");
    if(rules[statusNowLocal][0]==="2") $("#mainTimer").attr("class","invisible");

    if(bigTimerTime===60) {
        document.getElementById("mic-1").play();
        setTimeout("document.getElementById(\"mic-1\").pause();",3000);
    }
    else if(bigTimerTime===30) {
        document.getElementById("mic-2").play();
        setTimeout("document.getElementById(\"mic-2\").pause();",700);
    }

    min = Math.floor(freeTimerTime[0]/60);
    sec = freeTimerTime[0] - min*60;
    if ( min < 10 ) min = "0" + min;
    if ( sec < 10 ) sec = "0" + sec;
    str = min+" : "+sec;
    $("#CTime").html(str);
    if(freeTimerTime[0]<=30) $("#CTime").attr("class","CTime danger-time-small");
    else $("#CTime").attr("class","CTime");

    if(freeTimerTime[0]===60) {
        document.getElementById("mic-1").play();
        setTimeout("document.getElementById(\"mic-1\").pause();",3000);
    }
    else if(freeTimerTime[0]===30) {
        document.getElementById("mic-2").play();
        setTimeout("document.getElementById(\"mic-2\").pause();",700);
    }

    min = Math.floor(freeTimerTime[1]/60);
    sec = freeTimerTime[1] - min*60;
    if ( min < 10 ) min = "0" + min;
    if ( sec < 10 ) sec = "0" + sec;
    str = min+" : "+sec;
    $("#CCTime").html(str);
    if(freeTimerTime[1]<=30) $("#CCTime").attr("class","CCTime danger-time-small");
    else $("#CCTime").attr("class","CCTime");

    if(freeTimerTime[1]===60) {
        document.getElementById("mic-1").play();
        setTimeout("document.getElementById(\"mic-1\").pause();",3000);
    }
    else if(freeTimerTime[1]===30) {
        document.getElementById("mic-2").play();
        setTimeout("document.getElementById(\"mic-2\").pause();",700);
    }
}

//大计时器部分
function bigTimerDecline() {
    if(bigTimerTime === 0){
        document.getElementById("mic-3").play();
        setTimeout("document.getElementById(\"mic-3\").pause();",7000);
        stopBigTimer();
        return;
    }
    bigTimerTime--;
}
function startBigTimer() {
    timerStatus[0]=1;
    BigTimerId = setInterval("bigTimerDecline();",1000);
}
function stopBigTimer() {
    timerStatus[0]=0;
    clearInterval(BigTimerId);
}

//自由辩论计时器部分
function CTimerDecline() {
    if(freeTimerTime[1] === 0){
        stopCTimer();
        document.getElementById("mic-3").play();
        setTimeout("document.getElementById(\"mic-3\").pause();",5000);
        startCCTimer();
        return;
    }
    freeTimerTime[1]--;
}
function startCTimer() {
    if(freeTimerTime[1] === 0) {
        return ;
    }
    timerStatus[1]=0;
    CTimerId = setInterval("CTimerDecline();",1000);
}
function stopCTimer() {
    timerStatus[1]=1;
    clearInterval(CTimerId);
}
function CCTimerDecline() {
    if(freeTimerTime[0] === 0){
        stopCCTimer();
        document.getElementById("mic-3").play();
        setTimeout("document.getElementById(\"mic-3\").pause();",5000);
        startCTimer();
        return;
    }
    freeTimerTime[0]--;
}
function startCCTimer() {
    if(freeTimerTime[0] === 0) {
        return ;
    }
    timerStatus[1]=1;
    CCTimerId = setInterval("CCTimerDecline();",1000);
}
function stopCCTimer() {
    timerStatus[1]=0;
    clearInterval(CCTimerId);
}

//人物照片部分
function changeActivePerson(uid) {
    $(".imgBox-C-1").attr("class","imgBox imgBox-C-1");
    $(".imgBox-C-2").attr("class","imgBox imgBox-C-2");
    $(".imgBox-C-3").attr("class","imgBox imgBox-C-3");
    $(".imgBox-C-4").attr("class","imgBox imgBox-C-4");
    $(".imgBox-CC-1").attr("class","imgBox imgBox-CC-1");
    $(".imgBox-CC-2").attr("class","imgBox imgBox-CC-2");
    $(".imgBox-CC-3").attr("class","imgBox imgBox-CC-3");
    $(".imgBox-CC-4").attr("class","imgBox imgBox-CC-4");
    for(let i=0;i<uid.length;i++){
        if(uid[i]<=4) $(".imgBox-C-"+uid[i]).attr("class","imgBox imgBox-C-"+uid[i]+" a-active");
        else $(".imgBox-CC-"+(uid[i]-4)).attr("class","imgBox imgBox-CC-"+(uid[i]-4)+" a-active");
    }
}
function changeStatusTo(id) {
    let tmp = statusNowLocal;
    statusNowLocal=id;
    let [type,u1,u2,time,str]=rules[id];
    console.log([type,u1,u2,time,str]);
    let uid = [];
    if(rules[tmp][0]==="2") {
        stopCTimer();
        stopCCTimer();
    }
    else {
        stopBigTimer();
    }
    if(type === "0"){
        if(u1.length===2) str = posList[uid[0] = parseInt(right(u1,1))] + " · " + str;
        else str = posList[uid[0] = parseInt(right(u1,1))+4] + " · " + str;
        changeStatusHTML(str);
        bigTimerTime=time;
        $("#mainTimer").attr("class","bigTime");
        $("#freeTimerId").attr("class","invisible timeSet");
        changeActivePerson(uid);
    }
    else if(type === "1"){
        if(u1.length===2) str = posList[uid[0] = parseInt(right(u1,1))] + " · " + str;
        else str = posList[uid[0] = parseInt(right(u1,1))+4] + " · " + str;
        str = str + " · ";

        if(u2.length===2) str = str + posList[uid[1] = parseInt(right(u2,1))];
        else str = str + posList[uid[1] = parseInt(right(u2,1))+4];
        changeStatusHTML(str);
        changeActivePerson(uid);
        bigTimerTime=time;
        $("#mainTimer").attr("class","bigTime");
        $("#freeTimerId").attr("class","invisible timeSet");
    }
    else if(type === "2"){
        changeStatusHTML(str);
        freeTimerTime=[time,time];
        $("#mainTimer").attr("class","invisible bigTime");
        $("#freeTimerId").attr("class","timeSet");
        changeActivePerson([1,2,3,4,5,6,7,8]);
    }
    else if(type === "3"){
        changeStatusHTML("比赛介绍环节");
        bigTimerTime=time;
        changeActivePerson([1,2,3,4,5,6,7,8]);
    }
}
function checkStatus() {
    $.ajax({
        url:"./rule/server-ko.json",
        success: function (res) {
            if(res.order===0){
                 //无需进行环节切换
            }
            else if(res.order === 1){
                if(res.statusTo !== statusNowLocal){
                    //停止计时并切换环节

                }
            }
            else if(res.order === 2){
                //开始计时
            }
            else if(res.order === 3){
                //暂停计时
            }

        }
    })
}
function stepStatus(){
    changeStatusTo(statusNowLocal+1);
}
function declineStatus(){
    changeStatusTo(statusNowLocal-1);
}


function getQueryString(name){
    let reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
    let r = window.location.search.substr(1).match(reg);
    if(r!=null)return  unescape(r[2]); return null;
}

$(document).ready(function () {
    document.onkeydown = function() {
        let {keyCode} = window.event;
        if (keyCode === 39 && statusNowLocal!== rules.length-2) {
            stepStatus();
        }
        else if (keyCode === 37 && statusNowLocal!== 0) {
            declineStatus();
        }
        else if (keyCode === 13) {
            stopBigTimer();
            stopCTimer();
            stopCCTimer();
            timerStatus = [0,0];
        }
        else if (keyCode === 32) {
            if(rules[statusNowLocal][0]!=="2"){
                if(timerStatus[0]===0) startBigTimer();
                else stopBigTimer();
            }
            else {
                if(timerStatus[1]===-1) {
                    startCTimer();
                }
                else if(timerStatus[1]===0) {
                    stopCTimer();
                    startCCTimer();
                }
                else if(timerStatus[1]===1) {
                    stopCCTimer();
                    startCTimer();
                }
            }
        }
        else if (keyCode==49) {
            document.getElementById("mic-1").play();
            setTimeout("document.getElementById(\"mic-1\").pause();",3000);
        }
        else if (keyCode==50) {
            document.getElementById("mic-2").play();
            setTimeout("document.getElementById(\"mic-2\").pause();",3000);
        }
        else if (keyCode==51) {
            document.getElementById("mic-3").play();
            setTimeout("document.getElementById(\"mic-3\").pause();",3000);
        }
    };//rule/ko-demo.json
    // $.ajax({url:"./rule/ko-demo.json",success:function (res) {
    $.ajax({url:"./rule/ko-json.php?id="+getQueryString("id"),success:function (res) {
            res = JSON.parse(res);
            let {battle,team} = res;
            let titleJ = $("#title");
            if(battle.title.length>18) titleJ.addClass("two-line");
            titleJ.html(battle.title);
            $("#teamName-C").html(team[0].teamName);
            $("#teamName-CC").html(team[1].teamName);
            team[0].debaters.map((item,index)=>{
                $("#name-C-"+(index+1)).html(item.name);
                $("#img-C-"+(index+1)).attr("src",item.imgUrl);
                $("#pos-C-"+(index+1)).html(posList[index+1]);
            });
            team[1].debaters.map((item,index)=>{
                $("#name-CC-"+(index+1)).html(item.name);
                $("#img-CC-"+(index+1)).attr("src",item.imgUrl);
                $("#pos-CC-"+(index+1)).html(posList[index+5]);
            });
            let rule_arr=battle.rule.split(";");
            for(let i =0;i< rule_arr.length;i++){
                rules[i]=rule_arr[i].split(",");
            }
            console.log(rules);
            changeStatusTo(0);
            CheckTimeId = setInterval("checkTimer();",1000);
        }});
});