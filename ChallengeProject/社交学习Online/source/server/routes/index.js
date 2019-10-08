const fs = require("fs");
const options = [];
const rootName = __dirname+"/config";

(fs.readdirSync(rootName) || []).forEach(path => {
    let c = require(rootName+"/"+path);
    c.forEach(i => options.push(i));
});

module.exports = options;