import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter/constants/text_font_style.dart';
import 'package:template_flutter/features/goals/data/goal_store.dart';
import 'package:template_flutter/gen/assets.gen.dart';
import 'package:template_flutter/gen/colors.gen.dart';

class CurrentGoalsCard extends StatelessWidget {
  const CurrentGoalsCard({
    super.key,
    this.goalIndex = 0,
    this.onTap,
  });

  final int goalIndex;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final List<SavedGoal> goals = GoalStore.instance.goals;
    if (goals.isEmpty) {
      return _EmptyCurrentGoalCard(onTap: onTap);
    }

    final int resolvedIndex = goalIndex.clamp(0, goals.length - 1);
    final SavedGoal goal = goals[resolvedIndex];

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 14.h),
        decoration: BoxDecoration(
          color: AppColors.allPrimaryColor,
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all(
            color: AppColors.allsecondaryColor.withValues(alpha: 0.12),
            width: 1.w,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 74.w,
              height: 74.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.cF5EDD7.withValues(alpha: 0.45),
              ),
              child: Center(
                child: Image(
                  image: AssetImage(goal.iconPath),
                  width: 32.w,
                  height: 32.w,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                goal.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style:
                    TextFontStyle.textStyle24c3B230EHelveticaNeue500.copyWith(
                  fontSize: 22.sp,
                  height: 1.12,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            _GoalDayCountBadge(dayCountText: goal.dayCountLabel),
          ],
        ),
      ),
    );
  }
}

class _GoalDayCountBadge extends StatelessWidget {
  const _GoalDayCountBadge({required this.dayCountText});

  final String dayCountText;

  @override
  Widget build(BuildContext context) {
    final List<String> parts = dayCountText.split(' ');
    final String ratio = parts.isNotEmpty ? parts.first : dayCountText;
    final String suffix =
        parts.length > 1 ? parts.sublist(1).join(' ') : 'days';

    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 10.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.cB4B197,
            AppColors.cB4B197,
          ],
        ),
        borderRadius: BorderRadius.circular(999.r),
        border: Border.all(
          color: AppColors.cF5EDD7.withValues(alpha: 0.85),
          width: 1.w,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image(
            image: AssetImage(Assets.icons.fire.path),
            width: 20.w,
            height: 20.w,
            fit: BoxFit.contain,
          ),
          SizedBox(width: 6.w),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: ratio,
                  style:
                      TextFontStyle.textStyle24c3B230EHelveticaNeue500.copyWith(
                    fontSize: 20.sp,
                    height: 1,
                  ),
                ),
                TextSpan(
                  text: ' $suffix',
                  style:
                      TextFontStyle.textStyle24c8C7C68HelveticaNeue400.copyWith(
                    fontSize: 20.sp,
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyCurrentGoalCard extends StatelessWidget {
  const _EmptyCurrentGoalCard({this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
        decoration: BoxDecoration(
          color: AppColors.allPrimaryColor,
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all(
            color: AppColors.allsecondaryColor.withValues(alpha: 0.12),
            width: 1.w,
          ),
        ),
        child: Text(
          'No current goals yet',
          style: TextFontStyle.textStyle16c796956HelveticaNeue400,
        ),
      ),
    );
  }
}
