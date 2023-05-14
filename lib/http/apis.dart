///  apis.dart
///
///  Created by iotjin on 2020/07/07.
///  description:  api管理

class APIs {
  /// url 前缀
  static const String apiPrefix = 'https://www.fastmock.site/mock/1010b262a743f0b06c565c7a31ee9739/root';

  /// 登录接口
  static const String login = '/login';

  /// 刷新token
  static const String refreshToken = '/refreshToken';

  /// 获取分页数据
  static const String getPage = '/mock/pages';

  /// 获取分页分组数据
  static const String getGroupPage = '/mock/groupPages';

  /// 获取固定数据
  static const String getSimpleArrDic = '/getSimpleArrDic';

  /// 微信朋友圈
  static const String getFriendsCircleList = '/mock/wx/friendsCircle';
}
