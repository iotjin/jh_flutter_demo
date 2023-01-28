///  wx_pay_cell.dart
///
///  Created by iotjin on 2020/08/27.
///  description: 微信支付 cell

import 'package:flutter/material.dart';
import '/project/configs/project_config.dart';
import '../models/wx_pay_model.dart';

class WxPayCell extends StatelessWidget {
  const WxPayCell({
    Key? key,
    required this.model,
    this.onClickCell,
  }) : super(key: key);

  final WxPayModel model;
  final Function(dynamic model)? onClickCell;

  @override
  Widget build(BuildContext context) {
    return _cardView();
  }

  Widget _cardView() {
    return Card(
      margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
      // 设置圆角
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      // 普通的边
      // shape: Border.all(color: Colors.yellow, width: 5.0),
      // 抗锯齿
      clipBehavior: Clip.antiAlias,
      // 阴影大小
      elevation: 3,
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(15),
            width: double.infinity,
            child: Text(model.title.jhNullSafe),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            // 可以直接指定每行（列）显示多少个Item
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // 一行的Widget数量
              crossAxisSpacing: 0.5, // 水平间距
              mainAxisSpacing: 0.5, // 垂直间距
              childAspectRatio: 1.0, // 子Widget宽高比例
            ),
            // GridView内边距
            padding: const EdgeInsets.all(0.0),
            itemCount: model.funcList!.length,
            itemBuilder: (context, index) {
              return item(model.funcList![index]);
            },
          )
        ],
      ),
    );
  }

  Widget item(FuncList funcModel) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1.0),
          border: Border.all(color: Colors.grey.withOpacity(0.3), width: 0.5), //边框
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(Icons.card_membership),
            const SizedBox(height: 10),
            Text(funcModel.text.jhNullSafe, style: const TextStyle(color: Color(0xFF666666), fontSize: 13)),
          ],
        ),
      ),
      onTap: () => onClickCell?.call(funcModel.toJson()),
    );
  }
}
