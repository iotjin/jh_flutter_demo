## [Flutter 常用命令](https://www.cnblogs.com/cag2050/p/10542771.html)

| Flutter 常用命令 | 说明 |
| --- | --- |
| flutter | 列出所有的命令 |
| flutter help <command></command> | 查看具体命令的帮助信息 |
| flutter doctor | 查看是否还需要安装其它依赖（它将自动检查计算机内的flutter的工具链的状态，并给出建议和提示） |
| flutter doctor -v | 查看详细信息 |
| flutter channel | 查看 Flutter SDK 所有分支 |
| flutter channel stable | 切换分支 |
| flutter upgrade | 升级 Flutter SDK（此命令会同时更新 Flutter SDK 和你的 Flutter 项目依赖包） |
| flutter packages get | 获取项目所有的依赖包（只更新项目依赖包，不包括 Flutter SDK） |
| flutter packages upgrade | 获取项目所有依赖包的最新版本（只更新项目依赖包，不包括 Flutter SDK） |
| flutter analyze | 分析项目代码 |
| flutter build apk |  |
| flutter build iOS |  |
| flutter run --release| 发布版本调试，发布版本测试需要连接真机方能调试。 |

# Android 打包配置注意事项：

## 为什么 APK 体积变大了？

Flutter 3.35+ 起，Gradle 插件默认会把 **armeabi-v7a、arm64-v8a、x86_64** 三套 native 库打进同一个 APK（Fat APK），体积约为单架构的 2～3 倍。
**推荐**使用 `--split-per-abi` 按架构分包；真机分发一般只需 `app-arm64-v8a-release.apk` 即可。

## CPU 架构（ABI）说明

| ABI | 说明 | 典型设备 |
| --- | --- | --- |
| **arm64-v8a** | 64 位 ARM，2014 年后主流 Android 真机 | 目前绝大多数在售手机（推荐默认只打此架构） |
| **armeabi-v7a** | 32 位 ARM，兼容较老 32 位手机 | 老旧或低端 32 位设备 |
| **x86_64** | 64 位 x86 | Android 模拟器、少数 x86 平板/设备 |
| **armeabi** | 已废弃的 32 位 ARM | Android 5.0 之前极老设备，现网基本可忽略 |
| **x86** | 32 位 x86 | 老旧模拟器，现网基本可忽略 |

注释里的 `'armeabi-v7a', 'arm64-v8a', 'x86_64'` 表示同时打进三种架构（Fat APK）；`'armeabi','x86'` 为更早期架构，一般不再使用。

## 场景 A：直接发 APK（官网、内测、侧载）

**按架构拆成多个 APK（推荐）** — 一次打出各架构小包，体积小，可按设备分发；真机一般发 `app-arm64-v8a-release.apk`：
```
flutter build apk --release --split-per-abi
```
输出示例：`app-armeabi-v7a-release.apk`、`app-arm64-v8a-release.apk`、`app-x86_64-release.apk`（路径：`build/app/outputs/flutter-apk/`）。


**按指定架构打单包**（输出均为 `build/app/outputs/flutter-apk/app-release.apk`）：

| 架构 | 命令 | 适用设备 |
| --- | --- | --- |
| armeabi-v7a | `flutter build apk --release --target-platform=android-arm` | 较老 32 位 ARM 真机 |
| arm64-v8a（推荐） | `flutter build apk --release --target-platform=android-arm64` | 目前绝大多数 Android 真机 |
| x86_64 | `flutter build apk --release --target-platform=android-x64` | Android 模拟器、少数 x86 设备 |

```
# 只打 armeabi-v7a
flutter build apk --release --target-platform=android-arm

# 只打 arm64-v8a（推荐）
flutter build apk --release --target-platform=android-arm64

# 只打 x86_64
flutter build apk --release --target-platform=android-x64
```

**默认 Fat APK**（不推荐，体积最大；Flutter 3.35+ 默认打入 armeabi-v7a + arm64-v8a + x86_64）：
```
flutter build apk --release
```
输出：`build/app/outputs/flutter-apk/app-release.apk`

## 场景 B：上架 Google Play

商店会按用户设备自动下发对应架构，应打 App Bundle：
```
flutter build appbundle --release
```
输出：`build/app/outputs/bundle/release/app-release.aab`

## 场景 C：Gradle 固定架构

若希望**不加命令行参数**、每次 `flutter build apk --release` 都固定某一架构，
可在 `android/app/build.gradle` 的 `release` 中配置（Flutter 3.35+ 必须先 `clear` 再添加，否则会被插件默认值覆盖）：

```
ndk {
    abiFilters.clear()
    abiFilters.add("arm64-v8a")   // 或 "armeabi-v7a" / "x86_64"
}
```

配置后执行 `flutter build apk --release` 即只打对应架构。

与 `--target-platform`、`--split-per-abi` 同时使用时，以 Gradle `abiFilters` 为准；
例如只配 arm64 时，`--split-per-abi` 也只会产出 arm64 分包。

若仅偶尔需要指定架构，优先使用场景 A 的 `--target-platform` 命令，更灵活。

## 体积分析（可选）

```
flutter build apk --release --analyze-size
```

---

# web端打包注意事项：

- 1、先清空历史数据：
```
flutter clean
flutter pub get
```
- 2、查看是否支持web端：
```
flutter config -h
```
不支持运行
```
flutter config --enable-web
```
- 3、为现有项目添加 Web 支持
```
// 只添加web端
flutter create --platforms=web .
// 其他平台
flutter create --platforms=windows,macos,linux .
// 默认
flutter create .
```
- 4、编译
```
// 编译时自动修改base标签
flutter build web --web-renderer html --base-href=/jh_flutter_demo/

// 打开速度一般,兼容性好
flutter build web
flutter build web --release

// 打开速度快，兼容性好
flutter build web --web-renderer html

// 打开速度慢，对于复杂的页面兼容性好
flutter build web --web-renderer canvaskit
```
注：
>找到了index.html,用浏览器打开一片空白
这个属于正常现象，不像正常的前端web，点击index.html就能访问。
在flutter里面是不能直接访问的，要放到容器里面去才能访问，如：GitHub pages、tomcat等

```
ListView({
  Axis scrollDirection = Axis.vertical, // 列表的滚动方向，可选值：Axis的horizontal、vertical
  ScrollController controller, // 控制器，与列表滚动相关，比如监听列表的滚动事件
  ScrollPhysics physics, // 列表滚动至边缘后继续拖动的物理效果，Android与iOS效果不同：Android = 波纹状（ClampingScrollPhysics），而iOS = 回弹的弹性效果（BouncingScrollPhysics）。若想不同的平台上呈现各自的效果可使用AlwaysScrollableScrollPhysics，它会根据不同平台自动选用各自的物理效果。若想禁用在边缘的拖动效果，可使用NeverScrollableScrollPhysics
  bool shrinkWrap = false, // 决定列表的长度是否仅包裹其内容的长度。当ListView嵌在一个无限长的容器组件中时，shrinkWrap必须为true，否则Flutter会给出警告；
  EdgeInsetsGeometry padding, // 列表内边距
  this.itemExtent, // 子元素长度。当列表中的每一项长度是固定的情况下可以指定该值，有助于提高列表的性能（因为它可以帮助ListView在未实际渲染子元素之前就计算出每一项元素的位置）；
  double cacheExtent, // 预渲染区域长度，ListView会在其可视区域的两边留一个cacheExtent长度的区域作为预渲染区域（对于ListView.build或ListView.separated构造函数创建的列表，不在可视区域和预渲染区域内的子元素不会被创建或会被销毁）；
  List<Widget> children = const <Widget>[], // 容纳子元素的组件数组
})

//防止当列表长度没有充满时回弹失效
physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),

```