const SqliteHelper = require("../../SqliteHelper");
const SSO = require("../../sso");

exports.lives = async (ctx, ResultFulCallback)=>{


    // 查找对应标签
    let lives = await SqliteHelper.selectSync("account", null, null) || [];


    ctx.body = ResultFulCallback(1, null, {
        data:lives
    });
};

exports.sendmessage = async (ctx, ResultFulCallback, wss) => {


    let body = ctx.request.body || {};
    let liverguid = body.liverguid || "";
    let message = body.message || "";
    if (liverguid.length <= 0 || message.length <= 0) {
        ctx.body = ResultFulCallback(0, "参数异常", null);
        return;
    }

    // 查找用户信息
    let header = ctx.request.header;
    let AuthorizationToken = header["authorization"] || "";
    AuthorizationToken = AuthorizationToken.replace(new RegExp("Bearer", "g"), "").trim();
    let tokenInfo = await SSO.sso_get_token(AuthorizationToken);
    let rowguid = JSON.parse(tokenInfo.data).userguid;

    await new Promise(function (resolve) {
        wss.lessonMessageWithGuid(liverguid, rowguid, message, (code, msg)=>{
            ctx.body = ResultFulCallback(code, msg);
            resolve();
        });
    })
};