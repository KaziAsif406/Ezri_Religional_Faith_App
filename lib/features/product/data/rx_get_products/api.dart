import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../networks/dio/dio.dart';
import '../../../../networks/endpoints.dart';
import '../../../../networks/exception_handler/data_source.dart';

final class GetProductsApi {
  static final GetProductsApi _singleton =
      GetProductsApi._internal();
  GetProductsApi._internal();
  static GetProductsApi get instance => _singleton;
  Future<Map> getProductsData({required int pageNum  , required perPage }) async {
    try {
      Response response = await getHttp(
        Endpoints.products(pageNum ,perPage),
      );
      if (response.statusCode == 200 || response.statusCode == 201 ) {
        Map data = json.decode(json.encode(response.data));
        return data;
      } else {
        // Handle non-200 status code errors
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      // Handle generic errors
      rethrow;
    }
  }
}
