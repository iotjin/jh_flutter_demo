import 'package:flutter/material.dart';

import 'package:flutter_easyrefresh/delivery_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'http_page_test_model.dart';
import 'http_page_test_item.dart';
import 'package:dio/dio.dart';

//import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:jh_flutter_demo/http/http_utils.dart';

var dataArr;
var pageIndex = 0; //页数

class HttpPageTestPage extends StatefulWidget {
  @override
  _HttpPageTestPageState createState() => _HttpPageTestPageState();
}

class _HttpPageTestPageState extends State<HttpPageTestPage> {
  EasyRefreshController _controller = EasyRefreshController();

  @override
  void initState() {
    super.initState();
  }

  var _count;

//  var url =
//      "https://www.fastmock.site/mock/1010b262a743f0b06c565c7a31ee9739/root/getPageArrDic";
//  var dio = new Dio();
//  void getNewData()async{
//    pageIndex =0;
//    print("pageIndex- ${pageIndex}");
//    var response = await dio.post(url, data:{"page":pageIndex,});
//    dataArr =response.data["data"];
//    setState(() {
//      _count =dataArr.length==null? 0:dataArr.length;
//      print("最新条数"+_count.toString());
//      _controller.resetLoadState();
//    });
//  }
//  void getMoreData()async{
//    pageIndex++;
//    print("more pageIndex- ${pageIndex}");
//    var response = await dio.post(url, data:{"page":pageIndex,});
//    var moreData =response.data["data"];
//    dataArr =dataArr+moreData;
//    setState(() {
//      _count =dataArr.length==null? 0:dataArr.length;
//      print("加载更多条数"+_count.toString());
////      _controller.finishLoad(noMore: _count >= 30);
//      _controller.finishLoad();
//    });
//  }

  void getNewData() {
    pageIndex = 0;
    print("pageIndex- ${pageIndex}");
    HttpUtils.getNewPageList({"page": pageIndex}, success: (result) {
      dataArr = result['data'];
      setState(() {
        _count = dataArr.length == null ? 0 : dataArr.length;
        print("最新条数" + _count.toString());
        _controller.resetLoadState();
      });
    }, fail: (code) {});
  }

  void getMoreData() {
    pageIndex++;
    print("more pageIndex- ${pageIndex}");
//    var response = await dio.post(url, data: {
//      "page": pageIndex,
//    });
//    var moreData = response.data["data"];
//    dataArr = dataArr + moreData;
//    setState(() {
//      _count = dataArr.length == null ? 0 : dataArr.length;
//      print("加载更多条数" + _count.toString());
////      _controller.finishLoad(noMore: _count >= 30);
//      _controller.finishLoad();
//    });

    HttpUtils.getNewPageList({"page": pageIndex}, success: (result) {
      var moreData = result['data'];
      dataArr = dataArr + moreData;
      setState(() {
        _count = dataArr.length == null ? 0 : dataArr.length;
        print("加载更多条数" + _count.toString());
//      _controller.finishLoad(noMore: _count >= 30);
        _controller.finishLoad();
      });
    }, fail: (code) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('分页加载')),
        body: EasyRefresh(
            header: DeliveryHeader(),
            controller: _controller,
//            firstRefresh: false,
            firstRefresh: true,
            onRefresh: () async {
              print("下拉刷新-----");
              getNewData();
            },
            onLoad: () async {
              print("上拉加载-----");
              getMoreData();
            },
            child: cell(_count)));
  }
}

Widget cell(var dataCount) {
  if (dataCount == null) {
    return Container();
  }
  if (dataCount == 0) {
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Text("暂无数据",
          textAlign: TextAlign.center, style: TextStyle(fontSize: 18.0)),
    );
  } else {
    return ListView.separated(
      itemCount: dataCount,
      itemBuilder: (context, index) {
        /*先将字符串转成json*/
        Map<String, dynamic> json = Map<String, dynamic>.from(dataArr[index]);
        /*将Json转成实体类*/
        WorkOrderModel model = WorkOrderModel.fromJson(json);
        return HttPageTestItem(
          data: model,
          onTap: () {
            print("点击的index ${index}");
            print("点击的地点" + model.place);
          },
        );
      },
      separatorBuilder: (context, index) {
        return Divider(
          height: .5,
          indent: 15,
          endIndent: 15,
//            color: Color(0xFFDDDDDD),
          color: Colors.purple,
        );
      },
    );
  }
}
