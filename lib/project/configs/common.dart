///  common.dart
///
///  Created by iotjin on 2023/08/17.
///  description:

import 'package:intl/intl.dart';

class CommonUtils {
  static toLocaleString(num? num) {
    return NumberFormat().format(num);
  }
}
