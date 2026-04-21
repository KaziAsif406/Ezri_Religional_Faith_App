import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter/constants/text_font_style.dart';

import '../../../../gen/colors.gen.dart';
import 'faith_anchor_store.dart';

class FaithAnchorCard extends StatelessWidget {
  const FaithAnchorCard({
    super.key,
    required this.item,
    this.onDelete,
    this.onEdit,
  });

  final FaithAnchorItem item;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(26.w, 22.h, 26.w, 22.h),
      decoration: BoxDecoration(
        color: AppColors.allPrimaryColor,
        borderRadius: BorderRadius.circular(40.r),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF4A230D).withValues(alpha: 0.42),
            blurRadius: 32.r,
            spreadRadius: 2.r,
            offset: Offset(0, 14.h),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Text(
            '"${item.content}"',
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextFontStyle.textStyle16c8C7C68HelveticaNeue400.copyWith(
              fontSize: 48.sp,
              color: AppColors.c352619,
              fontWeight: FontWeight.w500,
              height: 1.35,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 54.w,
                height: 54.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                      Color(0xFF82C4C8),
                      Color(0xFF4E9BA2),
                    ],
                  ),
                ),
                child: Icon(
                  Icons.person,
                  size: 34.sp,
                  color: AppColors.cF5EDD7,
                ),
              ),
              SizedBox(width: 12.w),
              Flexible(
                child: Text(
                  item.reference.isEmpty ? 'Unknown Reference' : item.reference,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextFontStyle.textStyle16c8C7C68HelveticaNeue400.copyWith(
                    fontSize: 42.sp,
                    color: AppColors.c8C7C68,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 18.h),
          const _WavyDivider(),
          SizedBox(height: 18.h),
          Row(
            children: <Widget>[
              _TypePill(typeText: item.type),
              const Spacer(),
              _ActionCircleButton(
                icon: Icons.delete_outline_rounded,
                onTap: onDelete,
              ),
              SizedBox(width: 10.w),
              _ActionCircleButton(
                icon: Icons.edit_outlined,
                onTap: onEdit,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TypePill extends StatelessWidget {
  const _TypePill({required this.typeText});

  final String typeText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.cF5EDD7.withValues(alpha: 0.38),
        borderRadius: BorderRadius.circular(999.r),
        border: Border.all(
          color: AppColors.cF5EDD7.withValues(alpha: 0.60),
          width: 1.w,
        ),
      ),
      child: Text(
        typeText,
        style: TextFontStyle.textStyle16c8C7C68HelveticaNeue400.copyWith(
          fontSize: 40.sp,
          color: AppColors.c796956,
        ),
      ),
    );
  }
}

class _ActionCircleButton extends StatelessWidget {
  const _ActionCircleButton({required this.icon, this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 62.w,
        height: 62.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.cF5EDD7.withValues(alpha: 0.56),
        ),
        child: Icon(
          icon,
          size: 30.sp,
          color: AppColors.c513B26,
        ),
      ),
    );
  }
}

class _WavyDivider extends StatelessWidget {
  const _WavyDivider();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 7.h,
      child: CustomPaint(
        painter: _WavyLinePainter(),
      ),
    );
  }
}

class _WavyLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = AppColors.cF5EDD7.withValues(alpha: 0.92)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8.w;

    final Path path = Path();
    const double waves = 14;
    final double segment = size.width / waves;

    path.moveTo(0, size.height / 2);
    for (double i = 0; i < waves; i++) {
      final double startX = i * segment;
      final double endX = startX + segment;
      path.quadraticBezierTo(
        startX + segment / 2,
        i % 2 == 0 ? 0 : size.height,
        endX,
        size.height / 2,
      );
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
