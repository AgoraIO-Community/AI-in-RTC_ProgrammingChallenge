const SqliteHelper = require("../../SqliteHelper");
const SSO = require("../../sso");

exports.callTo = async (ctx, ResultFulCallback, wss) => {

    let body = ctx.request.body || {};
    let to = body.to || "";
    if (to.length <= 0) {
        ctx.body = ResultFulCallback(0, "参数异常", null);
        return;
    }

    // 查找用户信息
    let header = ctx.request.header;
    let AuthorizationToken = header["authorization"] || "";
    AuthorizationToken = AuthorizationToken.replace(new RegExp("Bearer", "g"), "").trim();
    let tokenInfo = await SSO.sso_get_token(AuthorizationToken);
    let userguid = JSON.parse(tokenInfo.data).userguid;

    if (userguid == to) {
        ctx.body = ResultFulCallback(0, "无法和自己通话", null);
        return;
    }

    let user = await SqliteHelper.selectSync("account", null, {
        "rowguid": userguid
    });


    // 超时处理
    await new Promise(function (resolve) {
        let isRest = false;
        let timeout = setTimeout(() => {
            isRest = true;
            ctx.body = ResultFulCallback(0, "call timeout", null);
            resolve();
        }, 3 * 1000);
        wss.callToRowguid(to, {event: "call", data: user}, (code, error) => {
            if (isRest) return;
            clearTimeout(timeout);
            if (code == 1) {
                ctx.body = ResultFulCallback(1, "success", null);
            } else {
                ctx.body = ResultFulCallback(0, error, null);
            }
            resolve();
        });
    });
};

exports.closeTo = async (ctx, ResultFulCallback, wss) => {

    let body = ctx.request.body || {};
    let to = body.to || "";
    if (to.length <= 0) {
        ctx.body = ResultFulCallback(0, "参数异常", null);
        return;
    }

    // 查找用户信息
    let header = ctx.request.header;
    let AuthorizationToken = header["authorization"] || "";
    AuthorizationToken = AuthorizationToken.replace(new RegExp("Bearer", "g"), "").trim();
    let tokenInfo = await SSO.sso_get_token(AuthorizationToken);
    let userguid = JSON.parse(tokenInfo.data).userguid;

    if (userguid == to) {
        ctx.body = ResultFulCallback(0, "参数错误", null);
        return;
    }


    await new Promise(function (resolve) {
        wss.closeFromGuid(userguid, to, (code, msg) => {
            ctx.body = ResultFulCallback(code, msg);
            resolve();
        })
    });
};

exports.refuseTo = async (ctx, ResultFulCallback, wss) => {

    let body = ctx.request.body || {};
    let formUid = body.from || "";
    if (formUid.length <= 0) {
        ctx.body = ResultFulCallback(0, "参数异常", null);
        return;
    }

    // 查找用户信息
    let header = ctx.request.header;
    let AuthorizationToken = header["authorization"] || "";
    AuthorizationToken = AuthorizationToken.replace(new RegExp("Bearer", "g"), "").trim();
    let tokenInfo = await SSO.sso_get_token(AuthorizationToken);
    let to = JSON.parse(tokenInfo.data).userguid;

    if (formUid == to) {
        ctx.body = ResultFulCallback(0, "参数错误", null);
        return;
    }

    await new Promise(function (resolve) {
        wss.refuseFromGuid(formUid, to, (code, msg) => {
            ctx.body = ResultFulCallback(code, msg);
            resolve();
        })
    });

};

exports.acceptTo = async (ctx, ResultFulCallback, wss) => {

    let body = ctx.request.body || {};
    let formUid = body.from || "";
    if (formUid.length <= 0) {
        ctx.body = ResultFulCallback(0, "参数异常", null);
        return;
    }

    // 查找用户信息
    let header = ctx.request.header;
    let AuthorizationToken = header["authorization"] || "";
    AuthorizationToken = AuthorizationToken.replace(new RegExp("Bearer", "g"), "").trim();
    let tokenInfo = await SSO.sso_get_token(AuthorizationToken);
    let to = JSON.parse(tokenInfo.data).userguid;

    if (formUid == to) {
        ctx.body = ResultFulCallback(0, "参数错误", null);
        return;
    }

    await new Promise(function (resolve) {
        wss.acceptFromGuid(formUid, to, (code, msg) => {
            ctx.body = ResultFulCallback(code, msg);
            resolve();
        })
    });
};

exports.openlive = async (ctx, ResultFulCallback, wss) => {


    // 查找用户信息
    let header = ctx.request.header;
    let AuthorizationToken = header["authorization"] || "";
    AuthorizationToken = AuthorizationToken.replace(new RegExp("Bearer", "g"), "").trim();
    let tokenInfo = await SSO.sso_get_token(AuthorizationToken);
    let rowguid = JSON.parse(tokenInfo.data).userguid;

    await new Promise(function (resolve) {
        wss.openLiveWithGuid(rowguid, (code, msg) => {
            ctx.body = ResultFulCallback(code, msg);
            resolve();
        })
    });
};

exports.leaveopenlive = async (ctx, ResultFulCallback, wss) => {

    // 查找用户信息
    let header = ctx.request.header;
    let AuthorizationToken = header["authorization"] || "";
    AuthorizationToken = AuthorizationToken.replace(new RegExp("Bearer", "g"), "").trim();
    let tokenInfo = await SSO.sso_get_token(AuthorizationToken);
    let rowguid = JSON.parse(tokenInfo.data).userguid;

    await new Promise(function (resolve) {
        wss.leaveLiveWithGuid(rowguid, (code, msg) => {
            ctx.body = ResultFulCallback(code, msg);
            resolve();
        })
    });

};

exports.joinopenlive = async (ctx, ResultFulCallback, wss) => {

    let body = ctx.request.body || {};
    let liverguid = body.liverguid || "";
    if (liverguid.length <= 0) {
        ctx.body = ResultFulCallback(0, "参数异常", null);
        return;
    }

    // 查找用户信息
    let header = ctx.request.header;
    let AuthorizationToken = header["authorization"] || "";
    AuthorizationToken = AuthorizationToken.replace(new RegExp("Bearer", "g"), "").trim();
    let tokenInfo = await SSO.sso_get_token(AuthorizationToken);
    let rowguid = JSON.parse(tokenInfo.data).userguid;

    await new Promise(function (resolve, reject) {
        wss.joinliveWithGuid(liverguid, rowguid, (code, msg)=>{
            ctx.body = ResultFulCallback(code, msg);
            resolve();
        });
    });
};

exports.requestleaveopenlive = async (ctx, ResultFulCallback, wss) => {
    let body = ctx.request.body || {};
    let liverguid = body.liverguid || "";
    if (liverguid.length <= 0) {
        ctx.body = ResultFulCallback(0, "参数异常", null);
        return;
    }

    // 查找用户信息
    let header = ctx.request.header;
    let AuthorizationToken = header["authorization"] || "";
    AuthorizationToken = AuthorizationToken.replace(new RegExp("Bearer", "g"), "").trim();
    let tokenInfo = await SSO.sso_get_token(AuthorizationToken);
    let rowguid = JSON.parse(tokenInfo.data).userguid;

    await new Promise(function (resolve, reject) {
        wss.leaveliveWithGuid(liverguid, rowguid, (code, msg)=>{
            ctx.body = ResultFulCallback(code, msg);
            resolve();
        });
    });
};
