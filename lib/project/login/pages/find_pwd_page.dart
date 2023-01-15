import 'package:flutter/material.dart';
import 'package:jhtoast/jhtoast.dart';
import 'package:provider/provider.dart';
import '/jh_common/jh_form/jh_form.dart';
import '/jh_common/widgets/jh_button.dart';
import '/project/provider/theme_provider.dart';
import '/project/configs/project_config.dart';

class FindPwdPage extends StatefulWidget {
  const FindPwdPage({Key? key}) : super(key: key);

  @override
  State<FindPwdPage> createState() => _FindPwdPageState();
}

class _FindPwdPageState extends State<FindPwdPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();

  final FocusNode _node1 = FocusNode();
  final FocusNode _node2 = FocusNode();

  bool pwdShow = false; // 密码是否显示明文

  bool _isFocused1 = false;
  bool _isFocused2 = false;

  @override
  void initState() {
    super.initState();

    // 自动填充上次登录的用户名，填充后将焦点定位到密码输入框
    _nameController.text = '';
    _node1.addListener(() {
      if (mounted) {
        setState(() {
          _isFocused1 = _node1.hasFocus;
        });
      }
    });
    _node2.addListener(() {
      if (mounted) {
        setState(() {
          _isFocused2 = _node2.hasFocus;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar('重置密码'),
      body: KeyboardActions(
        config: JhKeyboardUtils.getKeyboardConfig(context, [_node1, _node2]),
        child: _body(),
      ),
    );
  }

  Widget _body() {
    // TODO: 通过ThemeProvider进行主题管理
    final provider = Provider.of<ThemeProvider>(context);
    var themeColor = KColors.dynamicColor(context, provider.getThemeColor(), KColors.kThemeColor);
    var labelTextStyle = TextStyle(fontSize: 15.0, color: themeColor);
    var hintColor = KColors.dynamicColor(context, KColors.kFormHintColor, KColors.kFormHintDarkColor);
    var hintTextStyle = TextStyle(fontSize: 15.0, color: hintColor);

    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  focusNode: _node1,
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: '用户名',
                    labelStyle: _isFocused1 ? labelTextStyle : hintTextStyle,
                    hintText: '请输入用户名',
                    hintStyle: const TextStyle(fontSize: 15),
                    focusedBorder:
                        UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 0.8)),
                    enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 0.5)),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  focusNode: _node2,
                  controller: _pwdController,
                  decoration: InputDecoration(
                    labelText: '密码',
                    labelStyle: _isFocused2 ? labelTextStyle : hintTextStyle,
                    hintText: '请输入密码',
                    hintStyle: const TextStyle(fontSize: 15),
                    focusedBorder:
                        UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 0.8)),
                    enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 0.5)),
                    suffixIcon: IconButton(
                      icon: Icon(pwdShow ? Icons.visibility : Icons.visibility_off),
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        setState(() {
                          pwdShow = !pwdShow;
                        });
                      },
                    ),
                  ),
                  obscureText: !pwdShow,
                ),
                const SizedBox(height: 50),
                JhButton(text: '重 置', onPressed: _clickOkBtn)
              ],
            ),
          ),
        )
      ],
    );
  }

  void _clickOkBtn() async {
//    Navigator.of(context).pushAndRemoveUntil(
//         MaterialPageRoute(builder: (context) => BaseTabBar()
//        ), (route) => route == null);

//    Navigator.pushReplacementNamed(context, 'BaseTabBar');

    var hide = JhToast.showIOSLoadingText(
      context,
      msg: '正在重置...',
    );
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pop(context);
      hide();
    });
  }
}
