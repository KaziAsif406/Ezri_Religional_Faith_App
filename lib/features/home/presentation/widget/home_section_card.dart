import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:template_flutter/common_widgets/custom_button.dart';
import 'package:template_flutter/constants/text_font_style.dart';

import '../../../../gen/colors.gen.dart';

class HomeSectionCard extends StatelessWidget {
  const HomeSectionCard({
    super.key,
    required this.backgroundColor,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.buttonLabel,
    required this.buttonGradient,
    required this.buttonShadowColor,
    this.elevatedButton = false,
  });

  final Color backgroundColor;
  final String imagePath;
  final String title;
  final String description;
  final String buttonLabel;
  final List<Color> buttonGradient;
  final Color buttonShadowColor;
  final bool elevatedButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 390.w,
      // height: 300.h,
      padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 24.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: AppColors.allsecondaryColor.withValues(alpha: 0.12),
          width: 1.w,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.c1C1919.withValues(alpha: 0.10),
            blurRadius: 12.r,
            offset: Offset(0, 6.h),
          ),
        ],
      ),
      child: Column(
        children: [
          Image.asset(
            imagePath,
            width: 64.sp,
            height: 64.sp,
          ),
          SizedBox(height: 12.h),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextFontStyle.textStyle20c8C7C68HelveticaNeue500.copyWith(
              fontWeight: FontWeight.w900,
              height: 1.2,
              letterSpacing: 0,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextFontStyle.textStyle14c99907AHelveticaNeue400,
          ),
          SizedBox(height: 16.h),
          CustomButton(
            onPressed: () {},
            title: buttonLabel,
            width: 247.w,
            height: 52.h,
            backgroundGradient: LinearGradient(
              colors: buttonGradient
                  .map((color) => color)
                  .toList(),
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            titleGradient: const LinearGradient(
              colors: [
                Color(0xFFFFFFFF),
                Color(0xFFF5EDD7),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(34.r),
            textStyle: TextFontStyle.textStyle16cFFFFFFHelveticaNeue500,
            padding: EdgeInsets.symmetric(horizontal: 18.w),
          ),
        ],
      ),
    );
  }
}