import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter/constants/text_font_style.dart';

class HomeSectionHeader extends StatelessWidget {
  const HomeSectionHeader({
    super.key,
    required this.titlePrefix,
    required this.titleHighlight,
    this.actionText,
    this.onActionTap,
  });

  final String titlePrefix;
  final String titleHighlight;
  final String? actionText;
  final VoidCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    final hasAction = actionText != null && onActionTap != null;

    return Row(
      children: [
        Text(
          titlePrefix,
          style: TextFontStyle.textStyle24c8C7C68HelveticaNeue400,
        ),
        SizedBox(width: 8.w),
        Text(
          titleHighlight,
          style: TextFontStyle.textStyle24c3B230EHelveticaNeue700,
        ),
        const Spacer(),
        if (hasAction)
          GestureDetector(
            onTap: onActionTap,
            child: Text(
              actionText!,
              style: TextFontStyle.textStyle18c3B230EHelveticaNeue700.copyWith(
                decoration: TextDecoration.underline,
                decorationThickness: 1.8,
              ),
            ),
          ),
      ],
    );
  }
}