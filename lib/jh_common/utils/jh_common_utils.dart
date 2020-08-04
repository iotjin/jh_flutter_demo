/**
 *  jh_common_utils.dart
 *
 *  Created by iotjin on 2020/03/25.
 *  description:  公共工具类
 */

import 'dart:math';

import 'package:flutter/material.dart';

class JhCommonUtils {
  double getRandom(int min, int max) {
    if (max > min) {
      return min + Random.secure().nextInt(max - min) + 0.0;
    } else {
      return max + Random.secure().nextInt(min - max) + 0.0;
    }
  }
}
