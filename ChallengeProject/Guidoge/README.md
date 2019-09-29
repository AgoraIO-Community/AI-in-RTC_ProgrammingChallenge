# Project Guidoge

*移动设备辅助视觉拓展方案*

- 项目名称：Guidoge｜可鲁
- 开发者：nekowink, eEhyQx.
- 项目概述：Guidoge是一套基于普通智能移动设备辅助视觉方案

## 0.Trailer

[![GUIDOGE VIDEO](https://s2.ax1x.com/2019/09/29/uGMrVO.png)](https://www.bilibili.com/video/av69334959)

👆 点击上方图片播放可鲁的1min宣传片！

## 1.项目介绍

Guidoge是一套基于普通智能移动设备辅助视觉方案，主要面向视障人士、骑行或平衡车爱好者等有视觉辅助/拓展需求的群体。Guidoge无需复杂的外设，仅凭一台手机与一根挂绳（Guidoge Loop）就可实现丰富的视觉辅助/拓展功能。

## 2.解决方案

Guidoge唯一的外设只有一根挂绳（Guidoge Loop）。用户在打开Guidoge APP完成相关设置后通过Guidoge Loop将手机后置摄像头朝前挂在胸前，将接下来将由Guidoge Sever完成Depth estimation，Object Detection在内的一些任务并给用户实现以导航、避障为核心的视觉拓展功能。

**避障**

Guidoge Sever通过前端发送的视频信息进行Depth estimation步骤得到前景的深度信息并通过Object Detection进行障碍识别，并根据这些信息，利用语音、震动等交互方式对用户进行预警。

**导航**

根据预设的目的地及设备提供的当前位置信息，Guidoge利用第三方导航服务的API获取路径方案，并将路径方案进一步转换为语义明确的震动、语音提示，给用户带来更加良好的导航体验。

**远程指引**

Guidoge提供了开放给用户亲属、好友的观察窗口。用户可以通过开启远程指引模式允许亲属、好友通过观察窗口观察Guidoge采集到的画面，并由亲属、好友提供远程指引。

**后视镜模式**

Guidoge开放给骑行、平衡车爱好者等用户群体后视镜模式；这个模式下，用户需要调整Guidoge Loop使移动设备贴在背上；Guidoge APP会利用避障功能实现对后方障碍物的检测。

**无屏交互**

Guidoge提供了完备的语音用户界面方式，用户可以通过语音控制实现与Guidoge的无屏交互。Guidoge对用户的基础反馈也通过振动、语音两种方式传递，真正实现无屏交互。

## 3.技术实现

Guidoge方案中涉及到的许多技术都与Deep Learning，Computer Vision密切相关，这里我们将简单描述我们目前一些核心技术点采用的方案。

**视频推流**

采用了Agora（声网）提供的SDK完成了视频推流。

**Depth estimation**

根据硬件支持度，我们提供了3种Depth estimation方案：

- 原生Depth信息（如：TOF）
- 双目摄像头推断
- 单目摄像头估计

前两者都已经有了较成熟的方法，在此我们不再赘述。在利用单目摄像头进行Depth estimation上我们采用了ICCV2019近期刊登的论文Digging Into Self-Supervised Monocular Depth Estimation（Clément Godard, Oisin Mac Aodha, Michael Firman, Gabriel Brostow）的开源版本实现。
  
**Object Detection**
  
根据硬件支持度及环境状况，我们提供了2种Object Detection方案：
  
- 直接利用深度信息判定
- 利用点云判定（需要移动设备相机内参）

第一种方案利用Depth信息使用梯度估计的方法结合团队设计的障碍物预警算法实现路况描述、障碍的判定；第二种方案是在能获取相机内参的情况下，将Depth信息还原为Point Cloud，再采用CVPR2019近期刊登的论文PointRCNN: 3D Object Proposal Generation and Detection from Point Cloud（Shi S , Wang X , Li H）的开源版本结合团队设计的障碍物预警算法实现实现障碍物识别、预警。在条件允许前提下两种方案可以同时执行。

## Reference

Godard, Clément, Mac Aodha O , Firman M , et al. Digging Into Self-Supervised Monocular Depth Estimation[J]. 2018.

Shi S , Wang X , Li H . PointRCNN: 3D Object Proposal Generation and Detection from Point Cloud[J]. 2018.
