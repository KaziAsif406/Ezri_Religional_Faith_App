import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../constants/text_font_style.dart';
import '../../../../helpers/ui_helpers.dart';
import '../../model/products_details_model.dart';

String _cleanHtmlText(String htmlText) {
  // Simple HTML tag removal - you might want to use a proper HTML parser
  return htmlText
      .replaceAll(RegExp(r'<[^>]*>'), '')
      .replaceAll('&nbsp;', ' ')
      .trim();
}

Widget buildDescription(Product product) {
  if (product.description?.isEmpty ?? true) {
    return const SizedBox.shrink();
  }

  return Padding(
    padding: EdgeInsets.all(16.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: TextFontStyle.textStyle18c202020DMSans600,
        ),
        UIHelper.verticalSpace(8.h),
        Text(
          _cleanHtmlText(product.description ?? ''),
          style: TextFontStyle.textStyle14c606060DMSans400.copyWith(
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}
