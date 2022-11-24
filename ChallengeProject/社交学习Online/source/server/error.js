const Logkit = require("./logkit");
const Util = require("./Util");

const ErrorHandler = async (error) => {
    // 服务器发生错误了
    Logkit.w(error.message);
};

const JSONError = (e) => Util.HTTPRestFul(0, e.message||"发生错误了", null);

const HTMLError = (e) => Util.HTTPRestFul(0, e.message||"发生错误了", null);

const TEXTError = (e) => e.code+":发生错误了，请联系管理员";

const ErrorObjHandler = {
    JSONError,
    HTMLError,
    TEXTError
};

module.exports = {
    ErrorHandler,
    ErrorObjHandler
};