import 'package:flutter/material.dart';
import 'package:jhtoast/jhtoast.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import '/jh_common/jh_form/jh_keyboard_utils.dart';
import '/jh_common/widgets/jh_button.dart';
import '/base_appbar.dart';

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

  @override
  void initState() {
    // 自动填充上次登录的用户名，填充后将焦点定位到密码输入框
    _nameController.text = '';
    super.initState();
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
                    hintText: '请输入密码',
                    hintStyle: const TextStyle(fontSize: 15),
                    focusedBorder:
                        UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 0.8)),
                    enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 0.5)),
                    suffixIcon: IconButton(
                      icon: Icon(pwdShow ? Icons.visibility : Icons.visibility_off),
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
