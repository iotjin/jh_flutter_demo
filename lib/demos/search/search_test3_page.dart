import 'package:flutter/material.dart';
import '/jh_common/jh_form/jh_login_text_field.dart';
import '/project/configs/colors.dart';

class SearchTest3Page extends StatelessWidget {
  const SearchTest3Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
//      cursorColor: Colors.white, // 设置光标
          AppBar(
        backgroundColor: KColors.kThemeColor,
        titleSpacing: 15,
        automaticallyImplyLeading: false,
        // 隐藏返回箭头
        title: _searchBar(),
        actions: <Widget>[
          InkWell(
            child: const SizedBox(
              width: 50,
              height: 50,
              child: Center(
                child: Text('搜索'),
              ),
            ),
            onTap: () {},
          )
        ],
      ),
      body: ElevatedButton(
        child: const Text('返回'),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  _searchBar() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1.0), // 灰色的一层边框
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
      ),
      alignment: Alignment.center,
      height: 38,
//           padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      child: const JhLoginTextField(
        leftWidget: Icon(
          Icons.search,
          size: 30,
        ),
        hintText: '请输入搜索信息',
        isShowDeleteBtn: true,
        isDense: true,
      ),
    );
  }
}
