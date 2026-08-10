///  apis.dart
///
///  Created by iotjin on 2020/07/07.
///  description:  api管理


///  本地 Mock 开关（默认开启）
///  kEnableLocalMock 为 true 时，命中指定 path的接口 由 MockInterceptor 返回假数据。
///  需要请求真实接口时，将 kEnableLocalMock 改为 false。
const bool kEnableLocalMock = true;

class APIs {
  /// url 前缀（关闭本地 Mock 后生效，将请求真实接口）
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
