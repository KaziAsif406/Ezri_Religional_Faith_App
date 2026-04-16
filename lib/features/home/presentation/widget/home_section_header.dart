import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../gen/colors.gen.dart';

class HomeSectionHeader extends StatelessWidget {
  const HomeSectionHeader({
    super.key,
    required this.titlePrefix,
    required this.titleHighlight,
    this.actionText,
    this.onActionTap,
  });

  final String titlePrefix;
  final String titleHighlight;
  final String? actionText;
  final VoidCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    final hasAction = actionText != null && onActionTap != null;

    return Row(
      children: [
        Text(
          titlePrefix,
          style: TextStyle(
            color: AppColors.c8C7C68,
            fontSize: 28.sp,
            fontWeight: FontWeight.w300,
            height: 1.05,
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          titleHighlight,
          style: TextStyle(
            color: AppColors.allsecondaryColor,
            fontSize: 28.sp,
            fontWeight: FontWeight.w500,
            height: 1.05,
          ),
        ),
        const Spacer(),
        if (hasAction)
          GestureDetector(
            onTap: onActionTap,
            child: Text(
              actionText!,
              style: TextStyle(
                color: AppColors.allsecondaryColor,
                fontSize: 17.sp,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline,
                decorationThickness: 1.8,
              ),
            ),
          ),
      ],
    );
  }
}