import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter/common_widgets/stacked_cards.dart';
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
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.allPrimaryColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: AppColors.allsecondaryColor.withValues(alpha: 0.12),
            width: 1.w,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 64.w,
              height: 64.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white.withValues(alpha: 0.35),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.allsecondaryColor.withValues(alpha: 0.10),
                    blurRadius: 10.r,
                    offset: Offset(0, 5.h),
                  ),
                ],
              ),
              child: Center(
                child: Image(
                  image: AssetImage(goal.iconPath),
                  width: 30.w,
                  height: 30.w,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                goal.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style:
                    TextFontStyle.textStyle18c3B230EHelveticaNeue400.copyWith(
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

class CurrentGoalsStackedView extends StatelessWidget {
  const CurrentGoalsStackedView({
    super.key,
    required this.goals,
    this.onCardTap,
  });

  final List<SavedGoal> goals;
  final ValueChanged<int>? onCardTap;

  @override
  Widget build(BuildContext context) {
    return StackedSwipeDeck<SavedGoal>(
      items: goals,
      keyBuilder: (SavedGoal goal) => '${goal.title}_${goal.reminderTimeLabel}',
      deckHeight: 210.h,
      maxVisibleCards: 3,
      topOffsetStep: 16.h,
      scaleStep: 0.02,
      horizontalInset: 6.w,
      emptyBuilder: (BuildContext context, VoidCallback resetDeck) {
        return _EmptyCurrentGoalCard(
          onTap: resetDeck,
        );
      },
      cardBuilder: (BuildContext context, SavedGoal goal, bool isTopCard) {
        final int index = goals.indexOf(goal);
        return CurrentGoalsCard(
          goalIndex: index,
          onTap: onCardTap == null ? null : () => onCardTap!(index),
        );
      },
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
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40.r),
        border: Border.all(
          color: AppColors.white.withValues(alpha: 0.40),
          width: 1.w,
        ),
        color: Colors.transparent,
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 8.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.cF5EDD7,
              const Color.fromARGB(255, 182, 173, 148),
            ],
          ),
          borderRadius: BorderRadius.circular(999.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image(
              image: AssetImage(Assets.icons.fire.path),
              width: 18.w,
              height: 18.w,
              fit: BoxFit.contain,
            ),
            SizedBox(width: 4.w),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: ratio,
                    style:
                        TextFontStyle.textStyle18c3B230EHelveticaNeue500,
                  ),
                  TextSpan(
                    text: ' $suffix',
                    style:
                        TextFontStyle.textStyle14c8C7C68HelveticaNeue400,
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
