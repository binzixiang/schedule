import 'package:get/get.dart';
import 'package:schedule/common/api/schedule/v2/schedule_query_api_v2.dart';
import 'package:schedule/global_logic.dart';

import 'state.dart';

class FunctionExamPlanLogic extends GetxController {
  final FunctionExamPlanState state = FunctionExamPlanState();
  final globalState = Get.find<GlobalLogic>().state;
  final queryApi = ScheduleQueryApiV2();


  void init() {
    queryExamPlan();
  }

  /// 查询考试计划
  void queryExamPlan() {
    state.isLoading.value = true;
    queryApi
        .queryPersonExamPlan(semester: globalState.semesterWeekData["semester"])
        .then((value) {
      state.isLoading.value = false;
      // logger.i(value);
      // 判断字符串是否包含 类似2024-11-07的日期
      final reg = RegExp(r"\d{4}-\d{2}-\d{2}");
      // 过滤比当前日期小的考试计划
      value.removeWhere((element) {
        final match = reg.firstMatch(element["examTime"]);
        if (match == null) {
          return true;
        }

        final examTime = DateTime.parse(match.group(0)!);
        return examTime.isBefore(DateTime.now());
      });
      state.personExamList.value = value;
      update();
    });
  }
}
