// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/jh_common/widgets/jh_scrollview.dart';
import '/project/configs/colors.dart';
import '/project/provider/theme_provider.dart';
import '/base_appbar.dart';

class UIPage3 extends StatefulWidget {
  const UIPage3({Key? key}) : super(key: key);

  @override
  State<UIPage3> createState() => _UIPage3State();
}

class _UIPage3State extends State<UIPage3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar('Material3 Test'),
      body: _body(),
    );
  }

  _body() {
    return JhScrollView(
      child: Column(
        children: <Widget>[
          _testUI(),
          _testBtn(),
          _testOther(),
        ],
      ),
    );
  }

  _testUI() {
    var textTheme = Theme.of(context).textTheme;
    print('textTheme: ${Theme.of(context).textTheme}');

    Widget testUI = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('切换M2/M3需要切换代码ThemeProvider文件的getThemeData函数', style: TextStyle(color: Colors.red, fontSize: 16)),
        Text('Display Large', style: textTheme.displayLarge),
        Text('Display Medium', style: textTheme.displayMedium),
        Text('Display Small', style: textTheme.displaySmall),
        Text('Headline Large', style: textTheme.headlineLarge),
        Text('Headline Medium', style: textTheme.headlineMedium),
        Text('Headline Small', style: textTheme.headlineSmall),
        Text('Title Large', style: textTheme.titleLarge),
        Text('Title Medium', style: textTheme.titleMedium),
        Text('Title Small', style: textTheme.titleSmall),
        Text('Label Large', style: textTheme.labelLarge),
        Text('Label Medium', style: textTheme.labelMedium),
        Text('Label Small', style: textTheme.labelSmall),
        Text('Body Large', style: textTheme.bodyLarge),
        Text('Body Medium', style: textTheme.bodyMedium),
        Text('Body Small', style: textTheme.bodySmall),
      ],
    );
    return testUI;
  }

  _testBtn() {
    final provider = Provider.of<ThemeProvider>(context);
    var themeColor = KColors.dynamicColor(context, provider.getThemeColor(), KColors.kThemeColor);

    Widget testBtn = Column(children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton(
            child: const Text('TextButton'),
            onPressed: () {},
          ),
          TextButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('图标TextButton'),
            onPressed: () {},
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            child: const Text('ElevatedButton'),
            onPressed: () {},
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('图标ElevatedButton'),
            onPressed: () {},
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          OutlinedButton(
            child: const Text('OutlinedButton'),
            onPressed: () {},
          ),
          OutlinedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('图标OutlinedButton'),
            onPressed: () {},
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FilledButton(
            child: const Text('FilledButton'),
            onPressed: () {},
          ),
          FilledButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('图标FilledButton'),
            onPressed: () {},
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FilledButton.tonal(
            child: const Text('Tonal'),
            onPressed: () {},
          ),
          FilledButton.tonalIcon(
            icon: const Icon(Icons.add),
            label: const Text('TonalIcon'),
            onPressed: () {},
          ),
        ],
      ),
      IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
      SizedBox(height: 10),
      FloatingActionButton(
        heroTag: 'UI-FloatingActionButton1',
        backgroundColor: themeColor,
        foregroundColor: Colors.white,
        shape: CircleBorder(),
        onPressed: () {},
        // child: const Text("浮动按钮(FloatingActionButton)"),
        child: const Icon(Icons.add),
      ),
      SizedBox(height: 10),
      FloatingActionButton.extended(
        heroTag: 'UI-FloatingActionButton2',
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text("浮动按钮(FloatingActionButton)"),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      ),
      SizedBox(height: 10),
      Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        runSpacing: 4,
        spacing: 4,
        children: [
          FloatingActionButton.small(
            heroTag: 'UI-FloatingActionButton11',
            onPressed: () {},
            tooltip: 'Small',
            child: const Icon(Icons.add),
          ),
          FloatingActionButton.extended(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
            heroTag: 'UI-FloatingActionButton22',
            onPressed: () {},
            tooltip: 'Extended',
            icon: const Icon(Icons.add),
            label: const Text('Create'),
          ),
          FloatingActionButton(
            heroTag: 'UI-FloatingActionButton33',
            onPressed: () {},
            tooltip: 'Standard',
            child: const Icon(Icons.add),
          ),
          FloatingActionButton.large(
            heroTag: 'UI-FloatingActionButton44',
            onPressed: () {},
            tooltip: 'Large',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    ]);
    return testBtn;
  }

  _testOther() {
    Widget testOther = Column(children: <Widget>[
      Padding(
        padding: EdgeInsets.all(16),
        child: LinearProgressIndicator(),
      ),
      Padding(
          padding: EdgeInsets.all(16),
          child: LinearProgressIndicator(
            //模糊进度，循环进度进度条
            // backgroundColor: Colors.grey,
            valueColor: AlwaysStoppedAnimation(Colors.red),
          )),
      Padding(
          padding: EdgeInsets.all(16),
          child: LinearProgressIndicator(
            //具体进度
            backgroundColor: Colors.grey,
            valueColor: AlwaysStoppedAnimation(Colors.blue),
            value: 0.6,
          )),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CircularProgressIndicator(),
          CircularProgressIndicator(
            // backgroundColor: Colors.grey, // 设置背景颜色
            valueColor: AlwaysStoppedAnimation(Colors.red), // 设置进度颜色
            strokeWidth: 4.0, // 设置进度条宽度
            // value: 0.5, // 设置进度值（0.0 - 1.0）, 设置为 null持续旋转
          ),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.blue),
            strokeWidth: 4.0,
          ),
        ],
      ),
      SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          RefreshProgressIndicator(),
          RefreshProgressIndicator(
            value: 0.5,
            backgroundColor: Colors.blue, // 设置背景颜色
            valueColor: AlwaysStoppedAnimation<Color>(Colors.pink), // 设置进度颜色
          ),
        ],
      ),
      SizedBox(height: 10),
      Theme(
        data: ThemeData(
          inputDecorationTheme: InputDecorationTheme(
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.orange, width: 1)),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.pinkAccent, width: 1)),
          ),
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: '请输入',
            prefixIcon: Icon(Icons.person),
          ),
        ),
      ),
      SizedBox(height: 10),
      TextField(
        decoration: InputDecoration(
          hintText: '请输入',
          border: OutlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 1)),
          // focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.orange, width: 1)),
          // enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.pinkAccent, width: 1)),
        ),
      ),
      SizedBox(height: 10),
      Wrap(
        spacing: 5,
        runSpacing: 5,
        children: <Widget>[
          const ActionChip(
            color: MaterialStatePropertyAll(Colors.white),
            label: Text('Assist'),
            avatar: Icon(Icons.event),
          ),
          FilterChip(
            label: const Text('Filter'),
            selected: true,
            onSelected: null,
          ),
          InputChip(
            label: const Text('Input'),
            onDeleted: () {},
            isEnabled: false,
          ),
          const ActionChip(
            label: Text('Suggestion'),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Switch(
            // 当前状态
            value: false,
            // 激活时原点颜色
            activeColor: Colors.yellow,
            // 激活时的背景色
            activeTrackColor: Colors.red,
            // 非激活时圆点颜色
            inactiveThumbColor: Colors.green,
            // 非激活时的背景色
            inactiveTrackColor: Colors.blue,
            trackOutlineWidth: MaterialStateProperty.all(0.0),
            trackOutlineColor: MaterialStateProperty.all(Colors.transparent),
            onChanged: (value) {},
          ),
          Switch(
            // 当前状态
            value: true,
            // 激活时原点颜色
            activeColor: Colors.yellow,
            // 激活时的背景色
            activeTrackColor: Colors.red,
            // 非激活时圆点颜色
            inactiveThumbColor: Colors.green,
            // 非激活时的背景色
            inactiveTrackColor: Colors.blue,
            trackOutlineWidth: MaterialStateProperty.all(0.0),
            trackOutlineColor: MaterialStateProperty.all(Colors.transparent),
            onChanged: (value) {},
          ),
        ],
      ),
      AppBar(
        title: Text('标题', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
        elevation: 3,
        shadowColor: Colors.yellow,
      ),
      SizedBox(height: 10),
      Column(
        children: [
          SizedBox(
            height: 64,
            child: Scaffold(
              floatingActionButton: FloatingActionButton.small(
                heroTag: 'UI-FloatingActionButton66',
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                tooltip: 'Add',
                elevation: 0.0,
                child: const Icon(Icons.add),
                onPressed: () {},
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
              bottomNavigationBar: BottomAppBar(
                color: Colors.yellow,
                elevation: 0.0,
                child: Row(
                  children: <Widget>[
                    // IconButton(
                    //   tooltip: 'More',
                    //   icon: const Icon(Icons.more_vert),
                    //   onPressed: () {},
                    // ),
                    const IconButtonAnchorExample(),
                    IconButton(
                      tooltip: 'Search',
                      icon: const Icon(Icons.search),
                      onPressed: () {},
                    ),
                    IconButton(
                      tooltip: 'Favorite',
                      icon: const Icon(Icons.favorite),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: 10),
      BottomNavigationBar(
        backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
        ],
        currentIndex: 0,
        onTap: (index) {},
      ),
      SizedBox(height: 10),
      Theme(
        data: ThemeData(
          splashFactory: InkSplash.splashFactory,
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.white,
            // elevation: 0,
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home2',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Business2',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'School2',
            ),
          ],
          currentIndex: 0,
          onTap: (index) {},
        ),
      ),
      SizedBox(height: 10),
      DefaultTabController(
        length: 3,
        child: TabBar(
          dividerColor: Colors.red,
          tabs: <Widget>[
            Tab(icon: Icon(Icons.directions_car)),
            Tab(icon: Icon(Icons.directions_transit)),
            Tab(icon: Icon(Icons.directions_bike)),
          ],
        ),
      ),
      SizedBox(height: 10),
      NavigationBar(
        selectedIndex: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.red,
        indicatorColor: Colors.yellow,
        elevation: 0,
        shadowColor: Colors.black,
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(color: Colors.yellow, width: 2.0),
        ),
        animationDuration: Duration(milliseconds: 2000),
        onDestinationSelected: (int index) {
          print(index);
        },
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          NavigationDestination(
            icon: Icon(Icons.school),
            label: 'School',
          ),
        ],
      ),
      SizedBox(height: 10),
      Container(
        width: 200,
        height: 500,
        child: NavigationDrawer(
          backgroundColor: Colors.yellow,
          onDestinationSelected: (int index) {
            print(index);
          },
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'Drawer Header',
                // style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const NavigationDrawerDestination(
              icon: Icon(Icons.message),
              label: Text('Messages'),
            ),
            const NavigationDrawerDestination(
              icon: Icon(Icons.account_circle),
              label: Text('Profile'),
            ),
            const NavigationDrawerDestination(
              icon: Icon(Icons.settings),
              label: Text('Settings'),
            ),
          ],
        ),
      ),
      SizedBox(height: 10),
      Container(
        width: 100,
        height: 500,
        child: NavigationRail(
          backgroundColor: Colors.yellow,
          selectedIndex: 0,
          onDestinationSelected: (int index) {
            print(index);
          },
          destinations: const <NavigationRailDestination>[
            NavigationRailDestination(
              icon: Icon(Icons.favorite),
              label: Text('Favorites'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.bookmark),
              label: Text('Bookmarks'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.account_circle),
              label: Text('Profile'),
            ),
          ],
        ),
      ),
      SizedBox(height: 10),
    ]);
    return testOther;
  }
}

class IconButtonAnchorExample extends StatelessWidget {
  const IconButtonAnchorExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      builder: (context, controller, child) {
        return IconButton(
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          icon: const Icon(Icons.more_vert),
        );
      },
      menuChildren: [
        MenuItemButton(
          child: const Text('Menu 1'),
          onPressed: () {},
        ),
        MenuItemButton(
          child: const Text('Menu 2'),
          onPressed: () {},
        ),
        SubmenuButton(
          menuChildren: <Widget>[
            MenuItemButton(
              onPressed: () {},
              child: const Text('Menu 3.1'),
            ),
            MenuItemButton(
              onPressed: () {},
              child: const Text('Menu 3.2'),
            ),
            MenuItemButton(
              onPressed: () {},
              child: const Text('Menu 3.3'),
            ),
          ],
          child: const Text('Menu 3'),
        ),
      ],
    );
  }
}
