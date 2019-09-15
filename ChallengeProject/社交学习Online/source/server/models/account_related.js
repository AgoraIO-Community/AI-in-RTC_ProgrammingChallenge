
module.exports = {

    columns:[
        // 用户的userguid
        {
            name: "userguid",
            type: "VARCHAR(256)",
            attr: "Not Null",
        },
        // 关注的userguid
        {
            name: "relateguid",
            type: "VARCHAR(256)",
            attr: "Not Null",
        }
    ]

};