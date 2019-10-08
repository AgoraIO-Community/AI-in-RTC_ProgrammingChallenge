# 办公小镇
worktown
## 作品介绍
 办公小镇(worktown) 是一个虚拟办公环境，致力于解决团队远程合作的考勤与沟通问题。
## 环境介绍
* 后端：java / spring boot
* 前端：vue / element UI
* 数据库：mysql
* WebRtc：AgoraRTCSDK（声网）
* 人脸识别：腾讯AI开放平台
## 团队介绍
* acrow 17576297@qq.com
* minove 2368157914@qq.com
* daishuhua 30883669@qq.com
## 调试方法
* 后端代码根目录为项目根目录
* 前端代码根目录为web子目录
* 前后端使用相应IDE（idea，vscode）分别启动调试即可
* 后端默认启动端口为8800、前端默认启动端口为8080
* 安全起见，敏感数据进行了加工处理，调试时需改为自己注册的数据：

###### application.properties 中 worktown.video-server 需要改为声网开发者项目appid

###### TencentApiUtil.java 中 常量需要改为 腾讯开发者项目（需要开放能力：人脸搜索与验证、人脸检测与分析）appid与 appsecret

