///  jh_keyboard_utils.dart
///
///  Created by iotjin on 2020/04/10.
///  description:  键盘配置

import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import '/project/configs/colors.dart';

class JhKeyboardUtils {
  /// 三方键盘配置
  static KeyboardActionsConfig getKeyboardConfig(BuildContext context, List<FocusNode> list) {
    return KeyboardActionsConfig(
//      keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
      keyboardBarColor: context.jhIsDark ? Colors.grey[800] : Colors.grey[200],
      nextFocus: true,
      actions: List.generate(
          list.length,
          (i) => KeyboardActionsItem(
                focusNode: list[i],
                toolbarButtons: [
                  (node) {
                    return GestureDetector(
                      onTap: () => node.unfocus(),
                      child: Stack(
                        alignment: Alignment.centerRight,
                        children: <Widget>[
                          Container(color: Colors.transparent, width: 100),
                          const Positioned(right: 15, child: Text('关闭')),
                        ],
                      ),
                    );
                  },
                ],
              )),
    );
  }

  static void unFocus() {
    // 关闭键盘方法：FocusScope.of(context).requestFocus(FocusNode());
    // 使用下面的方式，会触发不必要的build。
    // FocusScope.of(context).unFocus();
    // https://github.com/flutter/flutter/issues/47128#issuecomment-627551073
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
