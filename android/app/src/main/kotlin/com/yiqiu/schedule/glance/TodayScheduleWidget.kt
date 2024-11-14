package com.yiqiu.schedule.glance

import HomeWidgetGlanceState
import HomeWidgetGlanceStateDefinition
import android.content.Context
import androidx.compose.runtime.Composable
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.glance.GlanceId
import androidx.glance.GlanceModifier
import androidx.glance.action.clickable
import androidx.glance.appwidget.GlanceAppWidget
import androidx.glance.appwidget.cornerRadius
import androidx.glance.appwidget.lazy.LazyColumn
import androidx.glance.appwidget.lazy.itemsIndexed
import androidx.glance.appwidget.provideContent
import androidx.glance.background
import androidx.glance.color.DynamicThemeColorProviders
import androidx.glance.currentState
import androidx.glance.layout.Alignment
import androidx.glance.layout.Box
import androidx.glance.layout.Column
import androidx.glance.layout.Row
import androidx.glance.layout.Spacer
import androidx.glance.layout.fillMaxSize
import androidx.glance.layout.fillMaxWidth
import androidx.glance.layout.height
import androidx.glance.layout.padding
import androidx.glance.layout.width
import androidx.glance.text.FontWeight
import androidx.glance.text.Text
import androidx.glance.text.TextAlign
import androidx.glance.text.TextStyle
import es.antonborri.home_widget.actionStartActivity
import com.yiqiu.schedule.MainActivity
import kotlinx.serialization.json.Json
import kotlinx.serialization.json.JsonElement
import kotlinx.serialization.json.JsonObject
import kotlinx.serialization.json.jsonArray
import kotlinx.serialization.json.jsonObject
import java.util.Calendar

class TodayScheduleWidget : GlanceAppWidget() {

    /** Needed for Updating */
    override val stateDefinition = HomeWidgetGlanceStateDefinition()

    // 是否有课程
    private var hasCourse = false

    override suspend fun provideGlance(context: Context, id: GlanceId) {
        provideContent { GlanceContent(context, currentState()) }
    }

    @Composable
    private fun GlanceContent(context: Context, currentState: HomeWidgetGlanceState) {
        hasCourse = false
        val data = currentState.preferences
        val semesterWeekDataStr = handleString(data.getString("semesterWeekData", "")!!)
        val courseDataStr = handleString(data.getString("courseData", "")!!)
        val experimentDataStr = handleString(data.getString("experimentData", "")!!)

        val semesterWeekData: Map<String, String> = when(semesterWeekDataStr) {
            "" -> mapOf("currentWeek" to "1")
            else -> Json.decodeFromString(semesterWeekDataStr)
        }

        val courseData: List<JsonElement> = when(courseDataStr) {
            "" -> listOf()
            else -> Json.decodeFromString<List<List<JsonElement>>>(courseDataStr)[semesterWeekData["currentWeek"]!!.toInt() - 1]
        }

        val experimentData: List<JsonObject> = when(experimentDataStr) {
            "" -> listOf()
            else -> Json.decodeFromString<List<List<JsonObject>>>(experimentDataStr)[semesterWeekData["currentWeek"]!!.toInt() - 1]
        }

        Box(
            modifier =
            GlanceModifier.background(DynamicThemeColorProviders.secondaryContainer)
                .padding(16.dp)
                .fillMaxSize()
                .cornerRadius(15.dp)
                .clickable(onClick = actionStartActivity<MainActivity>(context))
        ) {
            Row(modifier = GlanceModifier.fillMaxWidth()) {
                val modifier = GlanceModifier.defaultWeight()

                Text(modifier = modifier,
                    text = "今天 / ${getCurrentDayOfWeekText()}",
                    style = TextStyle(fontSize = 11.sp,
                        color = DynamicThemeColorProviders.primary)
                )
                Text(modifier = modifier,
                    text = "第${semesterWeekData["currentWeek"]}周",
                    style = TextStyle(fontSize = 11.sp,
                        color = DynamicThemeColorProviders.primary,
                        textAlign = TextAlign.End)
                )
            }

            LazyColumn (
                modifier = GlanceModifier.fillMaxSize().padding(top = 25.dp),
                horizontalAlignment = Alignment.Horizontal.Start
            ) {
                val week = getCurrentDayOfWeekNumber()
                val list = mutableListOf<Int>()
                for (i in 0..4) {
                    list.add(week + i * 7 - 1)
                }

                // 课程列表
                itemsIndexed(courseData) { index, item ->
                    if (!list.contains(index) ||
                        (courseData[index] is JsonObject &&
                                courseData[index].jsonObject.isEmpty() &&
                        experimentData[index].jsonObject.isEmpty())) {
                        return@itemsIndexed
                    }

                    when(item) {
                        is JsonObject -> {
                            Column {
                                if (item.isNotEmpty()) {
                                    GetCourseCard(context, item)
                                }

                                if (experimentData[index].isNotEmpty()) {
                                    GetCourseCard(context, experimentData[index])
                                }
                            }
                        }
                        else -> {
                            Column {
                                for (course in item.jsonArray) {
                                    GetCourseCard(context, course.jsonObject)
                                }

                                if (experimentData[index].isNotEmpty()) {
                                    GetCourseCard(context, experimentData[index])
                                }
                            }
                        }
                    }
                }
            }

            if (!hasCourse) {
                Column(
                    modifier = GlanceModifier.fillMaxSize()
                        .clickable(onClick = actionStartActivity<MainActivity>(context)),
                    verticalAlignment = Alignment.Vertical.CenterVertically,
                    horizontalAlignment = Alignment.Horizontal.CenterHorizontally
                ) {
                    Text(
                        text = "没有课程啦",
                        style = TextStyle(fontSize = 14.sp, color = DynamicThemeColorProviders.primary)
                    )
                }
            }
        }
    }

    // 获取课程卡片
    @Composable
    private fun GetCourseCard(context: Context, course: JsonObject) {
        val classTimeList = course["classTime"].toString().replace("\"", "")
            .split("-")
        val currentTime = getCurrentTime()
        if (currentTime > formatTime(classTimeList[1])) {
            return
        } else {
            hasCourse = true
        }

        val className = course["className"].toString().replace("\"", "")
        val classAddress = course["classAddress"].toString().replace("\"", "")
        val classTeacher = course["classTeacher"].toString().replace("\"", "")
        val classTime = classTimeList.joinToString(separator = "\n") { formatTime(it) }

        val subText = when {
            classAddress == "" && classTeacher == "" -> ""
            classAddress == "" -> classTeacher
            classTeacher == "" -> classAddress
            else -> "$classAddress | $classTeacher"
        }

        Column {
            Row(
                modifier = GlanceModifier.height(65.dp)
                    .fillMaxWidth()
                    .background(DynamicThemeColorProviders.onSecondary.getColor(context).copy(alpha = 0.5f))
                    .cornerRadius(10.dp)
                    .padding(horizontal = 7.dp)
                    .clickable(onClick = actionStartActivity<MainActivity>(context)),
                verticalAlignment = Alignment.Vertical.CenterVertically
            ) {
                Text(
                    modifier = GlanceModifier.width(32.dp),
                    text = classTime,
                    style = TextStyle(fontSize = 11.sp,
                        color = DynamicThemeColorProviders.onBackground)
                )

                Spacer(
                    modifier = GlanceModifier.width(4.dp)
                )

                Spacer(
                    modifier = GlanceModifier.width(3.dp)
                        .height(35.dp)
                        .background(DynamicThemeColorProviders.primary)
                        .cornerRadius(5.dp)
                )

                Spacer(
                    modifier = GlanceModifier.width(9.dp)
                )

                Column {
                    Text(
                        text = className,
                        style = TextStyle(fontSize = 14.sp, fontWeight = FontWeight.Bold,
                            color = DynamicThemeColorProviders.onBackground),
                        maxLines = 1
                    )

                    Spacer(
                        modifier = GlanceModifier.height(2.dp)
                    )

                    Text(
                        text = subText,
                        style = TextStyle(fontSize = 11.sp,
                            color = DynamicThemeColorProviders.onBackground),
                        maxLines = 1
                    )
                }
            }

            Spacer(
                modifier = GlanceModifier.height(8.dp)
            )
        }
    }

    // 获取当前时间
    private fun getCurrentTime(): String {
        val calendar = Calendar.getInstance()
        val hour = calendar.get(Calendar.HOUR_OF_DAY)
        val minute = calendar.get(Calendar.MINUTE)
        return "${if (hour < 10) "0$hour" else hour}:${if (minute < 10) "0$minute" else minute}"
    }

    // 格式化时间
    private fun formatTime(time: String): String {
        val hour = time.split(":")[0].toInt()
        val minute = time.split(":")[1].toInt()
        return "${if (hour < 10) "0$hour" else hour}:${if (minute < 10) "0$minute" else minute}"
    }

    // 处理字符串
    private fun handleString(str: String): String {
        return str.drop(1).dropLast(1).replace("\\", "")
    }

    // 获取当前星期文字
    private fun getCurrentDayOfWeekText(): String {
        val calendar = Calendar.getInstance()
        val dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK)
        return when (dayOfWeek) {
            1 -> "周日"
            2 -> "周一"
            3 -> "周二"
            4 -> "周三"
            5 -> "周四"
            6 -> "周五"
            7 -> "周六"
            else -> "未知"
        }
    }

    // 获取当前星期数字
    private fun getCurrentDayOfWeekNumber(): Int {
        val calendar = Calendar.getInstance()
        return when (val dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK)) {
            1 -> 7
            else -> dayOfWeek - 1
        }
    }
}