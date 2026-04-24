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
    required this.icon,
    this.status = MilestoneStatus.inProgress,
    this.progress,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final MilestoneStatus status;
  final double? progress;

  @override
  Widget build(BuildContext context) {
    final bool hasProgress = progress != null;
    final Color iconContainerColor = status == MilestoneStatus.completed
        ? AppColors.cE5EAEB.withValues(alpha: 0.28)
        : AppColors.cF5EDD7.withValues(alpha: 0.36);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
      decoration: BoxDecoration(
        color: AppColors.cF5EDD7.withValues(alpha: 0.60),
        borderRadius: BorderRadius.circular(26.r),
        border: Border.all(
          color: AppColors.c8C7C68.withValues(alpha: 0.20),
          width: 1.w,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 70.w,
                height: 70.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: iconContainerColor,
                ),
                child: Icon(
                  icon,
                  size: 30.sp,
                  color: status == MilestoneStatus.locked
                      ? AppColors.c99907A
                      : AppColors.allsecondaryColor,
                ),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextFontStyle.textStyle24c3B230EHelveticaNeue500
                          .copyWith(
                        fontSize: 16.sp,
                        color: status == MilestoneStatus.locked
                            ? AppColors.c99907A
                            : AppColors.allsecondaryColor,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      subtitle,
                      style: TextFontStyle.textStyle14c796956HelveticaNeue400
                          .copyWith(
                        fontSize: 14.sp,
                        color: status == MilestoneStatus.locked
                            ? AppColors.c99907A
                            : AppColors.c796956,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10.w),
              _StatusChip(status: status),
            ],
          ),
          if (hasProgress) ...[
            SizedBox(height: 16.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(999.r),
              child: LinearProgressIndicator(
                value: progress!.clamp(0, 1),
                minHeight: 8.h,
                backgroundColor: AppColors.cBCD5BC,
                valueColor:
                    const AlwaysStoppedAnimation<Color>(AppColors.c15AB09),
              ),
            ),
          ],
          SizedBox(height: 14.h),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});

  final MilestoneStatus status;

  @override
  Widget build(BuildContext context) {
    final Color fillColor;
    final Color textColor;
    final String label;

    switch (status) {
      case MilestoneStatus.completed:
        fillColor = AppColors.cBCD5BC;
        textColor = AppColors.c238D1A;
        label = 'Completed';
        break;
      case MilestoneStatus.inProgress:
        fillColor = AppColors.cF5EDD7;
        textColor = AppColors.allsecondaryColor;
        label = 'In Progress';
        break;
      case MilestoneStatus.locked:
        fillColor = AppColors.c99907A;
        textColor = AppColors.cF5EDD7;
        label = 'Locked';
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.r),
        color: fillColor,
        border: Border.all(
          color: AppColors.c8C7C68.withValues(alpha: 0.40),
          width: 1.w,
        ),
      ),
      child: Text(
        label,
        style: TextFontStyle.textStyle20c3B230EHelveticaNeue500.copyWith(
          fontSize: 14.sp,
          color: textColor,
        ),
      ),
    );
  }
}
