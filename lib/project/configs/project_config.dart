/**
 *  project_config.dart
 *
 *  Created by iotjin on 2020/05/07.
 *  description:  项目的一些全局配置项，数据持久化使用的key
 */

export 'apis.dart';
export 'colors.dart';
export 'dimens.dart';
export 'gaps.dart';
export 'strings.dart';
export 'styles.dart';

export 'package:jh_flutter_demo/jh_common/utils/jh_screen_utils.dart';
export 'package:jh_flutter_demo/http/log_utils.dart';
export 'package:jh_flutter_demo/base_appbar.dart';
export 'package:jh_flutter_demo/project/routes/navigator_utils.dart';

const bool isDark = false;

double wx_cellH = 55.0;
double wx_rowSpace = 6.0;

/********************************* 数据存储 相关 ********************************/

/* 保存本地的用户model */
const kUserDefault_UserInfo = 'UserInfo';
/* 上次版本号 */
const kUserDefault_LastVersion = 'kUserDefault_LastVersion';
