import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:schedule/common/api/schedule/v2/schedule_user_api_v2.dart';
import '../../common/api/schedule/schedule_user_api.dart';
import '../../generated/l10n.dart';
import '../../global_logic.dart';
import '../route_config.dart';
import 'state.dart';

class SplashLogic extends GetxController {
  final SplashState state = SplashState();
  final globalState = Get.find<GlobalLogic>().state;
  final globalLogic = Get.find<GlobalLogic>();

  final userApi = ScheduleUserApiV2();

  @override
  void dispose() {
    state.animationController.dispose();
    super.dispose();
  }

  /// 初始化动画控制器
  void initAnimationController(TickerProvider vsync, BuildContext context) {
    state.animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: vsync,
    );
    state.animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // logger.i("success");
        navigateToSchedule();
      }
    });
    state.animationController.forward();
  }

  /// 跳转主页面
  /// [context] 上下文
  /// [milliseconds] 延迟时间
  void navigateToSchedule() {
    Get.offNamed(RouteConfig.appMain);
  }

  /// 自动登录教务系统
  void autoLoginEducationalSystem() {
    // 获取用户信息
    final username = globalState.scheduleUserInfo["username"];
    final password = globalState.scheduleUserInfo["password"];
    // 开始登录并超时时间为10s
    if (username == null ||
        password == null ||
        username.isEmpty ||
        password.isEmpty) {
      return;
    }

    userApi
        .loginEducationalSystem(userAccount: username, userPassword: password)
        .then((loginStatus) {
      switch (loginStatus) {
        case ScheduleUserStatus.loginTimeOut:
          Get.snackbar(
            S.current.login_statue,
            S.current.login_timeout,
            backgroundColor:
                Theme.of(Get.context!).colorScheme.primaryContainer,
            margin: EdgeInsets.only(
              top: 30.w,
              left: 50.w,
              right: 50.w,
            ),
          );
          break;
        case ScheduleUserStatus.success:
          // 储存登录成功
          globalLogic.setIsLogin(true);
          break;
        case ScheduleUserStatus.fail:
          Get.snackbar(
            S.current.login_statue,
            S.current.login_fail,
            backgroundColor:
                Theme.of(Get.context!).colorScheme.primaryContainer,
            margin: EdgeInsets.only(
              top: 30.w,
              left: 50.w,
              right: 50.w,
            ),
          );
          break;
      }
    });
  }
}
