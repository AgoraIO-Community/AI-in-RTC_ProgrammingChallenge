
const UUID = require("../Util").UUID;

module.exports = {

    columns:[
        {
            name: "rowguid",
            type: "VARCHAR(256)",
            attr: "Not Null Unique",
            fn: UUID
        },
        // token过期时间
        {
            name: "expires",
            type: "INTEGER",
        },
        // token信息
        {
            name: "data",
            type: "VARCHAR(256)",
        },
        // token信息
        {
            name:"token",
            type:"VARCHAR(256)"
        },
        // refreshtoken信息
        {
            name:"refreshtoken",
            type:"VARCHAR(256)"
        },
        // refreshexpires过期时间
        {
            name:"refreshexpires",
            type:"INTEGER"
        }
    ]

};