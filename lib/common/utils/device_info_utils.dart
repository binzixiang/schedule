import 'dart:ui';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:schedule/common/utils/logger_utils.dart';
import 'package:schedule/common/utils/platform_utils.dart';

class DeviceInfoUtils {
  static final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  static void specificDeviceConfigurations() {
    final data =
        MediaQueryData.fromView(PlatformDispatcher.instance.implicitView!);
    bool isTablet = data.size.shortestSide > 600;

    if (!isTablet) {
      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    }
  }

  /// 获取cpu架构
  static Future<String> getCpuArchitecture() async {
    if (PlatformUtils.isAndroid) {
      final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      // arm64-v8a armeabi-v7a armeabi
      List<String> supportedAbis = androidInfo.supportedAbis;
      if (supportedAbis.isNotEmpty) {
        // 判断是否含有 arm64-v8a
        bool contains = supportedAbis.contains("arm64-v8a");
        if(contains) {
          return "arm64-v8a";
        } else {
          return supportedAbis.first;
        }
      } else {
        return 'all';
      }
    } else {
      return 'unknown';
    }
  }
}
