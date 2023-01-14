import 'package:flutter/material.dart';
import '/jh_common/widgets/jh_text_list.dart';
import '/project/routes/jh_nav_utils.dart';

final List titleData = [
  'ListViewTest',
  'ListViewTest2',
  'ListViewTest3',
  'ListViewTest4',
  'ListViewTest5',
  'ListViewTestCard',
  'ListViewTestCustomVC',
  '假数据分页 - header/footer跟随',
  'ListViewGroup',
  'ListViewGroup2',
  'ListViewGroup3 - 分组分页',
  'ListViewHeader - 头部跟随滚动',
];
final List routeData = [
  'ListViewTest',
  'ListViewTest2',
  'ListViewTest3',
  'ListViewTest4',
  'ListViewTest5',
  'ListViewTestCard',
  'ListViewTestCustomVC',
  'ListViewTestPullDownVC',
  'ListViewGroupPage',
  'ListViewGroupPage2',
  'ListViewGroupPage3',
  'ListViewHeaderPage',
];

class ListViewDemoListPage extends StatelessWidget {
  const ListViewDemoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return JhTextList(
      title: 'ListViewDemoList',
      dataArr: titleData,
      callBack: (index, str) {
        JhNavUtils.pushNamed(context, routeData[index]);
      },
    );
  }
}

/*

ListView({
  Axis scrollDirection = Axis.vertical, // 列表的滚动方向，可选值：Axis的horizontal、vertical
  ScrollController controller, // 控制器，与列表滚动相关，比如监听列表的滚动事件
  ScrollPhysics physics, // 列表滚动至边缘后继续拖动的物理效果，Android与iOS效果不同：Android = 波纹状（ClampingScrollPhysics），而iOS = 回弹的弹性效果（BouncingScrollPhysics）。若想不同的平台上呈现各自的效果可使用AlwaysScrollableScrollPhysics，它会根据不同平台自动选用各自的物理效果。若想禁用在边缘的拖动效果，可使用NeverScrollableScrollPhysics
  bool shrinkWrap = false, // 决定列表的长度是否仅包裹其内容的长度。当ListView嵌在一个无限长的容器组件中时，shrinkWrap必须为true，否则Flutter会给出警告；
  EdgeInsetsGeometry padding, // 列表内边距
  this.itemExtent, // 子元素长度。当列表中的每一项长度是固定的情况下可以指定该值，有助于提高列表的性能（因为它可以帮助ListView在未实际渲染子元素之前就计算出每一项元素的位置）；
  double cacheExtent, // 预渲染区域长度，ListView会在其可视区域的两边留一个cacheExtent长度的区域作为预渲染区域（对于ListView.build或ListView.separated构造函数创建的列表，不在可视区域和预渲染区域内的子元素不会被创建或会被销毁）；
  List<Widget> children = const <Widget>[], // 容纳子元素的组件数组
})

* */
