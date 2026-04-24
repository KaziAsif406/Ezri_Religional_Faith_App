import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter/gen/assets.gen.dart';
import 'package:template_flutter/gen/colors.gen.dart';

class CircularProgressButton extends StatelessWidget {
  const CircularProgressButton({
    super.key,
    required this.isSelected,
    this.selectedBackgroundColor = AppColors.cD8B698,
    this.unselectedBackgroundColor = AppColors.c796956,
    this.selectedIcon,
    this.unselectedIcon,
    this.size,
    this.onTap,
  });

  final bool isSelected;
  final Color selectedBackgroundColor;
  final Color unselectedBackgroundColor;
  final Widget? selectedIcon;
  final Widget? unselectedIcon;
  final double? size;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final double buttonSize = size ?? 48.w;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        width: buttonSize,
        height: buttonSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color:
              isSelected ? selectedBackgroundColor : unselectedBackgroundColor,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.c513B26.withValues(alpha: 0.24),
                    blurRadius: 14.r,
                    offset: Offset(0, 6.h),
                  ),
                ]
              : const <BoxShadow>[],
        ),
        child: Center(
          child: isSelected
              ? selectedIcon ?? _DefaultFireIcon(isSelected: true)
              : unselectedIcon ?? _DefaultFireIcon(isSelected: false),
        ),
      ),
    );
  }
}

class WeeklyProgressIndicator extends StatelessWidget {
  const WeeklyProgressIndicator({
    super.key,
    this.dayLabels = const <String>['S', 'M', 'T', 'W', 'T', 'F', 'S'],
    required this.completedDays,
    this.selectedBackgroundColor = AppColors.cD8B698,
    this.unselectedBackgroundColor = AppColors.c796956,
    this.selectedIcon,
    this.unselectedIcon,
    this.dayTextStyle,
  });

  final List<String> dayLabels;
  final int completedDays;
  final Color selectedBackgroundColor;
  final Color unselectedBackgroundColor;
  final Widget? selectedIcon;
  final Widget? unselectedIcon;
  final TextStyle? dayTextStyle;

  @override
  Widget build(BuildContext context) {
    final int selectedCount = completedDays.clamp(0, dayLabels.length);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List<Widget>.generate(dayLabels.length, (int index) {
        final bool isSelected = index < selectedCount;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressButton(
              isSelected: isSelected,
              size: 48.w,
              selectedBackgroundColor: selectedBackgroundColor,
              unselectedBackgroundColor: unselectedBackgroundColor,
              selectedIcon: selectedIcon,
              unselectedIcon: unselectedIcon,
            ),
            SizedBox(height: 10.h),
            Text(
              dayLabels[index],
              style: dayTextStyle ??
                  TextStyle(
                    color: AppColors.cF5EDD7.withValues(alpha: 0.86),
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400,
                  ),
            ),
          ],
        );
      }),
    );
  }
}

class _DefaultFireIcon extends StatelessWidget {
  const _DefaultFireIcon({required this.isSelected});

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return isSelected
        ? Image.asset(
            'assets/icons/fire.png',
            width: 24.w,
            height: 24.w,
            fit: BoxFit.contain,
          )
        : Image.asset(
            'assets/icons/fire_default.png',
            width: 24.w,
            height: 24.w,
            fit: BoxFit.contain,
            color: AppColors.cD8B698,
            colorBlendMode: BlendMode.srcIn,
          );
    
    // Image.asset(
    //   Assets.icons.fire.path,
    //   width: 24.w,
    //   height: 24.w,
    //   fit: BoxFit.contain,
    //   color: isSelected ? null : AppColors.cD8B698,
    //   colorBlendMode: BlendMode.srcIn,
    // );
  }
}
