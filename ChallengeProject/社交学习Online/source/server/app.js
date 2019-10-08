/**
 author：朱德振
 created on: 2018/6/9
 description: web项目入口文件
 */


const Session = require('koa-generic-session');
const SQLite3Store = require('koa-sqlite3-session');
const KeyGrip = require('keygrip');
const bodyParser = require('koa-bodyparser');
const Koa = require('koa');
const Util = require("./Util");
const app = new Koa();
const ServerOptions = require("./package.json").server;
const SQLiteHelper = require("./SqliteHelper");
const fs = require("fs");
const KoaBody = require("koa-body");
const WsSocket = require("./wsserver");


const Error = require("./error");
const initialRouter = require("./router");


let startServer = async (server) => {

    /**
     * 初始化数据库
     * */
    SQLiteHelper.initializate();


    /**
     * 配置文件上传的解析器,并且判断当前是否临时目录没有则创建
     * */
    let _tmp_path = __dirname+"/rmps/";
    if (fs.existsSync(_tmp_path) == false) {
        fs.mkdirSync(_tmp_path);
    }
    app.use(KoaBody({
        multipart: true,
        formidable: {
            maxFileSize: 5*100*1024*1024    // 设置上传文件大小最大限制，默认5M
            , uploadDir:_tmp_path
        },
    }));
    /**
     * 配置中间件body参数解析器
     *
    app.use(bodyParser());
     */

    /**
     * 配置加密密钥
     * */
    app.keys = new KeyGrip(['im a newer secret', 'i like turtle'], 'sha256');

    /**
    * 增加session配置
    * */
    let dbPath = __dirname+"/tmps";
    Util.mkdir(dbPath);
    app.use(Session({
        key: ServerOptions.session.key,
        overwrite: true,
        httpOnly: true,
        signed: true,
        rolling: false,
        renew: false,
        ttl:ServerOptions.session.expired*1000,
        store: new SQLite3Store(dbPath+"/koa-session.db")
    }, app));

    /**
     * 加入日志处理模块
     * */
    server.on('error', Error.ErrorHandler);

    /**
     * 配置请求错误中间件
     * */
    app.use(async (ctx,next)=>{
        try {
            await next();
        } catch (e) {
            // 发生错误处理
            let contentType = (ctx.request.header["content-type"] || "").toLocaleLowerCase();
            ctx.body = Util.HTTPToBody(contentType, {
                json:Error.ErrorObjHandler.JSONError(e),
                text:Error.ErrorObjHandler.TEXTError(e),
                html:Error.ErrorObjHandler.HTMLError(e)
            });
        }
    });


    /**
     * 初始化socket组件
     * */
    let ws = WsSocket({ port:ServerOptions.socket.port });

    // /**
    //  * 加载路由机制
    //  * */
    app.use(initialRouter(ws));


    /**
     * 注册所有组件
     * */
    server.listen(ServerOptions.port, async () => {
        console.log(`Server listening at ${ServerOptions.port}`);
    });

};

// 启动服务器
startServer(app).then();
