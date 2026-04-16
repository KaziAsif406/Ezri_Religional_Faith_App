import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../common_widgets/app_network_image.dart';
import '../../../../constants/text_font_style.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../helpers/all_routes.dart';
import '../../../../helpers/navigation_service.dart';
import '../../../../helpers/ui_helpers.dart';
import '../../model/product_model.dart';

Widget buildProductItem(ProductModel product) {
  return InkWell(
    onTap: () {
      // Handle product item tap if needed

      NavigationService.navigateToWithArgs(Routes.productDetailsScreen, {
        'productId': product.id,
      });
    },
    child: Container(
      decoration: BoxDecoration(
        color: AppColors.cFFFFFF,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.c000000.withValues(alpha: 0.1),
            blurRadius: 8.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.r),
              topRight: Radius.circular(12.r),
            ),
            child: AppNetworkImage(
              imageUrl: product.image ?? '',
              height: 120.h,
              width: double.infinity,
              fit: BoxFit.cover,
              customErrorWidget: Container(
                height: 120.h,
                width: double.infinity,
                color: AppColors.cE8E8E8,
                child: Icon(
                  Icons.image_not_supported_outlined,
                  size: 40.sp,
                  color: AppColors.c949494,
                ),
              ),
            ),
          ),

          UIHelper.verticalSpace(8.h),

          // Product Details
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Name
                Text(
                  product.name ?? 'No Name',
                  style: TextFontStyle.textStyle14c202020DMSans600,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                UIHelper.verticalSpace(4.h),

                // Price
                Row(
                  children: [
                    if (product.onSale == true &&
                        (product.salePrice?.isNotEmpty ?? false))
                      Text(
                        '\$${product.regularPrice ?? '0.00'}',
                        style:
                            TextFontStyle.textStyle12c606060DMSans400.copyWith(
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    UIHelper.horizontalSpace(4.w),
                    Text(
                      '\$${_getDisplayPrice(product)}',
                      style: TextFontStyle.textStyle14cFF3A1222DMSans600,
                    ),
                  ],
                ),

                UIHelper.verticalSpace(4.h),

                // Rating and Stock
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Rating
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 14.sp,
                          color: AppColors.cFFD700,
                        ),
                        UIHelper.horizontalSpace(2.w),
                        Text(
                          product.rating ?? '0',
                          style: TextFontStyle.textStyle12c606060DMSans400,
                        ),
                      ],
                    ),

                    // Stock Status
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: (product.inStock ?? false)
                            ? AppColors.c4CAF50
                            : AppColors.cF44336,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        (product.inStock ?? false)
                            ? 'In Stock'
                            : 'Out of Stock',
                        style: TextFontStyle.textStyle10cFFFFFFDMSans400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

String _getDisplayPrice(ProductModel product) {
  if (product.price?.isNotEmpty ?? false) {
    return product.price!;
  } else if (product.regularPrice?.isNotEmpty ?? false) {
    return product.regularPrice!;
  } else if (product.salePrice?.isNotEmpty ?? false) {
    return product.salePrice!;
  }
  return '0.00';
}
