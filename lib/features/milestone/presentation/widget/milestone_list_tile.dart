import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter/constants/text_font_style.dart';
import 'package:template_flutter/gen/colors.gen.dart';

enum MilestoneStatus { completed, inProgress, locked }

class MilestoneListTile extends StatelessWidget {
  const MilestoneListTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    this.status = MilestoneStatus.inProgress,
    this.progress,
  });

  final String title;
  final String subtitle;
  final String imagePath;
  final MilestoneStatus status;
  final double? progress;

  @override
  Widget build(BuildContext context) {
    final bool hasProgress = progress != null;
    final Color iconContainerColor = status == MilestoneStatus.completed
        ? AppColors.white.withValues(alpha: 0.32)
        : AppColors.cF5EDD7.withValues(alpha: 0.36);

    return ClipRRect(
      borderRadius: BorderRadius.circular(24.r),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.allPrimaryColor,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(
            color: AppColors.allsecondaryColor.withValues(alpha: 0.12),
            width: 1.w,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 14.h),
              child: Row(
                children: [
                  Container(
                    width: 60.w,
                    height: 60.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: iconContainerColor,
                    ),
                    child: Center(
                      child: Image.asset(
                        imagePath,
                        height: 24.sp,
                        width: 24.sp,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextFontStyle
                              .textStyle16c3B230EHelveticaNeue500
                              .copyWith(
                            color: status == MilestoneStatus.locked
                                ? AppColors.c99907A
                                : AppColors.allsecondaryColor,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          subtitle,
                          style: TextFontStyle
                              .textStyle14c796956HelveticaNeue400
                              .copyWith(
                            color: status == MilestoneStatus.locked
                                ? AppColors.c99907A
                                : AppColors.c796956,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8.w),
                  _StatusChip(status: status),
                ],
              ),
            ),
            if (hasProgress)
              LinearProgressIndicator(
                value: progress!.clamp(0, 1),
                minHeight: 8.h,
                backgroundColor: AppColors.cBCD5BC,
                valueColor:
                    const AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 13, 156, 3)),
              ),
          ],
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});

  final MilestoneStatus status;

  @override
  Widget build(BuildContext context) {
    final Gradient fillgradient;
    final Color textColor;
    final String label;

    switch (status) {
      case MilestoneStatus.completed:
        fillgradient = LinearGradient(
          colors: [
            AppColors.white.withValues(alpha: 0.00),
            AppColors.white.withValues(alpha: 0.00),
          ],
        );
        textColor = AppColors.allPrimaryColor;
        label = '';
        break;
      case MilestoneStatus.inProgress:
        fillgradient = LinearGradient(
          colors: [
            AppColors.cCFC7B6,
            const Color.fromARGB(255, 165, 157, 139),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
        textColor = AppColors.allsecondaryColor;
        label = 'In Progress';
        break;
      case MilestoneStatus.locked:
        fillgradient = LinearGradient(
          colors: [
            AppColors.allsecondaryColor.withValues(alpha: 0.30),
            AppColors.allsecondaryColor.withValues(alpha: 0.30),
          ],
        );
        textColor = AppColors.cF5EDD7;
        label = 'Locked';
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.r),
        gradient: fillgradient,
        border: status == MilestoneStatus.completed
            ? null
            : Border.all(
                color: AppColors.allsecondaryColor.withValues(alpha: 0.20),
                width: 1.5.w,
              ),
      ),
      child: Text(
        label,
        style: TextFontStyle.textStyle14c3B230EHelveticaNeue500.copyWith(
          color: textColor,
        ),
      ),
    );
  }
}
