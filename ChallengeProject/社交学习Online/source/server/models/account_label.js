const UUID = require("../Util").UUID;


module.exports = {

    columns:[
        // 用户标记识别
        {
            name: "rowguid",
            type: "VARCHAR(256)",
            attr: "Not Null Unique",
            fn: UUID
        },
        // 用户guid
        {
            name: "userguid",
            type: "VARCHAR(256)",
            attr: "Not Null",
        },
        // 标签等级   0 灰色 1 蓝色 2 绿色 3 红色 4 金色
        {
            name: "level",
            type: "INTEGER",
            defaultValue: 0,
        },
        // 标签名称
        {
            name: "name",
            type:"VARCHAR(256)"
        }
    ]

};