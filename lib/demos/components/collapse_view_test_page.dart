import 'package:flutter/material.dart';
import '/jh_common/widgets/jh_collapse_view.dart';
import '/project/configs/project_config.dart';

class CollapseViewTestPage extends StatefulWidget {
  const CollapseViewTestPage({Key? key}) : super(key: key);

  @override
  State<CollapseViewTestPage> createState() => _CollapseViewTestPageState();
}

class _CollapseViewTestPageState extends State<CollapseViewTestPage> {
  var _isFold = false;
  var _isFold2 = false;
  var _isFold3 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar('JhCollapseView'),
      body: _body(),
      backgroundColor: KColors.dynamicColor(context, KColors.wxBgColor, KColors.kBgDarkColor),
    );
  }

  _body() {
    return ListView(children: [
      Column(children: [
        JhCollapseView(title: '标题', content: _testView()),
        JhCollapseView(
          title: '这是很长很长很长长很长很长很长很长很长很长很长很长很长很长的标题',
          titleStyle: TextStyle(color: Colors.white, fontSize: 13),
          arrowColor: Colors.white,
          headerColor: Color(0xFFA2BFEE),
          content: _testView(),
        ),
        JhCollapseView(
          titleWidget: _titleW(),
          titleCrossAxisAlignment: CrossAxisAlignment.start,
          arrowColor: Colors.white,
          headerColor: Color(0xFFA2BFEE),
          content: _testView(),
        ),
        JhCollapseView(
          titleWidget: _titleW2(),
          headerColor: Colors.white,
          content: _testView(),
        ),
        TextButton(
          child: Text('点击更新折叠状态'),
          onPressed: () {
            setState(() {
              _isFold = !_isFold;
            });
          },
        ),
        JhCollapseView(
          isFold: _isFold,
          title: 'isFold更新',
          content: _testView(),
          onChange: (isFold) {
            print('isFold:$isFold');
            setState(() {
              _isFold = isFold;
            });
          },
        ),
        JhCollapseView(
          title: 'card样式',
          collapseStyle: JhCollapseStyle.card,
          content: _testView(),
        ),
        JhCollapseView(
          title: '标题',
          collapseStyle: JhCollapseStyle.card,
          content: Container(
            child: Column(
              children: [
                separator(),
                _testView(),
              ],
            ),
          ),
        ),
        JhCollapseView(
          isFold: true,
          collapseStyle: JhCollapseStyle.card,
          // headerPadding: EdgeInsets.all(0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(3),
            boxShadow: [BoxShadow(color: Colours.red, spreadRadius: 1.5, blurRadius: 1.5)],
          ),
          titleWidget: _titleW2(),
          content: _testView(),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: KStyles.cellBorderStyle,
          child: JhCollapseView(
            padding: EdgeInsets.all(0),
            margin: EdgeInsets.all(0),
            title: '标题',
            titleStyle: TextStyle(color: Colors.white),
            arrowColor: Colors.white,
            headerColor: Color(0xFFA2BFEE),
            content: Container(
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 2,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    color: Colors.yellow,
                    child: ListTile(
                      title: Text('title$index'),
                      subtitle: Text('subtitle$index'),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        JhCollapseView(
          title: '居中箭头card样式',
          isFold: true,
          collapseType: JhCollapseType.centerArrow,
          collapseStyle: JhCollapseStyle.card,
          titleWidget: _titleW2(),
          content: _testView(),
        ),
        JhCollapseView(
          title: '居中箭头flat样式',
          isFold: true,
          collapseType: JhCollapseType.centerArrow,
          collapseStyle: JhCollapseStyle.flat,
          titleWidget: _titleW2(),
          content: _testView(),
        ),
        JhCollapseView(
          isFold: _isFold2,
          title: _isFold2 ? '查看更多' : '收起',
          collapseType: JhCollapseType.seeMore,
          titleWidget: _titleW2(),
          content: _testView(),
          onChange: (isFold) {
            print('isFold2:$isFold');
            setState(() {
              _isFold2 = isFold;
            });
          },
        ),
        JhCollapseView(
          isFold: _isFold3,
          title: _isFold3 ? '查看更多' : '收起',
          collapseType: JhCollapseType.seeMore,
          collapseStyle: JhCollapseStyle.card,
          hiddenDivider: true,
          titleWidget: _titleW2(),
          content: _testView(),
          onChange: (isFold) {
            print('isFold3:$isFold');
            setState(() {
              _isFold3 = isFold;
            });
          },
        ),
      ])
    ]);
  }

  _testView() {
    return Container(color: Colors.yellow, height: 100);
  }

  _titleW() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(child: Text('1212222222222222222222222222222222222222222')),
              SizedBox(width: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                color: Colors.red,
                child: Text('自定义title', style: TextStyle(color: Colors.white, fontSize: 12)),
              ),
            ],
          ),
        ),
        // Icon(Icons.arrow_drop_down),
      ],
    );
  }

  _titleW2() {
    return Container(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name:', style: KStyles.textBold15),
              SizedBox(width: 5),
              Expanded(child: Text('custom title widget')),
            ],
          ),
          SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Code:', style: KStyles.textBold15),
              SizedBox(width: 5),
              Expanded(child: Text('123')),
            ],
          ),
          SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('test:', style: KStyles.textBold15),
              SizedBox(width: 5),
              Expanded(child: Text('1212222222222222222222222222222222222222222')),
            ],
          ),
        ],
      ),
    );
  }
}
