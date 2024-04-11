///  intl_config.dart
///
///  Created by iotjin on 2024/03/15.
///  description:  国际化配置

import 'package:get/get.dart';
import 'intl_zh.dart';
import 'intl_en.dart';
import '/project/configs/strings.dart';

class LangTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'zh_CN': intlZhCn,
        'en_US': intlEnUs,
      };
}

/// 国际化的key
class IntlKeys {
  // test
  static const String test = 'test';
  static const String title = '标题';

  static const String loading = '加载中...';

  // main
  static const String oneTabTitle = KStrings.oneTabTitle;
  static const String twoTabTitle = KStrings.twoTabTitle;
  static const String threeTabTitle = KStrings.threeTabTitle;
  static const String fourTabTitle = KStrings.fourTabTitle;

  // login
  static const String loginTitle = '登录';
  static const String loginHintUser = '请输入用户名';
  static const String loginHintPwd = '请输入密码';
  static const String loginBtn = '登 录';
  static const String loginRegisterText = '注册';
  static const String loginLoading = '正在登录...';
  static const String loginMsgSuc = '登录成功';
  static const String loginMsgFail = '用户名或密码错误';

  // code page
  static const String loginCode = '验证码登录';
  static const String loginHintPhone = '请输入手机号';
  static const String loginHintCode = '请输入验证码';
  static const String loginGetCode = '获取验证码';
  static const String codeResendAfter = '重新获取';

  // find pwd
  static const String loginForgotPwd = '忘记密码';
  static const String resetPwd = '重置密码';
  static const String loginUserText = '用户名';
  static const String loginPwdText = '密码';
  static const String resetBtn = '重 置';
  static const String resetLoading = '正在重置...';

  // register
  static const String registerTitle = '账号注册';
  static const String loginPhoneText = '手机号';
  static const String loginCodeText = '验证码';
  static const String registerBtn = '注 册';
  static const String registerAgreement1 = '注册即视为同意';
  static const String registerAgreement2 = '《xxx服务协议》';
  static const String registerMsgAgreement = '点击服务协议';
  static const String registerLoading = '正在注册...';

  // home
  static const String homeDemoList = 'Demo 列表';
  static const String homeDemoListDescribe = '点击跳转demo列表';
  static const String homeWeRun = '微信运动';
  static const String homeWeRunDescribe = '[应用消息]';
  static const String homeSubscriptions = '订阅号消息';
  static const String homeSubscriptionsDescribe = '新闻联播开始啦';
  static const String homeQQMail = 'QQ邮箱提醒';
  static const String homeQQMailDescribe = '您有一封新的邮件，请前往查收';
  static const String homeWeTeam = '微信团队';
  static const String homeWeTeamDescribe = '安全登录提醒';
  static const String homeMarkAsUnread = '标为未读';
  static const String homeUnfollow = '不再关注';
  static const String homeDelete = '删除';
  static const String homeMsgMarkAsUnread = '点击标为未读';
  static const String homeMsgUnfollow = '点击不再关注';
  static const String homeMsgDelete = '点击删除';

  // contacts
  static const String contactsNewFriends = '新的朋友';
  static const String contactsGroupChats = '群聊';
  static const String contactsTags = '标签';
  static const String contactsOfficialAccounts = '公众号';
  static const String contactsStarred = '星标朋友';
  static const String contactsSearch = '搜索';
  static const String contactsRemarks = '备注';
  static const String contactsMsgRemarks = '点击备注';

  // discover
  static const String discoverMoments = '朋友圈';
  static const String discoverMomentsMock = '朋友圈-假数据';
  static const String discoverChannels = '视频号';
  static const String discoverScan = '扫一扫';
  static const String discoverShake = '摇一摇';
  static const String discoverTopStories = '看一看';
  static const String discoverSearch = '搜一搜';
  static const String discoverNearby = '附近的人';
  static const String discoverShopping = '购物';
  static const String discoverGames = '游戏';
  static const String discoverMiniPrograms = '小程序';

  // me
  static const String meWeiXinID = '微信号';
  static const String meServices = '服务';
  static const String meFavorites = '收藏';
  static const String meAlbum = '相册';
  static const String meCardsOffers = '卡包';
  static const String meStickerGallery = '表情';
  static const String meSettings = '设置';
  static const String meCheckUpdate = '检查更新';
  static const String meNewVersion = '有新版本';

  static const String language = '多语言';
}
