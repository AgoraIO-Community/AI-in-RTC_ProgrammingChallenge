const sso = require("../../sso");
const Util = require("../../Util");
const SqliteHelper = require("../../SqliteHelper");

exports.token = async (ctx, ResultFulCallback) => {

    let body = ctx.request.body || {};
    let loginid = body.loginid || "";
    let password = body.password || "";
    if ((loginid.length <= 0) || (password.length <= 0)) {
        ctx.body = ResultFulCallback(0, "账户名或者密码错误", null);
        return;
    }

    let userinfo = await SqliteHelper.selectSync("account", null, {"where": {"loginid": loginid}});
    if (userinfo == null) {
        ctx.body = ResultFulCallback(0, "账户名或者密码错误", null);
        return;
    }

    let cPwd = userinfo.password;
    if (Util.AuthPassword(password) != cPwd) {
        ctx.body = ResultFulCallback(0, "账户名或者密码错误", null);
        return;
    }

    // 生成token
    let token = await sso.sso_generator_token(userinfo);
    ctx.body = ResultFulCallback(1, "success", token);
};


exports.refreshToken = async (ctx, ResultFulCallback) => {
    let body = ctx.request.body || {};
    let refreshToken = body.refreshToken || "";
    if (refreshToken.length <= 0) {
        ctx.body = ResultFulCallback(0, "缺少 refreshToken 参数", null);
        return;
    }

    let refreshTokenInfo = await SqliteHelper.selectSync("access_token", null, {"refreshtoken": refreshToken});
    if (refreshTokenInfo == null) {
        // 说明refreshtoken已经过期
        ctx.body = ResultFulCallback(401, "refreshToken error", null);
        return;
    }

    let now = new Date().getTime();
    if (refreshTokenInfo.refreshexpires < now) {
        // 说明refreshtoken已经过期
        ctx.body = ResultFulCallback(401, "refreshToken has been expired", null);
        return;
    }


    // 生成token
    let token = await sso.sso_generator_token({
        rowguid: JSON.parse(refreshTokenInfo.data).userguid
    });
    ctx.body = ResultFulCallback(1, "success", token);
};

exports.checkuser = (ctx, ResultFulCallback) => {

    ctx.body = ResultFulCallback(1, "success", null);
};