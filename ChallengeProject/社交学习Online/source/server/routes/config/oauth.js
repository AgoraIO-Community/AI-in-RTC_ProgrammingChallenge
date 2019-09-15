module.exports = [

    { "path":"/oauth/token", "service":"SSO.token", "method":"post" },
    { "path":"/oauth/refreshtoken", "service":"SSO.refreshToken", "method":"post" },
    { "path":"/oauth/checkuser", "service":"SSO.checkuser", "method":"post" },

];