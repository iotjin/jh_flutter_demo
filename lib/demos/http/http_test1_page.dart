import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
//import 'package:dio_http_cache/dio_http_cache.dart';
import 'dart:io';
import 'dart:convert';

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

//    postRequest3();

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
  var url = "https://www.fastmock.site/mock/1010b262a743f0b06c565c7a31ee9739/root/getSimpleArrDic";
  var dio = new Dio();
  var response = await dio.post(url, data:{"id":12,"name":"wendu"});
  var result = response.data.toString();
   print("返回数据： "+result);
   print(response.data["msg"]);

}

void postRequest2()async{
  var url = "https://www.fastmock.site/mock/1010b262a743f0b06c565c7a31ee9739/root/getSimpleArrDic";
  var response = await Dio().post(url);
  print("返回数据： "+response.data.toString());
  print(response.data["msg"]);

}

void postRequest3()async{

  print("response----");
//      var url = "https://itunes.apple.com/lookup?id=id414478124";
  var url = "https://itunes.apple.com/cn/lookup?id=414478124";
  Options options = Options(headers: {HttpHeaders.acceptHeader:"Content-Type:application/x-www-form-urlencoded"});

  var response = await Dio().post(
      url,
      options: options);

  print("results---");
//  print(response.toString());
//  print('--${response.data.trim()}--');

  Map<String, dynamic> data = json.decode(response.data.trim());

  print('results##### ${data['results']}');

  print('version#####, ${data['results'][0]['version']}');




}