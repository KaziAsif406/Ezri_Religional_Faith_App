import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter/common_widgets/dual_tone_title.dart';
import 'package:template_flutter/constants/text_font_style.dart';
import 'package:template_flutter/features/milestone/presentation/widget/milestone_header.dart';
import 'package:template_flutter/features/milestone/presentation/widget/milestone_list_tile.dart';
import 'package:template_flutter/gen/colors.gen.dart';
import 'package:template_flutter/helpers/ui_helpers.dart';

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
            UIHelper.verticalSpace(120.h),
            Padding(
              padding: EdgeInsets.fromLTRB(24.w, 22.h, 24.w, 14.h),
              child: DualToneTitle(
                lightText: 'Milestone',
                darkText: 'List',
                lightTextStyle:
                    TextFontStyle.textStyle24c8C7C68HelveticaNeue300,
                darkTextStyle:
                    TextFontStyle.textStyle24c3B230EHelveticaNeue700,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  const MilestoneListTile(
                    title: 'Complete Daily Scripture Habit',
                    subtitle: 'Completed on Aug 15, 2025',
                    imagePath: 'assets/icons/checked_milestone.png',
                    status: MilestoneStatus.completed,
                  ),
                  SizedBox(height: 12.h),
                  const MilestoneListTile(
                    title: '5-Day Prayer Streak',
                    subtitle: '3/5 days done',
                    imagePath: 'assets/icons/milestone_streak.png',
                    status: MilestoneStatus.inProgress,
                    progress: 0.6,
                  ),
                  SizedBox(height: 12.h),
                  const MilestoneListTile(
                    title: 'Memorize 10 Verses',
                    subtitle: '0/10 complete',
                    imagePath: 'assets/icons/locked_milestone.png',
                    status: MilestoneStatus.locked,
                  ),
                  SizedBox(height: 12.h),
                  const MilestoneListTile(
                    title: 'Fast for 8 Days',
                    subtitle: 'Not yet started',
                    imagePath: 'assets/icons/locked_milestone.png',
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
