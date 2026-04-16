import 'package:rxdart/rxdart.dart';
import '../../../../networks/rx_base.dart';
import 'api.dart';

final class GetProductDetailsRx extends RxResponseInt {
  final api = GetProductDetailsApi.instance;

  GetProductDetailsRx({required super.empty, required super.dataFetcher});

  ValueStream get fileData => dataFetcher.stream;

  Future<bool> featchProductDetails({required int id}) async {
    try {
      // Clear previous data before making new API call
      dataFetcher.sink.add(empty);

      Map data = await api.getProductDetailsData(id: id);
      return await handleSuccessWithReturn(data);
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data) async {
    dataFetcher.sink.add(data);
    return true;
  }

// @override
//   handleErrorWithReturn(error) {
//     ErrorMessageHandler.showErrorToast(error); // Just one call!
//     return false;
//   }
}
