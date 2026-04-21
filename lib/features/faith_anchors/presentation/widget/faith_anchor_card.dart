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
      height: 215.h,
      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 16.h),
      decoration: BoxDecoration(
        color: AppColors.cE0DACA,
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF4A230D).withValues(alpha: 0.22),
            blurRadius: 22.r,
            spreadRadius: 1.r,
            offset: Offset(0, 5.h),
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
            style: TextFontStyle.textStyle20c3B230EHelveticaNeue400,
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 25.w,
                height: 25.w,
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
                  size: 25.sp,
                  color: AppColors.cF5EDD7,
                ),
              ),
              SizedBox(width: 8.w),
              Flexible(
                child: Text(
                  item.reference.isEmpty ? 'Unknown Reference' : item.reference,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextFontStyle.textStyle14c796956HelveticaNeue300.copyWith(
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ],
          ),
          // SizedBox(height: 12.h),
          Spacer(),
          const _WavyDivider(),
          SizedBox(height: 12.h),
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
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppColors.cF5EDD7.withValues(alpha: 0.0),
        borderRadius: BorderRadius.circular(999.r),
        border: Border.all(
          color: AppColors.cF2F2F2.withValues(alpha: 0.60),
          width: 1.w,
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.cF5EDD7,
              const Color.fromARGB(255, 184, 175, 156),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(999.r),
        ),
        child: Text(
          typeText,
          style: TextFontStyle.textStyle14c796956HelveticaNeue300.copyWith(
            fontWeight: FontWeight.w500,
          ),
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
        width: 32.w,
        height: 32.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.cFBFCFA.withValues(alpha: 0.30),
        ),
        child: Icon(
          icon,
          size: 18.sp,
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
