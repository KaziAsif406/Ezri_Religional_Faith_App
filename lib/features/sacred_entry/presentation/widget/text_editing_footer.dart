import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter/constants/text_font_style.dart';

import '../../../../gen/colors.gen.dart';

class TextEditingFooterButtons extends StatelessWidget {
  const TextEditingFooterButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        FooterCircleButton(
          label: 'B',
          style: TextFontStyle.textStyle14c3B230EHelveticaNeue500,
        ),
        SizedBox(width: 10.w),
        FooterCircleButton(
          label: 'I',
          style: TextFontStyle.textStyle14c3B230EHelveticaNeue400.copyWith(
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(width: 10.w),
        FooterCircleButton(
          label: 'U',
          style: TextFontStyle.textStyle14c3B230EHelveticaNeue400.copyWith(
            decoration: TextDecoration.underline,
          ),
        ),
      ],
    );
  }
}

class FooterCircleButton extends StatelessWidget {
  const FooterCircleButton({
    super.key,
    required this.label,
    required this.style,
  });

  final String label;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34.w,
      height: 34.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color.fromARGB(255, 230, 225, 213).withValues(alpha: 0.84),
        boxShadow: [
          BoxShadow(
            color: AppColors.c1C1919.withValues(alpha: 0.10),
            blurRadius: 4.r,
            offset: Offset(0, 5.h),
          ),
        ],
      ),
      child: Center(
        child: Text(label, style: style.copyWith(fontSize: 14.sp)),
      ),
    );
  }
}
