import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter/constants/text_font_style.dart';

import '../../../../gen/colors.gen.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.lightText,
    required this.darkText,
  });

  final String lightText;
  final String darkText;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: <InlineSpan>[
          TextSpan(
            text: '$lightText ',
            style: TextFontStyle.textStyle16c8C7C68HelveticaNeue400.copyWith(
              fontSize: 24.sp,
              color: AppColors.c8C7C68,
            ),
          ),
          TextSpan(
            text: darkText,
            style: TextFontStyle.textStyle16c8C7C68HelveticaNeue400.copyWith(
              fontSize: 24.sp,
              color: AppColors.c352619,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
