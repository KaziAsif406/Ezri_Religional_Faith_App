// lib/features/products/presentation/product_details_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../common_widgets/custom_appbar.dart';
import '../../../common_widgets/no_data_widget.dart';
import '../../../common_widgets/not_found_widget.dart';
import '../../../common_widgets/waiting_widget.dart';
import '../../../constants/text_font_style.dart';
import '../../../features/product/presentation/widget/build_product_images.dart';
import '../../../gen/colors.gen.dart';
import '../../../helpers/ui_helpers.dart';
import '../../../networks/api_acess.dart';
import '../model/products_details_model.dart';
import 'widget/addtional_info.dart';
import 'widget/poduct_details_widget.dart';
import 'widget/product_description.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int productId;

  const ProductDetailsScreen({super.key, required this.productId});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  void initState() {
    super.initState();
    // Assuming you have a product details API call method
    productDetailsRxObj.featchProductDetails(id: widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        showBackArrow: true,
        title: Text(
          "Product Details",
          style: TextFontStyle.textStyle18c172B4DDMSans500,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: productDetailsRxObj.fileData,
          builder: (context, snapshot) {
            if (snapshot.data == productDetailsRxObj.empty) {
              return const WaitingWidget();
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const WaitingWidget();
            } else if (snapshot.hasData && snapshot.data != null) {
              final responseData = snapshot.data!;

              // Parse the response
              ProductDetailsResModel productDetailsResponse;
              try {
                productDetailsResponse = ProductDetailsResModel.fromJson(
                    responseData as Map<String, dynamic>);
              } catch (e) {
                return const NoDataWidget(
                  title: 'Data Error',
                  subtitle: 'Failed to parse product details',
                );
              }

              if (productDetailsResponse.data?.product == null) {
                return const NoDataWidget(
                  title: 'Product Not Found',
                  subtitle: 'The product details are not available.',
                );
              }

              final product = productDetailsResponse.data!.product!;

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Images
                    buildProductImages(product),

                    // Product Details
                    buildProductDetails(product),

                    // Description
                    //  _buildDescription(product),

                    // Additional Information
                    buildAdditionalInfo(product),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return const NotFoundWidget();
            } else {
              // For demo - replace with actual API call
              return buildDemoProductDetails();
            }
          },
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.cFFFFFF,
        border: Border(
          top: BorderSide(color: AppColors.cE8E8E8),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.c000000.withValues(alpha: 0.1),
            blurRadius: 8.r,
            offset: Offset(0, -2.h),
          ),
        ],
      ),
      child: Row(
        children: [
          // Add to Cart Button
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                // Add to cart functionality
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.allPrimaryColor,
                foregroundColor: AppColors.cFFFFFF,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text(
                'Add to Cart',
                style: TextFontStyle.textStyle16cFFFFFFDMSans600,
              ),
            ),
          ),
          UIHelper.horizontalSpace(12.w),
          // Buy Now Button
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                // Buy now functionality
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.c4CAF50,
                foregroundColor: AppColors.cFFFFFF,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text(
                'Buy Now',
                style: TextFontStyle.textStyle16cFFFFFFDMSans600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String getDisplayPrice(Product product) {
    if (product.price?.isNotEmpty ?? false) {
      return product.price!;
    } else if (product.regularPrice?.isNotEmpty ?? false) {
      return product.regularPrice!;
    } else if (product.salePrice?.isNotEmpty ?? false) {
      return product.salePrice!;
    }
    return '0.00';
  }

  // Demo product for testing (remove when API is connected)
  Widget buildDemoProductDetails() {
    final demoProduct = Product(
      id: 1,
      name: "Demo Product",
      price: "29.99",
      regularPrice: "39.99",
      salePrice: "29.99",
      onSale: true,
      image: "https://via.placeholder.com/400",
      rating: "4.5",
      reviewCount: 25,
      stockStatus: "instock",
      inStock: true,
      description:
          "This is a demo product description with some details about the product features and benefits.",
      shortDescription: "Short description of the product",
      sku: "DEMO123",
      type: "simple",
      categories: [
        Category(id: 1, name: "Electronics", slug: "electronics"),
        Category(id: 2, name: "Mobile", slug: "mobile"),
      ],
    );

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildProductImages(demoProduct),
          buildProductDetails(demoProduct),
          buildDescription(demoProduct),
          buildAdditionalInfo(demoProduct),
        ],
      ),
    );
  }
}
