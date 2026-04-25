import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter/common_widgets/stacked_cards.dart';
// import 'package:template_flutter/constants/text_font_style.dart';
import 'package:template_flutter/features/goals/data/goal_store.dart';
import 'package:template_flutter/features/journey/presentation/widget/current_goals.dart';
import 'package:template_flutter/features/journey/presentation/widget/goals.dart';
import 'package:template_flutter/helpers/ui_helpers.dart';
// import 'package:template_flutter/gen/assets.gen.dart';
// import 'package:template_flutter/gen/colors.gen.dart';




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
    return Column(
      children: [
        UIHelper.verticalSpace(20.h),
        StackedSwipeDeck<SavedGoal>(
          items: goals,
          keyBuilder: (SavedGoal goal) => '${goal.title}_${goal.reminderTimeLabel}',
          deckHeight: 210.h,
          maxVisibleCards: 10,
          topOffsetStep: 10.h,
          scaleStep: 0.02,
          horizontalInset: 25.w,
          emptyBuilder: (BuildContext context, VoidCallback resetDeck) {
            return Goals(
              onAddGoalPressed: resetDeck,
            );
          },
          cardBuilder: (BuildContext context, SavedGoal goal, bool isTopCard) {
            final int index = goals.indexOf(goal);
            return CurrentGoalsCard(
              goalIndex: index,
              onTap: onCardTap == null ? null : () => onCardTap!(index),
            );
          },
        ),
      ],
    );
  }
}