import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter/constants/text_font_style.dart';
import 'package:template_flutter/gen/assets.gen.dart';
import 'package:template_flutter/gen/colors.gen.dart';
import 'package:template_flutter/helpers/ui_helpers.dart';


class MilestoneSummaryCard extends StatelessWidget {
  const MilestoneSummaryCard({
    required this.completedDays,
    required this.targetDays,
    required this.currentStreak,
    required this.userName,
    required this.remainingDays,
    required this.progress,
    this.onContinueTap,
  });

  final int completedDays;
  final int targetDays;
  final int currentStreak;
  final String userName;
  final int remainingDays;
  final double progress;
  final VoidCallback? onContinueTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28.r),
        color: AppColors.allsecondaryColor.withValues(alpha: 0.12),
        border: Border.all(
          color: AppColors.c8C7C68.withValues(alpha: 0.48),
          width: 1.2.w,
        ),
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.allsecondaryColor.withValues(alpha: 0.20),
              AppColors.allsecondaryColor.withValues(alpha: 0.40),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(
            color: AppColors.c8C7C68.withValues(alpha: 0.48),
            width: 1.w,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40.r),
                      border: Border.all(
                        color: AppColors.cF5F6F5.withValues(alpha: 0.40),
                        width: 1.w,
                      ),
                      color: Colors.transparent,
                    ),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40.r),
                        gradient: 
                            LinearGradient(
                          colors: [
                            AppColors.cF5EDD7,
                            const Color.fromARGB(255, 182, 173, 148),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            Assets.icons.fire.path,
                            width: 18.w,
                            height: 18.w,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            '$currentStreak days',
                            style: TextFontStyle.textStyle14c3B230EHelveticaNeue400,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Well done, $userName.',
                    style: TextFontStyle.textStyle18c3B230EHelveticaNeue500
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'Just $remainingDays more days of prayer and you\'ll\ncomplete this milestone!',
                    style:
                        TextFontStyle.textStyle14c675440HelveticaNeue400,
                  ),                  
                ],
              ),
            ),
            SizedBox(width: 16.w),
            Column(
              children: [
                SizedBox(
                  width: 80.w,
                  height: 80.w,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 80.w,
                        height: 80.w,
                        child: CircularProgressIndicator(
                          value: progress.clamp(0, 1),
                          backgroundColor: AppColors.allPrimaryColor.withValues(alpha: 0.28),
                          valueColor: const AlwaysStoppedAnimation<Color>(
                              AppColors.allsecondaryColor),
                          strokeWidth: 14.w,
                          strokeCap: StrokeCap.round,
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(0, 16),
                        child: Column(
                          children: [
                            Text(
                              '$completedDays/$targetDays',
                              textAlign: TextAlign.center,
                              style: TextFontStyle.textStyle20c3B230EHelveticaNeue500,
                            ),
                            Text(
                              'days',
                              textAlign: TextAlign.center,
                              style: TextFontStyle.textStyle14c3B230EHelveticaNeue400,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                UIHelper.verticalSpace(41.h),
                GestureDetector(
                  onTap: onContinueTap,
                  child: Text(
                    'Continue ->',
                    style: TextFontStyle.textStyle20cFFFFFFHelveticaNeue700
                        .copyWith(fontSize: 16.sp),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}