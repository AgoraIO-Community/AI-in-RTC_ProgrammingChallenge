# 社交学习Online


### 简介

本作品是基于Agora开发的一款在线社交学习应用，应用内部包含，社交圈，1对1视频，直播课程功能。


### 团队

团队名称：菜鸟党


名称 | 邮箱
--- | ---
[iamlion](https://github.com/iamlion) |  1748439277@qq.com
[c.w](https://github.com/wdzawdh) |  953098507@qq.com



联系QQ：1748439277


### 项目编译

本项目中所使用到的技术有 Flutter，NodeJs。在安装包文件夹下分别有Android，iOS的安装包可以直接安装试用，大部分的业务功能需要登陆使用，测试账号为“test0~test9”，密码默认都是 “11111”，登陆应用后建议可以到个人中心修改昵称，这样可以区分测试账户信息。


##### 客户端代码

代码位置([YOUR_PATH]/社交学习Online/source/client/climbing_app)

###### 第一步

安装 Flutter，请根据flutterchina上的教程安装 flutter，并且配置好环境变量。

https://flutterchina.club/get-started/install/


###### 第二步

安装依赖包，切换目录到 flutter 项目的根目录，执行以下命令，注意：cocoapods 版本需要在 v1.6.0 以上， 建议挂上VPN执行命令。
```
flutter packages get
```

###### 第三步

配置权限，根据 https://pub.dev/packages/agora_rtc_engine 的描述，你需要在Android和iOS的项目工程中配置好麦克风和摄像头权限。

###### 第四步
如果调试iOS程序，需要先打开 flutter 项目根目录下的ios工程文件，并且配置好 bundleId 和对应的描述文件，最后执行以下命令。
```
flutter run

或者

flutter run -d [设备id]

```

如果调试Android程序，直接执行上面的命令即可。


##### 服务端代码

代码位置([YOUR_PATH]/社交学习Online/source/server)

###### 第一步

安装 NodeJs，请前往NodeJs官网安装NodeJs：

https://nodejs.org/en/

###### 第二步

安装依赖包，切换到服务器代码目录下执行以下命令：

```
node install
```

###### 第三步

启动服务器，直接执行以下命令：
```
node app
```

### 演示

项目文件夹下存有演示视频，建议实际测试的时候例如功能“1对1视频”，“直播课程”可以利用两台手机进行测试试用。
