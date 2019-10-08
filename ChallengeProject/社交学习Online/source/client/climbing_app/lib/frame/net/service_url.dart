const debug = false;

const serviceUrl = debug ?
'http://192.168.1.106:3206':
'http://122.112.139.219:3206';

const socketUrl = debug ?
'ws://192.168.1.106:3207':
'ws://122.112.139.219:3207/';

const servicePath = {
  'homePageContext': serviceUrl + 'xxx', // 首页信息
  'platform_url': serviceUrl,
  'upload_rest_url':'$serviceUrl/attachRest' // 图片路由信息
};
