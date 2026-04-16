import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:template_flutter/common_widgets/custom_button.dart';

import '../../../../gen/colors.gen.dart';

class HomeSectionCard extends StatelessWidget {
  const HomeSectionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.buttonLabel,
    required this.buttonGradient,
    required this.buttonShadowColor,
    this.elevatedButton = false,
  });

  final IconData icon;
  final String title;
  final String description;
  final String buttonLabel;
  final List<Color> buttonGradient;
  final Color buttonShadowColor;
  final bool elevatedButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(18.w, 24.h, 18.w, 20.h),
      decoration: BoxDecoration(
        color: AppColors.allPrimaryColor.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(28.r),
        border: Border.all(
          color: AppColors.c8C7C68.withValues(alpha: 0.22),
          width: 1.w,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 84.w,
            height: 84.w,
            decoration: BoxDecoration(
              color: AppColors.allPrimaryColor.withValues(alpha: 0.75),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: AppColors.cA29783,
              size: 40.sp,
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.c8C7C68,
              fontSize: 24.sp,
              fontWeight: FontWeight.w500,
              height: 1.18,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.c99907A,
              fontSize: 18.sp,
              fontWeight: FontWeight.w300,
              height: 1.2,
            ),
          ),
          SizedBox(height: 24.h),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(34.r),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: buttonGradient,
              ),
              boxShadow: [
                BoxShadow(
                  color: buttonShadowColor,
                  blurRadius: elevatedButton ? 22.r : 18.r,
                  offset: Offset(0, elevatedButton ? 14.h : 10.h),
                ),
              ],
            ),
            child: CustomButton(
              onPressed: () {},
              title: buttonLabel,
              height: 54.h,
              backgroundColor: Colors.transparent,
              foregroundColor: AppColors.cF5EDD7,
              borderRadius: BorderRadius.circular(34.r),
              textStyle: TextStyle(
                color: AppColors.cF5EDD7,
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
              ),
              padding: EdgeInsets.symmetric(horizontal: 18.w),
            ),
          ),
        ],
      ),
    );
  }
}