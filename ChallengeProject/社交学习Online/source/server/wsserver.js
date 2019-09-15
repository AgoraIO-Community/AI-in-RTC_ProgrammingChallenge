const URL = require("url");

const LogDebug = (...args) => {
    console.log("[WebSocekt]", ...args);
};

const _communicationO2OQueue = {}; // 一对一聊天队列
const _liveO2MQueue = {}; // 直播房间聊天队列

const WSS = (options = {port}) => {
    const WebSocket = require('ws');
    const wss = new WebSocket.Server({port: options.port});

    wss.on("connection", (ws, req) => {
        // 解析路径参数
        let url = URL.parse(req.url);
        let qs = (url.query||"").split("&");
        let q = {};
        for (let item of qs) {
            let keys = item.split("=");
            q[keys[0]] = keys[1];
        }

        let userguid = q["userguid"] || "";
        if (userguid.length <= 0) {
            // userguid 不存在，链接关闭
            LogDebug("ws has no userguid");
            ws.terminate();
            return;
        }

        // 查找是否存在同一个socket
        for (let client of wss.clients) {
            if ((client.userinfo || {}).userguid == userguid) {
                LogDebug("duplite ws client");
                client.terminate();
                continue;
            }
        }

        LogDebug(userguid);
        ws.userinfo = {
            userguid: userguid,
        };

        ws.on("ping", (data)=>{
            ws.send("ping");
            // LogDebug("ping:", data.toString());
        });

        ws.on("pong", (data)=>{
            ws.send("pong");
            // LogDebug("pong",data.toString());
        });

        ws.on("close", ()=>{
            console.log("ws disconnected");
        });

        // 增加心跳
        ws.on("message", (data)=>{
            var val = data.toString();
            console.log(val);
        });

        ws.on("close", ()=> {
            // 断开通话聊天
            let useguid = ws.userinfo.userguid;
            delete _communicationO2OQueue[useguid];

            // 断开直播
            let roomKey = `room_${userguid}`;
            let myRoom = _liveO2MQueue[roomKey];
            if (myRoom)
            {
                let count = 0;
                for (let key in myRoom)
                {
                    count++;
                    if (count > 1)
                    {
                        break;
                    }
                }
                if (count <=1 )
                {
                    delete _liveO2MQueue[roomKey];
                } else {
                    delete myRoom[userguid];
                    _liveO2MQueue[roomKey] = myRoom;
                }
            }

            // 断开我链接上的直播室
            let exist_keys = [] ;
            for (let key in _liveO2MQueue)
            {
                let item = _liveO2MQueue[key];
                if (item[userguid]) {
                    let count = 0;
                    for (let t in item)
                    {
                        count++;
                        if (count > 1)
                        {
                            break;
                        }
                    }
                    if (count <=1 )
                    {
                        exist_keys.push(key);
                    }
                }
            }
            exist_keys.forEach(key=>{
                let item = _liveO2MQueue[key];
                delete item[userguid];
            });
        });

        LogDebug("some thing come in ...");
    });

    LogDebug("WebSocket listening at " + options.port);

    let _sendClient = (client, json, cb) =>
    {
        if (client.readyState == WebSocket.OPEN)
        {
            client.send(JSON.stringify(json), null, ()=>(cb&&cb(1, "success")));
        }
        else
        {
            cb && cb(0, "对方不在线");
        }
    }

    let remoteAllClose = (eventName, o2o, to, from, compare, cb) => {
        if (o2o.length > 0)
        {
            if (o2o == to)
            {
                for (let client of wss.clients)
                {
                    if (client.userinfo.userguid == compare)
                    {

                        _sendClient(client, { event:eventName }, (...args)=>{
                            delete _communicationO2OQueue[from];
                            cb && cb(...args);
                        });
                        return;
                    }
                }
            } else {
                cb && cb(0, "参数异常");
            }
        } else {
            cb && cb(1, "success");
        }
    };

    return {
        server: wss,
        broadcast: (fromRowgud = "", json, cb) => {
            if (fromRowgud.length > 0) {
                wss.clients.forEach((client) => {
                    if (client.userinfo.userguid == fromRowgud) {
                        return;
                    }
                    _sendClient(client, json, cb);
                });
            } else {
                wss.clients.forEach(client => _sendClient(client, json, cb));
            }
        },
        callToRowguid:(toRowguid, json, cb) => {

            for (let key in _communicationO2OQueue)
            {
                let val = _communicationO2OQueue[key];
                if ((key == toRowguid) || (val == toRowguid))
                {
                    cb && cb(0, "对方正在通话中...");
                    return;
                }
            }


            for (let client of wss.clients)
            {
                if (client.userinfo.userguid == toRowguid)
                {

                    _sendClient(client, json, (...args)=>{
                        let fromUguid = json["data"]["rowguid"];
                        _communicationO2OQueue[fromUguid] = toRowguid;
                        cb && cb(...args);
                    });
                    return;
                }
            }
            cb && cb(0, "对方不在线");
        },
        closeFromGuid:(fromUid, toUid, cb) => {
            let o2o = _communicationO2OQueue[fromUid] || "";
            remoteAllClose("remote-close", o2o, toUid, fromUid, toUid, cb);
        },

        refuseFromGuid:(from, to, cb) => {
            let o2o = _communicationO2OQueue[from] || "";
            remoteAllClose("remote-refuse", o2o, to, from, from, cb);
        },
        acceptFromGuid:(from, to, cb) => {
            let o2o = _communicationO2OQueue[from] || "";
            remoteAllClose("remote-accept", o2o, to, from, from, cb);
        },

        openLiveWithGuid:(rowguid, cb) => {
            let roomguid = `room_${rowguid}`;
            let item = _liveO2MQueue[roomguid];
            console.log(item);
            if (item)
            {
                let owner = item[rowguid];
                if (owner && (owner.master == true))
                {
                    cb(0, "直播中...");
                } else {
                    item[rowguid] = {
                        master:true
                    };
                    _liveO2MQueue[roomguid] = item;
                    cb(1, "房间存在，但主持人不在");
                }
            }
            else
            {
                _liveO2MQueue[roomguid] = {};
                _liveO2MQueue[roomguid][rowguid] =  {
                    master:true
                };
                cb(1, "success");
            }
        },
        leaveLiveWithGuid:(rowguid,cb) => {
            let roomguid = `room_${rowguid}`;
            let item = _liveO2MQueue[roomguid];
            console.log(item);
            if (item)
            {
                let count = 0;
                for (let key in item)
                {
                    count++;
                    if (count > 1)
                    {
                        break;
                    }
                }
                if (count <= 1)
                {
                    delete _liveO2MQueue[roomguid];
                } else {
                    delete item[rowguid];
                    _liveO2MQueue[roomguid] = item;
                }
            }

            cb(1, 'success');
        },
        joinliveWithGuid:(liver, myguid, cb) => {
            let roomguid = `room_${liver}`;
            let room = _liveO2MQueue[roomguid];
            if (room == null)
            {
                room = {};
            }

            room[myguid] = {master:false};

            _liveO2MQueue[roomguid] = room;
            cb(1, "success");
        },
        leaveliveWithGuid:(liver, myguid, cb) => {
            let roomguid = `room_${liver}`;
            let room = _liveO2MQueue[roomguid];
            if (room != null)
            {
                if (room[myguid]) {
                    delete room[myguid];
                    _liveO2MQueue[roomguid] = room;
                }
            }

            cb(1, "success");
        },

        lessonMessageWithGuid:(liver, myguid, message, cb) => {
            let roomguid = `room_${liver}`;
            let room = _liveO2MQueue[roomguid] || {};
            console.log(room);
            for (let key in room)
            {
                if (key != myguid)
                {
                    for (let c of wss.clients)
                    {
                        if (c.userinfo.userguid == key) {
                            _sendClient(c, {
                                event:"lesson-message",
                                data:{
                                    message:message,
                                }
                            });
                            break;
                        }
                    }
                }
            }
            cb(1, "success");
        }
    };
};

module.exports = WSS;