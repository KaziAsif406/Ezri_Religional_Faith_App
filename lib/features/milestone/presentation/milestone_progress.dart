import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter/common_widgets/dual_tone_title.dart';
import 'package:template_flutter/constants/text_font_style.dart';
import 'package:template_flutter/features/milestone/presentation/widget/milestone_header.dart';
import 'package:template_flutter/features/milestone/presentation/widget/milestone_list_tile.dart';
import 'package:template_flutter/gen/colors.gen.dart';

class MilestoneProgressScreen extends StatelessWidget {
  const MilestoneProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MilestoneHeader(),
            Padding(
              padding: EdgeInsets.fromLTRB(24.w, 22.h, 24.w, 14.h),
              child: DualToneTitle(
                lightText: 'Milestone',
                darkText: 'List',
                lightTextStyle:
                    TextFontStyle.textStyle24c513B26HelveticaNeue400.copyWith(
                  fontSize: 24.sp,
                ),
                darkTextStyle:
                    TextFontStyle.textStyle24c3B230EHelveticaNeue700.copyWith(
                  fontSize: 24.sp,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  const MilestoneListTile(
                    title: 'Complete Daily Scripture Habit',
                    subtitle: 'Completed on Aug 15, 2025',
                    icon: Icons.check,
                    status: MilestoneStatus.completed,
                  ),
                  SizedBox(height: 12.h),
                  const MilestoneListTile(
                    title: '5-Day Prayer Streak',
                    subtitle: '3/5 days done',
                    icon: Icons.show_chart,
                    status: MilestoneStatus.inProgress,
                    progress: 0.6,
                  ),
                  SizedBox(height: 12.h),
                  const MilestoneListTile(
                    title: 'Memorize 10 Verses',
                    subtitle: '0/10 complete',
                    icon: Icons.lock_outline_rounded,
                    status: MilestoneStatus.locked,
                  ),
                  SizedBox(height: 12.h),
                  const MilestoneListTile(
                    title: 'Fast for 8 Days',
                    subtitle: 'Not yet started',
                    icon: Icons.lock_outline_rounded,
                    status: MilestoneStatus.locked,
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
