/**
 author：zhudezhen
 created on: 2019/02/24
 description: SQLite数据核心业务组件
 */

const fs = require("fs");
const sqlite3 = require('sqlite3').verbose();
const DBName = "climbing.db";
const DBDir = __dirname + "/tmps";
const LogPerfix = "Sqlite";
const OSuffix = "climbing_";
const isDEBUG  = false;

let DBLog = (content) => {
    isDEBUG && console.log("[" + LogPerfix + "]", content);
};

// 创建数据库文件
let cDataBaseDir = () => {
    if (!fs.existsSync(DBDir)) {
        fs.mkdirSync(DBDir)
    }
    DBLog("dbfile directory success!!!");
};

// 创建数据库表
let cDataTable = async (fdb) => {
    DBLog("--------BEGIN CREATE Table");
    try {
        // 建立所有表
        let subModelDir = "models";
        if (fs.existsSync(__dirname + "/" + subModelDir) == false) {
            DBLog("models directory does not exist!");
            return;
        }

        let subModels = fs.readdirSync(__dirname + "/" + subModelDir);
        for (let fileName of subModels) {
            let obj = require(`${__dirname}/${subModelDir}/${fileName}`);
            let tableName = fileName.substr(0, fileName.length - ".js".length);
            let columns = obj.columns || [];
            // 如果未设置表名和列属性，则不进行初始化操作
            if ((tableName.length <= 0) ||
                (columns.length <= 0)) {
                continue;
            }
            // 创建列结构
            let createSql = 'CREATE TABLE IF NOT EXISTS `' + OSuffix + tableName + '` (';
            // 设置主键，自增id
            createSql += "`id`  INTEGER  Primary Key AUTOINCREMENT, ";
            for (let columnObj of columns) {
                let name = columnObj.name || "";
                let type = columnObj.type || "";
                let attr = columnObj.attr || "";
                // 名字或者类型没有定义，就不创建
                if ((name.length <= 0) ||
                    (type.length <= 0)) {
                    continue;
                }
                createSql += '`' + name + '` ' + type + " " + attr + ", ";
            }
            // 增加最后修改时间和数据添加时间
            createSql += "`createdAt`  DATE  Not NULL, ";
            createSql += "`updatedAt`  DATE  Not NULL ";
            // 如果列结构没有创建则不创建该表
            // if (createSql.substr(createSql.length - 1, 1) == '(') {
            //     continue;
            // } else {
            //     // 移除末尾的 ","
            //     createSql = createSql.substr(0, createSql.length - 2);
            // }
            createSql += ')';
            fdb.run(createSql);


            // 对数据库表结构字段自动升级
            let cols = await new Promise(function (resolve) {
                fdb.all(`PRAGMA table_info(${OSuffix + tableName})`, function (err, rows) {
                    resolve(rows);
                });
            });

            if (cols.length > 0) {
                for (let ouc of columns) {
                    let hased = false;
                    for (let inc of cols) {
                        if (inc.name == ouc.name) {
                            hased = true;
                            break;
                        }
                    }
                    if (hased == false) {

                        let name = ouc.name || "";
                        let type = ouc.type || "";
                        let attr = ouc.attr || "";
                        let alterSql = `ALTER TABLE ${OSuffix + tableName} ADD ${name} ${type} ${attr}`;
                        fdb.run(alterSql);
                    }
                }
            }

            DBLog(createSql);
        }
    } catch (e) {
        DBLog(e.message);
    } finally {
        // 首次创建完成数据库记得关闭数据库，释放资源
        fdb.close();
        DBLog("DataBase has been closed");
        DBLog("--------END CREATE Table");
    }
};

/**
 * 业务组件初始化代码
 * */
let initializate = () => {
    // - 创建数据库文件核心目录
    cDataBaseDir();
    // - 数据库初始化建表操作
    let fdb = new sqlite3.Database(`${DBDir}/${DBName}`);
    fdb.serialize(function () {
        cDataTable(fdb);
    });
};

// 派生数据库对象, 方法派生
function _dispatch_db(block) {
    let fdb = new sqlite3.Database(`${DBDir}/${DBName}`);
    fdb.serialize(function () {
        try {
            block && block(fdb);
        } catch (e) {
            DBLog(e.message);
        } finally {
            fdb.close();
        }
    });
}

// 统一方法派生
function _dispatch_fn(block) {
    return function (config, isTransition) {
        let info = block(config);
        let sql = info.sql;
        let params = config.params || (info.params || []);

        // 输入sql语句
        DBLog(sql);


        // 设置回调方法
        let callback = config.callback || function (err, row) {
            if (err) {
                DBLog(err.toString());
            } else {
                DBLog("operation completed");
            }
        };


        if (isTransition)
        {
            callback(null,  {
                sql,
                params,
                custom:info.custom
            });
            return;
        }

        // 判断如何使用方法
        let fn;
        if (sql.toUpperCase().indexOf("SELECT") >= 0) {
            fn = 'all';
        } else {
            fn = 'run';
        }
        // 执行方法
        _dispatch_db(function (db) {
            // console.log(params);
            // console.log(fn);
            // console.log(sql);
            if (params.length > 0) {
                db[fn](sql, params, function (err, row) {
                    row = row || [];
                    if (row.length == 1)
                    {
                        row = row[0];
                    }
                    else if (row.length <= 0)
                    {
                        row = info.custom;
                    }
                    // console.log(err, row);
                    callback && callback(err, row);
                });
            } else {
                db[fn](sql, function (err, row) {
                    row = row || [];
                    if (row.length == 1)
                    {
                        row = row[0];
                    }
                    else if (row.length <= 0)
                    {
                        row = info.custom;
                    }
                    callback && callback(err, row);
                });
            }
        });

    }
}

let SyncDispatchFn = (block, ...args)=>{
    let isTransition = args.pop();
    return new Promise(function (resolve, reject) {
        block(...args, function (err, obj) {
            DBLog(err, obj);
            if (err)
            {
                DBLog(err);
                resolve();
            }
            else
            {
                resolve(obj);
            }
        }, isTransition)
    });
};


/** ----------- 业务方法 ------------- */
// 批量创建服务
let batchcreate = _dispatch_fn((config) => {
    let datalist = config.datalist || [];
    let modelName = config.model || "";
    if (modelName.length <= 0) {
        return `config.model is not defined!`;
    }
    if (datalist.length <= 0) {
        return `config has no datalist!`;
    }
    let m = require(`./models/${modelName}`);
    if (m == null) {
        return `table ${modelName} is not existed`;
    }
    let batchInserSql = `${config.orReplaced ? "REPLACE" : "INSERT"} INTO  ` + OSuffix + `${modelName} (`;
    let customFnHash = {};
    for (let col of m.columns) {
        batchInserSql += '`' + col.name + '`, ';
        if (col.fn) {
            customFnHash[col.name] = col.fn;
        }
    }
    batchInserSql += '`createdAt`, ';
    batchInserSql += '`updatedAt`';
    batchInserSql += `) VALUES `;

    let itemInfoList = [];
    for (let item of datalist) {
        let itemInfo = {};
        batchInserSql += "(";
        for (let col of m.columns) {
            let val;
            if (col.fn) {
                val = item[col.name];
                if (!val) {
                    val = col.fn() || "";
                }
            } else {
                val = item[col.name];
            }

            if (val == null) {
                if (typeof col.defaultValue != 'undefined') {
                    val = col.defaultValue;
                }
            }
            itemInfo[col.name] = val;
            batchInserSql += (val ? `'` + val + `', ` : ((typeof col.defaultValue != 'undefined') ? col.defaultValue : 'NULL') + ', ');
        }
        batchInserSql += ("" + ((item.createdAt || new Date().getTime())) + ", ");
        batchInserSql += ("" + (new Date().getTime()) + "");
        batchInserSql += "), ";
        itemInfoList.push(itemInfo);
    }
    batchInserSql = batchInserSql.substr(0, batchInserSql.length - 2);

    return {
        custom: (itemInfoList.length == 1) ? itemInfoList[0]:itemInfoList,
        sql: batchInserSql
    }
});

// 批量插入操作
let batchInsert = (modelName, datalist, callback, isTransition) => {
    batchcreate({model: modelName, datalist: datalist, callback}, isTransition);
};

// 同步批量插入操作
let batchInsertSync = (modelName, datalist, isTransition) => {
    return SyncDispatchFn(batchInsert, modelName, datalist, isTransition);
};

// 插入单挑数据
let insertModel = (modelName, config, callback, isTransition) => {
    batchcreate({model: modelName, datalist: [config], callback}, isTransition);
};

// 同步插入数据
let insertModelSync = (modelName, userinfo, isTransition) => {
    return SyncDispatchFn(insertModel, modelName, userinfo, isTransition);
};

// 批量主键方法查询并且替换
let batchReplaceOrInsert = (modelName, datalist, callback, isTransition) => {
    batchcreate({ model:modelName, datalist:datalist, callback, orReplaced:true }, isTransition);
};

// 同步操作
let batchReplaceOrInsertSync = (modelName, datalist, isTransition) => {
    return SyncDispatchFn(batchReplaceOrInsert, modelName, datalist, isTransition);
};

let replaceOrInsert = (modelName, config, callback, isTransition) => {
    batchcreate({ model:modelName, datalist:[config], callback, orReplaced:true }, isTransition);
};

let replaceOrInsertSync = (modelName, config, isTransition) => {
    return SyncDispatchFn(replaceOrInsert, modelName, config, isTransition);
};

// 移除表中所有的数据
let removeall = _dispatch_fn((config) => {
    let modelName = config.model || "";
    if (modelName.length <= 0) {
        return `config.model is not defined!`;
    }
    let removeSql = `DELETE FROM ${OSuffix}${modelName}`;
    return {
        sql:removeSql
    };
});

let deleteAll = (modelName, callback, isTransition) => {
    removeall({ model:modelName, callback:callback }, isTransition);
};

let deleteAllSync = (modelName, isTransition) => {
    return SyncDispatchFn(deleteAll, modelName, isTransition);
};

// 获取条件语句支持 = 和 in
let whereSqlEqualAndIn = (where) => {
    let whereSql = "";
    let params ;
    for (let key in where)
    {
        if (!params) {
            params = []
        }

        let objc = where[key];
        if ((typeof objc == 'object') && objc.length > 0) {
            // 说明是数组
            let kks = "";
            for (let item of objc) {
                kks += "?,";
                params.push(item);
            }
            kks = kks.substr(0, kks.length - 1);
            whereSql += ` ${key} IN (${kks}) AND`;
        } else {
            whereSql += ` ${key} = ? AND`;
            params.push(objc);
        }
        whereSql = whereSql.substr(0, whereSql.length - 3);
    }

    return {
        sql:whereSql,
        params:params
    }
};

// 根据条件删除数据
let remove = _dispatch_fn((config) => {
    let modelName = config.model || "";
    let where = config.where || {};
    if (modelName.length <= 0) {
        return `config.model is not defined!`;
    }
    let removeSql = `DELETE FROM ${OSuffix}${modelName}`;
    let params;

    let whereItem = whereSqlEqualAndIn(where);
    if (whereItem.sql.length > 0)
    {
        if (removeSql.indexOf("WHERE") < 0)
        {
            removeSql += " WHERE ";
        }

        removeSql += whereItem.sql;
        params = whereItem.params;
    }

    return {
        sql:removeSql,
        params:params
    };
});

let deleteOne = (modelName, where, callback, isTransition) => {
    remove({model:modelName, where, callback }, isTransition);
};

let deleteOneSync = (modelName, where, isTransition) => {
    return SyncDispatchFn(deleteOne, modelName, where, isTransition);
};

// 创建查询任务
let runsql = _dispatch_fn((plugin, config) => {
    let sql = config.sql || "";
    let replaces = config.replaces || {};
    if (sql.length <= 0) {
        return `sql not defined!`;
    }

    for (let key in replaces) {
        var str = '{' + key + '}';
        sql = sql.replace(new RegExp(str, 'g'), replaces[key]);
    }

    return sql;
});

/** 实际修改业务数据 */
let updatesModel = _dispatch_fn((config) => {
    let data = config.data || {};
    let where = config.where;
    let model = config.model || "";
    let sql = `UPDATE ${OSuffix}${model} SET `;
    let params = [];
    for (let key in data) {
        sql += " " + key + " = ?,";
        params.push(data[key]);
    }
    sql += " updatedAt = ?";
    params.push(new Date().getTime());

    let whereItem = whereSqlEqualAndIn(where);
    if (whereItem.sql.length > 0)
    {
        if (sql.indexOf("WHERE") < 0)
        {
            sql += " WHERE ";
        }

        sql += whereItem.sql;
        params = params.concat(whereItem.params);
    }

    return {
        sql:sql,
        params:params
    };
});

let updateModel = (modelName, data, where, callback, isTransition) => {
    updatesModel({ model:modelName, data, where, callback }, isTransition);
};

let updateModelSync = (modelName, data, where, isTransition) => {
    return SyncDispatchFn(updateModel, modelName, data, where, isTransition);
};

let queryConditions = (where, parentKey)=>{
    let whereSql = "";
    let params = [];

    for (let key in where )
    {
        let val = where[key];
        switch (key) {
            case "$like":
                whereSql += ` ${parentKey} LIKE '%${val}%' `;
                break;
            case "$=":
                whereSql += ` ${parentKey} = ? `;
                params.push(val);
                break;
            case "$in":
                whereSql += ` ${parentKey} IN (`;
                for (let item of val)
                {
                    whereSql += "?,";
                    params.push(item);
                }
                whereSql = whereSql.substr(0, whereSql.length - 1);
                whereSql += ")";
                break;
            case "$or":
                for (let item of val)
                {
                    if (typeof item == 'object')
                    {
                        let conditions = queryConditions(item);
                        params = params.concat(conditions.params);
                        whereSql += conditions.sql + " OR ";
                    }
                    else
                    {
                        whereSql += ` ${parentKey} = ? OR `;
                        params.push(item);
                    }
                }
                let suffixOR = "OR ";
                if (whereSql.substr(whereSql.length - suffixOR.length, suffixOR.length) == suffixOR)
                {
                    whereSql = whereSql.substr(0, whereSql.length - suffixOR.length);
                }
                break;
            default:
                if (typeof val == 'object')
                {
                    let conditions = queryConditions(val, key);
                    whereSql += conditions.sql;
                    params = params.concat(conditions.params);
                }
                else
                {
                    whereSql += ` ${key} = ? `;
                    params.push(val);
                }

                break;
        }

        whereSql += " AND ";
    }

    let suffixAnd = "AND ";
    if (whereSql.substr(whereSql.length - suffixAnd.length, suffixAnd.length) == suffixAnd)
    {
        whereSql = whereSql.substr(0, whereSql.length - suffixAnd.length);
    }

    return {
        sql : whereSql.trim(),
        params
    };
};

let queryOne = _dispatch_fn(({ model, cols, where, join, end = {} }) => {
    let qSql = " SELECT ";
    let modelName = model;
    // 添加字段
    if (cols)
    {
        for (let col of cols)
        {
            qSql += `${col},`
        }
        qSql = qSql.substr(0,qSql.length - 1);
    }
    else
    {
        qSql += "*";
    }

    // 增加表名字
    let mainTable = `${OSuffix}${modelName}`;
    qSql += ` FROM ${mainTable} `;

    let joinSql;
    if (join)
    {
        let joinModel = join.model;
        let onCondi = join["$on"];
        let subTable = `${OSuffix}${joinModel}`;
        if (joinModel && onCondi)
        {

            let subModelReq = require("./models/"+joinModel);
            let subCols = subModelReq.columns;
            let subSql = "SELECT ";
            for (let sub of subCols)
            {
                subSql += `${sub.name} AS \`${subTable}.${sub.name}\`,`
            }
            subSql = subSql.substr(0, subSql.length - 1);
            subSql += ` FROM ${subTable}`;

            joinSql = ` JOIN (${subSql}) AS B ON `;
            for (let joinK in onCondi)
            {
                let joinV = onCondi[joinK];
                joinSql += ` ${mainTable}.${joinK} == B.\`${subTable}.${joinV}\` AND `;
            }

            let suffixAnd = "AND ";
            if (joinSql.substr(joinSql.length - suffixAnd.length, suffixAnd.length) == suffixAnd)
            {
                joinSql = joinSql.substr(0, joinSql.length - suffixAnd.length);
            }
        }
    }


    let params ;
    let conditionSqlItem = queryConditions(where);
    if (conditionSqlItem.sql.length > 0)
    {
        if ((joinSql||"").trim().length > 0)
        {
            qSql += joinSql;
        }

        let conditionSql = conditionSqlItem.sql;
        // conditionSql = conditionSql.substr(0, conditionSql.length - "AND ".length);
        qSql += ` WHERE ${conditionSql}`;
        params =  conditionSqlItem.params;
    } else {
        if ((joinSql||"").trim().length > 0)
        {
            qSql += joinSql;
        }
    }

    let orderBy = end.orderby || {};
    if (orderBy.asc)
    {
        qSql += ` ORDER BY ${orderBy.asc} ASC`;
    }
    else if (orderBy.desc)
    {
        qSql += ` ORDER BY ${orderBy.desc} DESC`;
    }



    let limit = end.limit || [];
    if (limit.length > 0)
    {
        qSql += ` LIMIT ${limit[0]}`;
        if (limit.length > 1)
        {
            qSql += `, ${limit[1]}`;
        }
    }


    return {
        sql:qSql,
        params
    }
});

let select = (modelName, cols, where, join, end,  callback) => {
    queryOne({
        model:modelName,
        cols,
        where,
        join,
        end,
        callback
    });
};

let selectSync = (modelName, cols, where, join, end = {}, isTransition)=>{
    return SyncDispatchFn(select, modelName, cols, where, join, end, isTransition);
};

let queryCount = _dispatch_fn(({model, col, where}) => {

    let qSql = " SELECT ";
    let modelName = model;
    if (col)
    {
        qSql += "COUNT("+col+") as total_"+col+" ";
    }
    else
    {
        qSql += "COUNT(*) as total ";
    }


    // 增加表名字
    let mainTable = `${OSuffix}${modelName}`;
    qSql += ` FROM ${mainTable} `;

    let params ;
    let conditionSqlItem = queryConditions(where);
    if (conditionSqlItem.sql.length > 0)
    {
        let conditionSql = conditionSqlItem.sql;
        qSql += ` WHERE ${conditionSql}`;
        params =  conditionSqlItem.params;
    }

    return {
        sql:qSql,
        params
    }
});

let count = (modelName, col, where, callback) => {
    queryCount({
        model:modelName,
        col:col,
        where:where,
        callback
    });
};

let countSync = (modelName, col, where, isTransition) => {
    return SyncDispatchFn(count, modelName, col, where, isTransition);
};

// 创建"事务"任务
let transitionTask = (tasks, callback) => {
    if (tasks.length < 0) {
        return "transition task has no operation";
    }


    function begin(db, cb) {
        db.run("BEGIN;", cb);
    }

    function commit(db, cb) {
        db.run("COMMIT;", function (err) {
            if (err) {
                DBLog(err.message);
            } else {
                DBLog(`transition task has been completed`);
            }
            cb && cb(false);
        });
    }

    function rollback(db, cb) {
        db.run("ROLLBACK;", function (err) {
            if (err) {
                DBLog(err.message);
            } else {
                DBLog(`transition task has been rollbacked`);
            }
            cb && cb(true);
        });
    }

    function enumSQLRunner(index, db, cb) {
        if (index >= tasks.length) {
            commit(db, cb);
            return;
        }
        let item = tasks[index];
        if ((item.params || []).length > 0)
        {
            db.run(item.sql, item.params, function (err) {
                if (err) {
                    DBLog(err.message);
                    rollback(db, cb);
                } else {
                    index++;
                    enumSQLRunner(index, db, cb);
                    DBLog(`${item.sql}  ----> complete`);
                }
            });
        } else {
            db.run(item.sql, function (err) {
                if (err) {
                    DBLog(err.message);
                    rollback(db, cb);
                } else {
                    index++;
                    enumSQLRunner(index, db, cb);
                    DBLog(`${item.sql}  ----> complete`);
                }
            });
        }
    }

    let db = new sqlite3.Database(`${DBDir}/${DBName}`);
    db.serialize(function () {
        try {
            begin(db, function () {
                enumSQLRunner(0, db, function (isRollBack) {
                    db.close();
                    callback && callback(isRollBack);
                });
            });
        } catch (e) {
            callback && callback(false, e);
            DBLog(e.message);
        }
    });
};

let transitionTaskSync = (tasks) => {
    return new Promise(function (resolve, reject) {
        transitionTask(tasks, function (isRollBack, err) {
            if (err)
            {
                reject(err);
            }
            else
            {
                resolve(isRollBack);
            }
        })
    })
};

let transitionBuildTask = async (method, ...args) => {
    let weakSelf = module.exports;
    let fn = weakSelf[method];
    return  await fn(...args, true);
};


/**
 * 注册数据库业务服务
 * */
module.exports = {
    initializate,

    // 创建操作
    insertModel,
    insertModelSync,
    batchInsert,
    batchInsertSync,
    replaceOrInsert,
    replaceOrInsertSync,
    batchReplaceOrInsert,
    batchReplaceOrInsertSync,

    // 删除操作
    deleteAll,
    deleteAllSync,
    deleteOne,
    deleteOneSync,

    // 更新操作
    updateModel,
    updateModelSync,

    // 查询操作
    select,
    selectSync,
    count,
    countSync,

    // 事务操作
    transitionTask,
    transitionTaskSync,
    transitionBuildTask,

    // 开放方法：
    runsql,
};

// initializate();
// setTimeout(function () {
//
//     (async () => {
//         let userInfo = {
//             displayname: "LichMerry",
//             nickname: "HelloMerry",
//             mobile: "132413313",
//             mail: "qq.mail.com213444",
//         };
//         // let a = await insertModelSync( "UserInfo", userInfo);
//         // let a = await batchInsertSync("UserInfo", [userInfo]);
//         // let a = await batchReplaceOrInsertSync("UserInfo", [userInfo]);
//
//         // await deleteAllSync("UserInfo");
//         // console.log(a);
//         // await deleteOneSync("UserInfo", { "rowguid": a.rowguid });
//         // console.log(a);
//
//         // let rowguid = "86bd5fba4cf74fe8955e59b17cb13a6e";
//         // // // await updateModelSync("UserInfo", {mail:"123@qq.com"}, { rowguid:rowguid });
//         // let item = await selectSync("UserInfo",
//         //     ["rowguid", "displayname"],
//         //     {
//         //         "rowguid":rowguid,
//         //     });
//         // console.log(item);
//
//         // let course_type = {
//         //     title : "健身"
//         // };
//         //
//         // await deleteOneSync("course_type", { "title":course_type.title });
//         //
//         // course_type = await insertModelSync("course_type", course_type);
//         //
//         // console.log(course_type);
//         //
//         // let course = {
//         //     title:"FITTERGEAR健身卡系列1-5课",
//         //     type:"c0c7d7f4db32405c97f90437e480eb17"
//         // };
//         //
//         // await insertModelSync("course", course);
//
//         // let course_rowguid = "de96583198184cb8a7f190152c798b9d";
//         // let item = await selectSync("course", null, {
//         //     "rowguid":course_rowguid,
//         // }, {
//         //     model:"course_type",
//         //     "$on":{
//         //         "type":"rowguid"
//         //     }
//         // });
//         // console.log(item);
//
//         let item = await transitionTaskSync([
//             await transitionBuildTask("deleteAllSync", "course"),
//             await transitionBuildTask("insertModelSync", "course", { title:"课程1", type:"c0c7d7f4db32405c97f90437e480eb17"  }),
//             await transitionBuildTask("batchInsertSync", "course", [
//                 { title:"课程2", type:"c0c7d7f4db32405c97f90437e480eb17"  },
//                 { title:"课程3", type:"c0c7d7f4db32405c97f90437e480eb17"  }
//             ]),
//             await transitionBuildTask("replaceOrInsertSync", "course", {
//                     title:"课程4",
//                     type:"c0c7d7f4db32405c97f90437e480eb17"
//             }),
//             await transitionBuildTask("batchReplaceOrInsertSync", "course", [
//                 { title:"课程5", type:"c0c7d7f4db32405c97f90437e480eb17"  },
//                 { title:"课程6", type:"c0c7d7f4db32405c97f90437e480eb17"  }
//             ]),
//             await transitionBuildTask("deleteOneSync", "course", {
//                 "title":"课程6"
//             }),
//             await transitionBuildTask("updateModelSync", "course", {
//                 "title":"课程1111"
//             }, {
//                 "title":"课程1"
//             })
//         ]);
//         console.log(item);
//
//     })();
//     // insertModel("UserInfo", {
//     //
//     // }, function (err, data) {
//     //     console.log(err, data);
//     // });
//
// }, 200);

