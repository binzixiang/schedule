import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:schedule/common/api/other/other_api.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common/utils/device_info_utils.dart';
import '../../../common/utils/package_info_utils.dart';
import '../../../common/utils/platform_utils.dart';
import '../../../generated/l10n.dart';
import 'state.dart';

class PersonSettingLogic extends GetxController {
  final PersonSettingState state = PersonSettingState();

  final otherApi = OtherApi();

  /// 获取版本号
  String getVersion() {
    return PackageInfoUtils.version;
  }

  /// 检查版本更新
  void updateVersion(
      {required Widget Function(BuildContext context, String info, String url)
          newVersionDialogBuilder,
      required Widget Function(BuildContext context)
          lastVersionDialogBuilder}) {
    otherApi.getVersionInfo().then(
      (value) async {
        if (value['tag_name'] == null) {
          // 获取版本信息失败
          // logger.i("获取版本信息失败");
          Get.snackbar(
            S.of(Get.context!).snackbar_tip,
            S.of(Get.context!).update_dialog_version_fail,
            backgroundColor:
                Theme.of(Get.context!).colorScheme.primaryContainer,
            margin: EdgeInsets.only(
              top: 30.w,
              left: 50.w,
              right: 50.w,
            ),
          );
          return;
        }

        String version = value['tag_name'].replaceAll("v", "");
        bool isUpdate = PackageInfoUtils.compareVersion(version);

        // logger.i("version: $version, info: $info");
        if (isUpdate) {
          // 有新版本
          // logger.i("有新版本");

          String info = value['body'];
          List assets = value['assets'];
          List<String> downloadUrls = [];
          String downloadUrl = "";

          // 遍历获取下载url
          for (var asset in assets) {
            downloadUrls.add(asset['browser_download_url']);
          }

          // 判断平台
          if (PlatformUtils.isAndroid) {
            for (String url in downloadUrls) {
              if (url.contains("android")) {
                // 获取系统架构
                String arch = await DeviceInfoUtils.getCpuArchitecture();
                if (url.contains(arch)) {
                  downloadUrl = url;
                  break;
                }
              }
            }

            if (downloadUrl.isEmpty) {
              downloadUrl = downloadUrls
                  .firstWhere((element) => element.contains("android"));
            }
          } else if (PlatformUtils.isIOS) {
            for (String url in downloadUrls) {
              if (url.contains("ios")) {
                downloadUrl = url;
                break;
              }
            }
          }

          // 弹窗显示
          showDialog(
            context: Get.context!,
            builder: (context) {
              return newVersionDialogBuilder(context, info, downloadUrl);
            },
          );
        } else {
          // 当前已是最新版本
          // logger.i("当前已是最新版本");
          // 弹窗显示
          showDialog(
            context: Get.context!,
            builder: (context) {
              return lastVersionDialogBuilder(context);
            },
          );
        }
      },
    );
  }

  /// 跳转浏览器
  void jumpBrowser(String url) {
    launchUrl(Uri.parse(url));
  }

  /// 获取主题列表
  Map<String, String> getThemesMap() {
    final map = {
      "default": S.current.setting_follow_system,
      "light": S.current.setting_theme_light,
      "dark": S.current.setting_theme_dark,
    };
    return map;
  }

  /// 获取语言列表
  Map<String, String> getLanguagesMap() {
    final map = {
      "zh-CN": "简体中文",
      "en-US": "English",
    };
    return map;
  }
}
