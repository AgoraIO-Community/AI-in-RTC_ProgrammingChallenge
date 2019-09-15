
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
        // 消息发送者
        {
            name: "gmessageguid",
            type: "VARCHAR(256)",
        },
        // 附属内容
        {
            name: "value",
            type: "VARCHAR(256)"
        },
        // 消息类型 0 图文消息，1 视频文字消息，默认为 0
        {
            name: "type",
            type: "INTEGER",
            defaultValue:0,
        }
    ]

};