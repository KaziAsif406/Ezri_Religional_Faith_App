import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../constants/text_font_style.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../helpers/ui_helpers.dart';
import '../../model/products_details_model.dart';

String _getDisplayPrice(Product product) {
  if (product.price?.isNotEmpty ?? false) {
    return product.price!;
  } else if (product.regularPrice?.isNotEmpty ?? false) {
    return product.regularPrice!;
  } else if (product.salePrice?.isNotEmpty ?? false) {
    return product.salePrice!;
  }
  return '0.00';
}

Widget buildProductDetails(Product product) {
  return Padding(
    padding: EdgeInsets.all(16.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product Name
        Text(
          product.name ?? 'No Name',
          style: TextFontStyle.textStyle20c202020DMSans600,
        ),

        UIHelper.verticalSpace(8.h),

        // Rating
        Row(
          children: [
            Icon(
              Icons.star,
              size: 16.sp,
              color: AppColors.cFFD700,
            ),
            UIHelper.horizontalSpace(4.w),
            Text(
              product.rating ?? '0',
              style: TextFontStyle.textStyle14c606060DMSans400,
            ),
            UIHelper.horizontalSpace(8.w),
            Text(
              '(${product.reviewCount ?? 0} reviews)',
              style: TextFontStyle.textStyle12c949494DMSans400,
            ),
          ],
        ),

        UIHelper.verticalSpace(12.h),

        // Price
        Row(
          children: [
            if (product.onSale == true && product.salePrice?.isNotEmpty == true)
              Text(
                '\$${product.regularPrice ?? '0.00'}',
                style: TextFontStyle.textStyle16c606060DMSans400.copyWith(
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            UIHelper.horizontalSpace(8.w),
            Text(
              '\$${_getDisplayPrice(product)}',
              style: TextFontStyle.textStyle22cFF3A1222DMSans600,
            ),
            if (product.onSale == true) ...[
              UIHelper.horizontalSpace(8.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: AppColors.c4CAF50,
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(
                  'SALE',
                  style: TextFontStyle.textStyle10cFFFFFFDMSans400,
                ),
              ),
            ],
          ],
        ),

        UIHelper.verticalSpace(12.h),

        // Stock Status
        Row(
          children: [
            Container(
              width: 8.w,
              height: 8.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (product.inStock ?? false)
                    ? AppColors.c4CAF50
                    : AppColors.cF44336,
              ),
            ),
            UIHelper.horizontalSpace(8.w),
            Text(
              (product.inStock ?? false) ? 'In Stock' : 'Out of Stock',
              style: TextFontStyle.textStyle14c202020DMSans500,
            ),
            UIHelper.horizontalSpace(16.w),
            Text(
              'SKU: ${product.sku ?? 'N/A'}',
              style: TextFontStyle.textStyle12c949494DMSans400,
            ),
          ],
        ),

        UIHelper.verticalSpace(12.h),

        // Categories
        if (product.categories != null && product.categories!.isNotEmpty)
          Wrap(
            spacing: 8.w,
            children: product.categories!.map((category) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.cF5F5F5,
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(
                  category.name ?? '',
                  style: TextFontStyle.textStyle12c606060DMSans400,
                ),
              );
            }).toList(),
          ),
      ],
    ),
  );
}
