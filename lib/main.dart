import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:schedule/common/utils/app_theme_utils.dart';
import 'package:schedule/global_logic.dart';
import 'package:schedule/pages/route_config.dart';

import 'common/manager/data_storage_manager.dart';
import 'common/manager/onnx_manager.dart';
import 'common/manager/request_manager.dart';
import 'common/utils/device_info_utils.dart';
import 'common/utils/package_info_utils.dart';
import 'generated/l10n.dart';

Future<void> main() async {
  // 首先注册组件
  WidgetsFlutterBinding.ensureInitialized();

  // 初始化版本信息
  await PackageInfoUtils.packageInfoInit();

  // 初始化设备信息
  DeviceInfoUtils.specificDeviceConfigurations();

  // 初始化数据存储读取器
  await DataStorageManager().init();

  // 初始化onnx
  await OnnxManager().initOnnxModel(OnnxModelType.ocr);

  // 初始化网络请求管理
  await RequestManager().persistCookieJarInit();

  // 沉浸式状态栏
  AppThemeUtils.statusBarAndBottomBarImmersed();

  // 初始化全局逻辑
  final logic = Get.put(GlobalLogic());
  logic.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(720, 1080),
      splitScreenMode: true,
      ensureScreenSize: true,
      builder: (BuildContext context, Widget? child) {
        return GetBuilder<GlobalLogic>(builder: (logic) {
          return DynamicColorBuilder(
              builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
            return GetMaterialApp(
              title: 'Schedule',
              theme: ThemeData(
                colorScheme: logic.state.settings["isMonetColor"]
                    ? lightDynamic
                    : ColorScheme.fromSeed(
                        seedColor: logic.getColorTheme(),
                        brightness: Brightness.light,
                      ),
                useMaterial3: true,
              ),
              darkTheme: ThemeData(
                colorScheme: logic.state.settings["isMonetColor"]
                    ? darkDynamic
                    : ColorScheme.fromSeed(
                        seedColor: logic.getColorTheme(),
                        brightness: Brightness.dark,
                      ),
                useMaterial3: true,
              ),
              themeMode: logic.getThemeMode(),
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              getPages: RouteConfig.getPages,
              initialRoute: RouteConfig.appMain,
              locale: logic.getLocale(),
              localeResolutionCallback:
                  (Locale? deviceLocale, Iterable<Locale> supportedLocales) {
                String language = logic.state.settings["language"];
                return Locale(language.split("-")[0], language.split("-")[1]);
              },
            );
          });
        });
      },
    );
  }
}
