import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:schedule/common/utils/logger_utils.dart';

import '../../../../common/utils/screen_utils.dart';
import '../../../../generated/l10n.dart';
import 'logic.dart';

class FunctionHotWaterPage extends StatelessWidget {
  FunctionHotWaterPage({super.key});

  final logic = Get.put(FunctionHotWaterLogic());
  final state = Get.find<FunctionHotWaterLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).function_hot_water),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 获取选择饮水设备按钮
          deviceDrinkRowBtnWidget(),
          // 获取点击洗澡按钮按钮
          deviceHotWaterBtnWidget(context),
        ],
      ),
    );
  }

  /// 获取选择饮水设备按钮
  Widget deviceDrinkRowBtnWidget() {
    return Padding(
      padding: EdgeInsets.only(
        top: ScreenUtils.length(vertical: 80.w, horizon: 0),
      ),
      child: GetBuilder<FunctionHotWaterLogic>(builder: (logic) {
        List<ButtonSegment<int>> list = [];
        for (int i = 0; i < logic.state.deviceList.length && i < 4; i++) {
          list.add(
            ButtonSegment(
              label: Text(
                logic.state.deviceList[i]["posname"],
                style: TextStyle(
                  fontSize: ScreenUtils.length(vertical: 28.sp, horizon: 18.sp),
                ),
              ),
              value: i,
            ),
          );
        }

        // 如果列表为空默认
        if (list.isEmpty) {
          return const SizedBox();
        }

        return SegmentedButton(
          showSelectedIcon: false,
          style: ButtonStyle(
            padding: WidgetStateProperty.all(
              EdgeInsets.symmetric(
                horizontal: ScreenUtils.length(vertical: 28.w, horizon: 18.w),
              ),
            ),
          ),
          segments: list,
          selected: {logic.state.choiceDevice.value},
          onSelectionChanged: (Set<int> newSelected) {
            if (logic.state.waterStatus.value) {
              return;
            }
            logic.setChoiceDevice(newSelected.first);
          },
        );
      }),
    );
  }

  /// 获取点击洗澡按钮按钮
  Widget deviceHotWaterBtnWidget(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(
          top: ScreenUtils.length(
            vertical: 250.w,
            horizon: 80.w,
          ),
        ),
        child: GetBuilder<FunctionHotWaterLogic>(builder: (logic) {
          return ElevatedButton(
            onPressed: () {
              if (logic.state.choiceDevice.value == -1) {
                return;
              }

              if (logic.state.waterStatus.value) {
                logic.endWater();
              } else {
                logic.startWater();
              }
            },
            style: ButtonStyle(
              elevation: WidgetStateProperty.all(13),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(1000),
                ),
              ),
              fixedSize: WidgetStateProperty.all(
                Size(
                  ScreenUtils.length(vertical: 300.w, horizon: 150.w),
                  ScreenUtils.length(vertical: 300.w, horizon: 150.w),
                ),
              ),
            ),
            child: Text(
              logic.state.waterStatus.value
                  ? S.of(context).function_hot_water_btn_status_disable
                  : S.of(context).function_hot_water_btn_status_enable,
              style: TextStyle(
                fontSize: ScreenUtils.length(vertical: 43.sp, horizon: 28.sp),
              ),
            ),
          );
        }),
      ),
    );
  }
}