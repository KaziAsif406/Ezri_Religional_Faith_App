import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter/constants/text_font_style.dart';

import '../../../../gen/colors.gen.dart';

class RoundActionButton extends StatelessWidget {
  const RoundActionButton({
    super.key,
    required this.onTap,
    required this.filled,
    this.icon,
    this.iconText,
  });

  final VoidCallback onTap;
  final bool filled;
  final IconData? icon;
  final String? iconText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36.w,
        height: 36.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: filled
              ? AppColors.allPrimaryColor
              : AppColors.allPrimaryColor,
          border: Border.all(
            color: AppColors.allsecondaryColor.withValues(alpha: 0.20),
            width: 2.w,
          ),
          boxShadow: filled
              ? null
              : <BoxShadow>[
                  BoxShadow(
                    color: AppColors.c1C1919.withValues(alpha: 0.14),
                    blurRadius: 15.r,
                    offset: Offset(0, 7.h),
                  ),
                ],
        ),
        child: Center(
          child: icon != null
              ? Icon(
                  icon,
                  size: 20.sp,
                  color: AppColors.c513B26,
                )
              : Text(
                  iconText ?? '',
                  style: TextFontStyle.textStyle20c3B230EHelveticaNeue400.copyWith(
                    fontSize: 22.sp,
                    color: AppColors.c513B26,
                  ),
                ),
        ),
      ),
    );
  }
}
