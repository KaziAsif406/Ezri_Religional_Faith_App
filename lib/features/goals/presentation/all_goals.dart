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

class AllGoalsScreen extends StatefulWidget {
  const AllGoalsScreen({super.key});

  @override
  State<AllGoalsScreen> createState() => _AllGoalsScreenState();
}

class _AllGoalsScreenState extends State<AllGoalsScreen> {
  bool _isAddButtonVisible = true;

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
                      AllGoalsScreenTile(goal: goals[index]),
                      if (index != goals.length - 1) SizedBox(height: 14.h),
                    ],
                  ],
                ),
              ),
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
            textStyle: TextFontStyle.textStyle16cFFFFFFHelveticaNeue500.copyWith(
              color: AppColors.cF5EDD7,
            ),
          ),
        ),
      ),
    );
  }
}
