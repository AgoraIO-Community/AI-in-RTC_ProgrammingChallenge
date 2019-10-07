<?php include('./php_token/src/RtcTokenBuilder.php');?>
<!DOCTYPE html>
<html>
<head>
<title>Agora Web Sample</title>
<link rel="stylesheet" href="vendor/bootstrap.min.css">
<script src="AgoraRTCSDK-2.8.0.js"></script>
<script src="AgoraRTCSDK-2.9.0.js"></script>
<!--<script src="live.js"></script>-->
<script src="vendor/jquery.js"></script>
</head>
<?php 
function msectime(){
	list($msec, $sec) = explode(' ', microtime());
    return (float)sprintf('%.0f', (floatval($msec) + floatval($sec)) * 1000);
}
$appId=trim($_GET['APPID']);
//echo '<h4>APPID: ' . $appId . PHP_EOL .'</h4>';
$channel=trim($_GET['channel']);
//echo '<h4>CHANNEL ' . $channel . PHP_EOL .'</h4>';
$certificate=$_GET['certificate'];
//echo '<h4>CERTIFICATE ' . $certificate . PHP_EOL .'</h4>';
//$userAccount=trim(strval(msectime()));
$userUid=msectime();
//echo '<h4>UID ' . $userUid . PHP_EOL .'</h4>'; 
//$token=trim(str_replace(' ','',RtcTokenBuilder::buildTokenWithUserAccount($appId, $certificate, $channel, $userAccount, 1, 0)));
if(!empty($certificate)){
	$token = RtcTokenBuilder::buildTokenWithUid('8cdeee9db3d544659b9c6065a9cf8dcf', '7eb8c7eff4424ae79419bf721162b509', '1000', $userUid, 1, 0);
}else{
	$token='';
}

//echo '<h4>Token with user account: ' . $token . PHP_EOL .'</h4>';

//echo $appId.'<br/>';
//echo $token.'<br/>';
//print_r($token.'<br/>');
//echo '0068cdeee9db3d544659b9c6065a9cf8dcfIABhgfExEm89CimY5f/+zO/t7aW4edXv+C/YGDPtQzfg3hejJ7QAAAAAEADeGBsuOCSMXQEAAQBlJIxd';

?>
<body>
<div id="div_device" class="panel panel-default">
<div class="select">
<label for="audioSource">Audio source: </label><select id="audioSource"></select>
</div>
<div class="select">
<label for="videoSource">Video source: </label><select id="videoSource"></select>
</div>
</div>

<div id="div_join" class="panel panel-default">
<div class="panel-body">
<input id="appId" type="hidden" value="<?php echo $appId;?>"></input>
<input id="channel" type="hidden" value="<?php echo $channel;?>" ></input>
<input id="uid" type="hidden" value="<?php echo $userUid;?>" ></input>
<input id="certificate" type="hidden" value="<?php echo $certificate;?>"></input>
<input id="token" type="hidden" value="<?php echo $token;?>"></input>
Host: <input id="video" type="checkbox" checked></input>
<button id="join" class="btn btn-primary" onclick="join()">Join</button>
<button id="leave" class="btn btn-primary" onclick="leave()">Leave</button>
<button id="publish" class="btn btn-primary" onclick="publish()">Publish</button>
<button id="unpublish" class="btn btn-primary" onclick="unpublish()">Unpublish</button>
</div>
</div>

    <!--style>
    .video__box{width:910px; margin:0 auto; overflow:hidden;}
    .video__main{ width:810px; height:607px;float:left }
    .video__list{ width:200px; height:607px; float:left;}
    .video__item{ width:200px; height:174px; hei background:url(/img/icon_live.png) center center no-repeat; }
    </style>
    <div class="video__main">
    </div>
    <div class="video__list">
        <div class="video__item"></div>
        <div id="video" class="video__item">
            <div id="agora_local"></div>
        </div>
    </div-->

<div id="video" style="margin:0 auto;">
    <div id="agora_local" style="float:right;width:210px;height:147px;display:inline-block;"></div>
</div>

<script language="javascript">

if(!AgoraRTC.checkSystemRequirements()) {
  alert("Your browser does not support WebRTC!");
}

/* select Log type */
// AgoraRTC.Logger.setLogLevel(AgoraRTC.Logger.NONE);
// AgoraRTC.Logger.setLogLevel(AgoraRTC.Logger.ERROR);
// AgoraRTC.Logger.setLogLevel(AgoraRTC.Logger.WARNING);
// AgoraRTC.Logger.setLogLevel(AgoraRTC.Logger.INFO);  
// AgoraRTC.Logger.setLogLevel(AgoraRTC.Logger.DEBUG);

/* simulated data to proof setLogLevel() */
AgoraRTC.Logger.error('this is error');
AgoraRTC.Logger.warning('this is warning');
AgoraRTC.Logger.info('this is info');
AgoraRTC.Logger.debug('this is debug');

var client, localStream, camera, microphone;

var audioSelect = document.querySelector('select#audioSource');
var videoSelect = document.querySelector('select#videoSource');



function join() {
  document.getElementById("join").disabled = true;
  document.getElementById("video").disabled = true;
  var channel_key = null;

  console.log("Init AgoraRTC client with App ID: " + appId.value);
  var rtc = {
	  client: null,
	  joined: false,
	  published: false,
	  localStream: null,
	  remoteStreams: [],
	  params: {}
	};

	var option = {
	  appID: appId.value,
	  channel: channel.value,
	  uid: uid.value,
	  token: token.value==''?null:token.value
	}

	// Create a client
	rtc.client = AgoraRTC.createClient({mode: "live", codec: "h264"});
  //alert('appid:'+appId.value);
   rtc.client.init(option.appID, function () {
    console.log("AgoraRTC client initialized");
	//alert('token:'+token.value+'，channel：'+channel.value);
	rtc.client.setClientRole('host');
    rtc.client.join(option.token, channel.value, null, function(uid) {
      console.log("User " + uid + " join channel successfully");

      if (document.getElementById("video").checked) {
        camera = videoSource.value;
        microphone = audioSource.value;
        rtc.localStream = AgoraRTC.createStream({streamID: uid, audio: true, cameraId: camera, microphoneId: microphone, video: document.getElementById("video").checked, screen: false});
        //localStream = AgoraRTC.createStream({streamID: uid, audio: false, cameraId: camera, microphoneId: microphone, video: false, screen: true, extensionId: 'minllpmhdgpndnkomcoccfekfegnlikg'});
        if (document.getElementById("video").checked) {
          rtc.localStream.setVideoProfile('720p_3');

        }

        // The user has granted access to the camera and mic.
        rtc.localStream.on("accessAllowed", function() {
          console.log("accessAllowed");
        });

        // The user has denied access to the camera and mic.
        rtc.localStream.on("accessDenied", function() {
          console.log("accessDenied");
        });

        rtc.localStream.init(function() {
          console.log("getUserMedia successfully");
          rtc.localStream.play('agora_local');

          rtc.client.publish(rtc.localStream, function (err) {
            console.log("Publish local stream error: " + err);
          });

          rtc.client.on('stream-published', function (evt) {
            console.log("Publish local stream successfully");
          });
        }, function (err) {
          console.log("getUserMedia failed", err);
        });
      }
    }, function(err) {
      console.log("Join channel failed", err);
    });
  }, function (err) {
    console.log("AgoraRTC client init failed", err);
  });

  channelKey = "";
  rtc.client.on('error', function(err) {
    console.log("Got error msg:", err.reason);
    if (err.reason === 'DYNAMIC_KEY_TIMEOUT') {
      rtc.client.renewChannelKey(channelKey, function(){
        console.log("Renew channel key successfully");
      }, function(err){
        console.log("Renew channel key failed: ", err);
      });
    }
  });


  rtc.client.on('stream-added', function (evt) {
    var stream = evt.stream;
    console.log("New stream added: " + stream.getId());
    console.log("Subscribe ", stream);
    client.subscribe(stream, function (err) {
      console.log("Subscribe stream failed", err);
    });
  });

  rtc.client.on('stream-subscribed', function (evt) {
    var stream = evt.stream;
    console.log("Subscribe remote stream successfully: " + stream.getId());
    if ($('div#video #agora_remote'+stream.getId()).length === 0) {
      $('div#video').append('<div id="agora_remote'+stream.getId()+'" style="float:left; width:810px;height:607px;display:inline-block;"></div>');
    }
    stream.play('agora_remote' + stream.getId());
  });

  rtc.client.on('stream-removed', function (evt) {
    var stream = evt.stream;
    stream.stop();
    $('#agora_remote' + stream.getId()).remove();
    console.log("Remote stream is removed " + stream.getId());
  });

  rtc.client.on('peer-leave', function (evt) {
    var stream = evt.stream;
    if (stream) {
      stream.stop();
      $('#agora_remote' + stream.getId()).remove();
      console.log(evt.uid + " leaved from this channel");
    }
  });
}

function leave() {
  document.getElementById("leave").disabled = true;
  rtc.client.leave(function () {
    console.log("Leavel channel successfully");
  }, function (err) {
    console.log("Leave channel failed");
  });
}

function publish() {
  document.getElementById("publish").disabled = true;
  document.getElementById("unpublish").disabled = false;
  rtc.client.publish(localStream, function (err) {
    console.log("Publish local stream error: " + err);
  });
}

function unpublish() {
  document.getElementById("publish").disabled = false;
  document.getElementById("unpublish").disabled = true;
  rtc.client.unpublish(localStream, function (err) {
    console.log("Unpublish local stream failed" + err);
  });
}

function getDevices() {
  AgoraRTC.getDevices(function (devices) {
    for (var i = 0; i !== devices.length; ++i) {
      var device = devices[i];
      var option = document.createElement('option');
      option.value = device.deviceId;
      if (device.kind === 'audioinput') {
        option.text = device.label || 'microphone ' + (audioSelect.length + 1);
        audioSelect.appendChild(option);
      } else if (device.kind === 'videoinput') {
        option.text = device.label || 'camera ' + (videoSelect.length + 1);
        videoSelect.appendChild(option);
      } else {
        console.log('Some other kind of source/device: ', device);
      }
    }
  });
}

//audioSelect.onchange = getDevices;
//videoSelect.onchange = getDevices;
getDevices();
</script>
</body>
</html>
