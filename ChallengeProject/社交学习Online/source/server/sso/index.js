const ssolist = require("./sso_anonymous_list");
const Util = require("../Util");
const SqliteHelper = require("../SqliteHelper");
const Options = require("../package.json").server.token;

// 获取token
const sso_get_token = async (token) => {
    return await SqliteHelper.selectSync("access_token", null, {"token":token});
};

// 设置token
const sso_set_token = async (token, data) => {

    let now = new Date().getTime();

    return await SqliteHelper.insertModelSync("access_token", {
        token:token,
        refreshtoken:data.refreshToken,
        data:JSON.stringify(data),
        expires:now + Options.expired*1000,
        // 刷新token的过期时间为正常过期时间3倍
        refreshexpires:now + Options.expired*1000*3,
    });
};

// 生成token
const sso_generator_token = async (userinfo) => {
    let newTokenInfo = {
        token:Util.UUID(),
        expired:Options.expired,
        userguid:userinfo.rowguid,
        refreshToken:Util.UUID(),
    };
    await sso_set_token(newTokenInfo.token, newTokenInfo);
    return newTokenInfo;
};

// 网页回复信息
const sso_http_rest = (ctx, statusCode = 0, message) => {
    let header = ctx.request.header;
    let contentType = (header["content-type"] || "").toLocaleLowerCase();

    ctx.body = Util.HTTPToBody(contentType, {
        json:Util.HTTPRestFul(statusCode, message, null),
        text:message,
        html:"<span>"+message+"</span>"
    });
};


const sso_validate_path = (path) => {

    for (let item of ssolist)
    {
        if (item == path)
        {
            // 白名单中的路径不需要验证SSO
            return async (ctx, next) => await next();
        }
    }

    return async (ctx , next) => {
        let header = ctx.request.header;
        // 获取请求头中的token
        let AuthorizationToken = header["authorization"] || "";
        if (AuthorizationToken.length <= 0)
        {
            sso_http_rest(ctx, 503,"Missing Authorization Token");
            return;
        }
        AuthorizationToken = AuthorizationToken.replace(new RegExp("Bearer", "g"), "").trim();



        // 获取数据库中的token
        let dbTokenInfo = await sso_get_token(AuthorizationToken);
        if (dbTokenInfo == null)
        {
            // 数据库中不存在该token
            sso_http_rest(ctx, 403,"Missing Authorization Token");
            return;
        }

        // 数据库存在token，判断是否过期
        let nowTime = new Date().getTime();
        if ((dbTokenInfo.expires - nowTime) < 0)
        {
            // 说明已过期
            sso_http_rest(ctx, 403,"expired_token");
            return ;
        }


        // 执行下一步请求
        await next();
    };
};

module.exports = {

    sso_validate_path,

    sso_get_token,
    sso_generator_token
};