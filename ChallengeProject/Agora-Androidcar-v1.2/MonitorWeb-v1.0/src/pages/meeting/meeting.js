import $ from 'jquery';
import 'bootstrap/dist/css/bootstrap.min.css';
import 'bootstrap';

import '../../assets/css/main.css';
import './meeting.css';
import { Browser } from '../../utils/utils'
import RtcClient from '../../utils/rtcClient'
import SignalClient from '../../utils/signalClient'
import { AGORA_APP_ID } from '../../../static/agora.config';
import { DualType } from '../../utils/constants'

$(() => {
    const appid = AGORA_APP_ID;
    let account = Browser.getParameterByName("account");
    let channel = Browser.getParameterByName("channel");
    let role = Browser.getParameterByName("role");
    let rtc = new RtcClient(appid);
    let signal = new SignalClient(appid);

    // find spare container to place video into
    const findSpareContainer = () => {
        let $containers = $(`.video-container`);
        for( let i = 0; i < $containers.length; i++) {
            let $container = $($containers.get(i));
            let id = $container.attr('id');
            if(!id) {
                return $container;
            }
        }
        throw new Error(`no spare container left`);
    }

    // sync streams object with dom
    const syncStreamDisplay = streams => {
        //check removed streams
        let $containers = $(`.video-container`);
        for( let i = 0; i < $containers.length; i++) {
            let $container = $($containers.get(i));
            let id = $container.attr('id');
            if(!id) {
                continue;
            }
            let uid = id.split('-')[2];
            if(streams.filter(i => `${i.uid}` === `${uid}`).length === 0) {
                $container.removeAttr('id');
                $container.html('');
            }
        }

        //check newly added streams
        streams.forEach(stream => {
            let uid = stream.uid;
            let id = `agora-video-${uid}`;
            let $dom = $(`#${id}`);
            if($dom.length === 0) {
                //not found
                let $container = findSpareContainer();
                $container.attr('id', id);
                let dualType = $container.attr("dual");
                if(dualType === "main") {
                    //bigger screen uses high stream, which has higher resolution and bandwidth consumption
                    rtc.setRemoteStreamType(stream, DualType.High);
                } else {
                    //small screen uses low stream, which has lower resolution and bandwidth consumption
                    rtc.setRemoteStreamType(stream, DualType.Low);
                }
                stream.stream.play(id)
            }
        });
    }

    //// append a new chat message on screen
    //const displayChatMessage = (account, msg) => {
    //    $(`.chat-list`).append(`<li class="list-group-item">${account} - ${msg}</li>`);
    //}

    //bind stream update event
    rtc.on('streamlist-update', streams => {
        syncStreamDisplay(streams);
    });

    ////bind chat input
    //let $chatInput = $(`#chat-input`);
    //$chatInput.keypress(e => {
    //    if(e.which == 13) {
    //        let msg = e.currentTarget.value;
    //        $(e.currentTarget).val("");
    //        signal.broadcast(msg);
    //    }
    //});
    ////bind send btn click event
    //$(`#send_btn`).click(() => {
    //    let msg = $chatInput.val();
    //    $chatInput.val("");
    //    signal.broadcast(msg);
    //})

    //bind farward_btn click event
    $(`#farward_btn`).click(() => {
        let msg = $farward_btn.val();
        
        signal.broadcast(msg);
    })

    ////bind signal msg receive
    //signal.on("channel-message", ({account, msg}) => {
    //    displayChatMessage(account, msg);
    //});

    //by default call btn is disabled
    Promise.all([rtc.init(channel, role === "broadcaster"), signal.init(account, channel, role)]);

var keydown_flag = false;


	window.onkeydown = function(e){
        //if (e.keyCode == 13) {
        //  e.preventDefault();
        //  //client.sendMessage("C");
        //  signal.broadcastMessage("C");
        //  console.log('切换摄像头')
        //}
        if(!keydown_flag){
            console.log('按下'+e.key)
            console.log(e.keyCode)
            if(e.keyCode == 87){
	            signal.broadcast("01");
                console.log('往前走')
            }
            else if(e.keyCode == 83){
	            signal.broadcast("02");
                console.log('往后走')
            }
            else if(e.keyCode == 65){
	            signal.broadcast("03");
                console.log('往左走')
            }
            else if(e.keyCode == 68){
	            signal.broadcast("04");
                console.log('往右走')
            }
            else if(e.keyCode == 81){
	            signal.broadcast("13");
                console.log('左旋转')
            }
            else if(e.keyCode == 69){
	            signal.broadcast("14");
                console.log('右旋转')
            }
            else if(e.keyCode == 49||e.keyCode == 97){
	            signal.broadcast("s1");
                console.log('速度1')
            }
            else if(e.keyCode == 50||e.keyCode == 98){
	            signal.broadcast("s2");
                console.log('速度2')
            }
            else if(e.keyCode == 51||e.keyCode == 99){
	            signal.broadcast("s3");
                console.log('速度3')
            }
            else if(e.keyCode == 52||e.keyCode == 100){
	            signal.broadcast("s");
                console.log('速度4')
            }
            else if(e.keyCode == 70){
	            signal.broadcast("L");
                console.log('开关灯')
            }
            else if(e.keyCode == 16){
	            signal.broadcast("C");
                console.log('切换摄像头')
            }
            keydown_flag = true;
        }  
    } 

    window.onkeyup = function(e){
        console.log('释放'+e.key)
        console.log(e.keyCode)
        if(e.keyCode == 87||e.keyCode == 83||e.keyCode == 65||e.keyCode == 68||e.keyCode == 81||e.keyCode == 69){
	        signal.broadcast("05");
            console.log('停止')
        }
        keydown_flag = false;
    }
    
});