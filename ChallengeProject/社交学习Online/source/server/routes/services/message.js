const SqliteHelper = require("../../SqliteHelper");

exports.added = async (ctx, ResultFulCallback) => {

    let body = ctx.request.body || {};
    let userguid = body.userguid || "";
    let files = body.files || [];
    let content = body.content || "";
    let type = body.type || 0;
    if ((userguid.length <= 0) || ( (files.length <= 0) && (content.length <= 0) ))
    {
        ctx.body = ResultFulCallback(0, "缺少参数，无法操作");
        return ;
    }

    let tasks = [];
    let gmessageInsertTask = await SqliteHelper.transitionBuildTask(
        "insertModelSync",
        "gmessage",
        {
        userguid:userguid,
        content:content,
        type:type
    });
    tasks.push(gmessageInsertTask);

    let gmessageguid = gmessageInsertTask.custom.rowguid;
    for (let file of files)
    {
        let gmessageSubInsertTask = await  SqliteHelper.transitionBuildTask(
            "insertModelSync",
            "gmessage_subs",
            {
                gmessageguid:gmessageguid,
                value:file,
                type:type
            }
        );
        tasks.push(gmessageSubInsertTask);
    }


    await SqliteHelper.transitionTaskSync(tasks);

    // 创建成功
    ctx.body = ResultFulCallback(1, "success", null);

};


exports.get = async (ctx, ResultFulCallback) => {
    let body = ctx.request.body || {};
    let page = body.page || 1;
    let pageSize = 10;

    let lists = (await SqliteHelper.selectSync(
        "gmessage",
        null,
        null,
        {
            model:"account",
            "$on":{
                "userguid":"rowguid"
            }
        },
        {
            limit:[ (page - 1) * pageSize, pageSize ],
            orderby:{
                "desc":"createdAt"
            }
        },
    ) || []);

    // 转换为数组
    if ((lists instanceof Array) == false)
    {
        lists = [lists];
    }

    // 查询信息的子信息
    let whereIn = [];
    let userguids = [];
    for (let item of lists)
    {
        whereIn.push(item.rowguid);
        userguids.push(item.userguid);
    }
    let subs = (await SqliteHelper.selectSync("gmessage_subs", null, {
        "gmessageguid":{
            "$in":whereIn
        }
    }) || []);
    // 转换为数组
    if ((subs instanceof Array) == false)
    {
        subs = [subs];
    }

    // 查找对应标签
    let labels = await SqliteHelper.selectSync("account_label", null, {
        userguid:{
            "$in":userguids
        }
    }) || [];
    // 转换为数组
    if ((labels instanceof Array) == false)
    {
        labels = [labels];
    }



    // 转换消息为子数组
    for (let parent of lists)
    {
        if (parent.gmessagesubs == null)
        {
            parent.gmessagesubs = [];
        }

        if (parent["climbing_account.labels"] == null)
        {
            parent["climbing_account.labels"] = [];
        }

        for (let sub of subs)
        {
            if (parent.rowguid == sub.gmessageguid)
            {
                parent.gmessagesubs.push(sub);
            }
        }

        for (let sub of labels)
        {
            if (parent.userguid == sub.userguid)
            {
                parent["climbing_account.labels"].push(sub);
            }
        }
    }


    ctx.body = ResultFulCallback(1, "success", {
        list:lists
    });

};


exports.detail = async (ctx, ResultFulCallback) => {
    let body = ctx.request.body || {};
    let rowguid = body.rowguid || "";
    if (rowguid.length <= 0)
    {
        ctx.body = ResultFulCallback(0, "rowguid 参数不对", null);
        return;
    }

    let message = (await SqliteHelper.selectSync(
        "gmessage",
        null,
        {
            rowguid:rowguid
        },
        {
            model:"account",
            "$on":{
                "userguid":"rowguid"
            }
        },
    ) || []);

    if (message == null)
    {
        ctx.body = ResultFulCallback(0, "数据未找到", null) ;
        return ;
    }

    let userguid = message["climbing_account.rowguid"];

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

    message["climbing_account.labels"] = labels;
    message["climbing_account.fans"] = fans.total_userguid;
    message["climbing_account.relates"] = relates.total_relateguid;

    let subs = (await SqliteHelper.selectSync("gmessage_subs", null, {
        "gmessageguid":message["rowguid"]
    }) || []);
    // 转换为数组
    if ((subs instanceof Array) == false)
    {
        subs = [subs];
    }
    message["gmessagesubs"] = subs;

    ctx.body = ResultFulCallback(1, null, message);

};