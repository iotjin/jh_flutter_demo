// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: const BaseAppBar('Material3 Test'),
      body: _body(),
      drawer: _testNavigationDrawer(),
    );
  }

  _body() {
    return JhScrollView(
      child: Column(
        children: <Widget>[
          _testText(),
          _testBtn(),
          _testDialog(),
          _testUI(),
          _testCheckbox(),
          _testOther(),
        ],
      ),
    );
  }

  _testText() {
    var textTheme = Theme.of(context).textTheme;
    print('textTheme: ${Theme.of(context).textTheme}');

    Widget w = Column(
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
    return w;
  }

  _testBtn() {
    final provider = Provider.of<ThemeProvider>(context);
    var themeColor = KColors.dynamicColor(context, provider.getThemeColor(), KColors.kThemeColor);

    Widget w = Column(children: <Widget>[
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
    return w;
  }

  List<String> _popList = ['Apple', 'Banana', 'Orange', 'Strawberry', 'Pineapple'];
  var _selectedPopItem;

  _testDialog() {
    Widget w = Column(children: <Widget>[
      SizedBox(height: 10),
      TextButton(
        child: const Text('Show PopupMenuButton'),
        onPressed: () {
          showMenu<String>(
            context: context,
            position: RelativeRect.fromLTRB(100, 100, 0, 0),
            items: <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'Value1',
                child: Text('Value1'),
              ),
              const PopupMenuItem<String>(
                value: 'Value2',
                child: Text('Value2'),
              ),
              const PopupMenuItem<String>(
                value: 'Value3',
                child: Text('Value3'),
              ),
            ],
          ).then<void>((String? value) {
            if (value != null) {
              print('You selected: $value');
            }
          });
        },
      ),
      SizedBox(height: 10),
      PopupMenuButton<String>(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Show PopupMenuButton2'),
        ),
        onSelected: (String value) {
          print(_selectedPopItem);
          setState(() {
            _selectedPopItem = value;
          });
        },
        itemBuilder: (BuildContext context) {
          return _popList.map((String value) {
            return PopupMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList();
        },
      ),
      SizedBox(height: 10),
      TextButton(
        child: const Text('show dialog'),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('AlertDialog Title'),
                content: const Text('AlertDialog description'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  FilledButton(
                    child: const Text('Confirm'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              );
            },
          );
        },
      ),
      SizedBox(height: 10),
      TextButton(
        child: const Text('show full screen dialog'),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog.fullscreen(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      const Text('This is a fullscreen dialog'),
                      ElevatedButton(
                        child: const Text('Close'),
                        onPressed: () => Navigator.of(context).pop(),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      SizedBox(height: 10),
      TextButton(
        child: const Text('show modal bottom sheet'),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            showDragHandle: true,
            builder: (BuildContext context) {
              return Container(
                height: 200,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('This is a BottomSheet'),
                      ElevatedButton(
                        child: const Text('Close'),
                        onPressed: () => Navigator.of(context).pop(),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      SizedBox(height: 10),
      TextButton(
        child: const Text('show snackbar'),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('This is a snackbar'),
              action: SnackBarAction(
                label: 'Close',
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
              ),
            ),
          );
        },
      ),
      SizedBox(height: 10),
    ]);
    return w;
  }

  var _sliderValue = 0.5;
  var _sliderValue2 = 0.5;
  var _switchSelected = false;
  var _tabSelect1 = 0;
  var _tabSelect2 = 0;
  var _navigationBarValue = 0;

  _testUI() {
    Widget w = Column(children: <Widget>[
      SizedBox(height: 10),
      Divider(
        height: 10,
        thickness: 1,
        color: Colors.red,
        indent: 15,
        endIndent: 15,
      ),
      Divider(),
      Divider(
        height: 10,
        thickness: 1,
        color: Colors.red,
        indent: 15,
        endIndent: 15,
      ),
      SizedBox(height: 10),
      SizedBox(height: 10),
      Card(
        child: ListTile(
          leading: const Icon(Icons.account_box_rounded),
          title: const Text('Card'),
          subtitle: const Text('Card Subtitle'),
          trailing: const Icon(Icons.arrow_forward),
          onTap: () {},
        ),
      ),
      SizedBox(height: 10),
      ListTile(
        leading: Icon(Icons.map),
        title: Text('Map'),
        subtitle: Text('Map Subtitle'),
        trailing: Icon(Icons.arrow_forward),
        onTap: () {},
      ),
      SizedBox(height: 10),
      Slider(
        value: _sliderValue,
        onChanged: (value) {
          setState(() {
            _sliderValue = value;
          });
        },
      ),
      Slider(
        value: _sliderValue2,
        onChanged: (value) {
          setState(() {
            _sliderValue2 = value;
          });
        },
        activeColor: Colors.red,
        inactiveColor: Colors.blue,
        min: 0,
        max: 100,
        divisions: 10,
        label: _sliderValue2.toString(),
      ),
      SizedBox(height: 10),
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
            value: _switchSelected,
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
            onChanged: (value) {
              setState(() {
                _switchSelected = value;
              });
            },
          ),
          CupertinoSwitch(
            value: _switchSelected,
            onChanged: (value) {
              setState(() {
                _switchSelected = value;
              });
            },
          ),
        ],
      ),
      AppBar(
        title: Text('标题', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
        actions: <Widget>[
          Center(child: Text('右侧按钮', style: TextStyle(color: Colors.white))),
          IconButton(icon: Icon(Icons.add), onPressed: () {}),
        ],
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
        type: BottomNavigationBarType.fixed,
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
        currentIndex: _tabSelect1,
        onTap: (index) {
          setState(() {
            _tabSelect1 = index;
          });
        },
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
          type: BottomNavigationBarType.fixed,
          // showUnselectedLabels: false,
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
          currentIndex: _tabSelect2,
          onTap: (index) {
            setState(() {
              _tabSelect2 = index;
            });
          },
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
      Container(
        color: Colors.yellow,
        child: DefaultTabController(
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
      ),
      SizedBox(height: 10),
      NavigationBar(
        selectedIndex: _navigationBarValue,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.red,
        indicatorColor: Colors.yellow,
        elevation: 0,
        shadowColor: Colors.black,
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(color: Colors.yellow, width: 2.0),
        ),
        animationDuration: Duration(milliseconds: 500),
        onDestinationSelected: (int index) {
          print(index);
          setState(() {
            _navigationBarValue = index;
          });
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
      _testNavigationDrawer(),
      SizedBox(height: 10),
      // 通过按钮打开NavigationDrawer
      ElevatedButton(
        onPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        },
        child: const Text('Open Drawer'),
      ),
      SizedBox(height: 10),
      _testNavigationRail(),
      SizedBox(height: 10),
    ]);
    return w;
  }

  var _navigationDrawerValue = 0;

  _testNavigationDrawer() {
    return Container(
      width: 200,
      height: 500,
      child: NavigationDrawer(
        selectedIndex: _navigationDrawerValue,
        backgroundColor: Colors.yellow,
        onDestinationSelected: (int index) {
          print(index);
          setState(() {
            _navigationDrawerValue = index;
          });
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
    );
  }

  var _navigationRailValue = 0;

  _testNavigationRail() {
    return Container(
      width: 100,
      height: 500,
      child: NavigationRail(
        backgroundColor: Colors.yellow,
        selectedIndex: _navigationRailValue,
        labelType: NavigationRailLabelType.selected,
        onDestinationSelected: (int index) {
          print(index);
          setState(() {
            _navigationRailValue = index;
          });
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
    );
  }

  final List<String> _tempList0 = ['Apple', 'Banana', 'Orange', 'Strawberry', 'Pineapple'];
  final Map<String, bool> _selectedItems = {};
  var _selectedCheckboxValue = 'One';

  _testCheckbox() {
    Widget w = Column(children: <Widget>[
      // 单选radio
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Radio(
            value: 'One',
            groupValue: _selectedCheckboxValue,
            onChanged: (value) {
              setState(() {
                _selectedCheckboxValue = value.toString();
              });
            },
          ),
          Text('One'),
          Radio(
            value: 'Two',
            groupValue: _selectedCheckboxValue,
            onChanged: (value) {
              setState(() {
                _selectedCheckboxValue = value.toString();
              });
            },
          ),
          Text('Two'),
          Radio(
            value: 'Three',
            groupValue: _selectedCheckboxValue,
            onChanged: (value) {
              setState(() {
                _selectedCheckboxValue = value.toString();
              });
            },
          ),
          Text('Three'),
        ],
      ),
      SizedBox(height: 10),
      // 单选radio, 点击文字也可以选中
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedCheckboxValue = 'One';
              });
            },
            child: Row(
              children: [
                Radio(
                  value: 'One',
                  groupValue: _selectedCheckboxValue,
                  onChanged: (value) {
                    setState(() {
                      _selectedCheckboxValue = value.toString();
                    });
                  },
                ),
                Text('One'),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedCheckboxValue = 'Two';
              });
            },
            child: Row(
              children: [
                Radio(
                  value: 'Two',
                  groupValue: _selectedCheckboxValue,
                  onChanged: (value) {
                    setState(() {
                      _selectedCheckboxValue = value.toString();
                    });
                  },
                ),
                Text('Two'),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedCheckboxValue = 'Three';
              });
            },
            child: Row(
              children: [
                Radio(
                  value: 'Three',
                  groupValue: _selectedCheckboxValue,
                  onChanged: (value) {
                    setState(() {
                      _selectedCheckboxValue = value.toString();
                    });
                  },
                ),
                Text('Three'),
              ],
            ),
          ),
        ],
      ),
      // 多选checkbox
      Wrap(
        children: _tempList0.map((item) {
          return GestureDetector(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                  value: _selectedItems[item] ?? false,
                  onChanged: (value) {
                    setState(() {
                      _selectedItems[item] = value!;
                    });
                  },
                ),
                Text(item),
              ],
            ),
            onTap: () {
              setState(() {
                _selectedItems[item] = !(_selectedItems[item] ?? false);
              });
            },
          );
        }).toList(),
      ),
      SizedBox(height: 10),
      //  多选checkbox listTile
      Wrap(
        children: _tempList0.map((item) {
          return CheckboxListTile(
            title: Text(item),
            value: _selectedItems[item] ?? false,
            onChanged: (value) {
              setState(() {
                _selectedItems[item] = value!;
              });
            },
          );
        }).toList(),
      ),
    ]);
    return w;
  }

  var _curStep = 0;
  var _selectedDropdownOption;
  var _selectedSegment = 0;
  var _options = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];

  _testOther() {
    List<DropdownMenuEntry<String>> _list = [
      const DropdownMenuEntry<String>(value: "1", label: "One"),
      const DropdownMenuEntry<String>(value: "2", label: "Two"),
      const DropdownMenuEntry<String>(value: "3", label: "Three"),
    ];

    Widget w = Column(children: <Widget>[
      SizedBox(height: 10),
      DropdownButton<String>(
        hint: Text('Select an option'),
        // icon: const Icon(Icons.arrow_downward),
        // style: const TextStyle(color: Colors.deepPurple),
        // underline: Container(
        //   height: 2,
        //   color: Colors.deepPurpleAccent,
        // ),
        value: _selectedDropdownOption,
        items: _options.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _selectedDropdownOption = newValue;
          });
        },
      ),
      SizedBox(height: 10),
      DropdownMenu(
        width: 300,
        menuHeight: 400,
        initialSelection: _list.first,
        // enableFilter: true,
        // requestFocusOnTap: true,
        leadingIcon: const Icon(Icons.search),
        trailingIcon: const Icon(Icons.arrow_downward),
        hintText: 'Select an option',
        helperText: 'Help text',
        label: Text('Select text'),
        dropdownMenuEntries: _list,
        // dropdownMenuEntries: _options.map((String value) {
        //   return DropdownMenuEntry<String>(value: value, label: value);
        // }).toList(),
        onSelected: (value) {
          print('value: ${value}');
        },
      ),
      SizedBox(height: 10),
      // Segment 实现
      Container(
        width: 200,
        child: CupertinoSegmentedControl<int>(
          children: {
            0: Text('One'),
            1: Text('Two'),
            2: Text('Three'),
          },
          onValueChanged: (value) {
            setState(() {
              _selectedSegment = value;
            });
          },
          groupValue: _selectedSegment,
          borderColor: Colors.red,
          selectedColor: Colors.yellow,
          unselectedColor: Colors.blue,
        ),
      ),
      SizedBox(height: 10),
      Text('Single choice'),
      SingleChoice(),
      SizedBox(height: 10),
      Text('Multiple choice'),
      MultipleChoice(),
      SizedBox(height: 10),
      StepperExample(),
      SizedBox(height: 10),
      Stepper(
        physics: const NeverScrollableScrollPhysics(),
        currentStep: _curStep,
        onStepTapped: (step) {
          setState(() {
            _curStep = step;
          });
        },
        onStepContinue: () {
          setState(() {
            if (_curStep < 2) {
              _curStep++;
            }
          });
        },
        onStepCancel: () {
          setState(() {
            if (_curStep > 0) {
              _curStep--;
            }
          });
        },
        controlsBuilder: (BuildContext context, ControlsDetails details) {
          // return Container();
          return Row(
            children: <Widget>[
              if (details.onStepContinue != null)
                ElevatedButton(
                  onPressed: details.onStepContinue,
                  child: const Text('Continue'),
                ),
              if (details.onStepCancel != null)
                TextButton(
                  onPressed: details.onStepCancel,
                  child: const Text('Cancel'),
                ),
            ],
          );
          // return Align(
          //   alignment: Alignment.centerLeft,
          //   child: ElevatedButton(onPressed: () {}, child: Text("continue")),
          // );
        },
        steps: [
          // Step(title: Text('Step 标题一'), content: Container(child: Text('Step 内容一'))),
          // Step(title: Text('Step 标题二'), content: Container(child: Text('Step 内容二'))),
          // Step(title: Text('Step 标题三'), content: Container(child: Text('Step 内容三')))
          Step(title: Text('Step 标题一'), content: Container(child: Text('Step 内容一')), isActive: _curStep >= 0 ? true : false),
          Step(title: Text('Step 标题二'), content: Container(child: Text('Step 内容二')), isActive: _curStep >= 1 ? true : false),
          Step(title: Text('Step 标题三'), content: Container(child: Text('Step 内容三')), isActive: _curStep >= 2 ? true : false)
        ],
      )
    ]);
    return w;
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

enum Calendar { day, week, month, year }

class SingleChoice extends StatefulWidget {
  const SingleChoice({super.key});

  @override
  State<SingleChoice> createState() => _SingleChoiceState();
}

class _SingleChoiceState extends State<SingleChoice> {
  Calendar calendarView = Calendar.day;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<Calendar>(
      segments: const <ButtonSegment<Calendar>>[
        ButtonSegment<Calendar>(value: Calendar.day, label: Text('Day'), icon: Icon(Icons.calendar_view_day)),
        ButtonSegment<Calendar>(value: Calendar.week, label: Text('Week'), icon: Icon(Icons.calendar_view_week)),
        ButtonSegment<Calendar>(value: Calendar.month, label: Text('Month'), icon: Icon(Icons.calendar_view_month)),
        ButtonSegment<Calendar>(value: Calendar.year, label: Text('Year'), icon: Icon(Icons.calendar_today)),
      ],
      selected: <Calendar>{calendarView},
      onSelectionChanged: (Set<Calendar> newSelection) {
        setState(() {
          // By default there is only a single segment that can be
          // selected at one time, so its value is always the first
          // item in the selected set.
          calendarView = newSelection.first;
        });
      },
    );
  }
}

enum Sizes { extraSmall, small, medium, large, extraLarge }

class MultipleChoice extends StatefulWidget {
  const MultipleChoice({super.key});

  @override
  State<MultipleChoice> createState() => _MultipleChoiceState();
}

class _MultipleChoiceState extends State<MultipleChoice> {
  Set<Sizes> selection = <Sizes>{Sizes.large, Sizes.extraLarge};

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<Sizes>(
      segments: const <ButtonSegment<Sizes>>[
        ButtonSegment<Sizes>(value: Sizes.extraSmall, label: Text('XS')),
        ButtonSegment<Sizes>(value: Sizes.small, label: Text('S')),
        ButtonSegment<Sizes>(value: Sizes.medium, label: Text('M')),
        ButtonSegment<Sizes>(
          value: Sizes.large,
          label: Text('L'),
        ),
        ButtonSegment<Sizes>(value: Sizes.extraLarge, label: Text('XL')),
      ],
      selected: selection,
      onSelectionChanged: (Set<Sizes> newSelection) {
        setState(() {
          selection = newSelection;
        });
      },
      multiSelectionEnabled: true,
    );
  }
}

class StepperExample extends StatefulWidget {
  const StepperExample({super.key});

  @override
  State<StepperExample> createState() => _StepperExampleState();
}

class _StepperExampleState extends State<StepperExample> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Stepper(
      physics: const NeverScrollableScrollPhysics(),
      currentStep: _index,
      onStepCancel: () {
        if (_index > 0) {
          setState(() {
            _index -= 1;
          });
        }
      },
      onStepContinue: () {
        if (_index <= 0) {
          setState(() {
            _index += 1;
          });
        }
      },
      onStepTapped: (int index) {
        setState(() {
          _index = index;
        });
      },
      steps: <Step>[
        Step(
          title: const Text('Step 1 title'),
          content: Container(
            alignment: Alignment.centerLeft,
            child: const Text('Content for Step 1'),
          ),
        ),
        const Step(
          title: Text('Step 2 title'),
          content: Text('Content for Step 2'),
        ),
      ],
    );
  }
}
