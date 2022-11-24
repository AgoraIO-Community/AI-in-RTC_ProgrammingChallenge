module.exports = [

    { "path":"/rest/getuserinfo", "service":"Business.getUserInfo", "method":"post" },
    { "path":"/rest/userinfo_detail", "service":"Business.userinfo", "method":"post" },
    { "path":"/rest/edituserinfo", "service":"Business.edituserinfo", "method":"post" },

    { "path":"/rest/inituserinfo", "service":"Business.initUserInfo", "method":"get" },

    { "path":"/rest/ranklist", "service":"Business.ranklist", "method":"post" },




];