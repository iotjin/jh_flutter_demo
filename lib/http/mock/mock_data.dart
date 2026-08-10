///  mock_data.dart
///
///  description: 本地 Mock 数据

import 'dart:math';
import '../apis.dart';

class MockData {
  static final Random _random = Random();

  static const List<String> _names = ['刘一一一', '陈二儿', '张三儿', '李四', '王五', '赵六六', '孙七', '周八', '吴九九', '郑十'];
  static const List<String> _usernames = ['admin0', 'admin1', 'admin2'];
  static const List<String> _states = ['0', '1', '2', '3', '4', '5'];
  static const List<String> _sexes = ['0', '1'];
  static const List<String> _provinces = ['北京', '上海', '广东', '浙江', '江苏', '四川'];
  static const List<String> _cities = ['朝阳区', '浦东新区', '天河区', '西湖区', '鼓楼区', '武侯区'];
  static const List<String> _imgSizes = [
    '300/300',
    '400/400',
    '400/500',
    '400/600',
    '500/500',
    '600/400',
    '600/500',
    '700/800',
    '700/900',
    '800/400',
    '800/500',
    '800/600',
    '900/600',
    '750/1334',
    '1134/750',
    '1080/1920',
    '1920/1080',
  ];
  static const String _avatar = 'https://gitee.com/iotjh/Picture/raw/master/lufei.png';

  /// 按 path 解析 Mock；未配置返回 null（走真实网络）
  static Map<String, dynamic>? resolve(String path, {String method = 'GET', dynamic data, Map<String, dynamic>? queryParameters}) {
    final params = _mergeParams(method, data, queryParameters);

    if (path == APIs.login) {
      return _login(params);
    }
    if (path == APIs.refreshToken) {
      return _refreshToken();
    }
    if (path == APIs.getPage) {
      return _ok(_pageList(params, defaultMaxCount: 50));
    }
    if (path == APIs.getGroupPage) {
      return _ok(_groupPageList(params, defaultMaxCount: 50));
    }
    if (path == APIs.getFriendsCircleList) {
      return _ok(_momentsList(params, defaultMaxCount: 300));
    }
    if (path == APIs.getSimpleDict) {
      return _ok(_dictItem(0));
    }
    if (path == APIs.getSimpleDictList) {
      return _ok(List.generate(20, _dictItem));
    }
    return null;
  }

  static Map<String, dynamic> _mergeParams(String method, dynamic data, Map<String, dynamic>? queryParameters) {
    final Map<String, dynamic> params = {};
    if (queryParameters != null) {
      params.addAll(queryParameters);
    }
    // POST 以 body 为准
    if (method.toUpperCase() == 'POST' || method.toUpperCase() == 'PUT' || method.toUpperCase() == 'PATCH') {
      if (data is Map) {
        data.forEach((key, value) {
          params[key.toString()] = value;
        });
      }
    }
    return params;
  }

  static Map<String, dynamic> _ok(dynamic data, {String msg = '返回的信息'}) {
    return {'code': 200, 'suc': true, 'msg': msg, 'data': data};
  }

  static Map<String, dynamic> _login(Map<String, dynamic> params) {
    final userName = '${params['userName'] ?? ''}';
    final pwd = '${params['pwd'] ?? ''}';
    if (userName == 'jin' && pwd == '123456') {
      return {
        'code': 200,
        'suc': true,
        'msg': '登录成功',
        'data': {'userID': '1', 'userName': 'jin', 'phone': '123456789101', 'pwd': '123456', 'token': 'zheshitoken', 'avatarUrl': _avatar},
      };
    }
    return {'code': -1, 'suc': false, 'msg': '用户名或密码错误', 'data': ''};
  }

  static Map<String, dynamic> _refreshToken() {
    return _ok({'accessToken': 'zheshitoken', 'refreshToken': 'zheshitoken_refresh'}, msg: 'ok');
  }

  static List<Map<String, dynamic>> _pageList(Map<String, dynamic> params, {required int defaultMaxCount}) {
    final pageInfo = _parsePage(params, defaultMaxCount: defaultMaxCount);
    if (pageInfo == null) {
      return [];
    }
    final skip = pageInfo.skip;
    final limit = pageInfo.limit;
    final maxCount = pageInfo.maxCount;
    if (skip >= maxCount) {
      return [];
    }

    final List<Map<String, dynamic>> data = [];
    final end = min(skip + limit, maxCount);
    for (var i = skip; i < end; i++) {
      data.add(_pageItem(i));
    }
    return data;
  }

  static List<Map<String, dynamic>> _groupPageList(Map<String, dynamic> params, {required int defaultMaxCount}) {
    final pageInfo = _parsePage(params, defaultMaxCount: defaultMaxCount);
    if (pageInfo == null) {
      return [];
    }
    final skip = pageInfo.skip;
    final limit = pageInfo.limit;
    final maxCount = pageInfo.maxCount;
    if (skip >= maxCount) {
      return [];
    }

    final List<Map<String, dynamic>> data = [];
    final end = min(skip + limit, maxCount);
    for (var i = skip; i < end; i++) {
      data.add(_groupItem(i));
    }
    return data;
  }

  static List<Map<String, dynamic>> _momentsList(Map<String, dynamic> params, {required int defaultMaxCount}) {
    final pageInfo = _parsePage(params, defaultMaxCount: defaultMaxCount);
    if (pageInfo == null) {
      return [];
    }
    final skip = pageInfo.skip;
    final limit = pageInfo.limit;
    final maxCount = pageInfo.maxCount;
    if (skip >= maxCount) {
      return [];
    }

    final List<Map<String, dynamic>> data = [];
    final end = min(skip + limit, maxCount);
    for (var i = skip; i < end; i++) {
      data.add(_momentItem(i));
    }
    return data;
  }

  static _PageInfo? _parsePage(Map<String, dynamic> params, {required int defaultMaxCount}) {
    final noData = params['noData'];
    if (noData == true || '$noData' == 'true') {
      return null;
    }

    final page = int.tryParse('${params['page']}') ?? 0;
    final limit = int.tryParse('${params['limit'] ?? 10}') ?? 10;
    final maxCount = int.tryParse('${params['maxCount'] ?? defaultMaxCount}') ?? defaultMaxCount;
    return _PageInfo(skip: page * limit, limit: limit, maxCount: maxCount);
  }

  static Map<String, dynamic> _pageItem(int i) {
    final item = _dictItem(i);
    // Flutter HttpPageTestModel 读取 ID（大写，String?）
    item['ID'] = '$i';
    item['id'] = '$i';
    item['place'] = '${_pick(_cities)} $i';
    item['content'] = '这是内容' * (_random.nextInt(8) + 1);
    item['imageUrl'] = _avatar;
    return item;
  }

  static Map<String, dynamic> _groupItem(int i) {
    final groupNum = _random.nextInt(51) + 50; // 50-100
    final childCount = _random.nextInt(3) + 1; // 1-3
    final List<Map<String, dynamic>> children = [];
    for (var j = 0; j < childCount; j++) {
      final child = _dictItem(i * 10 + j);
      child['num'] = _random.nextInt(50) + 1;
      child['name'] = _pick(_names);
      children.add(child);
    }

    return {
      'id': '$i',
      'groupTitle': 'groupTitle$i',
      'groupText': '这是文字$i',
      'groupState': _pick(_states),
      'groupMoney': _float(0, 1000),
      'groupNum': groupNum,
      'groupBool': _random.nextBool(),
      'groupColor': _color(),
      'groupDateTime': _dateTime(),
      'groupPhone': _phone(),
      'groupContent': '这是内容' * (_random.nextInt(8) + 1),
      'groupImageUrl': _avatar,
      'data': children,
    };
  }

  static Map<String, dynamic> _momentItem(int i) {
    final imgCount = _random.nextInt(10); // 0-9
    final List<String> images = [];
    for (var k = 0; k < imgCount; k++) {
      final size = _pick(_imgSizes);
      final seed = _random.nextInt(1000000000) + 100;
      images.add('https://picsum.photos/$size?$seed');
    }

    return {
      'id': i,
      'name': _cname(),
      'color': _color(),
      'time': _dateTime(),
      'content': '这是内容' * (_random.nextInt(18) + 1),
      'images': images,
      'name2': '${_cname()}$i',
      'title': 'title$i',
      'text': '这是文字$i',
      'state': _pick(_states),
      'money': _float(0, 1000),
      'bool': _random.nextBool(),
      'email': 'user$i@163.com',
      'province': _pick(_provinces),
      'city': _pick(_cities),
      'area': _pick(_cities),
      'age': _random.nextInt(100) + 1,
      'img': _avatar,
      'IDCard': '11010119900101${(1000 + i).toString().padLeft(4, '0')}',
      'sex': _pick(_sexes),
      'dateTime': _dateTime(),
      'time2': '12:00:00',
      'place': '${_pick(_cities)} $i',
      'phone': _phone(),
      'imageUrl': _avatar,
    };
  }

  static Map<String, dynamic> _dictItem(int i) {
    return {
      'id': '$i',
      'ID': '$i',
      'title': 'title$i',
      'text': '这是文字$i',
      'username': _pick(_usernames),
      'name': _pick(_names),
      'name2': '${_cname()}$i',
      'state': _pick(_states),
      'money': _float(0, 1000),
      'bool': _random.nextBool(),
      'time': '12:00:00',
      'email': 'user$i@163.com',
      'province': _pick(_provinces),
      'city': _pick(_cities),
      'area': _pick(_cities),
      'age': _random.nextInt(100) + 1,
      'color': _color(),
      'img': _avatar,
      'IDCard': '11010119900101${(1000 + i).toString().padLeft(4, '0')}',
      'sex': _pick(_sexes),
      'dateTime': _dateTime(),
      'place': _pick(_cities),
      'phone': _phone(),
      'content': '这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容',
      'imageUrl': _avatar,
    };
  }

  static T _pick<T>(List<T> list) => list[_random.nextInt(list.length)];

  static String _cname() => _pick(_names);

  static double _float(num min, num max) {
    return double.parse((min + _random.nextDouble() * (max - min)).toStringAsFixed(2));
  }

  static String _color() {
    final value = _random.nextInt(0xFFFFFF);
    return '#${value.toRadixString(16).padLeft(6, '0')}';
  }

  static String _phone() {
    const prefixes = ['13', '18', '17'];
    final prefix = _pick(prefixes);
    final suffix = List.generate(9, (_) => _random.nextInt(10)).join();
    return '$prefix$suffix';
  }

  static String _dateTime() {
    final now = DateTime.now().subtract(Duration(minutes: _random.nextInt(10000)));
    String two(int n) => n.toString().padLeft(2, '0');
    return '${now.year}/${two(now.month)}/${two(now.day)} ${two(now.hour)}:${two(now.minute)}:${two(now.second)}';
  }
}

class _PageInfo {
  _PageInfo({required this.skip, required this.limit, required this.maxCount});

  final int skip;
  final int limit;
  final int maxCount;
}
