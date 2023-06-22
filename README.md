# jh_flutter_demo

[![Flutter version](https://img.shields.io/badge/Flutter%20version-3.10.0-brightgreen)](https://flutter.dev)
[![Dart version](https://img.shields.io/badge/Dart%20version-3.0.0-brightgreen)](https://dart.dev)
[![License](https://img.shields.io/badge/license-BSD--2--Clause-green)](LICENSE)
[![GitHub release (latest by date including pre-releases)](https://img.shields.io/github/v/release/iotjin/jh_flutter_demo?include_prereleases)](https://github.com/iotjin/jh_flutter_demo/releases/)


## English | [简体中文](README.zh-CN.md)

A new Flutter project - implement common UI effects, encapsulate components and utils. <br>
<br>

pwd：123456

The code is updated irregularly.
<br>
<br>

## Online preview

  https://iotjin.github.io/jh_flutter_demo

## Project environment

* Flutter version 3.10.0
* Dart version 3.0.0


## Some UI effects implemented

* Common framework construction, common base class implementation
* Macro Definitions for Font, Color, Frame, String, etc.
* Dio network request encapsulation
* API interface management and data management
* Modularized management of routes
* Screen adaptation
* Dark Mode adaptation
* Theme switch
* Components
  * BaseAppBar、BaseTabBar、BaseRefreshView、BaseWebView
  * Dialogs (center、bottom、toast、dialog、custom dialogs)
  * Time、Date、single-column、multi-column and bottom pickers
  * Cascading picker (multi-dimensional array or tree structure, supports search)
  * JhForm form input (single row、multi-row input style、select style、setting style、login style)
  * JhTopTabBar(navigation bar page switching)
  * Gradient color AppBar, multi-line title AppBar
  * Imitation of WeChat's upper-right corner pop-up box
  * Countdown button
  * APP update dialog
  * Picture/video picker based on WeChat UI (supports taking pictures and recording videos)
  * Taking photos, local image selection, nine-grid display, full-screen image viewing
  * Highlighting specified text in text
  * Empty data and network exceptions
  * Skeleton screen
  * Horizontal sliding menu (same effect as Pinduoduo homepage, Taobao My channel)
  * Carousel image(full screen, zoom)
  * Shake, zoom, translate animation
* Utils
  * AES encryption/decryption, MD5 encryption, base64 encoding/decoding
  * Local data AES encrypted storage
  * Real-time network monitoring
  * Getting device information, screen information, and notch screen detection
  * Loading image resources, color settings
  * Status bar settings
  * QR code scanning and generation
  * Navigation route jumping
  * Listening for page appearance or disappearance
  * Time format conversion
  * String processing
  * Random numbers
  * Exit the APP/jump to the app store
  * Debounce / Throttle
* UI related
  * ListView related (paging up/down refresh, grouping up/down refresh, group sticking)
  * GridView related
  * Chart related (dynamic loading of multiple charts, gradient line charts, mixed line and bar charts)
  * Badges
  * AppBar search and header search
  * Animation (tag cloud)
  * List slide button
  * City selection list
  * ListView/GridView drag and drop sorting
  * Rich text
  * log in / Register
  * Version new features
  * Checking for updates
  * Imitation of WeChat UI (home page, address book, discovery, and personal center, etc.)
  * AppBar image pull-down zoom and gradient effect (WeChat Sports Ranking List, personal homepage)
  * WeChat friends circle and image browsing
  * Cross-slide (personal center effect)


Note:
* Packaged components and utils in the `jh_common` folder
* For more, please download the project to view

<br>


## Precautions

* There will be some freezes in debug mode, which is normal. A good experience requires a release package. iOS can execute the command `flutter build ios` to create a release version. Android can execute the command `flutter build apk` to create a release version.
* iOS14 crashes when running on a real machine, which can be run on a real machine through `flutter run --release`

## <a id="Update record"></a> Update record
<details open id="Important update">
  <summary><strong>Important update</strong></summary>
   
```
* v3.10.0  - Update pubspec library and flutter version（Flutter 3.10.0，Dart 3.0.0）
* v3.7.0  - Update pubspec library and flutter version（Flutter 3.7.0，Dart 2.19.0）
* v3.3.0  - Update pubspec library and flutter version（Flutter 3.3.0，Dart 2.18.0），iOS minimum build version changed to 11.0
* v3.0.0  - Update pubspec library and flutter version（Flutter 3.0.0，Dart 2.17.0）
* v2.10.1 - Dark Mode adaptation
* v2.10.0 - Update pubspec library and flutter version（Flutter 2.10.0，Dart 2.16.0）
* v2.0.0  - Update Flutter SDK（ 2.0.3 ）and pubspec library
* v1.0.0  - environment：Flutter version 1.22.3，Dart version 2.10.3
```
</details>


## Appreciate the support


* If you think it's good, or my open source project is helpful to you, you can click "Star" in the upper right corner to support it. Your support is my motivation, thank you 🙂
* You can also scan the QR code below, invite the author to have a cup of milk tea 🧋

<br>

<img src="https://gitee.com/iotjh/res/raw/master/weapp/PayCode.jpg" width="400" height="400">

<br>

## Preview

Some page effects are as follows:


<br>
<br>
<br>

<img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Login.gif" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/wx/wx_home.jpg" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/wx/wx_contacts.jpg" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/wx/wx_discover.jpg" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/wx/wx_mine.jpg" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Other/BaseAppBar.gif" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Alert/JhToast.gif" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Alert/BootomSheet.gif" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Alert/JhDialog.gif" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Alert/JhCascadePicker.gif" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Alert/JhCascadeTreePicker1.gif" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Alert/JhCascadeTreePicker2.gif" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Alert/Alert_iOS.gif" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Other/PhotoSelect.gif" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Form/JhLoginTextField.jpg" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Form/JhTextField.jpg" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Form/JhFormInputCell.jpg" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Form/JhFormSelectCell.jpg" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Form/JhSetCell.jpg" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/topTabBar/JhTopTabBar.jpg" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/topTabBar/JhTopTabBar_redDot.jpg" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/search/navSearch_3.jpg" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/search/SearchTest4Page.gif" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Other/TagCloudWidget.gif" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Other/TagCloudWidget2.gif" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/eChart.gif" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Alert/JhPopMenus1.jpg" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Alert/JhPopMenus2.jpg" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Alert/JhPopMenus3.jpg" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Other/img_pull_down_big.gif" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Other/img_pull_down_big2.gif" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Other/img_pull_down_big.gif" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/wx/home/wx_motion_top.gif" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/wx/discover/wx_friendsCircle.gif" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/theme.gif" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Other/JhAssetPicker.gif" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Base/BaseRefreshView.gif" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Base/BaseRefreshViewShimmer.gif" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Base/BaseRefreshViewFixed.gif" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/Base/BaseRefreshViewFollow.gif" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/components/JhSlideMenuView.jpg" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/components/JhSwiperView.gif" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/topTabBar/PersonalCenterPage2.gif" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/topTabBar/PersonalCenterPage3.gif" width="208" height="404"><img src="https://gitee.com/iotjh/Picture/raw/master/FlutterDemoScreenShot/topTabBar/PersonalCenterPage5.gif" width="208" height="404">







<br>
<br>
<br>

## WeChat UI：

| ![](./ScreenShot/wx/wx_home.jpg)    |  ![](./ScreenShot/wx/wx_contacts.jpg)    | ![](./ScreenShot/wx/wx_discover.jpg)   |  ![](./ScreenShot/wx/wx_mine.jpg)   |
| :--------------------------------: | :---------------------------------: | :-------------------------------: | :-------------------------------:  |
| ![](./ScreenShot/wx/home/wx_motion.jpg)            |  ![](./ScreenShot/wx/home/wx_motion_top.gif)        | ![](./ScreenShot/wx/home/wx_subscribeNum.jpg)    |  ![](./ScreenShot/wx/home/wx_subscribeNumList.jpg)       |
|  ![](./ScreenShot/wx/home/wx_qqMessage.jpg)   |  ![](./ScreenShot/wx/contacts/wx_addFriend.jpg)    | ![](./ScreenShot/wx/contacts/wx_userInfo.jpg)          |  ![](./ScreenShot/wx/contacts/wx_newFriend.jpg)               | 
| ![](./ScreenShot/wx/contacts/wx_infoSet.jpg)       |  ![](./ScreenShot/wx/mine/wx_personInfo.jpg)         | ![](./ScreenShot/wx/mine/wx_pay.jpg)                        |  ![](./ScreenShot/wx/mine/wx_payManager.jpg)                  |
| ![](./ScreenShot/wx/discover/wx_friendsCircle.gif)    |  ![](./)   | ![](./)  | ![](./)  |

<br>

## <a id="Licenses"></a> Licenses
<details open id="Licenses">
  <summary><strong>Licenses</strong></summary>

```

BSD 2-Clause License

Copyright (c) 2020, iotjin
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

```

</details>