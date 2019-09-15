/**
 author：zhudezhen
 created on: 2018/7/15
 description:基础版本安装脚本
 */


var exec = require('child_process').exec;
var spawn = require('child_process').spawn;
var fs = require("fs");


var npmExec = (module,block) => {
    let s  = spawn("npm", ["install", module,  "--save"]);
    s.stdout.on("data", function (data) {
        console.log(data.toString("utf8"));
    });
    s.stdout.on("error", function () {
       console.log("----");
    });
    s.on("close", block);
    // console.log(s.on);
};

var startServer = () => {
    exec("node app",function (err,stdout,stderr) {
        console.log(err,stdout,stderr);
    });
    console.log("start server thanks you!");
}

var npmlists = [
    "keygrip"
    ,"koa"
    ,"xml2js"
    ,"koa-router"
    ,"koa-static"
    ,"koa-body"
    ,"koa-ejs"
    ,"koa-generic-session"
    ,"koa-sqlite3-session"
    ,"koa-bodyparser"
    ,"sqlite3"
    ,"node-uuid"
    ,"ws"
];

var resusionNpm = function(index,block){
    if (index >= npmlists.length) {
        block && block();
        return ;
    }
    npmExec(npmlists[index],function (err,stdout,stderr) {
        console.log(`package : ${index+1}/${npmlists.length}`);
        index++;
        resusionNpm(index, block);
    });
};

var packageJson = __dirname+"/./package.json";
if (!fs.existsSync(packageJson)) {
    fs.writeFileSync(packageJson, "{\n" +
        "  \"name\": \"miniweb\",\n" +
        "  \"version\": \"1.0.0\",\n" +
        "  \"private\": true,\n" +
        "  \"scripts\": {\n" +
        "    \"start\": \"node app\"\n" +
        "  },\n" +
        "  \"dependencies\": {\n" +

        "  },\n" +
        "\"server\": {" +
        "\"port\": \"3206\",\n" +
        "    \"session\": {\n" +
        "      \"key\": \"climbing.sid\",\n" +
        "      \"expired\": 1800\n" +
        "    },\n" +
        "    \"token\":{\n" +
        "        \"expired\":1800\n" +
        "    }," +
        "   \"socket\":{\n" +
        "        \"port\":\"3207\"\n" +
        "    }" +
        "  }\n"+
        "}\n");
}

if (fs.existsSync(__dirname+"/./node_modules")) {
    console.log("ready for server");
    console.log(`+ ${npmlists.length} dependencies installed`);
    // startServer();
} else {
    resusionNpm(0,function () {
        startServer();
    });
}
