
exports.focusmaps = async (ctx, ResultFulCallback) => {


    ctx.body = ResultFulCallback(1, "success", {
        focuses:[
            {
                main:"https://static.educity.cn/images/cms/2019-07/815/Td9JbVrUht.png",
            },
            {
                main:"https://static.educity.cn/images/cms/2019-02/437/bAh95jmcCc.png",
            },
            {
                main:"https://static.educity.cn/images/cms/2019-02/235/42t6LPfsvI.png",
            }
        ],
    })
};


exports.courses = async (ctx, ResultFulCallback) => {


    ctx.body = ResultFulCallback(1, "success", {
        page:1,
        total:10,
        data:[
            {
                cover:"https://static.educity.cn/images/cms/2019-05/616/4MdAdRW7fI.png",
                title:"2020初级会计职称零基础通关方案",
                content:"天津2019年高级会计师资格评审申报方式考高级会计师需要考外语吗？",
                createdAt:new Date("2019-5-22 12:12:12").getTime(),
                distributeAt:new Date("2019-5-22 12:12:12").getTime(),
            },
            {
                cover:"https://static.educity.cn/images/cms/2019-05/553/EfYtg4VXFB.png",
                title:"2019一级建造师网络直播班级",
                content:"天津2019年高级会计师资格评审申报方式考高级会计师需要考外语吗？",
                createdAt:new Date("2019-5-22 12:12:12").getTime(),
                distributeAt:new Date("2019-5-22 12:12:12").getTime(),
            }
        ],

    });
};