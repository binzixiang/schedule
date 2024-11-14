// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh_CN locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'zh_CN';

  static String m0(lesson) => "第${lesson}节课";

  static String m1(balance) => "余额：￥${balance}";

  static String m2(score) => "绩点：${score}";

  static String m3(time) => "考试时间：${time}";

  static String m4(className) => "课程名称：${className}";

  static String m5(room) => "上课地点：${room}";

  static String m6(teacher) => "课程教师：${teacher}";

  static String m7(time) => "上课时间：${time}";

  static String m8(week) => "第${week}周";

  static String m9(year, month) => "${year}/${month}月";

  static String m10(version) => "当前版本 ${version}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "app_main_exit_app": MessageLookupByLibrary.simpleMessage("再按一次退出应用"),
        "app_main_function": MessageLookupByLibrary.simpleMessage("功能"),
        "app_main_person": MessageLookupByLibrary.simpleMessage("我的"),
        "app_main_schedule": MessageLookupByLibrary.simpleMessage("课表"),
        "blue_color": MessageLookupByLibrary.simpleMessage("蓝色"),
        "camera_appBar_title": MessageLookupByLibrary.simpleMessage("摄像头预览"),
        "deep_purple_color": MessageLookupByLibrary.simpleMessage("深紫色"),
        "function_all_course_loading":
            MessageLookupByLibrary.simpleMessage("正在加载..."),
        "function_all_course_title":
            MessageLookupByLibrary.simpleMessage("全校课表"),
        "function_area_name": MessageLookupByLibrary.simpleMessage("功能区域"),
        "function_drink": MessageLookupByLibrary.simpleMessage("慧生活798"),
        "function_drink_btn_status_disable":
            MessageLookupByLibrary.simpleMessage("结算"),
        "function_drink_btn_status_enable":
            MessageLookupByLibrary.simpleMessage("喝水"),
        "function_drink_device_manage":
            MessageLookupByLibrary.simpleMessage("设备管理"),
        "function_drink_device_qr_code":
            MessageLookupByLibrary.simpleMessage("扫描设备二维码"),
        "function_drink_favorite_fail":
            MessageLookupByLibrary.simpleMessage("收藏失败！"),
        "function_drink_favorite_success":
            MessageLookupByLibrary.simpleMessage("收藏成功！"),
        "function_drink_switch_end_fail":
            MessageLookupByLibrary.simpleMessage("结算失败！"),
        "function_drink_switch_end_success":
            MessageLookupByLibrary.simpleMessage("结算成功！"),
        "function_drink_switch_start_fail":
            MessageLookupByLibrary.simpleMessage("开启设备失败！"),
        "function_drink_switch_start_success":
            MessageLookupByLibrary.simpleMessage("开启设备成功！"),
        "function_drink_token_manage_label":
            MessageLookupByLibrary.simpleMessage("Token"),
        "function_drink_token_manage_title":
            MessageLookupByLibrary.simpleMessage("Token管理"),
        "function_drink_unfavorite":
            MessageLookupByLibrary.simpleMessage("取消收藏"),
        "function_empty_classroom": MessageLookupByLibrary.simpleMessage("空教室"),
        "function_empty_classroom_what_lesson": m0,
        "function_exam_plan": MessageLookupByLibrary.simpleMessage("考试计划"),
        "function_exam_plan_empty":
            MessageLookupByLibrary.simpleMessage("暂无考试安排"),
        "function_hot_water": MessageLookupByLibrary.simpleMessage("河西用水"),
        "function_hot_water_btn_status_disable":
            MessageLookupByLibrary.simpleMessage("结束"),
        "function_hot_water_btn_status_enable":
            MessageLookupByLibrary.simpleMessage("开始"),
        "function_hot_water_campus_balance": m1,
        "function_hot_water_have_device_not_off":
            MessageLookupByLibrary.simpleMessage("您有设备未关闭！"),
        "function_life_assistant_area_name":
            MessageLookupByLibrary.simpleMessage("生活助手"),
        "function_score_empty": MessageLookupByLibrary.simpleMessage("暂无成绩"),
        "function_score_gpa": m2,
        "function_score_title": MessageLookupByLibrary.simpleMessage("成绩查询"),
        "function_social_exams": MessageLookupByLibrary.simpleMessage("社会考试"),
        "function_social_exams_time": m3,
        "function_teacher_no_data":
            MessageLookupByLibrary.simpleMessage("暂无教师数据"),
        "function_teacher_search_hint":
            MessageLookupByLibrary.simpleMessage("教师姓名"),
        "function_teacher_title": MessageLookupByLibrary.simpleMessage("教师课表"),
        "green_color": MessageLookupByLibrary.simpleMessage("绿色"),
        "lime_color": MessageLookupByLibrary.simpleMessage("青柠色"),
        "login_captcha_hint": MessageLookupByLibrary.simpleMessage("验证码"),
        "login_captcha_not_empty":
            MessageLookupByLibrary.simpleMessage("验证码不能为空"),
        "login_drink_login_fail":
            MessageLookupByLibrary.simpleMessage("登录失败！请检查手机号或验证码是否正确！"),
        "login_drink_login_success":
            MessageLookupByLibrary.simpleMessage("登录成功！"),
        "login_drink_message_code_fail":
            MessageLookupByLibrary.simpleMessage("获取短信验证码失败！"),
        "login_drink_message_code_success":
            MessageLookupByLibrary.simpleMessage("获取短信验证码成功！"),
        "login_fail": MessageLookupByLibrary.simpleMessage("登录失败"),
        "login_flushbar_title_error":
            MessageLookupByLibrary.simpleMessage("错误"),
        "login_hut_login_fail":
            MessageLookupByLibrary.simpleMessage("登录失败！请检查账号或密码是否正确！"),
        "login_hut_login_success":
            MessageLookupByLibrary.simpleMessage("登录成功！"),
        "login_login_button": MessageLookupByLibrary.simpleMessage("登录"),
        "login_message_code_hint":
            MessageLookupByLibrary.simpleMessage("短信验证码"),
        "login_message_code_not_empty":
            MessageLookupByLibrary.simpleMessage("短信验证码不能为空"),
        "login_password_hint": MessageLookupByLibrary.simpleMessage("密码"),
        "login_password_not_empty":
            MessageLookupByLibrary.simpleMessage("密码不能为空"),
        "login_send_message_code":
            MessageLookupByLibrary.simpleMessage("发送验证码"),
        "login_statue": MessageLookupByLibrary.simpleMessage("登录状态"),
        "login_tile": MessageLookupByLibrary.simpleMessage("登录"),
        "login_timeout": MessageLookupByLibrary.simpleMessage("登录超时"),
        "login_user_hint": MessageLookupByLibrary.simpleMessage("用户名"),
        "login_user_not_empty": MessageLookupByLibrary.simpleMessage("用户名不能为空"),
        "person_contact": MessageLookupByLibrary.simpleMessage("加入交流"),
        "person_join_qq_group": MessageLookupByLibrary.simpleMessage("加入QQ群"),
        "person_join_qq_group_tip":
            MessageLookupByLibrary.simpleMessage("QQ群号：161324332"),
        "person_login": MessageLookupByLibrary.simpleMessage("登录"),
        "person_logout": MessageLookupByLibrary.simpleMessage("退出登录"),
        "person_logout_tip": MessageLookupByLibrary.simpleMessage("确定退出登录？"),
        "person_semester_tip": MessageLookupByLibrary.simpleMessage("学期"),
        "person_start_day_tip": MessageLookupByLibrary.simpleMessage("开始日期"),
        "pickerCancel": MessageLookupByLibrary.simpleMessage("取消"),
        "pickerConfirm": MessageLookupByLibrary.simpleMessage("确认"),
        "pink_color": MessageLookupByLibrary.simpleMessage("粉色"),
        "schedule_course_detail": MessageLookupByLibrary.simpleMessage("课程详情"),
        "schedule_course_name": m4,
        "schedule_course_room": m5,
        "schedule_course_teacher": m6,
        "schedule_course_time": m7,
        "schedule_course_time_tile":
            MessageLookupByLibrary.simpleMessage("一&二&三&四&五"),
        "schedule_current_week": m8,
        "schedule_week_tile":
            MessageLookupByLibrary.simpleMessage("周一&周二&周三&周四&周五&周六&周日"),
        "schedule_year_and_month": m9,
        "setting_about_application":
            MessageLookupByLibrary.simpleMessage("作者：易秋"),
        "setting_about_application_name":
            MessageLookupByLibrary.simpleMessage("强智课表"),
        "setting_choice_color_sub_title":
            MessageLookupByLibrary.simpleMessage("个性化全局配色"),
        "setting_choice_color_theme":
            MessageLookupByLibrary.simpleMessage("选择主题颜色"),
        "setting_current_version": m10,
        "setting_follow_system": MessageLookupByLibrary.simpleMessage("跟随系统"),
        "setting_group_about": MessageLookupByLibrary.simpleMessage("关于"),
        "setting_group_interface": MessageLookupByLibrary.simpleMessage("界面"),
        "setting_group_language": MessageLookupByLibrary.simpleMessage("语言"),
        "setting_interface_theme":
            MessageLookupByLibrary.simpleMessage("选择深浅主题"),
        "setting_switch_language_tip":
            MessageLookupByLibrary.simpleMessage("切换语言"),
        "setting_switch_monet_color":
            MessageLookupByLibrary.simpleMessage("莫奈取色"),
        "setting_switch_monet_color_sub":
            MessageLookupByLibrary.simpleMessage("动态获取桌面壁纸颜色"),
        "setting_theme_dark": MessageLookupByLibrary.simpleMessage("深色主题"),
        "setting_theme_light": MessageLookupByLibrary.simpleMessage("浅色主题"),
        "setting_title": MessageLookupByLibrary.simpleMessage("设置"),
        "setting_update_main_text":
            MessageLookupByLibrary.simpleMessage("版本更新"),
        "setting_update_method": MessageLookupByLibrary.simpleMessage("更新方式"),
        "setting_update_method_github":
            MessageLookupByLibrary.simpleMessage("GitHub"),
        "setting_update_method_yuque":
            MessageLookupByLibrary.simpleMessage("语雀"),
        "snackbar_tip": MessageLookupByLibrary.simpleMessage("提示"),
        "update_dialog_cancel": MessageLookupByLibrary.simpleMessage("取消"),
        "update_dialog_confirm": MessageLookupByLibrary.simpleMessage("确定"),
        "update_dialog_current_is_last_version":
            MessageLookupByLibrary.simpleMessage("当前已是最新版本！"),
        "update_dialog_snackbar_vpn":
            MessageLookupByLibrary.simpleMessage("如果遇到下载失败请开启VPN"),
        "update_dialog_version_fail":
            MessageLookupByLibrary.simpleMessage("版本获取失败！")
      };
}
