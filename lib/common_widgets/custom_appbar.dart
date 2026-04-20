// lib/common_widgets/custom_appbar.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/constants/text_font_style.dart';
import '/gen/colors.gen.dart';


class CustomAppBar extends StatelessWidget {
  final String? titleText;

  const CustomAppBar({
    super.key,
    this.titleText,
  });


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/header_1.png',
          fit: BoxFit.cover,
        ),
        Positioned(
          top: 70.h,
          left: 24.w,
          right: 24.w,
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  width: 58.w,
                  height: 58.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.cF5EDD7.withValues(alpha: 0.75),
                      width: 1.6.w,
                    ),
                    color: const Color.fromARGB(17, 255, 255, 255),
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: AppColors.cF5EDD7,
                    size: 22.sp,
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Text(
                  titleText ?? '',
                  style:
                      TextFontStyle.textStyle28cFFFFFFHelveticaNeue700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}