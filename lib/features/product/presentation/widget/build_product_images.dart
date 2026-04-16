import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common_widgets/app_network_image.dart';
import '../../../../gen/colors.gen.dart';
import '../../model/products_details_model.dart';

Widget buildProductImages(Product product) {
  return Column(
    children: [
      // Main Image
      Container(
        height: 300.h,
        width: double.infinity,
        color: AppColors.cF5F5F5,
        child: AppNetworkImage(
          imageUrl: product.image ?? '',
          height: 300.h,
          width: double.infinity,
          fit: BoxFit.contain,
          customErrorWidget: Container(
            height: 300.h,
            width: double.infinity,
            color: AppColors.cE8E8E8,
            child: Icon(
              Icons.image_not_supported_outlined,
              size: 60.sp,
              color: AppColors.c949494,
            ),
          ),
        ),
      ),

      // Gallery Images (if available)
      if (product.galleryImages != null && product.galleryImages!.isNotEmpty)
        Container(
          height: 80.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: product.galleryImages!.length,
            itemBuilder: (context, index) {
              return Container(
                width: 60.w,
                height: 60.h,
                margin: EdgeInsets.only(right: 8.w),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.cE8E8E8),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: AppNetworkImage(
                  imageUrl: product.galleryImages![index].toString(),
                  height: 60.h,
                  width: 60.w,
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
        ),
    ],
  );
}
