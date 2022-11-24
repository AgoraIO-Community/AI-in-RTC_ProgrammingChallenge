// module.exports = async  (ctx, ResultFulCallback) => {
//
//     ctx.body = "13"
// };

const util = require("../../Util");

exports.tab = async (ctx, ResultFulCallback) => {
    // ctx.session.user = {"a":1,"b":util.UUID()};
    console.log(ctx.session);

    ctx.body = ResultFulCallback(1, "13", null);
};