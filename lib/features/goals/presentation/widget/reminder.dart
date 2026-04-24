import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter/common_widgets/custom_switch.dart';
import 'package:template_flutter/common_widgets/dual_tone_title.dart';
import 'package:template_flutter/constants/text_font_style.dart';
import 'package:template_flutter/gen/colors.gen.dart';

class ReminderSection extends StatelessWidget {
  const ReminderSection({
    super.key,
    required this.isReminderEnabled,
    required this.onReminderToggle,
    required this.selectedTime,
    required this.onTimeTap,
  });

  final bool isReminderEnabled;
  final ValueChanged<bool> onReminderToggle;
  final TimeOfDay selectedTime;
  final VoidCallback onTimeTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: DualToneTitle(
                lightText: 'Set',
                darkText: 'reminder time',
                lightTextStyle: TextFontStyle.textStyle24c8C7C68HelveticaNeue400,
                darkTextStyle: TextFontStyle.textStyle24c3B230EHelveticaNeue500
              ),
            ),
            CustomSwitch(
              value: isReminderEnabled,
              onChanged: onReminderToggle,
              width: 64,
              height: 34,
            ),
          ],
        ),
        if (isReminderEnabled) ...[
          SizedBox(height: 12.h),
          GestureDetector(
            onTap: onTimeTap,
            child: Container(
              width: double.infinity,
              height: 60.h,
              padding: EdgeInsets.fromLTRB(20.w, 8.h, 8.w, 8.h),
              decoration: BoxDecoration(
                color: AppColors.allPrimaryColor,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: AppColors.allsecondaryColor.withValues(alpha: 0.12),
                  width: 1.w,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      selectedTime.format(context),
                      style: TextFontStyle.textStyle20c3B230EHelveticaNeue400,
                    ),
                  ),
                  Container(
                    width: 44.w,
                    height: 44.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.cF5F6F5.withValues(alpha: 0.35),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.allsecondaryColor.withValues(alpha: 0.10),
                          blurRadius: 10,
                          offset: Offset(0, 3.h),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/icons/clock.png',
                        width: 20.w,
                        height: 20.w,
                        fit: BoxFit.contain,
                      )
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}
