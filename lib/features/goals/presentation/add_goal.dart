import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter/common_widgets/custom_appbar.dart';
import 'package:template_flutter/common_widgets/custom_button.dart';
import 'package:template_flutter/common_widgets/dual_tone_title.dart';
import 'package:template_flutter/common_widgets/wavy_separator.dart';
import 'package:template_flutter/constants/text_font_style.dart';
import 'package:template_flutter/features/goals/presentation/widget/frequency_selector.dart';
import 'package:template_flutter/features/goals/presentation/widget/goal_type_selector.dart';
import 'package:template_flutter/features/goals/presentation/widget/reminder.dart';
import 'package:template_flutter/gen/assets.gen.dart';
import 'package:template_flutter/gen/colors.gen.dart';
import 'package:template_flutter/helpers/navigation_service.dart';

class AddGoalScreen extends StatefulWidget {
  const AddGoalScreen({super.key});

  @override
  State<AddGoalScreen> createState() => _AddGoalScreenState();
}

class _AddGoalScreenState extends State<AddGoalScreen> {
  GoalType _selectedGoalType = GoalType.prayer;
  GoalFrequency _selectedFrequency = GoalFrequency.weekly;
  final Set<int> _selectedDays = <int>{2};
  bool _isReminderOn = true;
  TimeOfDay _selectedTime = const TimeOfDay(hour: 9, minute: 0);

  bool get _showDaySelector {
    return _selectedFrequency == GoalFrequency.weekly ||
        _selectedFrequency == GoalFrequency.monthly;
  }

  Future<void> _pickReminderTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.allsecondaryColor,
            ),
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );

    if (newTime != null) {
      setState(() {
        _selectedTime = newTime;
      });
    }
  }

  void _toggleDay(int dayIndex) {
    setState(() {
      if (_selectedDays.contains(dayIndex)) {
        _selectedDays.remove(dayIndex);
      } else {
        _selectedDays.add(dayIndex);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(
              titleText: 'Add New Goal',
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 0.h, 20.w, 40.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DualToneTitle(
                    lightText: 'What\'s the',
                    darkText: 'goal type?',
                    lightTextStyle:
                        TextFontStyle.textStyle24c8C7C68HelveticaNeue400,
                    darkTextStyle:
                        TextFontStyle.textStyle24c3B230EHelveticaNeue500,
                  ),
                  SizedBox(height: 12.h),
                  GoalTypeSelector(
                    selectedType: _selectedGoalType,
                    onTypeChanged: (GoalType newType) {
                      setState(() {
                        _selectedGoalType = newType;
                      });
                    },
                  ),
                  SizedBox(height: 28.h),
                  DualToneTitle(
                    lightText: 'How often do you',
                    darkText: 'want to do this?',
                    lightTextStyle:
                        TextFontStyle.textStyle24c8C7C68HelveticaNeue400,
                    darkTextStyle:
                        TextFontStyle.textStyle24c3B230EHelveticaNeue500,
                  ),
                  SizedBox(height: 14.h),
                  FrequencySelector(
                    selectedFrequency: _selectedFrequency,
                    onFrequencyChanged: (GoalFrequency newFrequency) {
                      setState(() {
                        _selectedFrequency = newFrequency;
                      });
                    },
                  ),
                  if (_showDaySelector) ...[
                    SizedBox(height: 24.h),
                    WavySeparator(
                        color: AppColors.cF5EDD7.withValues(alpha: 0.45)),
                    SizedBox(height: 24.h),
                    DualToneTitle(
                      lightText: 'Select',
                      darkText: 'the day(s)',
                      lightTextStyle:
                          TextFontStyle.textStyle24c8C7C68HelveticaNeue400,
                      darkTextStyle:
                          TextFontStyle.textStyle24c3B230EHelveticaNeue500,
                    ),
                    SizedBox(height: 14.h),
                    DaySelector(
                      selectedDays: _selectedDays,
                      onDayToggle: _toggleDay,
                    ),
                  ],
                  SizedBox(height: 24.h),
                  WavySeparator(
                      color: AppColors.cF5EDD7.withValues(alpha: 0.45)),
                  SizedBox(height: 24.h),
                  ReminderSection(
                    isReminderEnabled: _isReminderOn,
                    onReminderToggle: (bool value) {
                      setState(() {
                        _isReminderOn = value;
                      });
                    },
                    selectedTime: _selectedTime,
                    onTimeTap: _pickReminderTime,
                  ),
                  SizedBox(height: 32.h),
                  CustomButton(
                    onPressed: () {},
                    title: 'Save Goal',
                    height: 72.h,
                    borderRadius: BorderRadius.circular(999.r),
                    backgroundGradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.cC7BFAD,
                        AppColors.c6B2F45,
                      ],
                    ),
                    textStyle: TextFontStyle.textStyle32cFFFFFFHelveticaNeue500
                        .copyWith(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.cF5EDD7,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
