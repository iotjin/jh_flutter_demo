import 'package:flutter/material.dart';
import 'package:jhtoast/jhtoast.dart';
import '/jh_common/widgets/jh_text_list.dart';

final List titleData = ['文字', '成功', '失败', '警告', '加载中', '水平加载中', '自定义图文', '水平自定义图文', 'iOS样式加载中'];

class ToastTestPage extends StatelessWidget {
  const ToastTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return JhTextList(
      title: 'JhToast',
      dataArr: titleData,
      callBack: (index, str) {
        if (index == 0) {
          JhToast.showText(
            context, msg: '这是一条提示文字信息',
//              closeTime: 10
          );
        }
        if (index == 1) {
          JhToast.showSuccess(context, msg: '加载成功');
        }
        if (index == 2) {
          JhToast.showError(context, msg: '上传失败。请重新上传数据');
        }
        if (index == 3) {
          JhToast.showInfo(context, msg: '注意！注意！注意！');
        }
        if (index == 4) {
          var hide = JhToast.showLoadingText(context, msg: '正在加载中...');
          Future.delayed(const Duration(seconds: 2), () {
            hide();
          });
        }

        if (index == 5) {
          var hide = JhToast.showHorizontalLoadingText(context, msg: '正在加载中...');
          Future.delayed(const Duration(seconds: 2), () {
            hide();
          });
        }
        if (index == 6) {
          Widget img = Image.asset(
            'assets/images/toast_error.png',
            package: 'jhtoast',
          );
          JhToast.showImageText(context, msg: '自定义图文', image: img);
        }

        if (index == 7) {
          Widget img = Image.asset('assets/images/toast_success.png', package: 'jhtoast');
          JhToast.showHorizontalImageText(context, msg: '水平自定义图文', image: img);
        }

        if (index == 8) {
          var hide = JhToast.showIOSLoadingText(
            context,
            msg: '正在加载中...',
          );
          Future.delayed(const Duration(seconds: 2), () {
            hide();
          });
        }
      },
    );
  }
}
