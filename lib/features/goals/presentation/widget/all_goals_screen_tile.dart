import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter/common_widgets/custom_button.dart';
import 'package:template_flutter/constants/text_font_style.dart';
import 'package:template_flutter/features/goals/data/goal_store.dart';
import 'package:template_flutter/gen/colors.gen.dart';

class AllGoalsScreenTile extends StatelessWidget {
  const AllGoalsScreenTile({
    super.key,
    required this.goal,
    this.onTap,
  });

  final SavedGoal goal;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.allPrimaryColor,
        borderRadius: BorderRadius.circular(28.r),
        border: Border.all(
          color: AppColors.allsecondaryColor.withValues(alpha: 0.12),
          width: 1.w,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28.r),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 14.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 72.w,
                    height: 72.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.cF5EDD7.withValues(alpha: 0.45),
                    ),
                    child: Center(
                      child: Image(
                        image: AssetImage(goal.iconPath),
                        width: 30.w,
                        height: 30.w,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          goal.subtitle,
                          style:
                              TextFontStyle.textStyle12c99907AHelveticaNeue400,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          goal.title,
                          style: TextFontStyle
                              .textStyle20c3B230EHelveticaNeue500
                              .copyWith(
                            fontSize: 18.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10.w),
                  _GoalActionChip(
                    label: goal.isLocked
                        ? 'Locked'
                        : goal.progress >= 1
                            ? 'Done'
                            : 'Log',
                    onTap: onTap,
                    isLocked: goal.isLocked,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: WavyProgressSeparator(),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Today progress',
                    style: TextFontStyle.textStyle16c796956HelveticaNeue400
                        .copyWith(fontSize: 16.sp),
                  ),
                  SizedBox(height: 10.h),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(999.r),
                    child: LinearProgressIndicator(
                      value: goal.progress.clamp(0, 1),
                      minHeight: 10.h,
                      backgroundColor:
                          AppColors.cBCD5BC.withValues(alpha: 0.55),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        AppColors.c238D1A,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GoalActionChip extends StatelessWidget {
  const _GoalActionChip({
    required this.label,
    required this.isLocked,
    this.onTap,
  });

  final String label;
  final bool isLocked;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isLocked
                ? [
                    AppColors.cCFC7B6,
                    AppColors.cA29783,
                  ]
                : [
                    AppColors.cCFC7B6,
                    AppColors.cB4B197,
                  ],
          ),
          borderRadius: BorderRadius.circular(999.r),
          border: Border.all(
            color: AppColors.allsecondaryColor.withValues(alpha: 0.16),
            width: 1.w,
          ),
        ),
        child: Text(
          label,
          style: TextFontStyle.textStyle16c3B230EHelveticaNeue500.copyWith(
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }
}

class WavyProgressSeparator extends StatelessWidget {
  const WavyProgressSeparator({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 6.h,
      child: CustomPaint(
        painter: _WavyProgressPainter(),
      ),
    );
  }
}

class _WavyProgressPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = AppColors.cF5EDD7.withValues(alpha: 0.55)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2.w;

    final Path path = Path();
    const int waves = 14;
    final double segmentWidth = size.width / waves;
    path.moveTo(0, size.height / 2);
    for (int index = 0; index < waves; index++) {
      final double startX = index * segmentWidth;
      final double endX = startX + segmentWidth;
      path.quadraticBezierTo(
        startX + segmentWidth / 2,
        index.isEven ? 0 : size.height,
        endX,
        size.height / 2,
      );
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
