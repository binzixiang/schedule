import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:schedule/common/utils/schedule_utils.dart';
import 'package:schedule/common/widget/score_card/view.dart';

import '../../../../common/utils/screen_utils.dart';
import '../../../../generated/l10n.dart';
import 'logic.dart';

class FunctionExamPlanPage extends StatelessWidget {
  FunctionExamPlanPage({super.key});

  final logic = Get.put(FunctionExamPlanLogic());
  final state = Get.find<FunctionExamPlanLogic>().state;

  @override
  Widget build(BuildContext context) {
    logic.init();

    return Scaffold(
      appBar: appBarWidget(context),
      body: CustomScrollView(
        slivers: [
          // 获取SliverList
          sliverListWidget(),
          // 暂无成绩
          emptyScoreWidget(),
        ],
      ),
    );
  }

  /// 暂无成绩
  Widget emptyScoreWidget() {
    return GetBuilder<FunctionExamPlanLogic>(builder: (logic) {
      if (logic.state.personExamList.isEmpty && !logic.state.isLoading.value) {
        return SliverPadding(
          padding: EdgeInsets.only(
            top: ScreenUtils.length(vertical: 350.w, horizon: 150.w),
          ),
          sliver: SliverToBoxAdapter(
            child: Center(
              child: Text(
                S.current.function_exam_plan_empty,
                style: TextStyle(
                  fontSize: ScreenUtils.length(vertical: 35.sp, horizon: 20.sp),
                ),
              ),
            ),
          ),
        );
      }
      return const SliverToBoxAdapter(child: SizedBox());
    });
  }

  /// 获取SliverList
  Widget sliverListWidget() {
    return GetBuilder<FunctionExamPlanLogic>(builder: (logic) {
      return SliverList.builder(
        itemCount: logic.state.personExamList.length,
        itemBuilder: (context, index) {
          return ScoreCardComponent(
            subjectName: logic.state.personExamList[index]['examName'],
            subTitle: S.of(context).function_social_exams_time(
                logic.state.personExamList[index]['examTime']),
            score: ScheduleUtils.formatAddress(
                logic.state.personExamList[index]['examAddress']),
          );
        },
      );
    });
  }

  /// 获取SliverAppBar
  PreferredSizeWidget appBarWidget(BuildContext context) {
    return AppBar(
      title: Text(
        S.of(context).function_exam_plan,
      ),
    );
  }
}
