
const UUID = require("../Util").UUID;

module.exports = {

    columns:[
        {
            name: "rowguid",
            type: "VARCHAR(256)",
            attr: "Not Null Unique",
            fn: UUID
        },
        // 课程标题
        {
            name: "title",
            type: "VARCHAR(256)",
        },
        // 课程类型
        {
            name: "type",
            type: "VARCHAR(256)",
        },
    ]

};