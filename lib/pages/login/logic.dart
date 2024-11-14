import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:schedule/common/api/drink/drink_api.dart';
import 'package:schedule/common/api/schedule/schedule_user_api.dart';
import 'package:schedule/common/api/schedule/v2/schedule_user_api_v2.dart';
import 'package:schedule/pages/app_main/app_main_route_config.dart';
import 'package:schedule/pages/login/view.dart';
import 'package:schedule/pages/schedule/logic.dart';

import '../../common/api/hut/hut_user_api.dart';
import '../../generated/l10n.dart';
import '../../global_logic.dart';
import '../app_main/logic.dart';
import '../function/function_route_config.dart';
import 'state.dart';

class LoginLogic extends GetxController {
  final LoginState state = LoginState();
  final globalLogic = Get.find<GlobalLogic>();
  final globalState = Get.find<GlobalLogic>().state;

  final userApi = ScheduleUserApiV2();
  final drinkApi = DrinkApi();
  final hutUserApi = HutUserApi();

  void init(LoginPageType type) {
    switch (type) {
      case LoginPageType.schedule:
        break;
      case LoginPageType.hui798:
        Future.delayed(const Duration(milliseconds: 300), () {
          getDrinkPhotoCaptchaData();
        });
        break;
      case LoginPageType.hut:
        break;
      default:
        break;
    }
  }

  Future<void> changeTextFieldCallback(InputData inputData) async {
    state.name = inputData.name;
    state.password = inputData.password;
    state.confirmPassword = inputData.confirmPassword;
    state.captcha = inputData.captcha;
    state.messageCode = inputData.messageCode;
  }

  /// 获取图片验证码
  void getDrinkPhotoCaptchaData() {
    state.doubleRandom = Random().nextDouble();
    state.captchaData.value = drinkApi.userCaptcha(
      doubleRandom: state.doubleRandom.toString(),
      timestamp: DateTime.timestamp().millisecondsSinceEpoch.toString(),
    );
    update();
  }

  /// 获取短信验证码
  Future<bool> getDrinkMessageCaptcha(String photoCode, String phone) async {
    return await drinkApi.userMessageCode(
      doubleRandom: state.doubleRandom.toString(),
      photoCode: photoCode,
      phone: phone,
    );
  }

  /// 点击发送验证码点击事件
  void onSendCaptchaDrink() {
    // 如果验证码不为0则退出
    if (state.time.value != 0) {
      return;
    }
    String phone = state.name;
    String photoCode = state.captcha;
    // 获取短信验证码
    getDrinkMessageCaptcha(photoCode, phone).then((value) {
      if (value) {
        Get.snackbar(
          S.current.snackbar_tip,
          S.current.login_drink_message_code_success,
          backgroundColor: Theme.of(Get.context!).colorScheme.primaryContainer,
          margin: EdgeInsets.only(
            top: 30.w,
            left: 50.w,
            right: 50.w,
          ),
        );
      } else {
        Get.snackbar(
          S.current.snackbar_tip,
          S.current.login_drink_message_code_fail,
          backgroundColor: Theme.of(Get.context!).colorScheme.primaryContainer,
          margin: EdgeInsets.only(
            top: 30.w,
            left: 50.w,
            right: 50.w,
          ),
        );

        getDrinkPhotoCaptchaData();
        state.time.value = 0;
        state.captchaTimer?.cancel();
        update();
      }
    });

    // 防止内存泄露
    state.captchaTimer?.cancel();
    state.time.value = 5;
    state.captchaTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      state.time.value--;
      if (state.time.value <= 0) {
        timer.cancel();
      }
      update();
    });
    update();
  }

  Future<String?>? onLogin(LoginPageType type, LoginData data) async {
    switch (type) {
      case LoginPageType.schedule:
        return loginEducationalSystem(data);
      case LoginPageType.hui798:
        return loginHui798Drink(data);
      case LoginPageType.hut:
        return loginHut(data);
      default:
        return loginEducationalSystem(data);
    }
  }

  /// 获取页面类型
  LoginPageType getPageType(BuildContext context) {
    Object? arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments != null && arguments is Map) {
      state.returnId = arguments["returnId"] ?? 1;
      return arguments["type"] ?? LoginPageType.schedule;
    } else {
      return LoginPageType.schedule;
    }
  }

  /// 是否隐藏验证码
  bool hideCaptchaTextField(LoginPageType type) {
    switch (type) {
      case LoginPageType.schedule:
        return true;
      case LoginPageType.hui798:
        return false;
      default:
        return true;
    }
  }

  /// 是否隐藏密码输入框
  bool hidePasswordTextField(LoginPageType type) {
    switch (type) {
      case LoginPageType.schedule:
        return false;
      case LoginPageType.hui798:
        return true;
      default:
        return false;
    }
  }

  /// 是否隐藏短信验证码输入框
  bool hideMessageCodeTextField(LoginPageType type) {
    switch (type) {
      case LoginPageType.schedule:
        return true;
      case LoginPageType.hui798:
        return false;
      default:
        return true;
    }
  }

  /// 验证码文本比例
  double captchaTextRatio(LoginPageType type) {
    switch (type) {
      case LoginPageType.hui798:
        return 2 / 3;
      default:
        return 1.0;
    }
  }

  /// 短信验证码文本比例
  double messageCodeTextRatio(LoginPageType type) {
    switch (type) {
      case LoginPageType.hui798:
        return 3 / 5;
      default:
        return 1.0;
    }
  }

  /// 登录教务系统
  Future<String?>? loginEducationalSystem(LoginData data) async {
    // 开始登录并超时时间为10s
    final loginStatus = await userApi.loginEducationalSystem(
      userAccount: data.name,
      userPassword: data.password,
    );

    switch (loginStatus) {
      case ScheduleUserStatus.loginTimeOut:
        return S.current.login_timeout;
      case ScheduleUserStatus.success:
        // 保存用户信息
        await globalLogic.setScheduleUserInfo("username", data.name);
        await globalLogic.setScheduleUserInfo("password", data.password);

        return null;
      case ScheduleUserStatus.fail:
        return S.current.login_fail;
    }
  }

  /// 登录HUT
  Future<String?>? loginHut(LoginData data) async {
    return await hutUserApi
        .userLogin(username: data.name, password: data.password)
        .then((value) async {
      if (value) {
        Get.snackbar(
          S.current.snackbar_tip,
          S.current.login_hut_login_success,
          backgroundColor: Theme.of(Get.context!).colorScheme.primaryContainer,
          margin: EdgeInsets.only(
            top: 30.w,
            left: 50.w,
            right: 50.w,
          ),
        );
        // 保存用户信息
        await globalLogic.setHutUserInfo("username", data.name);
        await globalLogic.setHutUserInfo("password", data.password);
        return null;
      } else {
        Get.snackbar(
          S.current.snackbar_tip,
          S.current.login_hut_login_fail,
          backgroundColor: Theme.of(Get.context!).colorScheme.primaryContainer,
          margin: EdgeInsets.only(
            top: 30.w,
            left: 50.w,
            right: 50.w,
          ),
        );
        return S.current.login_hut_login_fail;
      }
    });
  }

  /// 登录惠生活798
  Future<String?>? loginHui798Drink(LoginData data) async {
    return await drinkApi
        .userLogin(phone: data.name, messageCode: data.messageCode)
        .then((value) async {
      if (value) {
        Get.snackbar(
          S.current.snackbar_tip,
          S.current.login_drink_login_success,
          backgroundColor: Theme.of(Get.context!).colorScheme.primaryContainer,
          margin: EdgeInsets.only(
            top: 30.w,
            left: 50.w,
            right: 50.w,
          ),
        );
        // 保存用户信息
        await globalLogic.setHui798UserInfo("username", data.name);
        await globalLogic.setHui798UserInfo("password", data.password);
        return null;
      } else {
        Get.snackbar(
          S.current.snackbar_tip,
          S.current.login_drink_login_fail,
          backgroundColor: Theme.of(Get.context!).colorScheme.primaryContainer,
          margin: EdgeInsets.only(
            top: 30.w,
            left: 50.w,
            right: 50.w,
          ),
        );
        getDrinkPhotoCaptchaData();
        return S.current.login_drink_login_fail;
      }
    });
  }

  /// 用户名输入框验证
  String? userValidator(String? value) {
    if (value == null || value.isEmpty) {
      return S.current.login_user_not_empty;
    }
    return null;
  }

  /// 密码输入框验证
  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return S.current.login_password_not_empty;
    }
    return null;
  }

  /// 验证码输入框验证
  String? captchaValidator(String? value) {
    if (value == null || value.isEmpty) {
      return S.current.login_captcha_not_empty;
    }
    return null;
  }

  /// 短信验证码输入框验证
  String? messageCodeValidator(String? value) {
    if (value == null || value.isEmpty) {
      return S.current.login_message_code_not_empty;
    }
    return null;
  }

  Future<void> onSubmitAnimationCompleted(LoginPageType type) async {
    switch (type) {
      case LoginPageType.schedule:
        // 储存登录成功
        await globalLogic.setIsLogin(true);
        // Get.offAllNamed(AppMainRouteConfig.main, id: 1);
        final scheduleLogic = Get.find<ScheduleLogic>();
        scheduleLogic.init();
        Get.back(id: state.returnId);
        break;
      case LoginPageType.hui798:
        final appMainLogic = Get.find<AppMainLogic>().state;
        await globalLogic.setHui798UserInfo("hui798IsLogin", true);
        if (appMainLogic.orientation.value) {
          Get.offNamedUntil(FunctionRouteConfig.functionDrink, (route) {
            return route.settings.name == FunctionRouteConfig.main;
          }, id: 2);
        } else {
          Get.offNamed(FunctionRouteConfig.functionDrink, id: 3);
        }
        break;
      case LoginPageType.hut:
        final appMainLogic = Get.find<AppMainLogic>().state;
        await globalLogic.setHutUserInfo("hutIsLogin", true);
        if (appMainLogic.orientation.value) {
          Get.offNamedUntil(FunctionRouteConfig.functionHotWater, (route) {
            return route.settings.name == FunctionRouteConfig.main;
          }, id: 2);
        } else {
          Get.offNamed(FunctionRouteConfig.functionHotWater, id: 3);
        }
        break;
      default:
        // 储存登录成功
        await globalLogic.setIsLogin(true);
        Get.offAllNamed(AppMainRouteConfig.main, id: state.returnId);
        break;
    }
  }
}
