///  apis.dart
///
///  Created by iotjin on 2020/07/07.
///  description:  api管理

class APIs {
  /// url 前缀
  static const String apiPrefix = 'https://console-mock.apipost.cn/mock/e7a66e3e-1b07-4902-9beb-366dd35ae67d/v1/api';

  /// 登录接口
  static const String login = '/mock/login';

  /// 刷新token
  static const String refreshToken = '/mock/refreshToken';

  /// 获取分页数据
  static const String getPage = '/mock/pages';

  /// 获取分页分组数据
  static const String getGroupPage = '/mock/groupPages';

  /// 获取固定数据
  static const String getSimpleDictList = '/mock/simpleDictList';

  /// 获取固定数据
  static const String getSimpleDict = '/mock/dict';

  /// 微信朋友圈
  static const String getFriendsCircleList = '/mock/wx/moments';
}
