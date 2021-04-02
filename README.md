# jh_flutter_demo

A new Flutter project - 实现一些常用效果、封装通用组件和工具类 <br> 
<br>

pwd：123456

代码不定期更新
<br>

注：Flutter版本升到2.0.3之后，一些第三方有冲突（图片选择和图表），暂时先注释了代码，如需查看可按tag v1.0.0版本环境运行查看

<br>

## 实现的一些效果

* UI相关
* ListView相关(上下拉刷新、分组上下拉刷新、分组吸顶)
* GridView相关
* 弹框封装(中间、底部、toast、自定义弹框)
* 仿微信右上角弹框
* 时间、日期、单列、多列、底部选择器
* 拍照、本地图片多选、九宫格展示、全屏查看图片
* JhForm 表单录入(选择样式、输入样式、登录样式)
* dio封装、分页上下拉加载数据、传值和回传、网络状态获取
* baseNav、baseAppBar、BaseTabBar、BaseWebView 封装
* 导航条搜索框
* chart相关(多图表动态加载、渐变折线图、折线柱状图混合图表)
* JhTopTabBar(导航条分页切换)
* 小红点
* 二维码扫描与生成
* 轮播(全屏、缩放)
* Animation(标签云)
* 列表侧滑按钮
* 城市选择列表
* 富文本
* 屏幕适配
* 倒计时按钮
* 登录注册
* 版本新特性
* 检查更新
* 路由分模块管理
* AES加解密、MD5加密、base64编码解码
* 本地数据AES加密存储
* 仿微信UI（首页，通讯录，发现和个人中心等）
* 导航条图片下拉放大和渐变效果(微信运动排行榜，个人主页)
* 微信朋友圈和图片浏览


## 封装的组件和工具类都在jh_common文件夹

<br>

## 项目运行环境

* Flutter version 2.0.3
* Dart version 2.12.2

## 注意事项

* debug模式下会有部分卡顿现象，这属于正常现象。良好的体验需要打release 包。 iOS可以执行命令flutter build ios 以创建release版本。 Android可以执行命令flutter build apk 以创建release版本。
* iOS14真机运行闪退，可通过 flutter run --release 真机运行

## <a id="更新记录"></a> 更新记录
<details open id="重要更新">
  <summary><strong>重要更新</strong></summary>
   
```
* v2.0.0版本，更新三方库版本，环境：Flutter version 2.0.3，Dart version 2.12.2
* v1.0.0版本，环境：Flutter version 1.22.3，Dart version 2.10.3
```
</details>

<br>
<br>
<br>

<img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Login.gif" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/wx/wx_home.jpg" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/wx/wx_contacts.jpg" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/wx/wx_discover.jpg" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/wx/wx_mine.jpg" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Other/BaseAppBar.gif" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Alert/JhToast.gif" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Alert/BootomSheet.gif" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Alert/JhDialog.gif" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Alert/Alert_iOS.gif" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Other/PhotoSelect.gif" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Form/JhLoginTextField.jpg" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Form/JhTextField.jpg" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Form/JhFormInputCell.jpg" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Form/JhFormSelectCell.jpg" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Form/JhSetCell.jpg" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/topTabBar/JhTopTabBar.jpg" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/topTabBar/JhTopTabBar_redDot.jpg" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/search/navSearch_3.jpg" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Other/TagCloudWidget.gif" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Other/TagCloudWidget2.gif" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/eChart.gif" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Alert/JhPopMenus1.jpg" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Alert/JhPopMenus2.jpg" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Alert/JhPopMenus3.jpg" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Other/img_pull_down_big.gif" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Other/img_pull_down_big2.gif" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Other/img_pull_down_big.gif" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/wx/home/wx_motion_top.gif" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/wx/discover/wx_friendsCircle.gif" width="208" height="404">






<br>
<br>
<br>

# 微信UI：

| ![](./ScreenShot/wx/wx_home.jpg)    |  ![](./ScreenShot/wx/wx_contacts.jpg)    | ![](./ScreenShot/wx/wx_discover.jpg)   |  ![](./ScreenShot/wx/wx_mine.jpg)   |
| :--------------------------------: | :---------------------------------: | :-------------------------------: | :-------------------------------:  |
| ![](./ScreenShot/wx/home/wx_motion.jpg)            |  ![](./ScreenShot/wx/home/wx_motion_top.gif)        | ![](./ScreenShot/wx/home/wx_subscribeNum.jpg)    |  ![](./ScreenShot/wx/home/wx_subscribeNumList.jpg)       |
|  ![](./ScreenShot/wx/home/wx_qqMessage.jpg)   |  ![](./ScreenShot/wx/contacts/wx_addFriend.jpg)    | ![](./ScreenShot/wx/contacts/wx_userInfo.jpg)          |  ![](./ScreenShot/wx/contacts/wx_newFriend.jpg)               | 
| ![](./ScreenShot/wx/contacts/wx_infoSet.jpg)       |  ![](./ScreenShot/wx/mine/wx_personInfo.jpg)         | ![](./ScreenShot/wx/mine/wx_pay.jpg)                        |  ![](./ScreenShot/wx/mine/wx_payManager.jpg)                  |
| ![](./ScreenShot/wx/discover/wx_friendsCircle.gif)    |  ![](./)   | ![](./)  | ![](./)  |

