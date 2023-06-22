import 'package:flutter/material.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import '/jh_common/utils/jh_screen_utils.dart';
import '/jh_common/widgets/jh_network_image.dart';
import '/jh_common/widgets/jh_tabbar.dart';
import '/project/configs/strings.dart';
import '/project/routes/jh_nav_utils.dart';
import './content_page.dart';

class PersonalCenterPage2 extends StatefulWidget {
  const PersonalCenterPage2({Key? key}) : super(key: key);

  @override
  State<PersonalCenterPage2> createState() => _PersonalCenterPage2State();
}

class _PersonalCenterPage2State extends State<PersonalCenterPage2> with TickerProviderStateMixin {
  late TabController _tabController;

  List<JhTabBarModel> model = [
    const JhTabBarModel(title: '标题一', widget: ContentPage()),
    const JhTabBarModel(title: '标题二', widget: ContentPage()),
  ];

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: model.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ExtendedNestedScrollView(
        onlyOneScrollInBody: true,
        pinnedHeaderSliverHeightBuilder: () {
          // final double statusBarHeight = MediaQuery.of(context).padding.top;
          // return statusBarHeight + kToolbarHeight;
          return JhScreenUtils.navigationBarHeight;
        },
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          _buildSliverAppBar(),
        ],
        body: JhTabBarView(tabModelList: model, tabController: _tabController),
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      title: const Text('Title', style: TextStyle(color: Colors.white)),
      centerTitle: true,
      leading: IconButton(
        icon: const ImageIcon(AssetImage('assets/images/common/ic_nav_back_white.png')),
        iconSize: 18,
        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
        onPressed: () => JhNavUtils.goBack(context),
      ),
      pinned: true,
      expandedHeight: 200,
      flexibleSpace: FlexibleSpaceBar(
        // background: Image.network(KStrings.headBgImage, fit: BoxFit.cover),
        background: JhNetworkImage(KStrings.headBgImage),
      ),
      bottom: JhTabBar(
        tabModelList: model,
        tabController: _tabController,
        switchPageCallBack: (index) {
          debugPrint('切换到第$index页');
        },
      ),
    );
  }
}
