import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../gen/colors.gen.dart';

class HomeActionTile extends StatelessWidget {
  const HomeActionTile({
    super.key,
    required this.label,
    required this.imagePath,
  });

  final String label;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
      child: Container(
        width: 124.w,
        height: 136.w,
        decoration: BoxDecoration(
          color: AppColors.allsecondaryColor.withValues(alpha: 0.32),
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.10),
              blurRadius: 22.r,
              offset: Offset(0, 12.h),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 72.w,
              height: 72.w,
              decoration: BoxDecoration(
                color: AppColors.allsecondaryColor.withValues(alpha: 0.92),
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                imagePath,
                width: 20.sp,
                height: 20.sp,
              ),
            ),
            SizedBox(height: 18.h),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.cF5EDD7,
                fontSize: 17.sp,
                fontWeight: FontWeight.w400,
                height: 1.18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}