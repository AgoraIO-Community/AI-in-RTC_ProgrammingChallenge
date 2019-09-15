
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
        // 匿名名称
        {
            name: "nickname",
            type: "VARCHAR(256)",
        },
        // 邮箱
        {
            name:"mail",
            type: "VARCHAR(256)",
        },
        // 手机号码
        {
            name:"mobile",
            type: "VARCHAR(256)",
        },
        // 登陆账号
        {
            name:"loginid",
            type: "VARCHAR(256)",
            attr:"NOT NULL UNIQUE"
        },
        // 密码
        {
            name:"password",
            type: "VARCHAR(256)",
        },
        // 头像地址
        {
            name:"photourl",
            type: "VARCHAR(256)",
        },
        // 身份角色 0 学生 1 老师
        {
            name:"role",
            type:"INTEGER",
            defaultValue:0,
        }
    ]

};