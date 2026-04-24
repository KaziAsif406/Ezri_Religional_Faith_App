import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter/constants/text_font_style.dart';
import 'package:template_flutter/gen/colors.gen.dart';
import 'package:template_flutter/helpers/ui_helpers.dart';

class JourneyProgressCard extends StatelessWidget {
  const JourneyProgressCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, -20.h),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.cC7BFAD.withValues(alpha: 0.00),
          borderRadius: BorderRadius.circular(24.r),
        ),
        padding: EdgeInsets.fromLTRB(16.w, 18.h, 16.w, 16.h),
        child: Row(
          children: [
            Expanded(
              child: _SummaryMetricTile(
                imagePath: 'assets/icons/fire_outlined.png',
                value: '15 days',
                label: 'Longest\nStreak',
              ),
            ),
            UIHelper.horizontalSpace(8.w),
            Expanded(
              child: _SummaryMetricTile(
                imagePath: 'assets/icons/book.png',
                value: '20 logged',
                label: 'Sacred Entries\nLogs',
              ),
            ),
            UIHelper.horizontalSpace(8.w),
            Expanded(
              child: _SummaryMetricTile(
                imagePath: 'assets/icons/verse.png',
                value: '05 saved',
                label: 'Anchored\nVerses',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryMetricTile extends StatelessWidget {
  const _SummaryMetricTile({
    required this.imagePath,
    required this.value,
    required this.label,
  });

  final String imagePath;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 176.h,
      padding: EdgeInsets.fromLTRB(8.w, 10.h, 8.w, 12.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.scaffoldColor.withValues(alpha: 0.00),
            AppColors.allPrimaryColor.withValues(alpha: 0.72),
          ],
        ),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            children: [
              Container(
                width: 95.w,
                height: 95.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.cF5EDD7.withValues(alpha: 0.45),
                ),
                child: Center(
                  child: Image.asset(
                    imagePath,
                    width: 34.w,
                    height: 34.w,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset(0, 72.h),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 13.w),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.cCFC7B6,
                        Color.fromARGB(255, 151, 143, 126),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(999.r),
                    border: Border.all(
                      color: AppColors.allsecondaryColor.withValues(alpha: 0.18),
                      width: 1.w,
                    ),
                  ),
                  child: Text(
                    value,
                    textAlign: TextAlign.center,
                    style: TextFontStyle.textStyle14c3B230EHelveticaNeue500,
                  ),
                ),
              ),
            ],
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextFontStyle.textStyle14c8C7C68HelveticaNeue500.copyWith(
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

