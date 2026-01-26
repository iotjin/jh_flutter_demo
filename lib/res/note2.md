# Flutter 常用命令速查表

## 🔧 基础 & 环境

| 命令 | 说明                 |
| --- |--------------------|
| flutter | 列出所有 Flutter 命令    |
| flutter help \<command> | 查看指定命令的帮助信息        |
| flutter doctor | ⭐ 检查 Flutter 环境    |
| flutter doctor -v | ⭐ 查看详细环境信息         |
| flutter config | 查看 / 设置 Flutter 配置 |
| flutter precache | 预下载 Flutter 依赖     |
| flutter downgrade | 回退到上一个 Flutter 版本  |

---

## 🌿 Channel & SDK 管理

| 命令 | 说明 |
| --- | --- |
| flutter channel | 查看所有分支 |
| flutter channel stable | 切换到 stable 分支 |
| flutter channel beta | 切换到 beta 分支 |
| flutter channel master | 切换到 master |
| flutter upgrade | 升级 Flutter SDK |
| flutter upgrade --force | 强制升级 Flutter SDK |
| flutter version | 查看 Flutter 版本信息 |

---

## 📦 依赖管理（Pub）

> ✅ 推荐使用 `flutter pub`  
> ❌ `flutter packages` 为旧写法

| 命令 | 说明                    |
| --- |-----------------------|
| flutter pub get | ⭐ 获取项目依赖              |
| flutter pub upgrade | ⭐ 升级依赖（不跨主版本）到最新的兼容版本 |
| flutter pub upgrade --major-versions | 升级到最新主版本              |
| flutter pub outdated | ⭐ 查看可升级的依赖            |
| flutter pub cache repair | 修复 pub 缓存             |
| flutter pub cache clean | 清空 pub 缓存             |

---

## 🧹 清理 & 构建准备（排坑必备）

| 命令 | 说明        |
| --- |-----------|
| flutter clean | ⭐ 清理构建产物  |
| flutter create . | 重新生成平台配置  |
| flutter gen-l10n | 生成国际化文件   |
| flutter pub run build_runner build | 生成代码（一次性） |
| flutter pub run build_runner watch | 监听并生成代码   |

---

## ▶️ 运行 & 调试

| 命令 | 说明 |
| --- | --- |
| flutter run | 运行到默认设备 |
| flutter run -d all | 运行到所有设备 |
| flutter run -d chrome | 运行到 Web |
| flutter run --debug | Debug 模式（默认） |
| flutter run --profile | Profile 模式 |
| flutter run --release | Release 模式 |
| flutter attach | 附加到已运行的 Flutter 应用 |
| flutter logs | 查看设备日志 |

---

## 🏗️ 构建（打包）

| 命令 | 说明               |
| --- |------------------|
| flutter build apk | ⭐ 构建 Android APK |
| flutter build appbundle | 构建 Android AAB   |
| flutter build ios | 构建 iOS（需 macOS）  |
| flutter build web | 构建 Web           |
| flutter build windows | 构建 Windows 桌面    |
| flutter build macos | 构建 macOS         |
| flutter build linux | 构建 Linux         |

---

## 🧪 测试 & 质量

| 命令 | 说明 |
| --- | --- |
| flutter test | 运行单元测试 |
| flutter test --coverage | 生成测试覆盖率 |
| flutter analyze | 静态代码分析 |
| dart format . | 格式化代码 |
| dart fix --apply | 自动修复问题 |

---

## 📱 设备 & 模拟器

| 命令 | 说明 |
| --- | --- |
| flutter devices | 查看已连接设备 |
| flutter emulators | 查看模拟器列表 |
| flutter emulators --launch \<id> | 启动模拟器 |
| flutter install | 安装应用到设备 |
| flutter screenshot | 截图当前界面 |

---

## 🧠 高级 & 排错（进阶）

| 命令 | 说明 |
| --- | --- |
| flutter run --verbose | 详细运行日志 |
| flutter build apk --verbose | 构建详细日志 |
| flutter logs --verbose | 详细设备日志 |

---

## ⭐ 常用命令

```bash
flutter clean
flutter pub get
flutter doctor -v
flutter pub cache repair
flutter run --verbose
