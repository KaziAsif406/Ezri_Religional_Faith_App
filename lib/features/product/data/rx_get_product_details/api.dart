import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../networks/dio/dio.dart';
import '../../../../networks/endpoints.dart';
import '../../../../networks/exception_handler/data_source.dart';

final class GetProductDetailsApi {
  static final GetProductDetailsApi _singleton =
      GetProductDetailsApi._internal();
  GetProductDetailsApi._internal();
  static GetProductDetailsApi get instance => _singleton;
  Future<Map> getProductDetailsData({required int id}) async {
    try {
      Response response = await getHttp(
        Endpoints.productDetails(id ),
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
