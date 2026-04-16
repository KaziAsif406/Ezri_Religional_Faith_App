// lib/features/products/presentation/products_screen.dart
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../common_widgets/custom_appbar.dart';
import '../../../common_widgets/app_network_image.dart';
import '../../../common_widgets/no_data_widget.dart';
import '../../../common_widgets/not_found_widget.dart';
import '../../../common_widgets/waiting_widget.dart';
import '../../../constants/text_font_style.dart';
import '../../../gen/colors.gen.dart';
import '../../../helpers/ui_helpers.dart';
import '../../../networks/api_acess.dart';
import '../model/product_model.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;
  int _currentPage = 1;
  bool _hasMore = true;
  List<ProductModel> _allProducts = [];
  PaginationModel? _pagination;

  @override
  void initState() {
    super.initState();
    _loadProducts(1);
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      if (!_isLoadingMore && _hasMore) {
        _loadMoreProducts();
      }
    }
  }

  void _loadProducts(int page) {
    getProductsRxObj.featchProducts(pageNum: page);
  }

  void _loadMoreProducts() {
    if (!_isLoadingMore && _hasMore) {
      setState(() {
        _isLoadingMore = true;
      });
      _currentPage++;
      _loadProducts(_currentPage);
    }
  }

  Future<void> _refreshProducts() async {
    setState(() {
      _currentPage = 1;
      _hasMore = true;
      _allProducts.clear();
      _pagination = null;
    });
    _loadProducts(_currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        showBackArrow: true,
        title: Text(
          "Products",
          style: TextFontStyle.textStyle18c172B4DDMSans500,
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshProducts,
        child: StreamBuilder(
          stream: getProductsRxObj.fileData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting &&
                _currentPage == 1) {
              return const WaitingWidget();
            } else if (snapshot.hasError) {
              return const NotFoundWidget();
            } else if (snapshot.hasData && snapshot.data != null) {
              final responseData = snapshot.data!;

              // Parse the response correctly based on your API structure
              Data? data;
              try {
                // Check if response has the full structure with success, message, data
                if (responseData.containsKey('success')) {
                  // Full response structure
                  final productsResponse =
                      ProductsResponse.fromJson(responseData);
                  data = productsResponse.data;
                } else if (responseData.containsKey('products')) {
                  // Direct data structure (products and pagination)
                  data = Data.fromJson(responseData);
                } else {
                  // Unknown structure
                  return const NoDataWidget(
                    title: 'Data Error',
                    subtitle: 'Unexpected data format',
                  );
                }
              } catch (e) {
                log('Error parsing response: $e');
                return const NoDataWidget(
                  title: 'Data Error',
                  subtitle: 'Failed to parse products data',
                );
              }

              // Check if data is null
              if (data == null) {
                return const NoDataWidget(
                  title: 'No Products!',
                  subtitle: 'No products available at the moment.',
                );
              }

              final List<ProductModel> newProducts = data.products ?? [];
              final PaginationModel pagination =
                  data.pagination ?? PaginationModel();

              // Update products list
              if (_currentPage == 1) {
                _allProducts = newProducts;
              } else {
                final existingIds = _allProducts.map((p) => p.id).toSet();
                final uniqueNewProducts = newProducts
                    .where((p) => !existingIds.contains(p.id))
                    .toList();
                _allProducts.addAll(uniqueNewProducts);
              }

              // Update pagination state
              _pagination = pagination;
              _hasMore = pagination.hasNext ?? false;

              // Reset loading state
              if (_isLoadingMore) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) {
                    setState(() {
                      _isLoadingMore = false;
                    });
                  }
                });
              }

              if (_allProducts.isEmpty && _currentPage == 1) {
                return const NoDataWidget(
                  title: 'No Products!',
                  subtitle: 'No products available at the moment.',
                );
              }

              return Column(
                children: [
                  // Products count
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${_pagination?.totalProducts ?? 0} Products',
                          style: TextFontStyle.textStyle14c606060DMSans400,
                        ),
                        Text(
                          'Loaded: ${_allProducts.length} of ${_pagination?.totalProducts ?? 0}',
                          style: TextFontStyle.textStyle14c606060DMSans400,
                        ),
                      ],
                    ),
                  ),

                  // Products Grid
                  Expanded(
                    child: GridView.builder(
                      controller: _scrollController,
                      padding: EdgeInsets.all(16.w),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16.w,
                        mainAxisSpacing: 16.h,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: _allProducts.length + (_hasMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == _allProducts.length && _hasMore) {
                          return _buildLoadingIndicator();
                        } else if (index == _allProducts.length && !_hasMore) {
                          return const SizedBox.shrink();
                        }

                        final product = _allProducts[index];
                        return _buildProductItem(product);
                      },
                    ),
                  ),
                ],
              );
            } else {
              return const NotFoundWidget();
            }
          },
        ),
      ),
    );
  }

  Widget _buildProductItem(ProductModel product) {
    return Container(
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

  Widget _buildLoadingIndicator() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              strokeWidth: 2.w,
              valueColor: const AlwaysStoppedAnimation<Color>(
                  AppColors.allPrimaryColor),
            ),
            UIHelper.verticalSpace(8.h),
            Text(
              'Loading more products...',
              style: TextFontStyle.textStyle12c606060DMSans400,
            ),
          ],
        ),
      ),
    );
  }
}
