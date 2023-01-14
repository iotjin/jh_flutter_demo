// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import '/jh_common/widgets/jh_progress_hud.dart';
import '/jh_common/widgets/jh_cascade_tree_picker.dart';
import '/jh_common/widgets/jh_text_list.dart';

final List titleData = [
  'JhCascadeTreePicker-都是三列',
  'JhCascadeTreePicker-不定列',
  'JhCascadeTreePicker-不定列-隐藏搜索',
  'JhCascadeTreePicker-不定列-默认选中(三级)',
  'JhCascadeTreePicker-不定列-默认选中(只有两级)',
  'JhCascadeTreePicker-第一列长度为1',
  'JhCascadeTreePicker-第一列长度为1-默认选中',
];

final treeData = [
  {
    'value': 'zhinan',
    'label': '指南',
    'children': [
      {
        'value': 'shejiyuanze',
        'label': '设计原则',
        'children': [
          {'value': 'yizhi', 'label': '一致'},
          {'value': 'fankui', 'label': '反馈'},
          {'value': 'xiaolv', 'label': '效率'},
          {'value': 'kekong', 'label': '可控'}
        ]
      },
      {
        'value': 'daohang',
        'label': '导航',
        'children': [
          {'value': 'cexiangdaohang', 'label': '侧向导航'},
          {'value': 'dingbudaohang', 'label': '顶部导航'}
        ]
      }
    ]
  },
  {
    'value': 'zujian',
    'label': '组件(三级)',
    'children': [
      {
        'value': 'basic',
        'label': 'Basic',
        'children': [
          {'value': 'layout', 'label': 'Layout 布局'},
          {'value': 'color', 'label': 'Color 色彩'},
          {'value': 'typography', 'label': 'Typography 字体'},
          {'value': 'icon', 'label': 'Icon 图标'},
          {'value': 'button', 'label': 'Button 按钮'}
        ]
      },
      {
        'value': 'form',
        'label': 'Form',
        'children': [
          {'value': 'radio', 'label': 'Radio 单选框'},
          {'value': 'checkbox', 'label': 'Checkbox 多选框'},
          {'value': 'input', 'label': 'Input 输入框'},
          {'value': 'input-number', 'label': 'InputNumber 计数器'},
          {'value': 'select', 'label': 'Select 选择器'},
          {'value': 'cascader', 'label': 'Cascader 级联选择器'},
          {'value': 'switch', 'label': 'Switch 开关'},
          {'value': 'slider', 'label': 'Slider 滑块'},
          {'value': 'time-picker', 'label': 'TimePicker 时间选择器'},
          {'value': 'date-picker', 'label': 'DatePicker 日期选择器'},
          {'value': 'datetime-picker', 'label': 'DateTimePicker 日期时间选择器'},
          {'value': 'upload', 'label': 'Upload 上传'},
          {'value': 'rate', 'label': 'Rate 评分'},
          {'value': 'form', 'label': 'Form 表单'}
        ]
      },
      {
        'value': 'data',
        'label': 'Data',
        'children': [
          {'value': 'table', 'label': 'Table 表格'},
          {'value': 'tag', 'label': 'Tag 标签'},
          {'value': 'progress', 'label': 'Progress 进度条'},
          {'value': 'tree', 'label': 'Tree 树形控件'},
          {'value': 'pagination', 'label': 'Pagination 分页'},
          {'value': 'badge', 'label': 'Badge 标记'}
        ]
      },
      {
        'value': 'notice',
        'label': 'Notice',
        'children': [
          {'value': 'alert', 'label': 'Alert 警告'},
          {'value': 'loading', 'label': 'Loading 加载'},
          {'value': 'message', 'label': 'Message 消息提示'},
          {'value': 'message-box', 'label': 'MessageBox 弹框'},
          {'value': 'notification', 'label': 'Notification 通知'}
        ]
      },
      {
        'value': 'navigation',
        'label': 'Navigation',
        'children': [
          {'value': 'menu', 'label': 'NavMenu 导航菜单'},
          {'value': 'tabs', 'label': 'Tabs 标签页'},
          {'value': 'breadcrumb', 'label': 'Breadcrumb 面包屑'},
          {'value': 'dropdown', 'label': 'Dropdown 下拉菜单'},
          {'value': 'steps', 'label': 'Steps 步骤条'}
        ]
      },
      {
        'value': 'others',
        'label': 'Others',
        'children': [
          {'value': 'dialog', 'label': 'Dialog 对话框'},
          {'value': 'tooltip', 'label': 'Tooltip 文字提示'},
          {'value': 'popover', 'label': 'Popover 弹出框'},
          {'value': 'card', 'label': 'Card 卡片'},
          {'value': 'carousel', 'label': 'Carousel 走马灯'},
          {'value': 'collapse', 'label': 'Collapse 折叠面板'}
        ]
      }
    ]
  },
  {
    'value': 'ziyuan',
    'label': '资源(两级)',
    'children': [
      {'value': 'axure', 'label': 'Axure Components'},
      {'value': 'sketch', 'label': 'Sketch Templates'},
      {'value': 'jiaohu', 'label': '组件交互文档'}
    ]
  },
  {
    'value': '4',
    'label': '大类4(有三级有四级)',
    'children': [
      {
        'value': '4-11',
        'label': '大类4-中类1(四级)',
        'children': [
          {
            'value': '4-111',
            'label': '大类4-小类1',
            'children': [
              {'value': '4-111-1111', 'label': '大类4-中类1-小类1-超小类1'},
              {'value': '4-111-2222', 'label': '大类4-中类1-小类1-超小类2'},
              {'value': '4-111-3333', 'label': '大类4-中类1-小类1-超小类3'},
              {'value': '4-111-4444', 'label': '大类4-中类1-小类1-超小类4'},
            ]
          },
          {
            'value': '4-222',
            'label': '大类4-小类2',
            'children': [
              {'value': '4-222-1111', 'label': '大类4-中类1-小类2-超小类1'},
              {'value': '4-222-2222', 'label': '大类4-中类1-小类2-超小类2'},
              {'value': '4-222-3333', 'label': '大类4-中类1-小类2-超小类3'},
              {'value': '4-222-4444', 'label': '大类4-中类1-小类2-超小类4'},
            ]
          },
        ]
      },
      {
        'value': '4-12',
        'label': '大类4-中类2(三级)',
        'children': [
          {'value': '4-12-111', 'label': '大类4-中类2-小类1'},
          {'value': '4-12-222', 'label': '大类4-中类2-小类2'},
          {'value': '4-12-333', 'label': '大类4-中类2-小类3'},
          {'value': '4-12-444', 'label': '大类4-中类2-小类4'},
        ]
      }
    ]
  },
  {
    'value': '5',
    'label': '大类5(children有null或[])',
    'children': [
      {'value': '5-11', 'label': '大类5-中类1([])', 'children': []},
      {'value': '5-12', 'label': '大类4-中类2(null)', 'children': null}
    ]
  },
  {'value': '6', 'label': '大类6(一级)'}
];

final treeData3 = [
  {
    'value': '1',
    'label': '大类1',
    'children': [
      {
        'value': '1-11',
        'label': '大类1-中类1',
        'children': [
          {'value': '1-11-111', 'label': '大类1-中类1-小类1'},
          {'value': '1-11-222', 'label': '大类1-中类1-小类2'},
          {'value': '1-11-333', 'label': '大类1-中类1-小类3'},
          {'value': '1-11-444', 'label': '大类1-中类1-小类4'},
        ]
      },
      {
        'value': '1-12',
        'label': '大类1-中类2',
        'children': [
          {'value': '1-12-111', 'label': '大类1-中类2-小类1'},
          {'value': '1-12-222', 'label': '大类1-中类2-小类2'},
          {'value': '1-12-333', 'label': '大类1-中类2-小类3'},
          {'value': '1-12-444', 'label': '大类1-中类2-小类4'},
        ]
      },
      {
        'value': '1-13',
        'label': '大类1-中类3',
        'children': [
          {'value': '1-13-111', 'label': '大类1-中类3-小类1'},
          {'value': '1-13-222', 'label': '大类1-中类3-小类2'},
          {'value': '1-13-333', 'label': '大类1-中类3-小类3'},
          {'value': '1-13-444', 'label': '大类1-中类3-小类4'},
        ]
      },
      {
        'value': '1-14',
        'label': '大类1-中类4',
        'children': [
          {'value': '1-14-111', 'label': '大类1-中类4-小类1'},
          {'value': '1-14-222', 'label': '大类1-中类4-小类2'},
          {'value': '1-14-333', 'label': '大类1-中类4-小类3'},
          {'value': '1-14-444', 'label': '大类1-中类4-小类4'},
        ]
      }
    ]
  },
  {
    'value': '2',
    'label': '大类2',
    'children': [
      {
        'value': '2-11',
        'label': '大类2-中类1',
        'children': [
          {'value': '2-11-111', 'label': '大类2-中类1-小类1'},
          {'value': '2-11-222', 'label': '大类2-中类1-小类2'},
          {'value': '2-11-333', 'label': '大类2-中类1-小类3'},
          {'value': '2-11-444', 'label': '大类2-中类1-小类4'},
        ]
      },
      {
        'value': '2-12',
        'label': '大类2-中类2',
        'children': [
          {'value': '2-12-111', 'label': '大类2-中类2-小类1'},
          {'value': '2-12-222', 'label': '大类2-中类2-小类2'},
          {'value': '2-12-333', 'label': '大类2-中类2-小类3'},
          {'value': '2-12-444', 'label': '大类2-中类2-小类4'},
        ]
      },
      {
        'value': '2-13',
        'label': '大类2-中类3',
        'children': [
          {'value': '2-13-111', 'label': '大类2-中类3-小类1'},
          {'value': '2-13-222', 'label': '大类2-中类3-小类2'},
          {'value': '2-13-333', 'label': '大类2-中类3-小类3'},
          {'value': '2-13-444', 'label': '大类2-中类3-小类4'},
        ]
      },
      {
        'value': '2-14',
        'label': '大类2-中类4',
        'children': [
          {'value': '2-14-111', 'label': '大类2-中类4-小类1'},
          {'value': '2-14-222', 'label': '大类2-中类4-小类2'},
          {'value': '2-14-333', 'label': '大类2-中类4-小类3'},
          {'value': '2-14-444', 'label': '大类2-中类4-小类4'},
        ]
      }
    ]
  },
  {
    'value': '3',
    'label': '大类3',
    'children': [
      {
        'value': '3-11',
        'label': '大类3-中类1',
        'children': [
          {'value': '3-11-111', 'label': '大类3-中类1-小类1'},
          {'value': '3-11-222', 'label': '大类3-中类1-小类2'},
          {'value': '3-11-333', 'label': '大类3-中类1-小类3'},
          {'value': '3-11-444', 'label': '大类3-中类1-小类4'},
        ]
      },
      {
        'value': '3-12',
        'label': '大类3-中类2',
        'children': [
          {'value': '3-12-111', 'label': '大类3-中类2-小类1'},
          {'value': '3-12-222', 'label': '大类3-中类2-小类2'},
          {'value': '3-12-333', 'label': '大类3-中类2-小类3'},
          {'value': '3-12-444', 'label': '大类3-中类2-小类4'},
        ]
      },
      {
        'value': '3-13',
        'label': '大类3-中类3',
        'children': [
          {'value': '3-13-111', 'label': '大类3-中类3-小类1'},
          {'value': '3-13-222', 'label': '大类3-中类3-小类2'},
          {'value': '3-13-333', 'label': '大类3-中类3-小类3'},
          {'value': '3-13-444', 'label': '大类3-中类3-小类4'},
        ]
      },
    ]
  },
  {
    'value': '4',
    'label': '大类4',
    'children': [
      {
        'value': '4-11',
        'label': '大类4-中类1',
        'children': [
          {'value': '4-11-111', 'label': '大类4-中类1-小类1'},
          {'value': '4-11-222', 'label': '大类4-中类1-小类2'},
          {'value': '4-11-333', 'label': '大类4-中类1-小类3'},
          {'value': '4-11-444', 'label': '大类4-中类1-小类4'},
        ]
      },
      {
        'value': '4-12',
        'label': '大类4-中类2',
        'children': [
          {'value': '4-12-111', 'label': '大类4-中类2-小类1'},
          {'value': '4-12-222', 'label': '大类4-中类2-小类2'},
          {'value': '4-12-333', 'label': '大类4-中类2-小类3'},
          {'value': '4-12-444', 'label': '大类4-中类2-小类4'},
        ]
      }
    ]
  }
];

final treeData4 = [
  {
    'value': '4',
    'label': '大类4(有三级有四级)',
    'children': [
      {
        'value': '4-11',
        'label': '大类4-中类1(四级)',
        'children': [
          {
            'value': '4-111',
            'label': '大类4-小类1',
            'children': [
              {'value': '4-111-1111', 'label': '大类4-中类1-小类1-超小类1'},
              {'value': '4-111-2222', 'label': '大类4-中类1-小类1-超小类2'},
              {'value': '4-111-3333', 'label': '大类4-中类1-小类1-超小类3'},
              {'value': '4-111-4444', 'label': '大类4-中类1-小类1-超小类4'},
            ]
          },
          {
            'value': '4-222',
            'label': '大类4-小类2',
            'children': [
              {'value': '4-222-1111', 'label': '大类4-中类1-小类2-超小类1'},
              {'value': '4-222-2222', 'label': '大类4-中类1-小类2-超小类2'},
              {'value': '4-222-3333', 'label': '大类4-中类1-小类2-超小类3'},
              {'value': '4-222-4444', 'label': '大类4-中类1-小类2-超小类4'},
            ]
          },
        ]
      },
      {
        'value': '4-12',
        'label': '大类4-中类2(三级)',
        'children': [
          {'value': '4-12-111', 'label': '大类4-中类2-小类1'},
          {'value': '4-12-222', 'label': '大类4-中类2-小类2'},
          {'value': '4-12-333', 'label': '大类4-中类2-小类3'},
          {'value': '4-12-444', 'label': '大类4-中类2-小类4'},
        ]
      }
    ]
  },
];

class CascadeTreePickerTest extends StatelessWidget {
  const CascadeTreePickerTest({super.key});

  @override
  Widget build(BuildContext context) {
    return JhTextList(
        title: 'JhCascadeTreePicker',
        dataArr: titleData,
        callBack: (index, str) {
          if (str == 'JhCascadeTreePicker-都是三列') {
            JhCascadeTreePicker.show(context,
                data: treeData3,
                labelKey: 'label',
                childrenKey: 'children',
                title: '请选择类型', clickCallBack: (selectItem, selectArr) {
              print(selectItem);
              print(selectArr);
              showText(selectItem);
            });
          }
          if (str == 'JhCascadeTreePicker-不定列') {
            JhCascadeTreePicker.show(context, data: treeData, labelKey: 'label', title: '请选择类型', splitString: ' / ',
                clickCallBack: (selectItem, selectArr) {
              print(selectItem);
              print(selectArr);
              showText(selectItem);
            });
          }
          if (str == 'JhCascadeTreePicker-不定列-隐藏搜索') {
            JhCascadeTreePicker.show(context, data: treeData, isShowSearch: false, labelKey: 'label', title: '请选择类型',
                clickCallBack: (selectItem, selectArr) {
              print(selectItem);
              print(selectArr);
              showText(selectItem);
            });
          }
          if (str == 'JhCascadeTreePicker-不定列-默认选中(三级)') {
            // var tempArr = [
            //   {'value': 'zujian', 'label': '组件(三级)'},
            //   {'value': 'form', 'label': 'Form'},
            //   {'value': 'cascader', 'label': 'Cascader 级联选择器'},
            // ];
            var values = ['zujian', 'form', 'cascader'];
            JhCascadeTreePicker.show(context, data: treeData, values: values, valuesKey: 'value', title: '请选择类型',
                clickCallBack: (selectItem, selectArr) {
              print(selectItem);
              print(selectArr);
              showText(selectItem);
            });
          }
          if (str == 'JhCascadeTreePicker-不定列-默认选中(只有两级)') {
            // var tempArr = [
            //   {'value': 'ziyuan', 'label': '资源(两级)'},
            //   {'value': 'axure', 'label': 'Axure Components'},
            // ];
            var values = ['资源(两级)', 'Axure Components'];
            JhCascadeTreePicker.show(context, data: treeData, values: values, valuesKey: 'label', title: '请选择类型',
                clickCallBack: (selectItem, selectArr) {
              print(selectItem);
              print(selectArr);
              showText(selectItem);
            });
          }
          if (str == 'JhCascadeTreePicker-第一列长度为1') {
            JhCascadeTreePicker.show(context, data: treeData4, title: '请选择类型', clickCallBack: (selectItem, selectArr) {
              print(selectItem);
              print(selectArr);
              showText(selectItem);
            });
          }
          if (str == 'JhCascadeTreePicker-第一列长度为1-默认选中') {
            var values = ['4', '4-11', '4-222', '4-222-4444'];
            JhCascadeTreePicker.show(context, data: treeData4, values: values, valuesKey: 'value', title: '请选择类型',
                clickCallBack: (selectItem, selectArr) {
              print(selectItem);
              print(selectArr);
              showText(selectItem);
            });
          }
        });
  }
}

void showText(str) {
  JhProgressHUD.showText(str.toString());
}
