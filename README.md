# jh_flutter_demo

A new Flutter project - 实现一些常用效果、封装通用组件和工具类 <br> 
<br>

pwd：123456

代码不定期更新
<br>


<br>

## 实现的一些效果

* 通用框架搭建、通用基类实现
* 字体、颜色、Frame、字符串等宏定义
* dio网络请求封装
* API接口管理和数据管理
* 路由模块化管理
* 屏幕适配
* 暗黑模式(DarkMode)适配
* 主题切换
* 组件
  * BaseAppBar、BaseTabBar、BaseRefreshView、BaseWebView
  * 弹框(中间、底部、toast、dialog、自定义弹框)
  * 时间、日期、单列、多列、底部选择器
  * 级联选择器（多维数组或树形结构、支持搜索）
  * JhForm 表单录入(单行多行输入样式、选择样式、设置样式、登录样式)
  * JhTopTabBar(导航条分页切换)
  * 渐变色导航条、多行标题导航条
  * 仿微信右上角弹框
  * 倒计时按钮
  * APP更新弹框
  * 基于微信UI的图片/视频选择器(支持拍照及录制视频)
  * 拍照、本地图片多选、九宫格展示、全屏查看图片
  * 文本高亮显示指定文本
  * 空数据
* 工具类
  * AES加解密、MD5加密、base64编码解码
  * 本地数据AES加密存储
  * 实时网络监测
  * 获取设备信息、屏幕信息、刘海屏判断
  * 加载图片资源、颜色设置
  * 状态栏设置
  * 二维码扫描与生成
  * 导航路由跳转
  * 时间格式转换
  * 字符串处理
  * 随机数
* UI相关
  * ListView相关(分页上下拉刷新、分组上下拉刷新、分组吸顶)
  * GridView相关
  * Chart相关(多图表动态加载、渐变折线图、折线柱状图混合图表)
  * 小红点
  * 导航条搜索框和header搜索框
  * 轮播(全屏、缩放)
  * Animation(标签云)
  * 列表侧滑按钮
  * 城市选择列表
  * ListView/GridView拖拽排序
  * 富文本
  * 登录注册
  * 版本新特性
  * 检查更新
  * 仿微信UI（首页，通讯录，发现和个人中心等）
  * 导航条图片下拉放大和渐变效果(微信运动排行榜，个人主页)
  * 微信朋友圈和图片浏览


注：
* 封装的组件和工具类都在`jh_common`文件夹
* 更多请下载工程查看

<br>

## 项目运行环境

* Flutter version 3.0.0
* Dart version 2.17.0

## 注意事项

* debug模式下会有部分卡顿现象，这属于正常现象。良好的体验需要打release 包。 iOS可以执行命令flutter build ios 以创建release版本。 Android可以执行命令flutter build apk 以创建release版本。
* iOS14真机运行闪退，可通过 flutter run --release 真机运行

## <a id="更新记录"></a> 更新记录
<details open id="重要更新">
  <summary><strong>重要更新</strong></summary>
   
```
* v3.0.0  - 更新三方库和flutter版本（Flutter 3.0.0，Dart 2.17.0）
* v2.10.1 - 暗黑模式(DarkMode)适配
* v2.10.0 - 更新三方库和flutter版本（Flutter 2.10.0，Dart 2.16.0）
* v2.0.0  - 更新 Flutter SDK（ 2.0.3 ）和依赖库
* v1.0.0  - 环境：Flutter version 1.22.3，Dart version 2.10.3
```
</details>

<br>
<br>
<br>

<img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Login.gif" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/wx/wx_home.jpg" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/wx/wx_contacts.jpg" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/wx/wx_discover.jpg" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/wx/wx_mine.jpg" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Other/BaseAppBar.gif" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Alert/JhToast.gif" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Alert/BootomSheet.gif" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Alert/JhDialog.gif" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Alert/JhCascadePicker.gif" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Alert/JhCascadeTreePicker1.gif" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Alert/JhCascadeTreePicker2.gif" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Alert/Alert_iOS.gif" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Other/PhotoSelect.gif" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Form/JhLoginTextField.jpg" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Form/JhTextField.jpg" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Form/JhFormInputCell.jpg" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Form/JhFormSelectCell.jpg" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Form/JhSetCell.jpg" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/topTabBar/JhTopTabBar.jpg" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/topTabBar/JhTopTabBar_redDot.jpg" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/search/navSearch_3.jpg" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Other/TagCloudWidget.gif" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Other/TagCloudWidget2.gif" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/eChart.gif" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Alert/JhPopMenus1.jpg" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Alert/JhPopMenus2.jpg" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Alert/JhPopMenus3.jpg" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Other/img_pull_down_big.gif" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Other/img_pull_down_big2.gif" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Other/img_pull_down_big.gif" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/wx/home/wx_motion_top.gif" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/wx/discover/wx_friendsCircle.gif" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/theme.gif" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Other/JhAssetPicker.gif" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Base/BaseRefreshView.gif" width="208" height="404">




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

