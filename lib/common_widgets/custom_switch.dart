import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../gen/colors.gen.dart';

class CustomSwitch extends StatelessWidget {
  const CustomSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.width = 60,
    this.height = 36,
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final double switchWidth = width.w;
    final double switchHeight = height.h;
    final double thumbSize = (height - 5).w;

    return Semantics(
      toggled: value,
      child: GestureDetector(
        onTap: () => onChanged(!value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          width: switchWidth,
          height: switchHeight,
          padding: EdgeInsets.all(2.5.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999.r),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFD8D1C1),
                Color(0xFFC3BBAB),
              ],
            ),
            border: Border.all(
              color: AppColors.allsecondaryColor,
              width: 1.w,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6C3D23).withValues(alpha: 0.10),
                blurRadius: 22.r,
                spreadRadius: 1.2.r,
                offset: const Offset(0, 8),
              ),
              BoxShadow(
                color: const Color(0xFF2A1307).withValues(alpha: 0.16),
                blurRadius: 7.r,
                spreadRadius: 0,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: AnimatedAlign(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            alignment: value ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              width: thumbSize,
              height: thumbSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const RadialGradient(
                  center: Alignment(-0.25, -0.30),
                  radius: 1.05,
                  colors: [
                    Color(0xFF654024),
                    Color(0xFF3F220F),
                    Color(0xFF2A1307),
                  ],
                ),
                border: Border.all(
                  color: const Color(0xFFF0E8D8).withValues(alpha: 0.55),
                  width: 1.w,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF1D0F06).withValues(alpha: 0.36),
                    blurRadius: 9.r,
                    spreadRadius: 0.5.r,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}