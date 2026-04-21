import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../gen/colors.gen.dart';

class RoundedInputShell extends StatelessWidget {
  const RoundedInputShell({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20.w, 8.h, 5.w, 8.h),
      decoration: BoxDecoration(
        color: AppColors.allPrimaryColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: AppColors.allsecondaryColor.withValues(alpha: 0.12),
          width: 1.w,
        ),
      ),
      child: child,
    );
  }
}
