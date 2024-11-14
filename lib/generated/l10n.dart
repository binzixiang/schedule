// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `schedule`
  String get app_main_schedule {
    return Intl.message(
      'schedule',
      name: 'app_main_schedule',
      desc: '',
      args: [],
    );
  }

  /// `function`
  String get app_main_function {
    return Intl.message(
      'function',
      name: 'app_main_function',
      desc: '',
      args: [],
    );
  }

  /// `person`
  String get app_main_person {
    return Intl.message(
      'person',
      name: 'app_main_person',
      desc: '',
      args: [],
    );
  }

  /// `Press again to exit the app`
  String get app_main_exit_app {
    return Intl.message(
      'Press again to exit the app',
      name: 'app_main_exit_app',
      desc: '',
      args: [],
    );
  }

  /// `Login status`
  String get login_statue {
    return Intl.message(
      'Login status',
      name: 'login_statue',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login_tile {
    return Intl.message(
      'Login',
      name: 'login_tile',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get login_user_hint {
    return Intl.message(
      'Name',
      name: 'login_user_hint',
      desc: '',
      args: [],
    );
  }

  /// `Name cannot be empty`
  String get login_user_not_empty {
    return Intl.message(
      'Name cannot be empty',
      name: 'login_user_not_empty',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get login_password_hint {
    return Intl.message(
      'Password',
      name: 'login_password_hint',
      desc: '',
      args: [],
    );
  }

  /// `Message code`
  String get login_message_code_hint {
    return Intl.message(
      'Message code',
      name: 'login_message_code_hint',
      desc: '',
      args: [],
    );
  }

  /// `Password cannot be empty`
  String get login_password_not_empty {
    return Intl.message(
      'Password cannot be empty',
      name: 'login_password_not_empty',
      desc: '',
      args: [],
    );
  }

  /// `Captcha cannot be empty`
  String get login_captcha_not_empty {
    return Intl.message(
      'Captcha cannot be empty',
      name: 'login_captcha_not_empty',
      desc: '',
      args: [],
    );
  }

  /// `Message code cannot be empty`
  String get login_message_code_not_empty {
    return Intl.message(
      'Message code cannot be empty',
      name: 'login_message_code_not_empty',
      desc: '',
      args: [],
    );
  }

  /// `LOGIN`
  String get login_login_button {
    return Intl.message(
      'LOGIN',
      name: 'login_login_button',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get login_flushbar_title_error {
    return Intl.message(
      'Error',
      name: 'login_flushbar_title_error',
      desc: '',
      args: [],
    );
  }

  /// `Login failed`
  String get login_fail {
    return Intl.message(
      'Login failed',
      name: 'login_fail',
      desc: '',
      args: [],
    );
  }

  /// `Login timeout`
  String get login_timeout {
    return Intl.message(
      'Login timeout',
      name: 'login_timeout',
      desc: '',
      args: [],
    );
  }

  /// `Captcha`
  String get login_captcha_hint {
    return Intl.message(
      'Captcha',
      name: 'login_captcha_hint',
      desc: '',
      args: [],
    );
  }

  /// `Send code`
  String get login_send_message_code {
    return Intl.message(
      'Send code',
      name: 'login_send_message_code',
      desc: '',
      args: [],
    );
  }

  /// `Obtained the SMS verification code successfully!`
  String get login_drink_message_code_success {
    return Intl.message(
      'Obtained the SMS verification code successfully!',
      name: 'login_drink_message_code_success',
      desc: '',
      args: [],
    );
  }

  /// `Failed to obtain SMS verification code!`
  String get login_drink_message_code_fail {
    return Intl.message(
      'Failed to obtain SMS verification code!',
      name: 'login_drink_message_code_fail',
      desc: '',
      args: [],
    );
  }

  /// `Login success!`
  String get login_drink_login_success {
    return Intl.message(
      'Login success!',
      name: 'login_drink_login_success',
      desc: '',
      args: [],
    );
  }

  /// `Please check if the mobile phone number or verification code is correct!`
  String get login_drink_login_fail {
    return Intl.message(
      'Please check if the mobile phone number or verification code is correct!',
      name: 'login_drink_login_fail',
      desc: '',
      args: [],
    );
  }

  /// `Login success!`
  String get login_hut_login_success {
    return Intl.message(
      'Login success!',
      name: 'login_hut_login_success',
      desc: '',
      args: [],
    );
  }

  /// `Please check if the account or password is correct!`
  String get login_hut_login_fail {
    return Intl.message(
      'Please check if the account or password is correct!',
      name: 'login_hut_login_fail',
      desc: '',
      args: [],
    );
  }

  /// `Mon&Tues&Wed&Thur&Fri&Sat&Sun`
  String get schedule_week_tile {
    return Intl.message(
      'Mon&Tues&Wed&Thur&Fri&Sat&Sun',
      name: 'schedule_week_tile',
      desc: '',
      args: [],
    );
  }

  /// `1st&2nd&3rd&4th&5th`
  String get schedule_course_time_tile {
    return Intl.message(
      '1st&2nd&3rd&4th&5th',
      name: 'schedule_course_time_tile',
      desc: '',
      args: [],
    );
  }

  /// `Week {week}`
  String schedule_current_week(Object week) {
    return Intl.message(
      'Week $week',
      name: 'schedule_current_week',
      desc: '',
      args: [week],
    );
  }

  /// `{year}/{month} Month`
  String schedule_year_and_month(Object year, Object month) {
    return Intl.message(
      '$year/$month Month',
      name: 'schedule_year_and_month',
      desc: '',
      args: [year, month],
    );
  }

  /// `Course details`
  String get schedule_course_detail {
    return Intl.message(
      'Course details',
      name: 'schedule_course_detail',
      desc: '',
      args: [],
    );
  }

  /// `Course name: {className}`
  String schedule_course_name(Object className) {
    return Intl.message(
      'Course name: $className',
      name: 'schedule_course_name',
      desc: '',
      args: [className],
    );
  }

  /// `Teacher: {teacher}`
  String schedule_course_teacher(Object teacher) {
    return Intl.message(
      'Teacher: $teacher',
      name: 'schedule_course_teacher',
      desc: '',
      args: [teacher],
    );
  }

  /// `Classroom: {room}`
  String schedule_course_room(Object room) {
    return Intl.message(
      'Classroom: $room',
      name: 'schedule_course_room',
      desc: '',
      args: [room],
    );
  }

  /// `Time: {time}`
  String schedule_course_time(Object time) {
    return Intl.message(
      'Time: $time',
      name: 'schedule_course_time',
      desc: '',
      args: [time],
    );
  }

  /// `Function area`
  String get function_area_name {
    return Intl.message(
      'Function area',
      name: 'function_area_name',
      desc: '',
      args: [],
    );
  }

  /// `Life assistant`
  String get function_life_assistant_area_name {
    return Intl.message(
      'Life assistant',
      name: 'function_life_assistant_area_name',
      desc: '',
      args: [],
    );
  }

  /// `Score`
  String get function_score_title {
    return Intl.message(
      'Score',
      name: 'function_score_title',
      desc: '',
      args: [],
    );
  }

  /// `All courses`
  String get function_all_course_title {
    return Intl.message(
      'All courses',
      name: 'function_all_course_title',
      desc: '',
      args: [],
    );
  }

  /// `ILife`
  String get function_drink {
    return Intl.message(
      'ILife',
      name: 'function_drink',
      desc: '',
      args: [],
    );
  }

  /// `Social exams`
  String get function_social_exams {
    return Intl.message(
      'Social exams',
      name: 'function_social_exams',
      desc: '',
      args: [],
    );
  }

  /// `Empty classroom`
  String get function_empty_classroom {
    return Intl.message(
      'Empty classroom',
      name: 'function_empty_classroom',
      desc: '',
      args: [],
    );
  }

  /// `Teacher schedule`
  String get function_teacher_title {
    return Intl.message(
      'Teacher schedule',
      name: 'function_teacher_title',
      desc: '',
      args: [],
    );
  }

  /// `Exam schedule`
  String get function_exam_plan {
    return Intl.message(
      'Exam schedule',
      name: 'function_exam_plan',
      desc: '',
      args: [],
    );
  }

  /// `HeXi water`
  String get function_hot_water {
    return Intl.message(
      'HeXi water',
      name: 'function_hot_water',
      desc: '',
      args: [],
    );
  }

  /// `GPA:{score}`
  String function_score_gpa(Object score) {
    return Intl.message(
      'GPA:$score',
      name: 'function_score_gpa',
      desc: '',
      args: [score],
    );
  }

  /// `No score information`
  String get function_score_empty {
    return Intl.message(
      'No score information',
      name: 'function_score_empty',
      desc: '',
      args: [],
    );
  }

  /// `Time:{time}`
  String function_social_exams_time(Object time) {
    return Intl.message(
      'Time:$time',
      name: 'function_social_exams_time',
      desc: '',
      args: [time],
    );
  }

  /// `Loading...`
  String get function_all_course_loading {
    return Intl.message(
      'Loading...',
      name: 'function_all_course_loading',
      desc: '',
      args: [],
    );
  }

  /// `Lesson {lesson}`
  String function_empty_classroom_what_lesson(Object lesson) {
    return Intl.message(
      'Lesson $lesson',
      name: 'function_empty_classroom_what_lesson',
      desc: '',
      args: [lesson],
    );
  }

  /// `No exam information`
  String get function_exam_plan_empty {
    return Intl.message(
      'No exam information',
      name: 'function_exam_plan_empty',
      desc: '',
      args: [],
    );
  }

  /// `Teacher name`
  String get function_teacher_search_hint {
    return Intl.message(
      'Teacher name',
      name: 'function_teacher_search_hint',
      desc: '',
      args: [],
    );
  }

  /// `No teacher information`
  String get function_teacher_no_data {
    return Intl.message(
      'No teacher information',
      name: 'function_teacher_no_data',
      desc: '',
      args: [],
    );
  }

  /// `Drink`
  String get function_drink_btn_status_enable {
    return Intl.message(
      'Drink',
      name: 'function_drink_btn_status_enable',
      desc: '',
      args: [],
    );
  }

  /// `Billing`
  String get function_drink_btn_status_disable {
    return Intl.message(
      'Billing',
      name: 'function_drink_btn_status_disable',
      desc: '',
      args: [],
    );
  }

  /// `The device is turned on successfully!`
  String get function_drink_switch_start_success {
    return Intl.message(
      'The device is turned on successfully!',
      name: 'function_drink_switch_start_success',
      desc: '',
      args: [],
    );
  }

  /// `Failed to turn on the device!`
  String get function_drink_switch_start_fail {
    return Intl.message(
      'Failed to turn on the device!',
      name: 'function_drink_switch_start_fail',
      desc: '',
      args: [],
    );
  }

  /// `Collected successfully!`
  String get function_drink_switch_end_success {
    return Intl.message(
      'Collected successfully!',
      name: 'function_drink_switch_end_success',
      desc: '',
      args: [],
    );
  }

  /// `Bookmark failed!`
  String get function_drink_switch_end_fail {
    return Intl.message(
      'Bookmark failed!',
      name: 'function_drink_switch_end_fail',
      desc: '',
      args: [],
    );
  }

  /// `Unfavorite`
  String get function_drink_unfavorite {
    return Intl.message(
      'Unfavorite',
      name: 'function_drink_unfavorite',
      desc: '',
      args: [],
    );
  }

  /// `Collected successfully!`
  String get function_drink_favorite_success {
    return Intl.message(
      'Collected successfully!',
      name: 'function_drink_favorite_success',
      desc: '',
      args: [],
    );
  }

  /// `Bookmark failed!`
  String get function_drink_favorite_fail {
    return Intl.message(
      'Bookmark failed!',
      name: 'function_drink_favorite_fail',
      desc: '',
      args: [],
    );
  }

  /// `Device management`
  String get function_drink_device_manage {
    return Intl.message(
      'Device management',
      name: 'function_drink_device_manage',
      desc: '',
      args: [],
    );
  }

  /// `Device QR code`
  String get function_drink_device_qr_code {
    return Intl.message(
      'Device QR code',
      name: 'function_drink_device_qr_code',
      desc: '',
      args: [],
    );
  }

  /// `Token management`
  String get function_drink_token_manage_title {
    return Intl.message(
      'Token management',
      name: 'function_drink_token_manage_title',
      desc: '',
      args: [],
    );
  }

  /// `Token`
  String get function_drink_token_manage_label {
    return Intl.message(
      'Token',
      name: 'function_drink_token_manage_label',
      desc: '',
      args: [],
    );
  }

  /// `Start`
  String get function_hot_water_btn_status_enable {
    return Intl.message(
      'Start',
      name: 'function_hot_water_btn_status_enable',
      desc: '',
      args: [],
    );
  }

  /// `End`
  String get function_hot_water_btn_status_disable {
    return Intl.message(
      'End',
      name: 'function_hot_water_btn_status_disable',
      desc: '',
      args: [],
    );
  }

  /// `The device is not turned off, please turn off the device first!`
  String get function_hot_water_have_device_not_off {
    return Intl.message(
      'The device is not turned off, please turn off the device first!',
      name: 'function_hot_water_have_device_not_off',
      desc: '',
      args: [],
    );
  }

  /// `balance:￥{balance}`
  String function_hot_water_campus_balance(Object balance) {
    return Intl.message(
      'balance:￥$balance',
      name: 'function_hot_water_campus_balance',
      desc: '',
      args: [balance],
    );
  }

  /// `Semester`
  String get person_semester_tip {
    return Intl.message(
      'Semester',
      name: 'person_semester_tip',
      desc: '',
      args: [],
    );
  }

  /// `Start day`
  String get person_start_day_tip {
    return Intl.message(
      'Start day',
      name: 'person_start_day_tip',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get person_logout {
    return Intl.message(
      'Logout',
      name: 'person_logout',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get person_login {
    return Intl.message(
      'Login',
      name: 'person_login',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to log out?`
  String get person_logout_tip {
    return Intl.message(
      'Are you sure you want to log out?',
      name: 'person_logout_tip',
      desc: '',
      args: [],
    );
  }

  /// `Contact`
  String get person_contact {
    return Intl.message(
      'Contact',
      name: 'person_contact',
      desc: '',
      args: [],
    );
  }

  /// `Join QQ group`
  String get person_join_qq_group {
    return Intl.message(
      'Join QQ group',
      name: 'person_join_qq_group',
      desc: '',
      args: [],
    );
  }

  /// `QQ group number: 161324332`
  String get person_join_qq_group_tip {
    return Intl.message(
      'QQ group number: 161324332',
      name: 'person_join_qq_group_tip',
      desc: '',
      args: [],
    );
  }

  /// `Setting`
  String get setting_title {
    return Intl.message(
      'Setting',
      name: 'setting_title',
      desc: '',
      args: [],
    );
  }

  /// `UI`
  String get setting_group_interface {
    return Intl.message(
      'UI',
      name: 'setting_group_interface',
      desc: '',
      args: [],
    );
  }

  /// `Monet color`
  String get setting_switch_monet_color {
    return Intl.message(
      'Monet color',
      name: 'setting_switch_monet_color',
      desc: '',
      args: [],
    );
  }

  /// `Dynamically get the desktop wallpaper color`
  String get setting_switch_monet_color_sub {
    return Intl.message(
      'Dynamically get the desktop wallpaper color',
      name: 'setting_switch_monet_color_sub',
      desc: '',
      args: [],
    );
  }

  /// `Select a light and shade theme`
  String get setting_interface_theme {
    return Intl.message(
      'Select a light and shade theme',
      name: 'setting_interface_theme',
      desc: '',
      args: [],
    );
  }

  /// `Light theme`
  String get setting_theme_light {
    return Intl.message(
      'Light theme',
      name: 'setting_theme_light',
      desc: '',
      args: [],
    );
  }

  /// `Dark theme`
  String get setting_theme_dark {
    return Intl.message(
      'Dark theme',
      name: 'setting_theme_dark',
      desc: '',
      args: [],
    );
  }

  /// `Select a color theme`
  String get setting_choice_color_theme {
    return Intl.message(
      'Select a color theme',
      name: 'setting_choice_color_theme',
      desc: '',
      args: [],
    );
  }

  /// `Personalize global color matching`
  String get setting_choice_color_sub_title {
    return Intl.message(
      'Personalize global color matching',
      name: 'setting_choice_color_sub_title',
      desc: '',
      args: [],
    );
  }

  /// `Follow the system`
  String get setting_follow_system {
    return Intl.message(
      'Follow the system',
      name: 'setting_follow_system',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get setting_group_language {
    return Intl.message(
      'Language',
      name: 'setting_group_language',
      desc: '',
      args: [],
    );
  }

  /// `Switch languages`
  String get setting_switch_language_tip {
    return Intl.message(
      'Switch languages',
      name: 'setting_switch_language_tip',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get setting_group_about {
    return Intl.message(
      'About',
      name: 'setting_group_about',
      desc: '',
      args: [],
    );
  }

  /// `Version updates`
  String get setting_update_main_text {
    return Intl.message(
      'Version updates',
      name: 'setting_update_main_text',
      desc: '',
      args: [],
    );
  }

  /// `Current version {version}`
  String setting_current_version(Object version) {
    return Intl.message(
      'Current version $version',
      name: 'setting_current_version',
      desc: '',
      args: [version],
    );
  }

  /// `Author: YiQiu`
  String get setting_about_application {
    return Intl.message(
      'Author: YiQiu',
      name: 'setting_about_application',
      desc: '',
      args: [],
    );
  }

  /// `QiangZhi Schedule`
  String get setting_about_application_name {
    return Intl.message(
      'QiangZhi Schedule',
      name: 'setting_about_application_name',
      desc: '',
      args: [],
    );
  }

  /// `Update method`
  String get setting_update_method {
    return Intl.message(
      'Update method',
      name: 'setting_update_method',
      desc: '',
      args: [],
    );
  }

  /// `GitHub`
  String get setting_update_method_github {
    return Intl.message(
      'GitHub',
      name: 'setting_update_method_github',
      desc: '',
      args: [],
    );
  }

  /// `YuQue`
  String get setting_update_method_yuque {
    return Intl.message(
      'YuQue',
      name: 'setting_update_method_yuque',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get update_dialog_confirm {
    return Intl.message(
      'Confirm',
      name: 'update_dialog_confirm',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get update_dialog_cancel {
    return Intl.message(
      'Cancel',
      name: 'update_dialog_cancel',
      desc: '',
      args: [],
    );
  }

  /// `If the download fails, turn on the VPN`
  String get update_dialog_snackbar_vpn {
    return Intl.message(
      'If the download fails, turn on the VPN',
      name: 'update_dialog_snackbar_vpn',
      desc: '',
      args: [],
    );
  }

  /// `The current version is the latest version!`
  String get update_dialog_current_is_last_version {
    return Intl.message(
      'The current version is the latest version!',
      name: 'update_dialog_current_is_last_version',
      desc: '',
      args: [],
    );
  }

  /// `Failed to get the latest version information!`
  String get update_dialog_version_fail {
    return Intl.message(
      'Failed to get the latest version information!',
      name: 'update_dialog_version_fail',
      desc: '',
      args: [],
    );
  }

  /// `Camera Preview`
  String get camera_appBar_title {
    return Intl.message(
      'Camera Preview',
      name: 'camera_appBar_title',
      desc: '',
      args: [],
    );
  }

  /// `Deep purple`
  String get deep_purple_color {
    return Intl.message(
      'Deep purple',
      name: 'deep_purple_color',
      desc: '',
      args: [],
    );
  }

  /// `Green`
  String get green_color {
    return Intl.message(
      'Green',
      name: 'green_color',
      desc: '',
      args: [],
    );
  }

  /// `Pink`
  String get pink_color {
    return Intl.message(
      'Pink',
      name: 'pink_color',
      desc: '',
      args: [],
    );
  }

  /// `Blue`
  String get blue_color {
    return Intl.message(
      'Blue',
      name: 'blue_color',
      desc: '',
      args: [],
    );
  }

  /// `Lime`
  String get lime_color {
    return Intl.message(
      'Lime',
      name: 'lime_color',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get pickerConfirm {
    return Intl.message(
      'Confirm',
      name: 'pickerConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get pickerCancel {
    return Intl.message(
      'Cancel',
      name: 'pickerCancel',
      desc: '',
      args: [],
    );
  }

  /// `Tip`
  String get snackbar_tip {
    return Intl.message(
      'Tip',
      name: 'snackbar_tip',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'CN'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
