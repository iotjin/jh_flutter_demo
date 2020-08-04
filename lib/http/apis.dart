/**
 *  apis.dart
 *
 *  Created by iotjin on 2020/07/07.
 *  description:  api 管理
 */

class APIs {
  //url 前缀
  static const String apiPrefix =
      "https://www.fastmock.site/mock/1010b262a743f0b06c565c7a31ee9739/root";

  //登录接口
  static String login = "/login";
  //获取分页数据
  static String getPage = "/getPageArrDic";
  //获取分页分组数据
  static String getGroupPage = "/getGroupPageArrDic";

}

//接口类型
enum APIType {
  Login,
  GetPage,
}
//使用：APITypeValues[APIType.Login]
const APITypeValues = {
  APIType.Login: "/login",
  APIType.GetPage: "/getPageArrDic"
};
