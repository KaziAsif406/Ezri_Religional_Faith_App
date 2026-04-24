import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter/common_widgets/custom_appbar.dart';
import 'package:template_flutter/constants/text_font_style.dart';
import 'package:template_flutter/features/goals/data/goal_store.dart';
import 'package:template_flutter/features/goals/presentation/widget/all_goals_screen_tile.dart';
import 'package:template_flutter/gen/colors.gen.dart';

class AllGoalsScreen extends StatelessWidget {
  const AllGoalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<SavedGoal> goals = GoalStore.instance.goals;

    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomAppBar(titleText: 'All Goals'),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 0.h, 20.w, 24.h),
              child: Text(
                'Your saved goals',
                style: TextFontStyle.textStyle24c3B230EHelveticaNeue500,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 24.h),
              child: Column(
                children: [
                  for (int index = 0; index < goals.length; index++) ...[
                    AllGoalsScreenTile(goal: goals[index]),
                    if (index != goals.length - 1) SizedBox(height: 14.h),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
