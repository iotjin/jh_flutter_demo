import 'package:flutter/material.dart';
import '/jh_common/jh_form/jh_text_field.dart';
import '/project/configs/colors.dart';
import '/project/routes/jh_nav_utils.dart';

class SearchTest1Page extends StatelessWidget {
  const SearchTest1Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:

//      cursorColor: Colors.white, // 设置光标
          AppBar(
        backgroundColor: KColors.kThemeColor,
        automaticallyImplyLeading: false,
        titleSpacing: 15,
        title: _searchBar(context),
        actions: <Widget>[
          IconButton(
              icon:
//          ImageIcon(AssetImage('images/overview.png',),color: Colors.white,size: 30,),
                  const Icon(Icons.person_pin_circle, color: Colors.white),
              onPressed: () {}),
          IconButton(
              icon:
//              ImageIcon(AssetImage('images/more.png',),color: Colors.white,size: 30,),
                  const Icon(Icons.more_horiz, color: Colors.white),
              onPressed: () {}),
          const SizedBox(width: 5),
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

  _searchBar(context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1.0), // 灰色的一层边框
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        ),
        alignment: Alignment.center,
        height: 38,
//           padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
        child: const JhTextField(
          enabled: false,
          leftWidget: Icon(
            Icons.search,
            size: 30,
          ),
          hintText: '请输入搜索信息',
        ),
      ),
      onTap: () {
        JhNavUtils.pushNamed(context, 'SiteSearchPage');
      },
    );
  }
}
