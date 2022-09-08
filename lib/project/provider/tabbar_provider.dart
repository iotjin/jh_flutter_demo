///  tabbar_provider.dart
///
///  Created by iotjin on 2022/09/06.
///  description:

import 'package:flutter/material.dart';

class TabbarProvider extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
