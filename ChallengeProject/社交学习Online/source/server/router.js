const router = require('koa-router')();  /*引入是实例化路由** 推荐*/
const config = require("./routes");
const Util = require("./Util");
const SSO = require("./sso");
const fs = require("fs");

const registerCustomRoute = () => {

    router.get("/attachRest/rmps/upload_*", async (ctx) => {

        let path = ctx.request.url;
        path = path.replace(new RegExp("/attachRest","g"), "");

        ctx.body = fs.readFileSync(__dirname+path);
    });

};

const initialRouter = (WebSocket) => {

    let registerRouter = (item) => {

        let method = item.method || "get";
        let path = item.path || "";
        if (path.length > 0)
        {
            let service = item.service || "";
            if (service.length > 0)
            {

                let s = service.split(".");
                let fn ;
                if (s.length > 1)
                {
                    let m = s[0];
                    let f = s[1];

                    fn = require(__dirname+"/./routes/services/"+m)[f];
                } else {
                    fn = require(__dirname+"/./routes/services/"+s);
                }

                router[method](path, async (ctx, next) => {

                    console.log(`[Rest-URL] ${ctx.request.method} ${ctx.request.url}`);

                    // 测试接口跨域
                    ctx.set("Access-Control-Allow-Origin", "*");
                    await next();

                }, SSO.sso_validate_path(path), async (ctx) => {

                    // 跨域白名单
                    await fn(ctx, Util.HTTPRestFul, WebSocket);
                });

            }
        }
    };

    config.forEach(item => registerRouter(item));

    registerCustomRoute();

    return router.routes();
};


module.exports = initialRouter;
