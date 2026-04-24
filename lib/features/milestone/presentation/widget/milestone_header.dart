import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter/common_widgets/circular_progress_button.dart';
import 'package:template_flutter/common_widgets/custom_appbar.dart';
import 'package:template_flutter/constants/text_font_style.dart';
import 'package:template_flutter/features/milestone/presentation/widget/milestone_summary.dart';
import 'package:template_flutter/gen/colors.gen.dart';

class MilestoneHeader extends StatelessWidget {
  const MilestoneHeader({
    super.key,
    this.completedDays = 3,
    this.targetDays = 7,
    this.currentStreak = 5,
    this.userName = 'Wade',
    this.onContinueTap,
  });

  final int completedDays;
  final int targetDays;
  final int currentStreak;
  final String userName;
  final VoidCallback? onContinueTap;

  @override
  Widget build(BuildContext context) {
    final double progress = targetDays == 0 ? 0 : completedDays / targetDays;
    final int remainingDays = (targetDays - completedDays).clamp(0, targetDays);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomAppBar(
          titleText: 'Milestone Progress',
          imageHeight: 380.0.h,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Transform.translate(
            offset: Offset(0, -230.h),
            child: Column(
              children: [
                WeeklyProgressIndicator(
                  completedDays: completedDays,
                  selectedBackgroundColor: AppColors.cF5F6F5.withValues(alpha: 0.12),
                  unselectedBackgroundColor: AppColors.allsecondaryColor.withValues(alpha: 0.28),
                  dayTextStyle: TextFontStyle.textStyle16cFFFFFFHelveticaNeue400.copyWith(
                    color: AppColors.cF5F6F5.withValues(alpha: 0.6),
                  ),
                ),
                SizedBox(height: 70.h),
                MilestoneSummaryCard(
                  completedDays: completedDays,
                  targetDays: targetDays,
                  currentStreak: currentStreak,
                  userName: userName,
                  remainingDays: remainingDays,
                  progress: progress,
                  onContinueTap: onContinueTap,
                ),
              ],
            ),
          ),
        ),
        
      ],
    );
  }
}


