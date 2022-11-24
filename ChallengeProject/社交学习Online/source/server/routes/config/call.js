module.exports = [

    // 发起电话
    { "path":"/rest/request_call_to", "service":"call.callTo", "method":"post" },
    // 关断电话
    { "path":"/rest/request_close_to", "service":"call.closeTo", "method":"post" },
    // 拒绝电话
    { "path":"/rest/request_refuse_to", "service":"call.refuseTo", "method":"post" },
    // 接受电话
    { "path":"/rest/request_accept_to", "service":"call.acceptTo", "method":"post" },


    // 开启直播会话
    { "path":"/rest/request_openlive", "service":"call.openlive", "method":"post" },
    // 主播离开直播室
    { "path":"/rest/leave_openlive", "service":"call.leaveopenlive", "method":"post" },
    // 路人加入主播室
    { "path":"/rest/request_joinopenlive", "service":"call.joinopenlive", "method":"post" },
    // 路人离开主播室
    { "path":"/rest/request_leaveopenlive", "service":"call.requestleaveopenlive", "method":"post" },


];