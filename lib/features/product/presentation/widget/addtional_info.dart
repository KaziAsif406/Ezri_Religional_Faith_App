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

Widget _buildInfoRow(String title, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8.h),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            title,
            style: TextFontStyle.textStyle14c202020DMSans600,
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: TextFontStyle.textStyle14c606060DMSans400,
          ),
        ),
      ],
    ),
  );
}

Widget buildAdditionalInfo(Product product) {
  return Padding(
    padding: EdgeInsets.all(16.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Additional Information',
          style: TextFontStyle.textStyle18c202020DMSans600,
        ),
        UIHelper.verticalSpace(12.h),
        _buildInfoRow('Product Type', product.type ?? 'N/A'),
        _buildInfoRow('Stock Status', product.stockStatus ?? 'N/A'),
        if (product.shortDescription?.isNotEmpty ?? false)
          _buildInfoRow(
              'Short Description', _cleanHtmlText(product.shortDescription!)),
      ],
    ),
  );
}
