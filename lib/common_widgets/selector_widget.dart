import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter/constants/text_font_style.dart';

import '../gen/colors.gen.dart';

class SelectorOption<T> {
  const SelectorOption({
    required this.value,
    required this.label,
    this.leading,
    this.onTap,
    this.selectedButtonGradient,
    this.unselectedButtonGradient,
    this.selectedBorderColor,
    this.unselectedBorderColor,
  });

  final T value;
  final String label;
  final Widget? leading;
  final VoidCallback? onTap;
  final Gradient? selectedButtonGradient;
  final Gradient? unselectedButtonGradient;
  final Color? selectedBorderColor;
  final Color? unselectedBorderColor;
}

class SelectorWidget<T> extends StatelessWidget {
  const SelectorWidget({
    super.key,
    required this.options,
    required this.selectedValue,
    required this.onChanged,
    this.height,
    // this.width,
    this.spacing,
    this.borderRadius,
    this.horizontalPadding,
    this.borderWidth,
    this.animationDuration,
    this.selectedTextStyle,
    this.unselectedTextStyle,
    this.selectedTextColor,
    this.unselectedTextColor,
    this.selectedButtonGradient,
    this.unselectedButtonGradient,
    this.selectedBorderColor,
    this.unselectedBorderColor,
    this.isScrollable = false,
  });

  final List<SelectorOption<T>> options;
  final T selectedValue;
  final ValueChanged<T> onChanged;
  final double? height;
  // final double? width;
  final double? spacing;
  final BorderRadius? borderRadius;
  final double? horizontalPadding;
  final double? borderWidth;
  final Duration? animationDuration;
  final TextStyle? selectedTextStyle;
  final TextStyle? unselectedTextStyle;
  final Color? selectedTextColor;
  final Color? unselectedTextColor;
  final Gradient? selectedButtonGradient;
  final Gradient? unselectedButtonGradient;
  final Color? selectedBorderColor;
  final Color? unselectedBorderColor;
  final bool isScrollable;

  @override
  Widget build(BuildContext context) {
    final double resolvedSpacing = spacing ?? 12.w;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List<Widget>.generate(options.length, (int index) {
          final SelectorOption<T> option = options[index];
          final bool isSelected = option.value == selectedValue;
      
          return Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? 0 : 12.w,
              right: index == options.length - 1 ? 0 : resolvedSpacing / 2,
              top: 4.h,
              bottom: 20.h,
            ),
            child: _SelectorButton(
              label: option.label,
              leading: option.leading,
              isSelected: isSelected,
              height: height ?? 56.h,
              // width: width ?? 122.w,
              borderRadius: borderRadius ?? BorderRadius.circular(34.r),
              horizontalPadding: horizontalPadding ?? 14.w,
              borderWidth: borderWidth ?? 1.w,
              animationDuration:
                  animationDuration ?? const Duration(milliseconds: 220),
              textStyle: isSelected
                  ? (selectedTextStyle ??
                      TextFontStyle.textStyle16c796956HelveticaNeue400)
                  : (unselectedTextStyle ??
                      TextFontStyle.textStyle16c796956HelveticaNeue400),
              textColor: isSelected
                  ? (selectedTextColor ?? AppColors.allsecondaryColor)
                  : (unselectedTextColor ?? AppColors.c685E4A),
              buttonGradient: isSelected
                  ? (option.selectedButtonGradient ?? selectedButtonGradient)
                  : (option.unselectedButtonGradient ??
                      unselectedButtonGradient),
              borderColor: isSelected
                  ? (option.selectedBorderColor ?? selectedBorderColor)
                  : (option.unselectedBorderColor ?? unselectedBorderColor),
              onTap: () {
                option.onTap?.call();
                onChanged(option.value);
              },
            ),
          );
        }),
      ),
    );
  }
}

class _SelectorButton extends StatelessWidget {
  const _SelectorButton({
    required this.label,
    required this.isSelected,
    required this.height,
    // required this.width,
    required this.borderRadius,
    required this.horizontalPadding,
    required this.borderWidth,
    required this.animationDuration,
    required this.textStyle,
    required this.textColor,
    required this.onTap,
    this.leading,
    this.buttonGradient,
    this.borderColor, 
  });

  final String label;
  final Widget? leading;
  final bool isSelected;
  final double height;
  // final double width;
  final BorderRadius borderRadius;
  final double horizontalPadding;
  final double borderWidth;
  final Duration animationDuration;
  final TextStyle textStyle;
  final Color textColor;
  final VoidCallback onTap;
  final Gradient? buttonGradient;
  final Color? borderColor;

  @override
Widget build(BuildContext context) {
  final Color resolvedBorderColor = borderColor ??
      AppColors.allsecondaryColor; // Default to transparent if no border color is provided

  final Gradient resolvedButtonGradient = buttonGradient ??
      LinearGradient(
        colors: [
          isSelected
              ? AppColors.c8F96A0.withValues(alpha: 0.12)
              : AppColors.cF5F6F5.withValues(alpha: 0.14),
          isSelected
              ? AppColors.c8F96A0.withValues(alpha: 0.32)
              : AppColors.cF5F6F5.withValues(alpha: 0.34),
        ],
      );

  return GestureDetector(
    onTap: onTap,
    child: AnimatedContainer(
      duration: animationDuration,
      height: height,
      decoration: BoxDecoration(
        gradient: resolvedButtonGradient,
        borderRadius: borderRadius,
        border: Border.all(
          color: resolvedBorderColor,
          width: borderWidth,
        ),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: AppColors.c1C1919.withValues(alpha: 0.12),
                  blurRadius: 3.r,
                  offset: Offset(0, 1.h),
                ),
              ]
            : null,
      ),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
        ),
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Row(
          // mainAxisSize: MainAxisSize.min, // ⭐ IMPORTANT
          children: [
            if (leading != null) ...[
              leading!,
              SizedBox(width: 6.w),
            ],
            Text(
              label,
              style: textStyle.copyWith(
                color: textColor,
                fontWeight:
                    isSelected ? FontWeight.w500 : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
