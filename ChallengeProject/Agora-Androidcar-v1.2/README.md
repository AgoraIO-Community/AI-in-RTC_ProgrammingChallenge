基于安卓的视频控制小车
=========

<p>本设计是将安卓技术、单片机技术、AgoraRTC实时音视频通信技术等相关技术应用到视频监控系统中，可实现视频监控系统的设备移动化，由可移动监控平台、控制软件两部分组成。通过无线网络对监控平台进行移动方向、速度的控制，平台上的安卓手机摄像头实时采集视频图像信号并通过无线WiFi网络将视频信号实时传输到手机端观看。具有控制方便，监控灵活，模块化，可拓展性强等优点，可应用于儿童陪伴机器人、家庭安防等领域。</p><p><img src="https://github.com/RoachWZ/AI-in-RTC_ProgrammingChallenge/blob/master/ChallengeProject/Agora-Androidcar-v1.2/photo/%E5%B1%95%E7%A4%BA_%E9%81%A5%E6%8E%A7.gif"><img src="https://github.com/RoachWZ/AI-in-RTC_ProgrammingChallenge/blob/master/ChallengeProject/Agora-Androidcar-v1.2/photo/%E5%B1%95%E7%A4%BA_%E9%81%A5%E6%8E%A71.gif"><img src="https://github.com/RoachWZ/AI-in-RTC_ProgrammingChallenge/blob/master/ChallengeProject/Agora-Androidcar-v1.2/photo/xtkt.png"><span style="font-size: 18px;">手机应用介绍</span></b></p><p style="margin-left: 40px;">1）用手机替代网络摄像头，更智能，更省电；</p><p style="margin-left: 40px;">2）支持红外遥控玩具遥控车； （移动功能，需要配套本设计红外遥控小车）</p><p style="margin-left: 40px;">3）人脸跟随；（娱乐功能，需要配套本设计红外遥控小车）</p><p style="margin-left: 20px;"><strong><span style="font-size: 16px;">使用方法：</span></strong></p><p style="margin-left: 40px;">1、安装应用，分别在两部手机上安装；</p><p style="margin-left: 40px;">2、将两部手机连入互联网（WiFi，或4G）；</p><p style="margin-left: 40px;">3、把其中一部手机放到红外遥控玩具车上；</p><p style="margin-left: 40px;">4、需要注册appID，两部手机用同一个appID</p><p><strong><span style="font-size: 18px;">使用时，先将小车上电。将两部手机连接到互联网，打开我们事先编写好的安卓软件，小车上的手机选择小车模式，另一部手机选择控制模式便可以进行操作了，画面右侧控制小车的运动，左侧则是速度的控制。</span></strong></p><p><img src="https://github.com/RoachWZ/AI-in-RTC_ProgrammingChallenge/blob/master/ChallengeProject/Agora-Androidcar-v1.2/photo/xc1.2.png" style="width: 272px;"><img src="https://github.com/RoachWZ/AI-in-RTC_ProgrammingChallenge/blob/master/ChallengeProject/Agora-Androidcar-v1.2/photo/kz1.2.png" style="background-color: initial; width: 424px; --darkreader-inline-bgcolor: initial;" data-darkreader-inline-bgcolor=""></p><p><span style=""><span style="font-size: 28px;"><strong>目录</strong></span></span></p><p><span style=""><span style="font-size: 28px;"><strong>一、 创意来源</strong></span></span></p><p><span style=""><span style="font-size: 28px;"><strong>二、 项目概述</strong></span></span></p><p><span style=""><span style="font-size: 28px;"><strong>三、 优势</strong></span></span></p><p><span style=""><span style="font-size: 28px;"><strong>四、 功能</strong></span></span></p><p><span style=""><span style="font-size: 28px;"><strong>五、 制作材料</strong></span></span></p><p><span style=""><span style="font-size: 28px;"><strong>六、 详细介绍</strong></span></span></p><p><span style=""><span style="font-size: 28px;"><strong>七、 参考文献</strong></span></span></p><p><span style=""><span style="font-size: 28px;"><strong><br></strong></span></span></p><p><strong><span style="font-size: 20px;">一、创意来源</span></strong></p><p style="margin-left: 20px;">当今在安防监控领域，大多数民用监控设备有几大弊端：</p><p style="margin-left: 20px;">位置固定：大多数设备位置固定，不便移动，即使有一些可以摄像头可以转动，但是仍然无法实现对大部分区域的监控，比如一些存在死角的位置就不会被监控（床底，墙角等等），因此小车的可移动性监控有较为突出的优点。应用在家庭监控领域较为合适，尤其是家中无人的时候。</p><p style="margin-left: 20px;">有线传输，电源线：大多数是有线传输，即使有一些是无线传输，但是仍要被束缚在电源线上。而本小车就不同了，可以直接装个充电宝做备用电源</p><p style="margin-left: 20px;">价格昂贵：当今一套完整的监控设备成本较高。而本小车利用了过时淘汰的手机，大大节约了成本，一定程度上控制了废旧手机的污染。基于当今监控设备这些缺点，构造出了基于安卓的视频控制小车。</p><p><strong style="background-color: initial; --darkreader-inline-bgcolor: initial;" data-darkreader-inline-bgcolor=""><span style="font-size: 20px;">二、项目概述</span></strong></p><p style="margin-left: 20px;">
	本设计是将安卓技术、单片机技术、无线通信技术等相关技术应用到视频监控系统中，可实现视频监控系统的设备移动化，由可移动监控平台、控制软件两部分组成。使用安卓手机作为控制端，通过无线网络对监控平台进行移动方向、速度的控制，平台上的摄像头实时采集视频图像信号并通过无线WiFi网络将视频信号实时传输到手机端观看，然后可实时拍照录像并可实时存储。由于监控端可移动，可以在无人进入的情况下获取危险环境的视频图像。具有控制方便，监控灵活，模块化，可拓展性强等优点，可应用于险情探测、防爆、现场巡视、家庭安防、图像采集等领域。</p><p>
	<strong><span style="font-size: 20px;">三、优势：</span></strong></p><p style="margin-left: 20px;">
	    设计之初不完全是为了DIY，我是希望能够做出一款实用便宜易用的产品，所以没有采用常用的DIY开源硬件方案例如arduino，而是选择了价格便宜，应用广泛的STC89C52RC单片机芯片来做控制方案。当然也相信大家能理解我为什么会选择Android手机来做智能小车大脑。</p><p style="margin-left: 40px;">
	1. 我们制作的智能小车抛开性能低下、操作复杂的单片机，使用移动终端作为控制端，利用移动终端（例如手机，电脑，平板）的高性能处理器和低廉的价格，降低了研发成本和研发难度。</p><p style="margin-left: 40px;">
	2. 通过移动网络或者本地局域网进行连接，可以在任何地方，使用任何设备即可对小车进行远程遥控，对家庭安全进行防护。</p><p style="margin-left: 40px;">
	3. 与WIFI IP camera对比：1）可以到处跑，因为不需要插着电源线；2）省电，待机长，所以不用担心充电问题。3）监控声音情况。</p><p>
	<strong><span style="font-size: 20px;">四、功能：</span></strong></p><p style="margin-left: 40px;">
	1）实时视频（android手机摄像头开发）</p><p style="margin-left: 40px;">
	2）红外遥控车（STC89C52RC ）</p><p style="margin-left: 40px;">
	3）人脸检测追踪（android手机编程）</p><p><span style="font-size: 16px;"><img src="https://github.com/RoachWZ/AI-in-RTC_ProgrammingChallenge/blob/master/ChallengeProject/Agora-Androidcar-v1.2/photo/%E5%B1%95%E7%A4%BA_%E4%BA%BA%E8%84%B8%E8%BF%BD%E8%B8%AA1.gif"></span><strong><br><span style=""><span style="font-size: 20px;">下面是 人脸跟随演 和&nbsp;</span></span></strong><strong><span style="font-size: 20px;">制作过程 的视频：</span></strong></p>

[![Watch the video](https://github.com/RoachWZ/AI-in-RTC_ProgrammingChallenge/blob/master/ChallengeProject/Agora-Androidcar-v1.2/photo/bf.png)](https://player.bilibili.com/player.html?aid=61487867&cid=114674825&page=2)

<p>
	<strong><span style="font-size: 20px;">五、制作材料：</span></strong></p><p style="margin-left: 40px;">
	1）控制板包括：</p><p style="margin-left: 80px;">
	STC89C52RC单片机最小系统</p><p style="margin-left: 80px;">
	红外遥控接收一体化模块VS1838B</p><p style="margin-left: 80px;">
	L293D电机驱动模块</p><p style="margin-left: 40px;">
	2）小车底盘（淘宝上面有非常多的小车底盘卖，自己任选），</p><p style="margin-left: 40px;">
	3）马达：TT马达 2个</p><p style="margin-left: 40px;">
	4）轮子：2个</p><p style="margin-left: 40px;">
	5）锂电池:2200mAH 两节7.4V   + 充电器（可用充电宝代替）</p><p style="margin-left: 40px;">
	6）杜邦线若干</p><p style="margin-left: 40px;">
	7)&nbsp; 车载手机支架（有车一族，不用的车载手机支架可以利用）</p><p>
	<strong></strong><span style="color: rgb(192, 80, 77); --darkreader-inline-color:#c9837e;" data-darkreader-inline-color=""><strong>总共约200左右，如果去掉5）7）剩下的也就<span style=""><span style="font-size: 28px;"><h3>100元</h3>出头</span></span></strong></span></p><p><span style="color: rgb(192, 80, 77); --darkreader-inline-color:#c9837e;" data-darkreader-inline-color=""></span></p><hr>
<p style="margin-left: 20px;"><strong><span style="color: rgb(0, 0, 0);"><span style=""><span style="font-size: 24px;">网上类似的产品价格都不是很亲民</span></span></span></strong></p><p><span style="color: rgb(192, 80, 77); --darkreader-inline-color:#c9837e;" data-darkreader-inline-color=""></span></p><p><img src="https://github.com/RoachWZ/AI-in-RTC_ProgrammingChallenge/blob/master/ChallengeProject/Agora-Androidcar-v1.2/photo/%E5%90%8C%E7%B1%BB%E4%BA%A7%E5%93%81.jpg"></p><hr>
<p>
	<strong><span style="font-size: 20px;">六、详细介绍</span></strong></p><p>
	<strong>1相关技术</strong></p><p style="margin-left: 20px;">
	Android摄像头自定义相机开发、Android人脸检测(FaceDetector)API开发、Android红外遥控开发、Android网络实时音视频传输开发、单片机红外解码及电机控制 。</p><p style="margin-left: 20px;">基于安卓的视频控制小车利用了能发射红外信号的安卓旧手机作为核心，通过WiFi将手机或电脑监控端与车载手机控制端相连接，继而间接实现手机或电脑监控端对小车的控制。</p><p style="margin-left: 20px;">
	通过手机或电脑端向手机发送指令，然后手机执行指令向小车发射红外信号进行相应控制，并调用车载手机摄像头将小车前方的图像信息回传给手机或电脑监控端。</p><p style="margin-left: 20px;">
	另外，小车还可以对人脸进行检测跟随，根据人脸在视频中位置，不断调整小车方向直到人脸位于屏幕中心，增强娱乐性。</p><p><strong>2相关代码</strong></p><p style="margin-left: 20px;"><a href="https://github.com/RoachWZ/AI-in-RTC_ProgrammingChallenge/tree/master/ChallengeProject/Agora-Androidcar-v1.2/51-IR-Car">小车端单片机代码</a></p><p style="margin-left: 20px;"><a href="https://github.com/RoachWZ/AI-in-RTC_ProgrammingChallenge/tree/master/ChallengeProject/Agora-Androidcar-v1.2/MonitorAndroidCar-v1.2">安卓手机端代码</a></p><p style="margin-left: 20px;"><a href="https://github.com/RoachWZ/AI-in-RTC_ProgrammingChallenge/tree/master/ChallengeProject/Agora-Androidcar-v1.2/MonitorWeb-v1.0">web端代码</a></p><hr>
<p style="margin-left: 40px;"><strong><span style="color: rgb(192, 80, 77); --darkreader-inline-color:#c9837e;" data-darkreader-inline-color="">特别说明</span></strong>：车载手机通过红外遥控小车，虽然红外的遥控的控制距离只有10m左右，无法绕过障碍物进行遥控。但发射红外遥控信号的手机就架在小车上，可以将手机的红外发射器和红外接收器放在一块固定住。虽然并不是所有的安卓手机都有红外发射器，但都有3.5mm的耳机接口，红外信号的38kHz频率在音频范围内，可以用耳机接口外接的红外发光二极管发射红外遥控信号。如果使用蓝牙来完成对小车的控制，小车上需要配备蓝牙模块与手机进行配对通信。而且并不是所有的手机都支持蓝牙，早期的一些安卓智能手机就不支持蓝牙。而且蓝牙需要配对连接，红外遥控无需配对连接，省去等待时间。相比蓝牙模块，红外模块成本更低。所以采用红外遥控模式。</p><hr><p><b style="background-color: initial; --darkreader-inline-bgcolor: initial;" data-darkreader-inline-bgcolor="">
<p><strong>3更多内容</strong></p><p style="margin-left: 20px;"><strong><span style="color: rgb(192, 80, 77); --darkreader-inline-color:#c9837e;" data-darkreader-inline-color="">以上只是简单介绍，更多内容请查看这两个链接</span></strong></p><p style="margin-left: 40px;">[1]：<a href="https://forum.mianbaoban.cn/topic/72289_1_1.html">AgoraRTC+旧安卓手机+51单片机红外遥控小车=远程视频遥控小车</a></p><p style="margin-left: 40px;">[2]：<a href="http://mc.dfrobot.com.cn/thread-297325-1-1.html">用51单片机和旧手机DIY远程视频监控小车（附论文PDF文件）</a></p><strong>远程视频遥控演示（相距500km）</strong></p><p style="margin-left: 20px;">
<span style="font-size: 18px;">下面是远程手机端演示</span></b></p>

[![Watch the video](https://github.com/RoachWZ/AI-in-RTC_ProgrammingChallenge/blob/master/ChallengeProject/Agora-Androidcar-v1.2/photo/bf.png)](https://player.bilibili.com/player.html?aid=62053730&cid=107876643&page=2)

<p><strong><span style="font-size: 18px;">下面是远程电脑端演示</span></strong></p>

[![Watch the video](https://github.com/RoachWZ/AI-in-RTC_ProgrammingChallenge/blob/master/ChallengeProject/Agora-Androidcar-v1.2/photo/bf.png)](https://player.bilibili.com/player.html?aid=62053730&cid=107876643&page=1)

<p><strong><span style="font-size: 20px;"><br></span></strong></p><p>
	<strong><span style="font-size: 20px;">七、 参考文献</span></strong></p><p style="margin-left: 20px;">
	<strong>   <span style="font-size: 16px;">国内外对于该类应用场景的研究：</span></strong></p><ul>
	
<li>手机机器人_百度百科<a href="https://baike.baidu.com/item/%E6%89%8B%E6%9C%BA%E6%9C%BA%E5%99%A8%E4%BA%BA/4388512">https://baike.baidu.com/item/%E6%89%8B%E6%9C%BA%E6...</a></li><li>Chap小家伙入门级编程机器人教育套件家庭版 – RoboSpace <a href="https://www.robospace.cc/chap/">https://www.robospace.cc/chap/</a></li>	
<li>派宝机器人 Padbot T1 | 您的桌面智能萌宠 <a href="https://www.padbot.cn/t1">https://www.padbot.cn/t1</a></li>	
<li>Botiful:Skype临场互动机器人 <a href="http://mobile.163.com/12/0729/16/87JIKNOV0011665S.html">http://mobile.163.com/12/0729/16/87JIKNOV0011665S....</a></li>	
<li><a href="https://www.kickstarter.com/projects/1452620607/botiful-telepresence-robot-for-android">https://www.kickstarter.com/projects/1452620607/bo...</a></li>	
<li>Romo：让智能手机变身机器人 <a href="http://www.ifanr.com/175468">http://www.ifanr.com/175468</a> </li>	
<li><a href="https://www.kickstarter.com/projects/peterseid/romo-the-smartphone-robot">https://www.kickstarter.com/projects/peterseid/rom...</a></li>	
<li><a href="https://www.kickstarter.com/projects/peterseid/romo-the-smartphone-robot-for-everyone">https://www.kickstarter.com/projects/peterseid/rom...</a></li>	
<li><a href="https://www.kickstarter.com/projects/peterseid/romo-the-smartphone-robot-for-everyone"></a>掌上看家：摸索视频应用的O2O模式 <a href="http://www.techweb.com.cn/news/2012-10-25/1249261.shtml">http://www.techweb.com.cn/news/2012-10-25/1249261....</a></li>	
<li>打造零成本安防方案，掌上看家将你的旧手机改造成安防摄像头</li>	
<li><a href="http://tech.163.com/14/0923/11/A6QRTAQN00094ODU.html">http://tech.163.com/14/0923/11/A6QRTAQN00094ODU.ht...</a></li>	
<li>Mindhelix 把废手机变成智能家居的一部分 <a href="http://www.shejipi.com/31209.html">http://www.shejipi.com/31209.html</a></li>	
<li>阿福管家(Alfred) <a href="http://www.360doc.com/content/17/0106/00/30371403_620394218.shtml">http://www.360doc.com/content/17/0106/00/30371403_...</a></li>	
<li>旧手机天堂？Hippo帮你用安卓手机DIY专属硬件 <a href="http://www.pcbeta.com/viewnews-67118-1.html">http://www.pcbeta.com/viewnews-67118-1.html</a></li>	
<li>科技玩具Romo：用iPhone整一个机器人“玩” <a href="https://www.leiphone.com/news/201406/d-romo.html">https://www.leiphone.com/news/201406/d-romo.html</a></li>	
<li>Romo活泼又聪明，多亏iPhone做大脑 <a href="https://www.guokr.com/article/68607/">https://www.guokr.com/article/68607/</a></li>	
<li>IOIO在Android手机中的应用与研究 <a href="http://www.21ic.com/app/opto/201304/179778.htm">http://www.21ic.com/app/opto/201304/179778.htm</a></li>	
<li>使用android IOIO和安卓手机制作视频遥控小车（控制灯的开关、实时视频传输、方向控制）<a href="http://blog.sina.com.cn/s/blog_8265bd790102vhpa.html">http://blog.sina.com.cn/s/blog_8265bd790102vhpa.ht...</a></li>	
<li>【DIY】远程手机遥控车 androidbot <a href="https://blog.csdn.net/xpp012/article/details/77964192">https://blog.csdn.net/xpp012/article/details/77964...</a></li>	
<li>Android实践：做一个可视频交互的智能小车 <a href="https://blog.csdn.net/weixin_33786077/article/details/87947763">https://blog.csdn.net/weixin_33786077/article/deta...</a></li>	
<li>StarRTC,AndroidThings,树莓派小车,公网环境,视频遥控(一)准备工作<a href="http://blog.starrtc.com/2018/07/11/starrtc-androidthings-rpi-prerequisite/">http://blog.starrtc.com/2018/07/11/starrtc-android...</a></li>	
<li>树莓派视频遥控小车 + iOS / Android / web应用<a href="https://www.jianshu.com/p/d0c8b51e9647">https://www.jianshu.com/p/d0c8b51e9647</a></li>	
<li>变废为宝+旧手机做一个家庭远程安防机器人 <a href="http://www.sohu.com/a/160959116_793365">http://www.sohu.com/a/160959116_793365</a></li>	
<li>[创意DIY] 手把手教你用iPhone变身卖萌遥控小车<a href="http://bbs.elecfans.com/m/forum.php?mod=viewthread&amp;tid=307662&amp;extra=page=29">http://bbs.elecfans.com/m/forum.php?mod=viewthread&amp;tid=307662&amp;extra=page=29</a></li>	
<li>极品智能飞车 wifi和Android控制小车（获奖作品原创）<a href="https://www.cirmall.com/circuit/1342/#/details">https://www.cirmall.com/circuit/1342/#/details</a></li>	
<li>用手机 DIY 一个 Wifi-Robot <a href="https://www.eefocus.com/embedream/blog/15-09/319693_3e54e.html">https://www.eefocus.com/embedream/blog/15-09/31969...</a></li>	
<li><a href="https://www.eefocus.com/embedream/blog/15-09/319693_3e54e.html"></a>低成本DIY视频预览遥控小车<a href="https://blog.csdn.net/cjnewstar111/article/details/9415415">https://blog.csdn.net/cjnewstar111/article/details...</a></li>	
<li>可以在外面遥控家里的视频通话的智能小车<a href="https://blog.csdn.net/lindev/article/details/50433260">https://blog.csdn.net/lindev/article/details/50433...</a></li>	
<li>旧手机+Arduino的巅峰之作&mdash;视频监控机器人 ，异地远程遥控（设计资料开源共享）<a href="https://www.cirmall.com/circuit/3170">https://www.cirmall.com/circuit/3170</a></li>	
<li>手机目标跟踪寻迹小车+蓝牙SPP通信，附APP和Arduino源码<a href="https://www.cirmall.com/circuit/6375">https://www.cirmall.com/circuit/6375</a></li>	
<li>做一个遥控车当手机支架 小伙子很有想法 <a href="http://www.iqiyi.com/w_19rx3g75bt.html">http://www.iqiyi.com/w_19rx3g75bt.html</a></li>	
<li>自制iphone第一人称视频遥控小车<a href="http://blog.sina.com.cn/s/blog_7355abc2010115ah.html">http://blog.sina.com.cn/s/blog_7355abc2010115ah.ht...</a></li>	
<li>桌面智能管家机器人-- 小氪 <a href="http://www.cirmall.com/bbs/thread-48752-1-1.html">http://www.cirmall.com/bbs/thread-48752-1-1.html</a></li>	
<li>能控制所有智能家居的机器人管家设计（硬件+程序源码+论文）<a href="https://www.cirmall.com/circuit/4808">https://www.cirmall.com/circuit/4808</a></li>	
<li>M1 Rover <a href="https://hackaday.io/project/161460-m1-rover">https://hackaday.io/project/161460-m1-rover</a></li>	
<li>M1 Rover：无人自动驾驶机器人，与Arduino兼容<a href="https://www.cirmall.com/articles/397468/p1">https://www.cirmall.com/articles/397468/p1</a></li><li>扫地机器人+手机，改造成安防机器人<a href="https://v.youku.com/v_show/id_XNDIzNTg4Nzk0MA==.html">https://v.youku.com/v_show/id_XNDIzNTg4Nzk0MA==.ht...</a></li><li>PlusBot手机外设机器人<a href="https://www.bilibili.com/video/av63968166">https://www.bilibili.com/video/av63968166</a></li><li>日本3D打印手机神器 能跑能送快递堪比机器人<a href="http://m.56.com/c/v84757613.shtml">http://m.56.com/c/v84757613.shtml</a></li><li>一款手机机器人,安装上感觉手机长出手指头了,真是太有意思了<a href="http://v.qq.com/page/x/0/b/l0792m0kcab.html">http://v.qq.com/page/x/0/b/l0792m0kcab.html</a></li><li>你的手机也可以是机器人的大脑,做一台自己专属的RoboMaster<a href="https://v.youku.com/v_show/id_XNDI5NTY4MDMyNA==.html">https://v.youku.com/v_show/id_XNDI5NTY4MDMyNA==.ht...</a></li><li>Turn Your Phone Into a Robot <a href="https://www.instructables.com/id/Turn-Your-Phone-into-a-Robot/">https://www.instructables.com/id/Turn-Your-Phone-i...</a></li><li>MobBob DIY Arduino robot controlled by Android smartphone <a href="https://m.youtube.com/watch?v=myOZJADSjpY">https://m.youtube.com/watch?v=myOZJADSjpY</a></li><li>MobBob：主体是智能手机的3D打印机器人<a href="http://www.3dhoo.com/news/guonei/13482.html">http://www.3dhoo.com/news/guonei/13482.html</a></li><li>MobBob V2 - Smart Phone Controlled Robot <a href="https://www.thingiverse.com/thing:990950">https://www.thingiverse.com/thing:990950</a></li><li>Oddwerx - Autonomous Smartphone Robots <a href="https://www.kickstarter.com/projects/ologic/oddwerx-autonomous-smartphone-robots">https://www.kickstarter.com/projects/ologic/oddwer...</a></li><li>Rover Robot <a href="https://www.shaperobotics.com/portfolio-item/build-a-rover-robot/">https://www.shaperobotics.com/portfolio-item/build...</a></li><li>BalDroid - Balancing Robot: Android Phone + IOIO-OTG board <a href="https://m.youtube.com/watch?v=45Q1tHr1-h4">https://m.youtube.com/watch?v=45Q1tHr1-h4</a></li><li>Voice Controlled Robot (VCR)<a href="http://voicecontrolledrobotusingandroid.blogspot.com/2016/07/voice-controlled-robot-using-android.html">http://voicecontrolledrobotusingandroid.blogspot.c...</a></li><li>Mobile Controlled Robot with &amp; without Arduino <a href="https://m.youtube.com/watch?v=mVAWew_48Kk">https://m.youtube.com/watch?v=mVAWew_48Kk</a></li><li>How to make a Skype Controlled UGV - DIY Spy Robot - IoT Project <a href="https://m.youtube.com/watch?v=WrENPS1xk6A">https://m.youtube.com/watch?v=WrENPS1xk6A</a></li>	
<li>
	
<h1><span style=""><span style=""><span style="font-size: 16px;">Android&trade; Based Robotics: Powerful, Flexible and Inexpensive Robots for Hobbyists, Educators, Students and Researchers</span></span></span></h1><p>	<span style=""><span style="font-size: 16px;">原文链接：<a href="http://www.socsci.uci.edu/~jkrichma/ABR/abr_background.html">http://www.socsci.uci.edu/~jkrichma/ABR/abr_background.html</a></span><br><span style="font-size: 16px;">相关项目链接：<a href="https://github.com/IeiuniumLux/AAV">https://github.com/IeiuniumLux/AAV</a></span></span><h2>下图是用Google浏览器翻译出来的译文</h2><br>
<img src="https://github.com/RoachWZ/AI-in-RTC_ProgrammingChallenge/blob/master/ChallengeProject/Agora-Androidcar-v1.2/photo/ABR.jpg" >

	
