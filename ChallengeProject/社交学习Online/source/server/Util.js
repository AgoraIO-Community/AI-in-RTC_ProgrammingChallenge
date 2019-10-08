const fs = require("fs");
const uuidv4 = require("node-uuid").v4;


const HTTPRestFul = (code, msg, obj) => {
    return {status: {code, msg}, custom: obj};
};

const mkdir = (path) => {
    if (fs.existsSync(path) == false)
    {
        fs.mkdirSync(path);
    }
};

const UUID = ()=>{
    let str = uuidv4();
    return str.replace(new RegExp("-", "g"), "");
};

const HTTPToBody = (contentType, {
    json,
    text,
    html
}) => {
    // 判断SSO中的token是否过期
    switch (contentType) {
        case "application/json":
            return json;
        case "text/plain":
            return text;
        case "text/html":
            return html;
        default :
            return json;
    }
};

const crypto = require('crypto');
const prefix = "climbing:";
const AuthPassword = (pwd) => {
    let md5 = crypto.createHash('md5');
    pwd = `${prefix}${pwd}`;
    return md5.update(pwd).digest('hex');
};

module.exports = {
    HTTPRestFul,
    mkdir,
    UUID,
    HTTPToBody,
    AuthPassword
};