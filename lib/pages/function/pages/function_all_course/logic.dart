import 'dart:convert';

import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker_plus/picker.dart';
import 'package:get/get.dart';
import 'package:schedule/common/api/schedule/v2/schedule_query_api_v2.dart';
import 'package:schedule/common/manager/data_storage_manager.dart';

import '../../../../generated/l10n.dart';
import '../../../../global_logic.dart';
import 'state.dart';

class FunctionAllCourseLogic extends GetxController {
  final FunctionAllCourseState state = FunctionAllCourseState();
  final globalState = Get.find<GlobalLogic>().state;

  final queryApi = ScheduleQueryApiV2();
  final storage = DataStorageManager();

  /// 选择周次
  void selectWeekConfirm(Picker picker, List<int> value) {
    state.week.value = (value[0] + 1).toString();
    Map<String, dynamic> major = getMajorIdByName(
        state.collegeAndMajorIndex[0],
        state.pickerData[state.collegeAndMajorIndex[0]]
            .children![state.collegeAndMajorIndex[1]].value!);
    getCourseData(
      major["majorId"],
      state.week.value,
      major["grade"].toString(),
      major["collegeId"],
      major["classId"],
    );
  }

  /// 选择学院和专业
  void selectCollegeAndMajorConfirm(Picker picker, List<int> value) {
    Map<String, dynamic> major = getMajorIdByName(
      state.collegeAndMajorIndex[0],
      state.pickerData[value[0]].children![value[1]].value!,
    );

    // 获取课程信息
    getCourseData(
      major["majorId"],
      state.week.value,
      major["grade"].toString(),
      major["collegeId"],
      major["classId"],
    );
    state.collegeAndMajorIndex = value;
  }

  /// 初始化
  Future<void> init() async {
    // var data = await queryApi.queryCollegeInfo();
    // queryApi.queryMajorInfo(
    //     collegeId: data[0]["collegeId"]);
    // return;

    // 读取缓存数据
    String? originCollegeInfoStr =
        storage.getString("functionAllCourseOriginCollegeInfo");
    if (originCollegeInfoStr != null) {
      refreshData();

      List originCollegeInfo = (jsonDecode(originCollegeInfoStr) as List);
      state.originCollegeInfo = originCollegeInfo;
      state.pickerData.clear();
      state.pickerData.addAll(originCollegeInfo
          .map((e) => PickerItem<String>(
              value: e["collegeName"],
              children: <PickerItem<String>>[PickerItem<String>(value: "")]))
          .toList());

      String? originCollegeInfoChildrenStr =
          storage.getString("functionAllCourseOriginCollegeInfoChildren");
      if (originCollegeInfoChildrenStr != null) {
        List originCollegeInfoChildren =
            jsonDecode(originCollegeInfoChildrenStr);
        state.originMajorInfo = originCollegeInfoChildren;
        for (int i = 0; i < originCollegeInfoChildren.length; i++) {
          state.pickerData[i].children?.clear();
          List list = originCollegeInfoChildren[i];
          state.pickerData[i].children?.addAll(list
              .map((e) => PickerItem<String>(value: e["majorName"]))
              .toList());
        }
      }

      await reGetNetworkData();
    } else {
      await reGetNetworkData();
    }

    // 获取课程信息
    Map<String, dynamic> major =
        getMajorIdByName(0, state.pickerData[0].children![0].value!);
    getCourseData(
      major["majorId"],
      state.week.value,
      major["grade"].toString(),
      major["collegeId"],
      major["classId"],
    );
    state.isLoad.value = false;
    update();
  }

  /// 重新初始化网络数据
  Future<void> reGetNetworkData() async {
    // 每隔7天检测一次
    if (storage.getString("lastFunctionAllCourseGetDataTime") != null) {
      DateTime lastCheckVersionTime =
      DateTime.parse(storage.getString("lastFunctionAllCourseGetDataTime")!);
      if (DateTime.now().difference(lastCheckVersionTime).inDays < 7) {
        return;
      }
    } else {
      storage.setString("lastFunctionAllCourseGetDataTime", DateTime.now().toString());
    }

    // 获取学院信息
    await queryApi.queryCollegeInfo().then((value) {
      state.originCollegeInfo = value;
      storage.setString(
          "functionAllCourseOriginCollegeInfo", jsonEncode(value));
      state.pickerData.clear();
      state.pickerData.addAll(state.originCollegeInfo
          .map((e) => PickerItem<String>(
              value: e["collegeName"],
              children: <PickerItem<String>>[PickerItem<String>(value: "")]))
          .toList());
    });

    // 多线程并发
    List<Future<List<Map<String, dynamic>>>> task = [];
    for (int i = 0; i < state.pickerData.length; i++) {
      task.add(queryApi.queryMajorInfo(
          collegeId: getCollegeIdByName(state.pickerData[i].value!)));
    }

    final result = await Future.wait(task);
    storage.setString(
        "functionAllCourseOriginCollegeInfoChildren", jsonEncode(result));
    for (int i = 0; i < state.pickerData.length; i++) {
      state.pickerData[i].children?.clear();
      state.pickerData[i].children?.addAll(result[i]
          .map((e) => PickerItem<String>(value: e["majorName"]))
          .toList());
    }

    // 保存检测时间
    storage.setString("lastFunctionAllCourseGetDataTime", DateTime.now().toString());
  }

  /// 刷新数据
  Future<void> refreshData() async {
    // 获取学院信息
    await queryApi.queryCollegeInfo().then((value) {
      state.originCollegeInfo = value;
      storage.setString(
          "functionAllCourseOriginCollegeInfo", jsonEncode(value));
    });

    // 多线程并发
    List<Future<List<Map<String, dynamic>>>> task = [];
    for (int i = 0; i < state.pickerData.length; i++) {
      task.add(queryApi.queryMajorInfo(
          collegeId: getCollegeIdByName(state.pickerData[i].value!)));
    }

    Future.delayed(const Duration(seconds: 1), () {
      Future.wait(task).then((value) {
        storage.setString(
            "functionAllCourseOriginCollegeInfoChildren", jsonEncode(value));
      });
    });
  }

  /// 获取adapter
  PickerDataAdapter<String> getClassPickerData() {
    return PickerDataAdapter<String>(
      data: state.pickerData,
      isArray: false,
    );
  }

  /// 根据名称获取学院ID
  String getCollegeIdByName(String collegeName) {
    return state.originCollegeInfo.firstWhere(
        (element) => element["collegeName"] == collegeName)["collegeId"];
  }

  /// 根据名称获取专业ID
  Map<String, dynamic> getMajorIdByName(int collegeIndex, String majorName) {
    return state.originMajorInfo[collegeIndex]
        .firstWhere((element) => element["majorName"] == majorName);
  }

  /// 获取周次数据
  PickerDataAdapter getWeekPickerData(BuildContext context) {
    List<PickerItem<String>> weekPickerData = List.generate(20, (index) {
      return PickerItem<String>(
        value: S.of(context).schedule_current_week(index + 1),
      );
    });
    return PickerDataAdapter<String>(
      data: weekPickerData,
      isArray: false,
    );
  }

  /// 获取课程表数据
  Future<void> getCourseData(String majorId, String week, String grade,
      String collegeId, String classId) async {
    await queryApi
        .queryMajorCourse(
            week: week,
            semester: globalState.semesterWeekData["semester"],
            grade: grade,
            collegeId: collegeId,
            majorId: majorId,
            classId: classId,
            cachePolicy: CachePolicy.refresh)
        .then((value) {
      // logger.i(value);
      state.courseData.value = value;
      update();
    });
  }
}
