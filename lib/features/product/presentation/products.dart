// lib/features/products/presentation/products_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter/helpers/navigation_service.dart';
import '../../../common_widgets/custom_appbar.dart';
import '../../../common_widgets/no_data_widget.dart';
import '../../../common_widgets/not_found_widget.dart';
import '../../../common_widgets/waiting_widget.dart';
import '../../../constants/text_font_style.dart';
import '../../../gen/colors.gen.dart';
import '../../../networks/api_acess.dart';
import '../../../helpers/all_routes.dart';
import '../model/product_model.dart';
import 'widget/product_widget.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  void initState() {
    super.initState();
    getProductsRxObj.featchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        backgroundColor: AppColors.c4CAF50,
        showBackArrow: false,
        title: Text(
          "Products",
          style: TextFontStyle.textStyle18c172B4DDMSans500
              .copyWith(color: AppColors.cFFFFFF),
        ),
        centerTitle: true,
        isSuffix: true,
        actions: [
          //user profile icon button
          IconButton(
            icon: const Icon(Icons.person, color: AppColors.cFFFFFF),
            onPressed: () {
              NavigationService.navigateTo(Routes.profile);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: getProductsRxObj.fileData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const WaitingWidget();
            } else if (snapshot.hasData && snapshot.data != null) {
              final responseData = snapshot.data!;

              // Parse the response
              Data? data;
              try {
                if (responseData.containsKey('success')) {
                  final productsResponse =
                      ProductsResponse.fromJson(responseData);
                  data = productsResponse.data;
                } else if (responseData.containsKey('products')) {
                  data = Data.fromJson(responseData);
                } else {
                  return const NoDataWidget(
                    title: 'Data Error',
                    subtitle: 'Unexpected data format',
                  );
                }
              } catch (e) {
                return const NoDataWidget(
                  title: 'Data Error',
                  subtitle: 'Failed to parse products data',
                );
              }

              if (data == null) {
                return const NoDataWidget(
                  title: 'No Products!',
                  subtitle: 'No products available at the moment.',
                );
              }

              final List<ProductModel> products = data.products ?? [];

              return products.isEmpty
                  ? const NoDataWidget(
                      title: 'No Products!',
                      subtitle: 'No products available at the moment.',
                    )
                  : GridView.builder(
                      padding: EdgeInsets.all(16.w),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16.w,
                        mainAxisSpacing: 16.h,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return buildProductItem(product);
                      },
                    );
            } else {
              return const NotFoundWidget();
            }
          },
        ),
      ),
    );
  }
}
