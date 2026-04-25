import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter/constants/text_font_style.dart';
import 'package:template_flutter/gen/colors.gen.dart';

enum GoalFrequency { daily, weekly, monthly }

class FrequencySelector extends StatelessWidget {
  const FrequencySelector({
    super.key,
    required this.selectedFrequency,
    required this.onFrequencyChanged,
  });

  final GoalFrequency selectedFrequency;
  final ValueChanged<GoalFrequency> onFrequencyChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: GoalFrequency.values.map((GoalFrequency frequency) {
        final bool isSelected = selectedFrequency == frequency;
        final String label = _frequencyLabel(frequency);

        return Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: GestureDetector(
              onTap: () => onFrequencyChanged(frequency),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                curve: Curves.easeInOut,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.cCFC7B6,
                            Color.fromARGB(255, 158, 150, 132),
                          ],
                        )
                      : null,
                  color: isSelected
                      ? null
                      : AppColors.white.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(40.r),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.allsecondaryColor.withValues(alpha: 0.20)
                        : AppColors.allsecondaryColor.withValues(alpha: 0.12),
                    width: isSelected ? 1.6.w : 1.w,
                  ),
                ),
                child: Text(
                  label,
                  style:
                      TextFontStyle.textStyle20c3B230EHelveticaNeue500.copyWith(
                    color: isSelected
                        ? AppColors.allsecondaryColor
                        : AppColors.c8C7C68,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  String _frequencyLabel(GoalFrequency frequency) {
    switch (frequency) {
      case GoalFrequency.daily:
        return 'Daily';
      case GoalFrequency.weekly:
        return 'Weekly';
      case GoalFrequency.monthly:
        return 'Monthly';
    }
  }
}

class DaySelector extends StatelessWidget {
  const DaySelector({
    super.key,
    required this.selectedDays,
    required this.onDayToggle,
  });

  final Set<int> selectedDays;
  final ValueChanged<int> onDayToggle;

  static const List<String> _dayLabels = <String>[
    'S',
    'M',
    'T',
    'W',
    'T',
    'F',
    'S'
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List<Widget>.generate(_dayLabels.length, (int index) {
        final bool isSelected = selectedDays.contains(index);

        return Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: GestureDetector(
              onTap: () => onDayToggle(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeOut,
                width: 48.w,
                height: 48.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: isSelected
                      ? const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.cCFC7B6,
                            Color.fromARGB(255, 158, 150, 132),
                          ],
                        )
                      : null,
                  color: isSelected
                      ? null
                      : AppColors.white.withValues(alpha: 0.12),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.allsecondaryColor.withValues(alpha: 0.18)
                        : Colors.transparent,
                    width: isSelected ? 1.4.w : 1.w,
                  ),
                ),
                child: Text(
                  _dayLabels[index],
                  style:
                      TextFontStyle.textStyle20c3B230EHelveticaNeue500.copyWith(
                    color: isSelected
                        ? AppColors.allsecondaryColor
                        : AppColors.c8C7C68,
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
