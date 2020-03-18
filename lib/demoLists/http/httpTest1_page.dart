import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
//import 'package:dio_http_cache/dio_http_cache.dart';

class HttpTest1Page extends StatefulWidget {
  @override
  _HttpTest1PageState createState() => _HttpTest1PageState();
}

class _HttpTest1PageState extends State<HttpTest1Page> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

//    postRequest();
    postRequest2();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
          title:Text("HttpTest1",style:TextStyle (color: Colors.white))
      ),
      body: Container(),
    );
  }
}

void postRequest() async {
  var url = "https://www.fastmock.site/mock/664dbd2c65e775cd90117b19acaf488f/root/getSimpleArrDic";
  var dio = new Dio();
  var response = await dio.post(url, data:{"id":12,"name":"wendu"});
  var result = response.data.toString();
//  print("返回数据： "+result);
    print(response.data["message"]);

}

void postRequest2()async{
  var url = "https://www.fastmock.site/mock/664dbd2c65e775cd90117b19acaf488f/root/getSimpleArrDic";
  var response = await Dio().post(url);
  print(response.data["message"]);

}