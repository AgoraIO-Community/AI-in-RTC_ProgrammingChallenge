#请用markdownPad打开此文件，请用markdownPad打开此文件，请用markdownPad打开此文件！
#完整视频教程请点击→ [部署视频教程](https://v.youku.com/v_show/id_XNDM4OTIwNjU4MA==.html?spm=a2h0k.11417342.soresults.dposter)
##一、作品介绍
该作品是一个可以发布直播的内容发布系统，通过系统后台发布直播，同时对直播进行播控，在首页显示直播链接，点击进去即可观看直播。
该系统在PHPCMS上进行，因此需要配置好lamp或者wamp的环境并且安装PHPCMS。
##二、团队介绍
该作品所有二次开发工作均由本人完成，本人苑学志，27岁，目前在人民卫生出版社有限公司做IT部门做产品经理。联系方式：邮箱844800670@qq.com，手机18610062316.
##五、下载安装PHPCMS
###1.下载
 ChallengeProject 文件夹下的phpcms_v9_UTF8目录是PHPCMS的安装文件（可以登录phpcms官网：http://www.phpcms.cn 下载。下载时推荐下载UTF-8字符集版本的，下载解压即可获得，直接使用这个目录也可以），该目录下有两个目录，其中install_package目录内的文件为需要安装的文件，readme里的文件为帮助文档和.htaccess文件（做伪静态时的规则）。
###2.安装
将install_package内的所有文件和目录拷贝到项目目录内，然后通过浏览器访问项目目录中的install目录，即可打开安装界面（如下图所示）。
![安装首界面.png](http://upload-images.jianshu.io/upload_images/7792042-cbaf5bf8a2e4993e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
**第一步：同意许可协议**

**第二步：运行环境检测**
如果运行环境中有哪些没开启，表格最后一列就表现为×，需要通过调整开启。若设备未联网，最后一行DNS解析则表现为×，但不影响在本机安装。

**第三步：选择模块**
注意PHPSSO设置中必须选择一项才能进行下一步。

**第四步：文件权限设置**
表格所列出的文件和目录都需要可写才行。

**第五步：账号设置**
**第六步：系统安装**
**第七步：安装完成**

安装完成后，要把项目中的install目录删掉，系统默认是在安装完后自动删掉的，如果没删，要手动删掉。
浏览器访问项目目录下/index.php则访问前台页面，访问项目目录下/admin.php则访问后台管理页面。
##六、站点迁移
###1.迁移前台模板
将ChallengeProject/dzwn/statics/中的live文件夹和dzwn_v1文件粘贴到项目目录下statics/中，再把ChallengeProject/dzwn/phpcms/中的dzwn_v1复制粘贴到项目目录下phpcms/templates/中。然后浏览器访问登录项目目录下/admin.php则进入后台管理页面，在“设置”→“站点管理”→“修改”进行模板的调换，如下图：
![站点管理.png](http://upload-images.jianshu.io/upload_images/7792042-9dd48ceb721b7b7f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
点击修改
![站点管理修改.png](http://upload-images.jianshu.io/upload_images/7792042-ef35178cd14049b5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
可以在此进行修改网站相关设置。在“模板风格”配置处选择“dzwn_v1”点击“确定”，点击右上角的“更新缓存”，再通过浏览器进入站点首页，即可看到首页变为大嘴蜗牛风格模板，如下图：
![大嘴蜗牛首页.png](https://upload-images.jianshu.io/upload_images/7792042-14a2a8778752b687.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
###2.迁移数据
将ChallengeProject/dzwn/db/中的sql文件导入安装PHPCMS时设置的数据库中，即可将本人准备好的数据迁移过来，其中包括用户123和live直播模板。
###3.更改后台模板
将ChallengeProject/dzwn/modules/中的content_list.tpl.php文件复制替换项目目录下phpcms/modules/content/templates/中的原content_list.tpl.php文件。
此时刷新后台，即可看到预制数据，如下图所示：
![预先置入数据.png](https://upload-images.jianshu.io/upload_images/7792042-d6b37917268da814.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
点击修改，则可以修改内部的APPID、CHANNEL、CERTIFICATE和文字内容等选项，点击播控后，则弹出播控界面，可以使用网页进行视频直播的发布。
##七、使用
在后台“内容”→“管理内容”→“小法庭”栏目中，可以进行直播的添加和修改，还可以在编辑页中制定将内容推送到网页的什么地方去，该作品目前只能推送到首页轮播图那里。操作界面如下图所示：
![后台编辑图.png](https://upload-images.jianshu.io/upload_images/7792042-85a94a1960fab520.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

创建好之后，在首页轮播图既可以看到相应内容，点击进去之后，即可观看直播。首页如下图所示：
![首页图.png](https://upload-images.jianshu.io/upload_images/7792042-18316fe7ab7a9dea.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
#完整视频教程请点击→ [部署视频教程](https://v.youku.com/v_show/id_XNDM4OTIwNjU4MA==.html?spm=a2h0k.11417342.soresults.dposter)
