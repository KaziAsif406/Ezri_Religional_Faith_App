import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter/common_widgets/custom_appbar.dart';
import 'package:template_flutter/common_widgets/custom_button.dart';
import 'package:template_flutter/constants/text_font_style.dart';
import 'package:template_flutter/features/goals/data/goal_store.dart';
import 'package:template_flutter/features/goals/presentation/widget/all_goals_screen_tile.dart';
import 'package:template_flutter/gen/colors.gen.dart';
import 'package:template_flutter/helpers/all_routes.dart';
import 'package:template_flutter/helpers/navigation_service.dart';
import 'package:template_flutter/helpers/ui_helpers.dart';

class AllGoalsScreen extends StatefulWidget {
  const AllGoalsScreen({super.key});

  @override
  State<AllGoalsScreen> createState() => _AllGoalsScreenState();
}

class _AllGoalsScreenState extends State<AllGoalsScreen> {
  bool _isAddButtonVisible = true;

  Future<void> _handleLogTap(int index) async {
    final bool completed = GoalStore.instance.logGoalAt(index);
    setState(() {});

    if (completed) {
      await _showCompletionDialog(index);
    }
  }

  Future<void> _showCompletionDialog(int index) async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.allPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.r),
          ),
          contentPadding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 12.h),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.75, end: 1),
                duration: const Duration(milliseconds: 420),
                curve: Curves.elasticOut,
                builder: (BuildContext context, double value, Widget? child) {
                  return Transform.scale(scale: value, child: child);
                },
                child: Container(
                  width: 72.w,
                  height: 72.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.cBCD5BC.withValues(alpha: 0.45),
                  ),
                  child: Icon(
                    Icons.check_circle_rounded,
                    color: AppColors.c238D1A,
                    size: 42.sp,
                  ),
                ),
              ),
              SizedBox(height: 14.h),
              Text(
                'Goal completed!',
                textAlign: TextAlign.center,
                style: TextFontStyle.textStyle20c3B230EHelveticaNeue500,
              ),
              SizedBox(height: 8.h),
              Text(
                'What would you like to do next?',
                textAlign: TextAlign.center,
                style: TextFontStyle.textStyle14c8C7C68HelveticaNeue400,
              ),
              SizedBox(height: 18.h),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        GoalStore.instance.resetGoalAt(index);
                        Navigator.of(dialogContext).pop();
                        setState(() {});
                      },
                      child: const Text('Reset Goal'),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        GoalStore.instance.removeGoalAt(index);
                        Navigator.of(dialogContext).pop();
                        setState(() {});
                      },
                      child: const Text('Remove Goal'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _showGoalOptionsDialog(int index) async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.allPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.r),
          ),
          title: Text(
            'Goal options',
            style: TextFontStyle.textStyle20c3B230EHelveticaNeue500,
          ),
          content: Text(
            'Choose what you want to do with this goal.',
            style: TextFontStyle.textStyle14c8C7C68HelveticaNeue400,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                NavigationService.navigateToWithArgs(
                  Routes.addGoal,
                  <String, dynamic>{
                    'goal': GoalStore.instance.goals[index],
                    'editIndex': index,
                  },
                );
              },
              child: const Text('Edit Goal'),
            ),
            TextButton(
              onPressed: () {
                GoalStore.instance.removeGoalAt(index);
                Navigator.of(dialogContext).pop();
                setState(() {});
              },
              child: const Text('Delete Goal'),
            ),
          ],
        );
      },
    );
  }

  void _setAddButtonVisible(bool isVisible) {
    if (_isAddButtonVisible == isVisible) {
      return;
    }
    setState(() {
      _isAddButtonVisible = isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<SavedGoal> goals = GoalStore.instance.goals;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: AppColors.scaffoldColor,
      body: NotificationListener<UserScrollNotification>(
        onNotification: (UserScrollNotification notification) {
          if (notification.depth != 0) {
            return false;
          }

          if (notification.direction == ScrollDirection.reverse) {
            _setAddButtonVisible(false);
          } else if (notification.direction == ScrollDirection.forward) {
            _setAddButtonVisible(true);
          }

          return false;
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(titleText: 'Current Goals'),
              Padding(
                padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 24.h),
                child: Column(
                  children: [
                    for (int index = 0; index < goals.length; index++) ...[
                      AllGoalsScreenTile(
                        goal: goals[index],
                        onTap: () => _handleLogTap(index),
                        onLongPress: () => _showGoalOptionsDialog(index),
                      ),
                      if (index != goals.length - 1) SizedBox(height: 14.h),
                    ],
                  ],
                ),
              ),
              UIHelper.verticalSpace(30.h),
            ],
          ),
        ),
      ),
      floatingActionButton: IgnorePointer(
        ignoring: !_isAddButtonVisible,
        child: AnimatedSlide(
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeOutCubic,
          offset: _isAddButtonVisible ? Offset.zero : const Offset(0, 1.6),
          child: CustomButton(
            onPressed: () {
              NavigationService.navigateTo(Routes.addGoal);
            },
            title: 'Add New Goal',
            height: 60.h,
            width: 190.w,
            borderRadius: BorderRadius.circular(5555.r),
            backgroundGradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                AppColors.cF5EDD7.withValues(alpha: 0.99),
                AppColors.c6B2F45.withValues(alpha: 0.92),
              ],
            ),
            textStyle:
                TextFontStyle.textStyle16cFFFFFFHelveticaNeue500.copyWith(
              color: AppColors.cF5EDD7,
            ),
          ),
        ),
      ),
    );
  }
}
