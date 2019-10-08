const fs = require("fs");
const Prefix = "[SERVER-ERROR-LOG]";

const w = async (c) => {
    console.log(Prefix, c);
};



module.exports = {
    w
};