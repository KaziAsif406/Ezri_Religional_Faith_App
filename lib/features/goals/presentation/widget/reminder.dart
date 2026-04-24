import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter/common_widgets/custom_switch.dart';
import 'package:template_flutter/constants/text_font_style.dart';
import 'package:template_flutter/gen/assets.gen.dart';
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
              child: RichText(
                text: TextSpan(
                  style: TextFontStyle.textStyle24c8C7C68HelveticaNeue400,
                  children: [
                    TextSpan(
                      text: 'Set ',
                      style: TextFontStyle.textStyle24c8C7C68HelveticaNeue400,
                    ),
                    TextSpan(
                      text: 'reminder time',
                      style: TextFontStyle.textStyle24c3B230EHelveticaNeue500,
                    ),
                  ],
                ),
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
          SizedBox(height: 14.h),
          GestureDetector(
            onTap: onTimeTap,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              decoration: BoxDecoration(
                color: AppColors.allPrimaryColor.withValues(alpha: 0.40),
                borderRadius: BorderRadius.circular(22.r),
                border: Border.all(
                  color: AppColors.allsecondaryColor.withValues(alpha: 0.10),
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
                    width: 50.w,
                    height: 50.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.cF5EDD7.withValues(alpha: 0.50),
                    ),
                    child: Center(
                      child: Image(
                        image: AssetImage(Assets.icons.calendar.path),
                        width: 22.w,
                        height: 22.w,
                        fit: BoxFit.contain,
                      ),
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
