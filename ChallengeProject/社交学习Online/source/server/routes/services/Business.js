const Util = require("../../Util");
const SqliteHelper = require("../../SqliteHelper");
const SSO = require("../../sso");

let getUserInfoBySqliteHelper = async (userguid) => {
    // 查找用户信息
    let user = await SqliteHelper.selectSync("account", null, {
        "rowguid":userguid
    });

    if (user == null)
    {
        return ;
    }

    // 查找对应标签
    let labels = await SqliteHelper.selectSync("account_label", null, {
        userguid:userguid
    }) || [];

    // 查找对应的粉丝，关注
    let fans = await SqliteHelper.countSync("account_related", "userguid", {
        "relateguid":userguid
    });

    let relates = await SqliteHelper.countSync("account_related", "relateguid", {
        "userguid":userguid
    });


    if ((labels instanceof Array) == false)
    {
        labels = [labels];
    }

    user.labels = labels;
    user.totalFans = fans.total_userguid;
    user.totalRelates = relates.total_relateguid;

    return  user;
};

exports.getUserInfo = async (ctx, ResultFulCallback) => {


    let header = ctx.request.header;

    // 获取请求头中的token
    let AuthorizationToken = header["authorization"] || "";
    AuthorizationToken = AuthorizationToken.replace(new RegExp("Bearer", "g"), "").trim();
    let tokenInfo = await SSO.sso_get_token(AuthorizationToken);
    let userguid  = JSON.parse(tokenInfo.data).userguid;

    let user = await getUserInfoBySqliteHelper(userguid);

    if (user == null)
    {
        ctx.body = ResultFulCallback(0, "用户信息获取失败", null);
        return ;
    }

    ctx.body = ResultFulCallback(1, "success", user);

};

exports.userinfo = async (ctx, ResultFulCallback) => {

    let body = ctx.request.body || {};
    let rowguid = body.rowguid || "";
    if (rowguid.length <= 0)
    {
        ctx.body = ResultFulCallback(0, "参数不正确", null);
        return ;
    }

    let user = await getUserInfoBySqliteHelper(rowguid);

    if (user == null)
    {
        ctx.body = ResultFulCallback(0, "用户信息获取失败", null);
        return ;
    }

    ctx.body = ResultFulCallback(1, "success", user);
};

exports.edituserinfo = async (ctx, ResultFulCallback) => {
    let body = ctx.request.body || {};
    let rowguid = body.rowguid || "";
    let key = body.key || "";
    let value = body.value || "";
    if ((rowguid.length <= 0) || (key.length <= 0) || (value.length <= 0))
    {
        ctx.body = ResultFulCallback(0, "incorret parameters", null);
        return ;
    }
    let updateModel = {};
    updateModel[key] = value;
    await SqliteHelper.updateModelSync("account", updateModel, { "rowguid":rowguid });
    ctx.body = ResultFulCallback(1, "success");
};

exports.initUserInfo = async (ctx, ResultFulCallback) => {
    let body = ctx.request.query || {};
    // 默认密码
    let pwd = Util.AuthPassword("11111");
    let loginid = body.loginid;

    // 创建用户
    // let user = await SqliteHelper.insertModelSync("account" , {
    //     nickname:"viper"+new Date().getTime(),
    //     loginid:loginid,
    //     password:pwd,
    // });

    // 创建用户
    let user = await SqliteHelper.transitionBuildTask("insertModelSync", "account",  {
        nickname:"viper"+new Date().getTime(),
        loginid:loginid,
        password:pwd,
    });

    let rowguid = user.custom.rowguid;


    await SqliteHelper.transitionTaskSync([
        user,
        await SqliteHelper.transitionBuildTask("insertModelSync", "account_label", {
            userguid:rowguid,
            name:"初学者"
        })
    ]);

    ctx.body = ResultFulCallback(1, 'success', user);
};

exports.ranklist = async (ctx, ResultFulCallback) => {


    let datalist = await SqliteHelper.selectSync("account", ["rowguid", "nickname"]);

    ctx.body = ResultFulCallback(1, null, {
        data:datalist || []
    }) ;
};