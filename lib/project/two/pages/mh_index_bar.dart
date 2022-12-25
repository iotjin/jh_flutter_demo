// import 'package:flutter/material.dart';
// import 'package:azlistview/azlistview.dart';
//
// /// IndexBar touch callback IndexModel.
// // typedef void IndexBarTouchCallback(IndexBarDetails model);
//
// /// Called to build index hint. 自定义气泡弹出Hint
// /// [tag] 标签值
// /// [indexModel] 当前选中的标签Model
// typedef Widget IndexBarHintBuilder(
//     BuildContext context, String tag, IndexBarDetails indexModel);
//
// /// Called to build index tag. 自定义气标签
// typedef Widget IndexBarTagBuilder(
//     BuildContext context, String tag, IndexBarDetails indexModel);
//
// /// MHIndexBar.
// class MHIndexBar extends StatefulWidget {
//   MHIndexBar({
//     Key key,
//     this.data = INDEX_DATA_DEF,
//     @required this.onTouch,
//     this.itemWidth = 24,
//     this.itemHeight = 16,
//     this.tagWidth = 14,
//     this.tagHeight = 14,
//     this.tag = '',
//     this.ignoreTags = const [],
//     this.mapTag,
//     this.mapSelTag,
//     this.mapHintTag,
//     this.color = Colors.transparent,
//     this.touchDownColor = Colors.transparent,
//     this.tagColor = Colors.transparent,
//     this.selectedTagColor = const Color(0xFF07C160),
//     this.textStyle = const TextStyle(
//         fontSize: 10.0, color: Color(0xFF555555), fontWeight: FontWeight.w500),
//     this.selectedTextStyle = const TextStyle(
//         fontSize: 10.0, color: Color(0xFFFFFFFF), fontWeight: FontWeight.w500),
//     this.hintOffsetX = -80.0,
//     this.hintOffsetY = -17.0,
//     this.hintImagePath,
//     this.hintContentAlignment = const Alignment(-0.25, 0.0),
//     this.indexBarTagBuilder,
//     this.indexBarHintBuilder,
//   });
//
//   /// index data.
//   final List<String> data;
//
//   /// 当前高亮显示的标签
//   final String tag;
//
//   /// 忽略的Tags，这些忽略Tag, 不会高亮显示，点击或长按 不会弹出 tagHint
//   final List<String> ignoreTags;
//
//   /// 针对某个Tag显示其他部件的映射,一般都是映射 图片/svg
//   final Map<String, Widget> mapTag;
//
//   /// 针对某个Tag显示高亮其他部件的映射,一般都是映射 图片/svg
//   final Map<String, Widget> mapSelTag;
//
//   /// 长按弹出气泡显示的内容,一般都是映射 图片/svg
//   final Map<String, Widget> mapHintTag;
//
//   /// MHIndexBar item width(def:24).
//   final int itemWidth;
//
//   /// MHIndexBar item height(def:16).
//   final int itemHeight;
//
//   /// MHIndexBar item 中的tag width(def:14). 尽量保证 tagWidth = tagHeight 且 tagWidth <= itemWidth
//   final int tagWidth;
//
//   /// MHIndexBar item 中的tag height(def:14). 尽量保证 tagWidth = tagHeight 且 tagHeight <= itemHeight
//   final int tagHeight;
//
//   /// Background color 默认是透明
//   final Color color;
//
//   /// MHIndexBar touch down color. 默认是透明
//   final Color touchDownColor;
//
//   /// 标签默认的背景色 默认是透明色
//   final Color tagColor;
//
//   /// 标签选中的背景色 默认是 0xFF07C160
//   final Color selectedTagColor;
//
//   /// MHIndexBar default text style. default is TextStyle(fontSize: 10.0, color: Color(0xFF555555), fontWeight: FontWeight.w500)
//   final TextStyle textStyle;
//
//   /// MHIndexBar highlight text style. default is TextStyle(fontSize: 10.0, color: Color(0xFFFFFFFF), fontWeight: FontWeight.w500)
//   final TextStyle selectedTextStyle;
//
//   /// Item touch callback.
//   final IndexBarTouchCallback onTouch;
//
//   /// hint左距离indexBar左侧的边距 默认是-80.0 = -(hintW + 20) // hintW = 60
//   final double hintOffsetX;
//
//   /// hint顶部距离indexBar顶部侧的边距 默认是-17.0 = -(hintH - itemHeight) * 0.5 // hintH = 50, itemHeight = 16
//   final double hintOffsetY;
//
//   /// hint背景图 只支持本地图片
//   final String hintImagePath;
//
//   /// hint内容对其方式
//   final Alignment hintContentAlignment;
//
//   /// 自定义标签，且 跟标签相关的属性将全部失效
//   final IndexBarTagBuilder indexBarTagBuilder;
//
//   /// 自定义气泡弹出Hint， 且 跟hint相关的属性将全部失效
//   final IndexBarHintBuilder indexBarHintBuilder;
//
//   @override
//   _SuspensionListViewIndexBarState createState() =>
//       _SuspensionListViewIndexBarState();
// }
//
// class _SuspensionListViewIndexBarState extends State<MHIndexBar> {
//   bool _isTouchDown = false;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       alignment: Alignment.center,
//       color: _isTouchDown ? widget.touchDownColor : widget.color,
//       width: widget.itemWidth.toDouble(),
//       child: _IndexBar(
//         tag: widget.tag,
//         ignoreTags: widget.ignoreTags,
//         mapTag: widget.mapTag,
//         mapSelTag: widget.mapSelTag,
//         mapHintTag: widget.mapHintTag,
//         data: widget.data,
//         itemWidth: widget.itemWidth,
//         itemHeight: widget.itemHeight,
//         tagWidth: widget.tagWidth,
//         tagHeight: widget.tagHeight,
//         textStyle: widget.textStyle,
//         selectedTextStyle: widget.selectedTextStyle,
//         hintOffsetX: widget.hintOffsetX,
//         hintOffsetY: widget.hintOffsetY,
//         hintImagePath: widget.hintImagePath,
//         hintContentAlignment: widget.hintContentAlignment,
//         tagColor: widget.tagColor,
//         selectedTagColor: widget.selectedTagColor,
//         indexBarTagBuilder: widget.indexBarTagBuilder,
//         indexBarHintBuilder: widget.indexBarHintBuilder,
//         onTouch: (details) {
//           if (widget.onTouch != null) {
//             if (_isTouchDown != details.isTouchDown) {
//               setState(() {
//                 _isTouchDown = details.isTouchDown;
//               });
//             }
//             widget.onTouch(details);
//           }
//         },
//       ),
//     );
//   }
// }
//
// /// Base IndexBar.
// class _IndexBar extends StatefulWidget {
//   /// index data.
//   final List<String> data;
//
//   final String tag;
//
//   /// 忽略的Tags，这些忽略Tag, 不会高亮显示，点击或长按 不会弹出 tagHint
//   final List<String> ignoreTags;
//
//   /// 针对某个Tag显示其他部件的映射,一般都是映射 图片/svg
//   final Map<String, Widget> mapTag;
//
//   /// 针对某个Tag显示高亮其他部件的映射,一般都是映射 图片/svg
//   final Map<String, Widget> mapSelTag;
//
//   /// 长按弹出气泡显示的内容,一般都是映射 图片/svg
//   final Map<String, Widget> mapHintTag;
//
//   /// IndexBar item width(def:24).
//   final int itemWidth;
//
//   /// IndexBar item height(def:16).
//   final int itemHeight;
//
//   /// MHIndexBar item 中的tag width(def:14). 尽量保证 tagWidth = tagHeight 且 tagWidth <= itemWidth
//   final int tagWidth;
//
//   /// MHIndexBar item 中的tag height(def:14). 尽量保证 tagWidth = tagHeight 且 tagHeight <= itemHeight
//   final int tagHeight;
//
//   /// MHIndexBar default text style. default is TextStyle(fontSize: 10.0, color: Color(0xFF555555), fontWeight: FontWeight.w500)
//   final TextStyle textStyle;
//
//   /// MHIndexBar highlight text style. default is TextStyle(fontSize: 10.0, color: Color(0xFFFFFFFF), fontWeight: FontWeight.w500)
//   final TextStyle selectedTextStyle;
//
//   /// Item touch callback.
//   final IndexBarTouchCallback onTouch;
//
//   /// hint左距离indexBar左侧的边距 默认是-80.0 = -(hintW + 20) // hintW = 60
//   final double hintOffsetX;
//
//   /// hint顶部距离indexBar顶部侧的边距 默认是-17.0 = -(hintH - itemHeight) * 0.5 // hintH = 50, itemHeight = 16
//   final double hintOffsetY;
//
//   /// hint背景图 只支持本地图片
//   final String hintImagePath;
//
//   /// hint内容对其方式
//   final Alignment hintContentAlignment;
//
//   /// 标签默认的背景色 默认是透明色
//   final Color tagColor;
//
//   /// 标签默认的背景色 默认是 0xFF07C160
//   final Color selectedTagColor;
//
//   /// 自定义标签，且 跟标签相关的属性将全部失效
//   final IndexBarTagBuilder indexBarTagBuilder;
//
//   /// 自定义气泡弹出Hint， 且 跟hint相关的属性将全部失效
//   final IndexBarHintBuilder indexBarHintBuilder;
//
//   _IndexBar({
//     Key key,
//     this.data = INDEX_DATA_DEF,
//     this.tag = '',
//     this.ignoreTags = const [],
//     this.mapTag,
//     this.mapSelTag,
//     this.mapHintTag,
//     @required this.onTouch,
//     this.itemWidth = 30,
//     this.itemHeight = 16,
//     this.tagWidth = 14,
//     this.tagHeight = 14,
//     this.textStyle = const TextStyle(
//         fontSize: 10.0, color: Color(0xFF555555), fontWeight: FontWeight.w500),
//     this.selectedTextStyle = const TextStyle(
//         fontSize: 10.0, color: Color(0xFFFFFFFF), fontWeight: FontWeight.w500),
//     this.hintOffsetX = -80.0,
//     this.hintOffsetY = -17.0,
//     this.tagColor = Colors.transparent,
//     this.selectedTagColor = const Color(0xFF07C160),
//     this.hintImagePath,
//     this.hintContentAlignment = const Alignment(-0.25, 0.0),
//     this.indexBarTagBuilder,
//     this.indexBarHintBuilder,
//   })  : assert(onTouch != null),
//         super(key: key);
//
//   @override
//   _IndexBarState createState() => _IndexBarState();
// }
//
// class _IndexBarState extends State<_IndexBar> {
//   List<int> _indexSectionList = new List();
//   int _widgetTop = -1;
//   int _lastIndex = 0;
//   bool _widgetTopChange = false;
//   bool _isTouchDown = false;
//   IndexBarDetails _indexModel = new IndexBarDetails();
//
//   /// get index.
//   int _getIndex(int offset) {
//     for (int i = 0, length = _indexSectionList.length; i < length - 1; i++) {
//       int a = _indexSectionList[i];
//       int b = _indexSectionList[i + 1];
//       if (offset >= a && offset < b) {
//         return i;
//       }
//     }
//     return -1;
//   }
//
//   void _init() {
//     _widgetTopChange = true;
//     _indexSectionList.clear();
//     _indexSectionList.add(0);
//     int tempHeight = 0;
//     widget.data?.forEach((value) {
//       tempHeight = tempHeight + widget.itemHeight;
//       _indexSectionList.add(tempHeight);
//     });
//   }
//
//   _triggerTouchEvent() {
//     if (widget.onTouch != null) {
//       widget.onTouch(_indexModel);
//     }
//   }
//
//   /// 获取背景色
//   Color _fetchColor(String tag) {
//     if (_indexModel.tag == tag) {
//       final List<String> ignoreTags = widget.ignoreTags ?? [];
//       return ignoreTags.indexOf(tag) != -1
//           ? widget.tagColor ?? Colors.transparent
//           : widget.selectedTagColor ?? Color(0xFF07C160);
//     }
//     return widget.tagColor ?? Colors.transparent;
//   }
//
//   // 获取Offstage 是否隐居幕后
//   bool _fetchOffstage(String tag) {
//     if (_indexModel.tag == tag) {
//       final List<String> ignoreTags = widget.ignoreTags ?? [];
//       return ignoreTags.indexOf(tag) != -1 ? true : !_indexModel.isTouchDown;
//     }
//     return true;
//   }
//
//   /// 构建索引标签Item部件
//   Widget _buildIndexTagItemWidget(String tag) {
//     return new Container(
//       width: widget.itemWidth.toDouble(),
//       height: widget.itemHeight.toDouble(),
//       alignment: Alignment.center,
//       child: Stack(
//         // 设置超出部分可见
//         overflow: Overflow.visible,
//         children: <Widget>[
//           _buildIndexBarTagWidget(context, tag, _indexModel),
//           _buildIndexBarHintWidget(context, tag, _indexModel),
//         ],
//       ),
//     );
//   }
//
//   /// 构建tag
//   Widget _buildIndexBarTagWidget(
//       BuildContext context, String tag, IndexBarDetails indexModel) {
//     if (widget.indexBarTagBuilder != null) {
//       return widget.indexBarTagBuilder(context, tag, _indexModel);
//     } else {
//       return Container(
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//           color: _fetchColor(tag),
//           borderRadius: BorderRadius.circular(widget.tagWidth * 0.5),
//         ),
//         child: _buildTagWidget(tag),
//         width: widget.tagWidth.toDouble(),
//         height: widget.tagHeight.toDouble(),
//       );
//     }
//   }
//
//   /// 构建某个tag
//   Widget _buildTagWidget(String tag) {
//     // 当前选中的tag, 也就是高亮的场景
//     if (_indexModel.tag == tag) {
//       final List<String> ignoreTags = widget.ignoreTags ?? [];
//       final isIgnore = ignoreTags.indexOf(tag) != -1;
//       // 如果是忽略
//       if (isIgnore) {
//         // 获取mapTag
//         if (widget.mapTag != null && widget.mapTag[tag] != null) {
//           // 返回映射的部件
//           return widget.mapTag[tag];
//         } else {
//           // 返回默认的部件
//           return Text(
//             tag,
//             textAlign: TextAlign.center,
//             style: widget.textStyle ??
//                 TextStyle(
//                   fontSize: 10.0,
//                   color: Color(0xFF555555),
//                   fontWeight: FontWeight.w500,
//                 ),
//           );
//         }
//       } else {
//         // 不忽略，则显示高亮组件
//         if (widget.mapSelTag != null && widget.mapSelTag[tag] != null) {
//           // 返回映射高亮的部件
//           return widget.mapSelTag[tag];
//         } else if (widget.mapTag != null && widget.mapTag[tag] != null) {
//           // 返回映射默认的部件
//           return widget.mapTag[tag];
//         } else {
//           // 返回默认的部件
//           return Text(
//             tag,
//             textAlign: TextAlign.center,
//             style: widget.selectedTextStyle ??
//                 TextStyle(
//                   fontSize: 10.0,
//                   color: Colors.white,
//                   fontWeight: FontWeight.w500,
//                 ),
//           );
//         }
//       }
//     }
//     // 非高亮场景
//     // 获取mapTag
//     if (widget.mapTag != null && widget.mapTag[tag] != null) {
//       // 返回映射的部件
//       return widget.mapTag[tag];
//     } else {
//       // 返回默认的部件
//       return Text(
//         tag,
//         textAlign: TextAlign.center,
//         style: widget.textStyle ??
//             TextStyle(
//               fontSize: 10.0,
//               color: Color(0xFF555555),
//               fontWeight: FontWeight.w500,
//             ),
//       );
//     }
//   }
//
//   /// 构建indexBar hint
//   Widget _buildIndexBarHintWidget(
//       BuildContext context, String tag, IndexBarDetails indexModel) {
//     // 如果外界自定义 indexbarHint
//     if (widget.indexBarHintBuilder != null) {
//       return widget.indexBarHintBuilder(context, tag, indexModel);
//     } else {
//       // 图片路径
//       final String hintImagePath = widget.hintImagePath ??
//           'assets/images/contacts/ContactIndexShape_60x50.png';
//       return Positioned(
//         left: widget.hintOffsetX ?? -80,
//         top: widget.hintOffsetY ?? -(50 - widget.itemHeight) * 0.5,
//         child: Offstage(
//           offstage: _fetchOffstage(tag),
//           child: Container(
//             width: 60.0,
//             height: 50.0,
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage(hintImagePath),
//                 fit: BoxFit.contain,
//               ),
//             ),
//             alignment: widget.hintContentAlignment ?? Alignment(-0.25, 0.0),
//             child: _buildHintChildWidget(tag),
//           ),
//         ),
//       );
//     }
//   }
//
//   /// 构建某个hint中子部件
//   Widget _buildHintChildWidget(String tag) {
//     if (widget.mapHintTag != null && widget.mapHintTag[tag] != null) {
//       // 返回映射高亮的部件
//       return widget.mapHintTag[tag];
//     }
//     return Text(
//       tag,
//       style: TextStyle(
//         color: Colors.white70,
//         fontSize: 30.0,
//         fontWeight: FontWeight.w700,
//       ),
//     );
//   }
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // 初始化
//     _init();
//
//     // 配置 _indexModel tag 可能是用户滚动列表的数据 导致tag
//     if (widget.tag != null &&
//         widget.tag.isNotEmpty &&
//         widget.tag != _indexModel.tag) {
//       _indexModel.tag = widget.tag;
//       _indexModel.isTouchDown = false;
//       _indexModel.position = widget.data.indexOf(widget.tag);
//     }
//
//     // ��件数据源
//     List<Widget> children = new List();
//
//     // 配置数据源Widget
//     widget.data.forEach((tag) {
//       final tagWidget = _buildIndexTagItemWidget(tag);
//       children.add(tagWidget);
//     });
//
//     return GestureDetector(
//       onVerticalDragDown: (DragDownDetails details) {
//         if (_widgetTop == -1 || _widgetTopChange) {
//           _widgetTopChange = false;
//           RenderBox box = context.findRenderObject();
//           Offset topLeftPosition = box.localToGlobal(Offset.zero);
//           _widgetTop = topLeftPosition.dy.toInt();
//         }
//         int offset = details.globalPosition.dy.toInt() - _widgetTop;
//         int index = _getIndex(offset);
//         if (index != -1) {
//           _lastIndex = index;
//           _indexModel.position = index;
//           _indexModel.tag = widget.data[index];
//           _indexModel.isTouchDown = true;
//           _triggerTouchEvent();
//         }
//       },
//       onVerticalDragUpdate: (DragUpdateDetails details) {
//         int offset = details.globalPosition.dy.toInt() - _widgetTop;
//         int index = _getIndex(offset);
//         if (index != -1 && _lastIndex != index) {
//           _lastIndex = index;
//           _indexModel.position = index;
//           _indexModel.tag = widget.data[index];
//           _indexModel.isTouchDown = true;
//           _triggerTouchEvent();
//         }
//       },
//       onVerticalDragEnd: (DragEndDetails details) {
//         _indexModel.isTouchDown = false;
//         _triggerTouchEvent();
//       },
//       onTapUp: (TapUpDetails details) {
//         _indexModel.isTouchDown = false;
//         _triggerTouchEvent();
//       },
//       child: new Column(
//         mainAxisSize: MainAxisSize.min,
//         children: children,
//       ),
//     );
//   }
// }
