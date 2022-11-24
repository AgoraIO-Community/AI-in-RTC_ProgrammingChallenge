
const UUID = require("../Util").UUID;

module.exports = {

    columns:[
        {
            name: "rowguid",
            type: "VARCHAR(256)",
            attr: "Not Null Unique",
            fn: UUID
        },
        // 类型名称
        {
            name: "title",
            type: "VARCHAR(256)",
        },
    ]

};