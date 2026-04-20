import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter/constants/text_font_style.dart';
import 'package:template_flutter/helpers/all_routes.dart';
import 'package:template_flutter/helpers/navigation_service.dart';

import '../../../../gen/colors.gen.dart';

class HomeActionTile extends StatelessWidget {
  const HomeActionTile({
    super.key,
    required this.label,
    required this.imagePath,
    this.iconSize,
  });

  final String label;
  final String imagePath;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    final BorderRadius tileRadius = BorderRadius.circular(24.r);

    return ClipRRect(
      borderRadius: tileRadius,
      child: GestureDetector(
        onTap: () {
          if (label == 'Add\nEntry') {
            NavigationService.navigateTo(Routes.addSacredEntry);
          } else if (label == 'Ezri\nChat') {
            // To be added
          } else if (label == 'Community\nLight') {
            NavigationService.navigateTo(Routes.communityScreen);
          }
        },
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
          child: Container(
            height: 135.h,
            width: 124.w,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: AppColors.allsecondaryColor.withValues(alpha: 0.30),
              borderRadius: tileRadius,
              border: Border.all(
                color: AppColors.cF5EDD7.withValues(alpha: 0.15),
                width: 1.w,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 52.h,
                  width: 52.w,
                  decoration: BoxDecoration(
                    color: AppColors.allsecondaryColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.c1C1919.withValues(alpha: 0.30),
                        blurRadius: 8.r,
                        offset: Offset(0, 6.h),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Image.asset(
                      imagePath,
                      height: iconSize ?? 20.h,
                      width: iconSize ?? 20.w,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  label,
                  style: TextFontStyle.textStyle14cF5EDD7HelveticaNeue400,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}