

exports.upload = async (ctx, ResultFulCallback) => {
    let files = ctx.request.files || {};
    let resultLs = [];
    for (let key in files)
    {
        let file = files[key];

        let fileArr = file.path.split("rmps/upload_");
        let fileguid = fileArr[fileArr.length - 1];
        resultLs.push(`/rmps/upload_${fileguid}`);
    }

    ctx.body = ResultFulCallback(1, "success", {
        files:resultLs
    });
};